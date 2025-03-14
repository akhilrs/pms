-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create necessary schemas
CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS storage;

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

------ PUBLIC SCHEMA TABLES ------

-- Users table (public schema for GoTrue)
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

-- Create indexes on users table
CREATE INDEX IF NOT EXISTS users_instance_id_idx ON users USING btree (instance_id);
CREATE INDEX IF NOT EXISTS users_instance_id_email_idx ON users USING btree (instance_id, lower(email));

-- Identities table
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

-- Add index on identities
CREATE INDEX IF NOT EXISTS identities_user_id_idx ON identities USING btree (user_id);

-- Refresh tokens table
CREATE TABLE IF NOT EXISTS refresh_tokens (
  id bigserial NOT NULL, 
  token varchar(255) NULL,
  user_id varchar(255) NULL,
  revoked bool NULL,
  created_at timestamptz NULL,
  updated_at timestamptz NULL,
  parent varchar(255) NULL,
  session_id uuid NULL,
  CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id),
  CONSTRAINT refresh_tokens_token_unique UNIQUE (token)
);

-- Create indices on refresh_tokens
CREATE INDEX IF NOT EXISTS refresh_tokens_parent_idx ON refresh_tokens USING btree (parent);
CREATE INDEX IF NOT EXISTS refresh_tokens_session_id_revoked_idx ON refresh_tokens USING btree (session_id, revoked);

-- Audit log entries
CREATE TABLE IF NOT EXISTS audit_log_entries (
  instance_id uuid NULL,
  id uuid NOT NULL,
  payload json NULL,
  created_at timestamptz NULL,
  ip_address inet NULL,
  CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id)
);

-- Sessions table
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

-- Create indices on sessions
CREATE INDEX IF NOT EXISTS sessions_user_id_idx ON sessions USING btree (user_id);
CREATE INDEX IF NOT EXISTS sessions_user_id_created_at_idx ON sessions USING btree (user_id, created_at);
CREATE INDEX IF NOT EXISTS sessions_not_after_idx ON sessions USING btree (not_after);

-- Schema migrations
CREATE TABLE IF NOT EXISTS schema_migrations (
  "version" varchar(255) NOT NULL,
  CONSTRAINT schema_migrations_pkey PRIMARY KEY ("version")
);

-- Fill schema_migrations with all GoTrue migrations to skip them
INSERT INTO schema_migrations (version) 
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

------ DUPLICATE SCHEMA TABLES FOR AUTH SCHEMA ------

-- Users table (auth schema)
CREATE TABLE IF NOT EXISTS auth.users (
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

-- Create indexes on auth.users table
CREATE INDEX IF NOT EXISTS users_instance_id_idx ON auth.users USING btree (instance_id);
CREATE INDEX IF NOT EXISTS users_instance_id_email_idx ON auth.users USING btree (instance_id, lower(email));

-- Auth schema migrations
CREATE TABLE IF NOT EXISTS auth.schema_migrations (
  "version" varchar(255) NOT NULL,
  CONSTRAINT schema_migrations_pkey PRIMARY KEY ("version")
);

-- Fill auth.schema_migrations with all migrations to skip them
INSERT INTO auth.schema_migrations (version) 
SELECT version FROM schema_migrations 
ON CONFLICT (version) DO NOTHING;

-- Functions to get user ID/role from JWT
CREATE OR REPLACE FUNCTION auth.uid() RETURNS uuid AS $$
  SELECT nullif(current_setting('request.jwt.claim.sub', true), '')::uuid;
$$ LANGUAGE sql STABLE;

CREATE OR REPLACE FUNCTION auth.role() RETURNS text AS $$
  SELECT nullif(current_setting('request.jwt.claim.role', true), '')::text;
$$ LANGUAGE sql STABLE;

------ APPLICATION SCHEMA ------

-- Enable RLS
ALTER DATABASE postgres SET "app.settings.enableRLS" TO true;

-- Profiles table
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key after both tables exist and are populated
ALTER TABLE public.profiles 
  ADD CONSTRAINT profiles_id_fkey 
  FOREIGN KEY (id) REFERENCES auth.users(id);

-- Projects table
CREATE TABLE IF NOT EXISTS public.projects (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'Planning' CHECK (status IN ('Planning', 'In Progress', 'On Hold', 'Completed', 'Canceled')),
  start_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP WITH TIME ZONE,
  owner_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Project members table
CREATE TABLE IF NOT EXISTS public.project_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('owner', 'admin', 'member')),
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(project_id, user_id)
);

