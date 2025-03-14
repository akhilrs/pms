-- Save this as "initdb/00_gotrue_fix.sql"
-- This creates all the tables GoTrue expects in the public schema

-- Create users table in public schema
CREATE TABLE IF NOT EXISTS users (
  instance_id uuid NULL,
  id uuid NOT NULL UNIQUE,
  aud varchar(255) NULL,
  "role" varchar(255) NULL,
  email varchar(255) NULL UNIQUE,
  encrypted_password varchar(255) NULL,
  confirmed_at timestamptz NULL,
  invited_at timestamptz NULL,
  confirmation_token varchar(255) NULL,
  confirmation_sent_at timestamptz NULL,
  recovery_token varchar(255) NULL,
  recovery_sent_at timestamptz NULL,
  email_change_token varchar(255) NULL,
  email_change varchar(255) NULL,
  email_change_sent_at timestamptz NULL,
  last_sign_in_at timestamptz NULL,
  raw_app_meta_data jsonb NULL,
  raw_user_meta_data jsonb NULL,
  is_super_admin bool NULL,
  created_at timestamptz NULL,
  updated_at timestamptz NULL,
  CONSTRAINT users_pkey PRIMARY KEY (id)
);

-- Create indices on users table
CREATE INDEX IF NOT EXISTS users_instance_id_idx ON users USING btree (instance_id);
CREATE INDEX IF NOT EXISTS users_instance_id_email_idx ON users USING btree (instance_id, lower(email));

-- Create identities table in public schema
CREATE TABLE IF NOT EXISTS identities (
  id text NOT NULL,
  user_id uuid NOT NULL,
  identity_data jsonb NOT NULL,
  provider text NOT NULL,
  last_sign_in_at timestamptz NULL,
  created_at timestamptz NULL,
  updated_at timestamptz NULL,
  email text NULL,
  CONSTRAINT identities_pkey PRIMARY KEY (provider, id)
);

-- Add index on identities.user_id
CREATE INDEX IF NOT EXISTS identities_user_id_idx ON identities USING btree (user_id);

-- Create refresh_tokens table in public schema
CREATE TABLE IF NOT EXISTS refresh_tokens (
  id bigserial NOT NULL, 
  token varchar(255) NULL,
  user_id varchar(255) NULL,
  revoked bool NULL,
  created_at timestamptz NULL,
  updated_at timestamptz NULL,
  parent varchar(255) NULL,
  session_id uuid NULL,
  CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id)
);

-- Add unique constraint on token
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM pg_constraint 
    WHERE conname = 'refresh_tokens_token_unique' AND conrelid = 'refresh_tokens'::regclass
  ) THEN
    ALTER TABLE refresh_tokens ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);
  END IF;
END
$$;

-- Create index on parent and session_id
CREATE INDEX IF NOT EXISTS refresh_tokens_parent_idx ON refresh_tokens USING btree (parent);
CREATE INDEX IF NOT EXISTS refresh_tokens_session_id_revoked_idx ON refresh_tokens USING btree (session_id, revoked);

-- Create audit_log_entries table
CREATE TABLE IF NOT EXISTS audit_log_entries (
  instance_id uuid NULL,
  id uuid NOT NULL,
  payload json NULL,
  created_at timestamptz NULL,
  ip_address inet NULL,
  CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id)
);

-- Create sessions table
CREATE TABLE IF NOT EXISTS sessions (
  id uuid NOT NULL,
  user_id uuid NOT NULL,
  created_at timestamptz NULL,
  updated_at timestamptz NULL,
  factor_id uuid NULL,
  aal aal_level NULL,
  not_after timestamptz NULL,
  CONSTRAINT sessions_pkey PRIMARY KEY (id)
);

-- Create index on sessions
CREATE INDEX IF NOT EXISTS sessions_user_id_idx ON sessions USING btree (user_id);
CREATE INDEX IF NOT EXISTS sessions_user_id_created_at_idx ON sessions USING btree (user_id, created_at);
CREATE INDEX IF NOT EXISTS sessions_not_after_idx ON sessions USING btree (not_after);

-- Create schema_migrations table in public schema
CREATE TABLE IF NOT EXISTS schema_migrations (
  "version" varchar(255) NOT NULL,
  CONSTRAINT schema_migrations_pkey PRIMARY KEY ("version")
);

-- Create type definitions required by auth tables
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'aal_level') THEN
    CREATE TYPE aal_level AS ENUM ('aal1', 'aal2', 'aal3');
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'factor_type') THEN
    CREATE TYPE factor_type AS ENUM ('totp', 'webauthn');
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'factor_status') THEN
    CREATE TYPE factor_status AS ENUM ('unverified', 'verified');
  END IF;
END $$;

-- Create auth schema and migrations table
CREATE SCHEMA IF NOT EXISTS auth;
CREATE TABLE IF NOT EXISTS auth.schema_migrations (
  "version" varchar(255) NOT NULL,
  CONSTRAINT schema_migrations_pkey PRIMARY KEY ("version")
);

-- Mark all migrations as completed
INSERT INTO auth.schema_migrations (version) 
VALUES 
('00'),                     -- init_auth_schema
('20210710035447'),         -- alter_users
('20210722035447'),         -- adds_confirmed_at
('20210730183235'),         -- add_email_change_confirmed
('20210909172000'),         -- create_identities_table
('20210927181326'),         -- add_refresh_token_parent
('20211122151130'),         -- create_user_id_idx
('20211124214934'),         -- update_auth_functions
('20211202183645'),         -- update_auth_uid
('20220114185221'),         -- update_user_idx
('20220114185340'),         -- add_banned_until
('20220224000811'),         -- update_auth_functions
('20220323170000'),         -- add_user_reauthentication
('20220429102000'),         -- add_unique_idx
('20220531120530'),         -- add_auth_jwt_function
('20220614074223'),         -- add_ip_address_to_audit_log
('20220811173540'),         -- add_sessions_table
('20221003041349'),         -- add_mfa_schema
('20221003041400'),         -- add_aal_and_factor_id_to_sessions
('20221011041400'),         -- add_mfa_indexes
('20221020193600'),         -- add_sessions_user_id_index
('20221021073300'),         -- add_refresh_tokens_session_id_revoked_index
('20221021082433'),         -- add_saml
('20221027105023'),         -- add_identities_user_id_idx
('20221114143122'),         -- add_session_not_after_column
('20221114143410'),         -- remove_parent_foreign_key_refresh_tokens
('20221120114718'),         -- add_identities_email_column
('20221124140122'),         -- add_identities_email_column
('20221125140132'),         -- backfill_email_identity
('20221125141029')          -- add_identities_email_column
ON CONFLICT (version) DO NOTHING;