-- Tasks table
CREATE TABLE IF NOT EXISTS public.tasks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'To Do' CHECK (status IN ('To Do', 'In Progress', 'Completed')),
  priority TEXT NOT NULL DEFAULT 'Medium' CHECK (priority IN ('Low', 'Medium', 'High')),
  due_date TIMESTAMP WITH TIME ZONE,
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  assignee_id UUID REFERENCES auth.users(id),
  creator_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Comments table
CREATE TABLE IF NOT EXISTS public.comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  content TEXT NOT NULL,
  task_id UUID REFERENCES public.tasks(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Files table
CREATE TABLE IF NOT EXISTS public.files (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  size INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  storage_path TEXT NOT NULL,
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  uploaded_by UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Messages table
CREATE TABLE IF NOT EXISTS public.messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  content TEXT NOT NULL,
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Activities table
CREATE TABLE IF NOT EXISTS public.activities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  entity_type TEXT NOT NULL, -- 'project', 'task', 'comment', etc.
  entity_id UUID NOT NULL,
  action TEXT NOT NULL, -- 'created', 'updated', 'deleted', etc.
  details JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create project stats function
CREATE OR REPLACE FUNCTION get_project_stats(project_uuid UUID)
RETURNS TABLE (
  total_tasks BIGINT,
  completed_tasks BIGINT,
  pending_tasks BIGINT,
  overdue_tasks BIGINT,
  progress NUMERIC
) LANGUAGE plpgsql AS $$
BEGIN
  RETURN QUERY
  WITH stats AS (
    SELECT
      COUNT(*) AS total,
      COUNT(*) FILTER (WHERE status = 'Completed') AS completed,
      COUNT(*) FILTER (WHERE status != 'Completed') AS pending,
      COUNT(*) FILTER (WHERE status != 'Completed' AND due_date < NOW()) AS overdue
    FROM public.tasks
    WHERE project_id = project_uuid
  )
  SELECT 
    total,
    completed,
    pending,
    overdue,
    CASE WHEN total > 0 THEN ROUND((completed::NUMERIC / total) * 100, 2) ELSE 0 END
  FROM stats;
END;
$$;

-- Create activity logging function
CREATE OR REPLACE FUNCTION log_activity(
  project_uuid UUID,
  user_uuid UUID,
  entity_type_val TEXT,
  entity_id_val UUID,
  action_val TEXT,
  details_val JSONB DEFAULT NULL
) RETURNS UUID LANGUAGE plpgsql AS $$
DECLARE
  activity_id UUID;
BEGIN
  INSERT INTO public.activities (
    project_id, user_id, entity_type, entity_id, action, details
  ) VALUES (
    project_uuid, user_uuid, entity_type_val, entity_id_val, action_val, details_val
  )
  RETURNING id INTO activity_id;
  
  RETURN activity_id;
END;
$$;

-- Create project with member function
CREATE OR REPLACE FUNCTION create_project_with_member(
  p_name TEXT,
  p_description TEXT,
  p_status TEXT,
  p_start_date TIMESTAMP WITH TIME ZONE,
  p_end_date TIMESTAMP WITH TIME ZONE,
  p_owner_id UUID
) RETURNS JSONB LANGUAGE plpgsql AS $$
DECLARE
  new_project_id UUID;
  new_member_id UUID;
BEGIN
  -- Insert the project
  INSERT INTO public.projects (
    name, description, status, start_date, end_date, owner_id
  ) VALUES (
    p_name, p_description, p_status, p_start_date, p_end_date, p_owner_id
  ) RETURNING id INTO new_project_id;
  
  -- Add the owner as a member with 'owner' role
  INSERT INTO public.project_members (
    project_id, user_id, role
  ) VALUES (
    new_project_id, p_owner_id, 'owner'
  ) RETURNING id INTO new_member_id;
  
  RETURN jsonb_build_object(
    'project_id', new_project_id,
    'member_id', new_member_id
  );
END;
$$;

-- RLS Policies

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.project_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.files ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;

-- Profiles: Users can view and update their own profile
CREATE POLICY "Users can view their own profile"
  ON public.profiles FOR SELECT
  USING (id = auth.uid());

CREATE POLICY "Users can update their own profile"
  ON public.profiles FOR UPDATE
  USING (id = auth.uid());

-- Projects: Users can view projects they own or are members of
CREATE POLICY "Users can view their projects" 
  ON public.projects FOR SELECT USING (
    owner_id = auth.uid() OR 
    EXISTS (
      SELECT 1 FROM public.project_members 
      WHERE project_id = id AND user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create projects"
  ON public.projects FOR INSERT
  WITH CHECK (owner_id = auth.uid());

CREATE POLICY "Owners can update their projects"
  ON public.projects FOR UPDATE
  USING (owner_id = auth.uid());

CREATE POLICY "Owners can delete their projects"
  ON public.projects FOR DELETE
  USING (owner_id = auth.uid());

-- Project Members: Project owners and admins can manage members
CREATE POLICY "Users can view project members"
  ON public.project_members FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.projects
      WHERE id = project_id AND (
        owner_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM public.project_members
          WHERE project_id = public.projects.id AND user_id = auth.uid()
        )
      )
    )
  );

CREATE POLICY "Project owners and admins can add members"
  ON public.project_members FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.projects
      WHERE id = project_id AND (
        owner_id = auth.uid() OR
        EXISTS (
          SELECT 1 FROM public.project_members
          WHERE project_id = public.projects.id AND user_id = auth.uid() AND role IN ('owner', 'admin')
        )
      )
    )
  );

-- Tasks: Project members can manage tasks
CREATE POLICY "Users can view tasks in their projects" 
  ON public.tasks FOR SELECT
  USING (
    creator_id = auth.uid() OR 
    assignee_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members 
      WHERE project_id = project_id AND user_id = auth.uid()
    )
  );

CREATE POLICY "Project members can create tasks"
  ON public.tasks FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.project_members
      WHERE project_id = project_id AND user_id = auth.uid()
    )
  );

-- Create anon and authenticated roles
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon NOLOGIN;
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'authenticated') THEN
    CREATE ROLE authenticated NOLOGIN;
  END IF;
END
$$;

-- Grant privileges
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO authenticated;

-- Grant select on public tables to anon
GRANT SELECT ON TABLE public.profiles TO anon;

-- Enable auto-update of timestamps
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_projects_modtime
BEFORE UPDATE ON public.projects
FOR EACH ROW
EXECUTE PROCEDURE update_modified_column();

CREATE TRIGGER update_tasks_modtime
BEFORE UPDATE ON public.tasks
FOR EACH ROW
EXECUTE PROCEDURE update_modified_column();

CREATE TRIGGER update_profiles_modtime
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE PROCEDURE update_modified_column();

-- Create test user in both auth and public schemas
INSERT INTO users (
  id, instance_id, aud, role, email, encrypted_password, confirmed_at, 
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at
) VALUES (
  'a45a1e2b-de1a-4ed5-89a3-e11355a9f35e',
  '00000000-0000-0000-0000-000000000000',
  'authenticated',
  'authenticated',
  'test@example.com',
  '$2a$10$klUkyqzV8v7EL/X0FXCG1OQYlq0YPZOx9XZmAT/C7tQkCqc0w3qBu', -- 'password'
  NOW(),
  '{"provider": "email"}',
  '{"name": "Test User"}',
  NOW(),
  NOW()
) ON CONFLICT (id) DO NOTHING;

-- Also insert into auth.users table
INSERT INTO auth.users (
  id, instance_id, aud, role, email, encrypted_password, confirmed_at, 
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at
) VALUES (
  'a45a1e2b-de1a-4ed5-89a3-e11355a9f35e',
  '00000000-0000-0000-0000-000000000000',
  'authenticated',
  'authenticated',
  'test@example.com',
  '$2a$10$klUkyqzV8v7EL/X0FXCG1OQYlq0YPZOx9XZmAT/C7tQkCqc0w3qBu', -- 'password'
  NOW(),
  '{"provider": "email"}',
  '{"name": "Test User"}',
  NOW(),
  NOW()
) ON CONFLICT (id) DO NOTHING;

-- Create test profile
INSERT INTO public.profiles (id, first_name, last_name, avatar_url, updated_at)
VALUES (
  'a45a1e2b-de1a-4ed5-89a3-e11355a9f35e',
  'Test',
  'User',
  'https://github.com/identicons/app/v1/identicon/DID.png',
  NOW()
) ON CONFLICT (id) DO NOTHING;
