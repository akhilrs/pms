--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO supabase_admin;

--
-- Name: ai_agent; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA ai_agent;


ALTER SCHEMA ai_agent OWNER TO supabase_admin;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: metrics; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA metrics;


ALTER SCHEMA metrics OWNER TO postgres;

--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: temp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA temp;


ALTER SCHEMA temp OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_jsonschema; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_jsonschema WITH SCHEMA public;


--
-- Name: EXTENSION pg_jsonschema; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_jsonschema IS 'pg_jsonschema';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA extensions;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


--
-- Name: activity_type; Type: TYPE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TYPE ai_agent.activity_type AS ENUM (
    'login',
    'logout',
    'create',
    'update',
    'delete',
    'other'
);


ALTER TYPE ai_agent.activity_type OWNER TO supabase_admin;

--
-- Name: file_type; Type: TYPE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TYPE ai_agent.file_type AS ENUM (
    'pdf',
    'docx',
    'txt',
    'csv',
    'other'
);


ALTER TYPE ai_agent.file_type OWNER TO supabase_admin;

--
-- Name: processing_status; Type: TYPE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TYPE ai_agent.processing_status AS ENUM (
    'pending',
    'in_progress',
    'completed',
    'failed'
);


ALTER TYPE ai_agent.processing_status OWNER TO supabase_admin;

--
-- Name: setting_value_type; Type: TYPE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TYPE ai_agent.setting_value_type AS ENUM (
    'string',
    'number',
    'boolean',
    'json'
);


ALTER TYPE ai_agent.setting_value_type OWNER TO supabase_admin;

--
-- Name: source_type; Type: TYPE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TYPE ai_agent.source_type AS ENUM (
    'file',
    'webpage',
    'text',
    'other'
);


ALTER TYPE ai_agent.source_type OWNER TO supabase_admin;

--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: feedback_vote; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.feedback_vote AS ENUM (
    'yes',
    'no'
);


ALTER TYPE public.feedback_vote OWNER TO postgres;

--
-- Name: sync_user_ids(); Type: FUNCTION; Schema: ai_agent; Owner: supabase_admin
--

CREATE FUNCTION ai_agent.sync_user_ids() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- If auth_id is provided but user_id is not, set user_id = auth_id
  IF NEW.auth_id IS NOT NULL AND NEW.user_id IS NULL THEN
    NEW.user_id := NEW.auth_id;
  END IF;
  
  -- If user_id is provided but auth_id is not, set auth_id = user_id
  IF NEW.user_id IS NOT NULL AND NEW.auth_id IS NULL THEN
    NEW.auth_id := NEW.user_id;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION ai_agent.sync_user_ids() OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: cleanup_last_changed_pages(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cleanup_last_changed_pages() RETURNS integer
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
declare
  newest_check_time timestamp with time zone;
  number_deleted integer;
begin
  select last_checked into newest_check_time
    from public.last_changed
    order by last_checked desc
    limit 1
  ;

  with deleted as (
    delete from public.last_changed
    where last_checked <> newest_check_time
    returning id
  )
  select count(*)
  from deleted
  into number_deleted;

  return number_deleted;
end;
$$;


ALTER FUNCTION public.cleanup_last_changed_pages() OWNER TO postgres;

--
-- Name: create_profile_for_new_user(); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.create_profile_for_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, user_id, first_name, last_name, avatar_url, created_at, updated_at)
  VALUES (NEW.id, NEW.id, '', '', '', NOW(), NOW());
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_profile_for_new_user() OWNER TO supabase_admin;

--
-- Name: docs_search_embeddings(extensions.vector, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.docs_search_embeddings(embedding extensions.vector, match_threshold double precision) RETURNS TABLE(id bigint, path text, type text, title text, subtitle text, description text, headings text[], slugs text[])
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
#variable_conflict use_variable
begin
  return query
  with match as(
	select *
	from public.page_section
	-- The dot product is negative because of a Postgres limitation, so we negate it
	where (page_section.embedding operator(public.<#>) embedding) * -1 > match_threshold	
	-- OpenAI embeddings are normalized to length 1, so
	-- cosine similarity and dot product will produce the same results.
	-- Using dot product which can be computed slightly faster.
	--
	-- For the different syntaxes, see https://github.com/pgvector/pgvector
	order by page_section.embedding operator(public.<#>) embedding
	limit 10
  )
  select
	page.id,
	page.path,
	page.type,
	page.meta ->> 'title' as title,
	page.meta ->> 'subtitle' as title,
	page.meta ->> 'description' as description,
	array_agg(match.heading) as headings,
	array_agg(match.slug) as slugs
  from public.page
  join match on match.page_id = page.id
  group by page.id;
end;
$$;


ALTER FUNCTION public.docs_search_embeddings(embedding extensions.vector, match_threshold double precision) OWNER TO postgres;

--
-- Name: docs_search_fts(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.docs_search_fts(query text) RETURNS TABLE(id bigint, path text, type text, title text, subtitle text, description text)
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
#variable_conflict use_variable
begin
  return query
  select
	page.id,
	page.path,
	page.type,
	page.meta ->> 'title' as title,
	page.meta ->> 'subtitle' as subtitle,
	page.meta ->> 'description' as description
  from public.page
  where title_tokens @@ websearch_to_tsquery(query) or fts_tokens @@ websearch_to_tsquery(query)
  order by greatest(
	  -- Title is more important than body, so use 10 as the weighting factor
	  -- Cut off at max rank of 1
	  least(10 * ts_rank(title_tokens, websearch_to_tsquery(query)), 1),
	  ts_rank(fts_tokens, websearch_to_tsquery(query))
  ) desc
  limit 10;
end;
$$;


ALTER FUNCTION public.docs_search_fts(query text) OWNER TO postgres;

--
-- Name: get_last_revalidation_for_tags(text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_last_revalidation_for_tags(tags text[]) RETURNS TABLE(tag text, created_at timestamp with time zone)
    LANGUAGE sql
    AS $$
  select
    tag,
    max(created_at) as created_at
  from validation_history
  where tag = any(tags)
  group by tag;
$$;


ALTER FUNCTION public.get_last_revalidation_for_tags(tags text[]) OWNER TO postgres;

--
-- Name: handle_updated_at(); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.handle_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_updated_at() OWNER TO supabase_admin;

--
-- Name: ipv6_active_status(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ipv6_active_status(project_ref text) RETURNS TABLE(pgbouncer_active boolean, vercel_active boolean)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
declare
  pgbouncer_active boolean;
  vercel_active boolean;
begin
  select exists (
    select 1 
    from public.active_pgbouncer_projects ap
    where ap.project_ref = $1
  ) into pgbouncer_active;

  select exists (
    select 1
    from public.vercel_project_connections_without_supavisor vp
    where vp.project_ref = $1
  ) into vercel_active;

  return query select pgbouncer_active, vercel_active;
end;
$_$;


ALTER FUNCTION public.ipv6_active_status(project_ref text) OWNER TO postgres;

--
-- Name: is_project_member(uuid, uuid); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.is_project_member(project_id uuid, user_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM project_members 
    WHERE project_members.project_id = $1 
    AND project_members.user_id = $2
  );
END;
$_$;


ALTER FUNCTION public.is_project_member(project_id uuid, user_id uuid) OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: page_section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page_section (
    id bigint NOT NULL,
    page_id bigint NOT NULL,
    content text,
    token_count integer,
    embedding extensions.vector(1536),
    slug text,
    heading text,
    rag_ignore boolean DEFAULT false
);


ALTER TABLE public.page_section OWNER TO postgres;

--
-- Name: match_page_sections_v2(extensions.vector, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.match_page_sections_v2(embedding extensions.vector, match_threshold double precision, min_content_length integer) RETURNS SETOF public.page_section
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
#variable_conflict use_variable
begin
  return query
  select *
  from public.page_section

  -- We only care about sections that have a useful amount of content
  where length(page_section.content) >= min_content_length

  -- The dot product is negative because of a Postgres limitation, so we negate it
  and (page_section.embedding operator(public.<#>) embedding) * -1 > match_threshold

  -- OpenAI embeddings are normalized to length 1, so
  -- cosine similarity and dot product will produce the same results.
  -- Using dot product which can be computed slightly faster.
  --
  -- For the different syntaxes, see https://github.com/pgvector/pgvector
  order by page_section.embedding operator(public.<#>) embedding;
end;
$$;


ALTER FUNCTION public.match_page_sections_v2(embedding extensions.vector, match_threshold double precision, min_content_length integer) OWNER TO postgres;

--
-- Name: update_last_changed_checksum(text, text, text, timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_last_changed_checksum(new_parent_page text, new_heading text, new_checksum text, git_update_time timestamp with time zone, check_time timestamp with time zone) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
declare
  existing_id bigint;
  previous_checksum text;
  updated_check_time timestamp with time zone;
begin
  select id, checksum into existing_id, previous_checksum
    from public.last_changed
    where
      parent_page = new_parent_page
      and heading = new_heading
  ;

  if existing_id is not null
    and previous_checksum is not null
    and previous_checksum = new_checksum

    then
      update public.last_changed set
        last_checked = check_time
        where
		  last_changed.id = existing_id
		  and last_changed.last_checked < check_time
		returning last_checked into updated_check_time
      ;

    else
      insert into public.last_changed (
        parent_page,
        heading,
        checksum,
        last_updated,
        last_checked
      ) values (
        new_parent_page,
        new_heading,
        new_checksum,
        git_update_time,
        check_time
      )
      on conflict
	    on constraint last_changed_parent_page_heading_key
        do update set
          checksum = new_checksum,
          last_updated = git_update_time,
          last_checked = check_time
        where
          last_changed.id = existing_id
		  and last_changed.last_checked < check_time
	  returning last_checked into updated_check_time
      ;

  end if;

  return updated_check_time;
end;
$$;


ALTER FUNCTION public.update_last_changed_checksum(new_parent_page text, new_heading text, new_checksum text, git_update_time timestamp with time zone, check_time timestamp with time zone) OWNER TO postgres;

--
-- Name: update_troubleshooting_entry_date_updated(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_troubleshooting_entry_date_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    new.date_updated = now();
    return new;
end;
$$;


ALTER FUNCTION public.update_troubleshooting_entry_date_updated() OWNER TO postgres;

--
-- Name: validate_troubleshooting_errors(jsonb[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_troubleshooting_errors(errors jsonb[]) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
    error jsonb;
begin
    if errors is null then
        return true;
    end if;

    foreach error in array errors
    loop
        if not jsonb_matches_schema(
            schema := '{
                "type": "object",
                "properties": {
                    "http_status_code": { "type": "number" },
                    "code": { "type": "string" },
                    "message": { "type": "string" }
                },
                "additionalProperties": false
            }',
            instance := error
        ) then
            return false;
        end if;
    end loop;

    return true;
end;
$$;


ALTER FUNCTION public.validate_troubleshooting_errors(errors jsonb[]) OWNER TO postgres;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
BEGIN
    RETURN query EXECUTE
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name || '/' AS name,
                    NULL::uuid AS id,
                    NULL::timestamptz AS updated_at,
                    NULL::timestamptz AS created_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
                ORDER BY prefixes.name COLLATE "C" LIMIT $3
            )
            UNION ALL
            (SELECT split_part(name, '/', $4) AS key,
                name,
                id,
                updated_at,
                created_at,
                metadata
            FROM storage.objects
            WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
            ORDER BY name COLLATE "C" LIMIT $3)
        ) obj
        ORDER BY name COLLATE "C" LIMIT $3;
        $sql$
        USING prefix, bucket_name, limits, levels, start_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
    DECLARE
      request_id bigint;
      payload jsonb;
      url text := TG_ARGV[0]::text;
      method text := TG_ARGV[1]::text;
      headers jsonb DEFAULT '{}'::jsonb;
      params jsonb DEFAULT '{}'::jsonb;
      timeout_ms integer DEFAULT 1000;
    BEGIN
      IF url IS NULL OR url = 'null' THEN
        RAISE EXCEPTION 'url argument is missing';
      END IF;

      IF method IS NULL OR method = 'null' THEN
        RAISE EXCEPTION 'method argument is missing';
      END IF;

      IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
        headers = '{"Content-Type": "application/json"}'::jsonb;
      ELSE
        headers = TG_ARGV[2]::jsonb;
      END IF;

      IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
        params = '{}'::jsonb;
      ELSE
        params = TG_ARGV[3]::jsonb;
      END IF;

      IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
        timeout_ms = 1000;
      ELSE
        timeout_ms = TG_ARGV[4]::integer;
      END IF;

      CASE
        WHEN method = 'GET' THEN
          SELECT http_get INTO request_id FROM net.http_get(
            url,
            params,
            headers,
            timeout_ms
          );
        WHEN method = 'POST' THEN
          payload = jsonb_build_object(
            'old_record', OLD,
            'record', NEW,
            'type', TG_OP,
            'table', TG_TABLE_NAME,
            'schema', TG_TABLE_SCHEMA
          );

          SELECT http_post INTO request_id FROM net.http_post(
            url,
            payload,
            params,
            headers,
            timeout_ms
          );
        ELSE
          RAISE EXCEPTION 'method argument % is invalid', method;
      END CASE;

      INSERT INTO supabase_functions.hooks
        (hook_table_id, hook_name, request_id)
      VALUES
        (TG_RELID, TG_NAME, request_id);

      RETURN NEW;
    END
  $$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

--
-- Name: chunks; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.chunks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source_id uuid NOT NULL,
    version double precision,
    chunk_index double precision,
    content text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    chunking_status ai_agent.processing_status,
    chunking_started_at timestamp with time zone,
    chunking_completed_at timestamp with time zone,
    chunking_error text,
    chunking_config jsonb,
    embedding_status ai_agent.processing_status,
    embedding_started_at timestamp with time zone,
    embedding_completed_at timestamp with time zone,
    embedding_error text,
    embedding_config jsonb,
    created_by uuid
);


ALTER TABLE ai_agent.chunks OWNER TO supabase_admin;

--
-- Name: conversations; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.conversations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    visitor_id uuid,
    title text,
    summary text,
    metadata jsonb,
    sentiment double precision,
    last_message_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    message_count integer DEFAULT 0,
    context text,
    profile_id uuid,
    user_id uuid,
    model_name text,
    system_prompt text,
    pinned boolean DEFAULT false,
    archived boolean DEFAULT false,
    is_shared boolean DEFAULT false,
    share_id uuid,
    context_length integer DEFAULT 0,
    last_message text,
    ip_address text,
    user_agent text,
    browser text,
    os text,
    device_type text,
    conversation_length integer DEFAULT 0,
    tag text,
    feedback text,
    feedback_rating integer,
    tags text[],
    category text,
    status text,
    priority text,
    assigned_to uuid,
    last_updated_by uuid,
    last_activity_at timestamp with time zone,
    is_pinned boolean DEFAULT false
);


ALTER TABLE ai_agent.conversations OWNER TO supabase_admin;

--
-- Name: embeddings; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.embeddings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    chunk_id uuid,
    model_name text,
    embedding bytea,
    created_at timestamp with time zone DEFAULT now(),
    vector_embedding extensions.vector(1536)
);


ALTER TABLE ai_agent.embeddings OWNER TO supabase_admin;

--
-- Name: message_references; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.message_references (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    message_id uuid,
    chunk_id uuid,
    embedding_id uuid,
    reference_score double precision,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.message_references OWNER TO supabase_admin;

--
-- Name: messages; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conversation_id uuid NOT NULL,
    role text,
    content text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    ip_address text,
    user_agent text,
    browser text,
    os text,
    device_type text,
    token_count integer DEFAULT 0,
    prompt_tokens integer DEFAULT 0,
    completion_tokens integer DEFAULT 0,
    model_name text,
    temperature double precision,
    is_visible boolean DEFAULT true,
    is_error boolean DEFAULT false,
    profile_id uuid,
    user_id uuid,
    model text,
    system_fingerprint text,
    finish_reason text,
    request_id text,
    latency double precision,
    version text,
    context_profile_id uuid,
    feedback text,
    feedback_rating integer
);


ALTER TABLE ai_agent.messages OWNER TO supabase_admin;

--
-- Name: permissions; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.permissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.permissions OWNER TO supabase_admin;

--
-- Name: profiles; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name text,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    auth_id uuid,
    email text,
    full_name text,
    display_name text,
    ip_address text,
    last_login_ip text,
    user_agent text,
    browser text,
    os text,
    device_type text,
    login_count integer DEFAULT 0,
    last_login_at timestamp with time zone,
    total_conversations integer DEFAULT 0,
    total_messages integer DEFAULT 0
);

ALTER TABLE ONLY ai_agent.profiles FORCE ROW LEVEL SECURITY;


ALTER TABLE ai_agent.profiles OWNER TO supabase_admin;

--
-- Name: role_permissions; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.role_permissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    role_id uuid NOT NULL,
    permission_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.role_permissions OWNER TO supabase_admin;

--
-- Name: roles; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.roles OWNER TO supabase_admin;

--
-- Name: setting_audit_log; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.setting_audit_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    setting_id uuid,
    user_id uuid,
    old_value text,
    new_value text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.setting_audit_log OWNER TO supabase_admin;

--
-- Name: setting_categories; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.setting_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    display_order double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.setting_categories OWNER TO supabase_admin;

--
-- Name: settings; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_id uuid,
    key text NOT NULL,
    description text,
    display_name text,
    value_type ai_agent.setting_value_type,
    value text,
    is_encrypted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.settings OWNER TO supabase_admin;

--
-- Name: source_versions; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.source_versions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source_id uuid NOT NULL,
    version_number double precision,
    processed_content text,
    processing_config jsonb,
    processed_at timestamp with time zone
);


ALTER TABLE ai_agent.source_versions OWNER TO supabase_admin;

--
-- Name: sources; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.sources (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source_type ai_agent.source_type,
    created_by_user_id uuid,
    title text,
    description text,
    content text,
    metadata jsonb,
    file_type ai_agent.file_type,
    file_hash text,
    raw_file_path text,
    url text,
    last_crawled_at timestamp with time zone,
    chunking_status ai_agent.processing_status,
    chunking_started_at timestamp with time zone,
    chunking_completed_at timestamp with time zone,
    chunking_error text,
    chunking_config jsonb
);


ALTER TABLE ai_agent.sources OWNER TO supabase_admin;

--
-- Name: user_activities; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.user_activities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    activity_type ai_agent.activity_type,
    description text,
    metadata jsonb,
    ip_address text,
    user_agent text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.user_activities OWNER TO supabase_admin;

--
-- Name: user_roles; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.user_roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    role_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.user_roles OWNER TO supabase_admin;

--
-- Name: users; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    uuid uuid NOT NULL,
    email text,
    name text,
    is_active boolean DEFAULT true,
    last_sign_in timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.users OWNER TO supabase_admin;

--
-- Name: visitors; Type: TABLE; Schema: ai_agent; Owner: supabase_admin
--

CREATE TABLE ai_agent.visitors (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    visitor_id uuid,
    title text,
    ip_address text,
    user_agent text,
    first_seen_at timestamp with time zone,
    last_seen_at timestamp with time zone,
    total_conversations double precision,
    contact_email text,
    contact_phone text,
    location text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE ai_agent.visitors OWNER TO supabase_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    id bigint NOT NULL,
    date_created date DEFAULT CURRENT_DATE NOT NULL,
    vote public.feedback_vote NOT NULL,
    page text NOT NULL,
    metadata jsonb
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- Name: feedback_response_aggregate; Type: VIEW; Schema: metrics; Owner: postgres
--

CREATE VIEW metrics.feedback_response_aggregate AS
 SELECT count(*) FILTER (WHERE (feedback.vote = 'yes'::public.feedback_vote)) AS yes,
    count(*) FILTER (WHERE (feedback.vote = 'no'::public.feedback_vote)) AS no
   FROM public.feedback;


ALTER TABLE metrics.feedback_response_aggregate OWNER TO postgres;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.activities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    project_id uuid NOT NULL,
    user_id uuid NOT NULL,
    entity_type text NOT NULL,
    entity_id uuid NOT NULL,
    action text NOT NULL,
    details jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.activities OWNER TO supabase_admin;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.comments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    content text NOT NULL,
    task_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comments OWNER TO supabase_admin;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.feedback ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: files; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.files (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    size integer NOT NULL,
    mime_type text NOT NULL,
    storage_path text NOT NULL,
    project_id uuid NOT NULL,
    uploaded_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.files OWNER TO supabase_admin;

--
-- Name: last_changed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.last_changed (
    id bigint NOT NULL,
    checksum text NOT NULL,
    parent_page text NOT NULL,
    heading text NOT NULL,
    last_updated timestamp with time zone DEFAULT now() NOT NULL,
    last_checked timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.last_changed OWNER TO postgres;

--
-- Name: TABLE last_changed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.last_changed IS 'Records when page sections from docs content were last edited.';


--
-- Name: COLUMN last_changed.checksum; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.last_changed.checksum IS 'Checksum of most recent section contents.';


--
-- Name: COLUMN last_changed.parent_page; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.last_changed.parent_page IS 'Path of the page containing this section.';


--
-- Name: COLUMN last_changed.last_updated; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.last_changed.last_updated IS 'When the content was last edited.';


--
-- Name: COLUMN last_changed.last_checked; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.last_changed.last_checked IS 'When the content was last checked. Used to identify and delete obsolete sections.';


--
-- Name: last_changed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.last_changed ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.last_changed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: launch_weeks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.launch_weeks (
    id text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone
);


ALTER TABLE public.launch_weeks OWNER TO postgres;

--
-- Name: meetups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetups (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    launch_week text NOT NULL,
    title text,
    country text,
    start_at timestamp with time zone,
    link text,
    display_info text,
    is_live boolean DEFAULT false NOT NULL,
    is_published boolean DEFAULT false NOT NULL,
    timezone text,
    city text
);


ALTER TABLE public.meetups OWNER TO postgres;

--
-- Name: COLUMN meetups.timezone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meetups.timezone IS 'Needs to be in America/Los_Angeles format.';


--
-- Name: messages; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    content text NOT NULL,
    project_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.messages OWNER TO supabase_admin;

--
-- Name: page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page (
    id bigint NOT NULL,
    path text NOT NULL,
    checksum text,
    meta jsonb,
    type text,
    source text,
    version uuid,
    last_refresh timestamp with time zone,
    content text,
    fts_tokens tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, content)) STORED,
    title_tokens tsvector GENERATED ALWAYS AS (to_tsvector('english'::regconfig, COALESCE((meta ->> 'title'::text), ''::text))) STORED
);


ALTER TABLE public.page OWNER TO postgres;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_id_seq OWNER TO postgres;

--
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;


--
-- Name: page_section_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.page_section_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_section_id_seq OWNER TO postgres;

--
-- Name: page_section_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.page_section_id_seq OWNED BY public.page_section.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    user_id uuid,
    first_name text,
    last_name text,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    auth_id uuid,
    email text,
    full_name text,
    display_name text,
    ip_address text,
    last_login_ip text,
    user_agent text,
    browser text,
    os text,
    device_type text,
    login_count integer DEFAULT 0,
    last_login_at timestamp with time zone
);


ALTER TABLE public.profiles OWNER TO supabase_admin;

--
-- Name: project_members; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.project_members (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    project_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role text DEFAULT 'member'::text NOT NULL,
    joined_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_members OWNER TO supabase_admin;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.projects (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text,
    owner_id uuid NOT NULL,
    status text DEFAULT 'Planning'::text,
    start_date timestamp with time zone DEFAULT now(),
    end_date timestamp with time zone,
    visibility text DEFAULT 'private'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.projects OWNER TO supabase_admin;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.tasks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    status text NOT NULL,
    priority text NOT NULL,
    due_date timestamp with time zone,
    project_id uuid NOT NULL,
    assignee_id uuid,
    creator_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT tasks_priority_check CHECK ((priority = ANY (ARRAY['Low'::text, 'Medium'::text, 'High'::text]))),
    CONSTRAINT tasks_status_check CHECK ((status = ANY (ARRAY['To Do'::text, 'In Progress'::text, 'Completed'::text])))
);


ALTER TABLE public.tasks OWNER TO supabase_admin;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    launch_week text NOT NULL,
    user_id uuid NOT NULL,
    email text,
    name text,
    username text,
    referred_by text,
    shared_on_twitter timestamp with time zone,
    shared_on_linkedin timestamp with time zone,
    game_won_at timestamp with time zone,
    ticket_number bigint NOT NULL,
    metadata jsonb,
    role text,
    company text,
    location text
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- Name: tickets_ticket_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tickets ALTER COLUMN ticket_number ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tickets_ticket_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tickets_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.tickets_view WITH (security_invoker='on') AS
 WITH lw12_referrals AS (
         SELECT tickets_1.referred_by,
            count(*) AS referrals
           FROM public.tickets tickets_1
          WHERE (tickets_1.referred_by IS NOT NULL)
          GROUP BY tickets_1.referred_by
        )
 SELECT tickets.id,
    tickets.name,
    tickets.username,
    tickets.ticket_number,
    tickets.created_at,
    tickets.launch_week,
    tickets.shared_on_twitter,
    tickets.shared_on_linkedin,
    tickets.metadata,
    tickets.role,
    tickets.company,
    tickets.location,
        CASE
            WHEN (lw12_referrals.referrals IS NULL) THEN (0)::bigint
            ELSE lw12_referrals.referrals
        END AS referrals,
        CASE
            WHEN ((tickets.shared_on_twitter IS NOT NULL) AND (tickets.shared_on_linkedin IS NOT NULL)) THEN true
            ELSE false
        END AS platinum,
        CASE
            WHEN (tickets.game_won_at IS NOT NULL) THEN true
            ELSE false
        END AS secret
   FROM (public.tickets
     LEFT JOIN lw12_referrals ON ((tickets.username = lw12_referrals.referred_by)));


ALTER TABLE public.tickets_view OWNER TO postgres;

--
-- Name: troubleshooting_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.troubleshooting_entries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    topics text[] NOT NULL,
    keywords text[],
    api jsonb,
    errors jsonb[],
    github_url text NOT NULL,
    date_created timestamp with time zone DEFAULT now() NOT NULL,
    date_updated timestamp with time zone DEFAULT now() NOT NULL,
    github_id text NOT NULL,
    checksum text NOT NULL,
    CONSTRAINT troubleshooting_api_check CHECK (((api IS NULL) OR public.jsonb_matches_schema(schema => '{
            "type": "object",
            "properties": {
                "sdk": {
                    "type": "array",
                    "items": { "type": "string" }
                },
                "management_api": {
                    "type": "array",
                    "items": { "type": "string" }
                },
                "cli": {
                    "type": "array",
                    "items": { "type": "string" }
                }
            },
            "additionalProperties": false
        }'::json, instance => api))),
    CONSTRAINT troubleshooting_errors_check CHECK (public.validate_troubleshooting_errors(errors))
);


ALTER TABLE public.troubleshooting_entries OWNER TO postgres;

--
-- Name: validation_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validation_history (
    id bigint NOT NULL,
    tag text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.validation_history OWNER TO postgres;

--
-- Name: validation_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.validation_history ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.validation_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER TABLE vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: page id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);


--
-- Name: page_section id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page_section ALTER COLUMN id SET DEFAULT nextval('public.page_section_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: chunks; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.chunks (id, source_id, version, chunk_index, content, metadata, created_at, chunking_status, chunking_started_at, chunking_completed_at, chunking_error, chunking_config, embedding_status, embedding_started_at, embedding_completed_at, embedding_error, embedding_config, created_by) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.conversations (id, visitor_id, title, summary, metadata, sentiment, last_message_at, updated_at, created_at, message_count, context, profile_id, user_id, model_name, system_prompt, pinned, archived, is_shared, share_id, context_length, last_message, ip_address, user_agent, browser, os, device_type, conversation_length, tag, feedback, feedback_rating, tags, category, status, priority, assigned_to, last_updated_by, last_activity_at, is_pinned) FROM stdin;
2d4ed13f-8a02-41a7-aca0-6de7a590cd54	\N	Assessing Mental Well-being: Sleep and Energy	\N	\N	\N	2025-04-03 18:32:19.69+00	2025-04-03 18:31:10.375+00	2025-04-03 18:30:23.383061+00	0	{}	\N	53798562-909c-460a-a8df-a62cfc556b34	\N	\N	f	f	f	\N	0	\N	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	\N	\N	\N	{}	\N	\N	\N	\N	\N	\N	f
53984d2c-b409-4c84-a8da-d569f33f694c	\N	Chat - Apr 4, 2025 at 9:23 AM	\N	\N	\N	2025-04-04 03:53:04.389+00	2025-04-04 03:53:01.785204+00	2025-04-04 03:53:01.785204+00	0	{}	\N	53798562-909c-460a-a8df-a62cfc556b34	\N	\N	f	f	f	\N	0	\N	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	\N	\N	\N	{}	\N	\N	\N	\N	\N	\N	f
\.


--
-- Data for Name: embeddings; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.embeddings (id, chunk_id, model_name, embedding, created_at, vector_embedding) FROM stdin;
\.


--
-- Data for Name: message_references; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.message_references (id, message_id, chunk_id, embedding_id, reference_score, created_at) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.messages (id, conversation_id, role, content, metadata, created_at, updated_at, ip_address, user_agent, browser, os, device_type, token_count, prompt_tokens, completion_tokens, model_name, temperature, is_visible, is_error, profile_id, user_id, model, system_fingerprint, finish_reason, request_id, latency, version, context_profile_id, feedback, feedback_rating) FROM stdin;
52a577f9-c7e1-4d53-892c-f7ffed07ddd2	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	Can you take a quick assessment?	\N	2025-04-03 18:30:23.398447+00	2025-04-03 18:30:23.398447+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
dc917747-d62c-4473-b0a0-ac8128eeef61	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	Ohhh, I'd be happy to help with that! Let's dive into a few questions about your mental well-being. How are you feeling emotionally right now?	\N	2025-04-03 18:30:25.120022+00	2025-04-03 18:30:25.120022+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
0208b488-d167-4ac4-ada7-b676f0795bdd	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	I am feeling neutral now	\N	2025-04-03 18:30:51.109444+00	2025-04-03 18:30:51.109444+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
f71083e2-bd64-465b-8b66-4582a5295d17	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	Hmm… neutral is an interesting place to be. Can you tell me how you've been sleeping lately?	\N	2025-04-03 18:30:53.175718+00	2025-04-03 18:30:53.175718+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
5cbceb39-a743-4fe1-abac-a43eadb81b3f	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	I've been sleeping well, thanks.	\N	2025-04-03 18:31:07.219678+00	2025-04-03 18:31:07.219678+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6f82ae82-3882-4d27-b7eb-893f4a281d66	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	That's great to hear! Good sleep is so important. How would you describe your energy levels during the day?	\N	2025-04-03 18:31:09.756066+00	2025-04-03 18:31:09.756066+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
5c7e043c-feac-42e6-a590-207bf4932d54	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	I'm usually quite tired.	\N	2025-04-03 18:31:22.094439+00	2025-04-03 18:31:22.094439+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
26b6a2c9-15b6-4238-ad99-a85d71a1d242	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	Uff… feeling tired can really take a toll. Do you feel you have a good social support system around you?	\N	2025-04-03 18:31:23.994335+00	2025-04-03 18:31:23.994335+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
bbd84594-ce67-418b-8b5e-5ba03cf9d5b2	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	Yes, I have supportive friends.	\N	2025-04-03 18:31:34.633161+00	2025-04-03 18:31:34.633161+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
612ddf66-8fb2-4fd8-ad14-bb17ccae020c	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	That's wonderful! Having supportive friends can make a huge difference. How often do you engage in activities that you find meaningful or enjoyable?	\N	2025-04-03 18:31:36.51096+00	2025-04-03 18:31:36.51096+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
82672763-3984-4198-9cb6-85b6f734f61c	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	I struggle to find engaging activities.	\N	2025-04-03 18:31:51.934994+00	2025-04-03 18:31:51.934994+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8788bbfa-b9e5-46f0-817b-9dc0ffc215ff	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	Ohhh, it can be tough to find engaging activities sometimes. Let's talk about how you usually manage stress when it arises. Do you have any coping strategies you rely on?	\N	2025-04-03 18:31:54.05107+00	2025-04-03 18:31:54.05107+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
d9cac5c9-8f93-4b81-b924-d53b0d676226	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	user	What do you recommend for stress management?	\N	2025-04-03 18:32:17.093961+00	2025-04-03 18:32:17.093961+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
dbabb9f1-f5ff-4942-af8c-266187fce4eb	2d4ed13f-8a02-41a7-aca0-6de7a590cd54	assistant	Sigh... there are several effective strategies for managing stress! You might try mindfulness exercises like deep breathing or meditation, physical activity like walking or yoga, or even journaling to express your thoughts. It’s all about finding what resonates with you. What have you tried before?	\N	2025-04-03 18:32:19.697166+00	2025-04-03 18:32:19.697166+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
3d2a1231-d25f-4166-a751-93ca37da308e	53984d2c-b409-4c84-a8da-d569f33f694c	user	Tell me about mental wellness	\N	2025-04-04 03:53:01.801093+00	2025-04-04 03:53:01.801093+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
d781df46-d538-43d7-bc52-04f6bfa8b8c6	53984d2c-b409-4c84-a8da-d569f33f694c	assistant	Hmm… mental wellness is all about maintaining a balance in your emotional, psychological, and social well-being. It affects how we think, feel, and act, impacting our daily lives. Good mental wellness helps you cope with stress, build relationships, and make choices. It’s important to nurture it just like physical health!	\N	2025-04-04 03:53:04.424698+00	2025-04-04 03:53:04.424698+00	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	\N	\N	\N	0	0	0	\N	\N	t	f	\N	\N	gpt-4o-mini	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.permissions (id, name, description, created_at) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.profiles (id, user_id, name, avatar_url, created_at, updated_at, auth_id, email, full_name, display_name, ip_address, last_login_ip, user_agent, browser, os, device_type, login_count, last_login_at, total_conversations, total_messages) FROM stdin;
53798562-909c-460a-a8df-a62cfc556b34	5094b493-e455-4171-862a-bd4bfe7f9005	\N	\N	2025-04-03 18:17:52.603009+00	2025-04-03 18:17:52.603009+00	5094b493-e455-4171-862a-bd4bfe7f9005	akhil@qusol.in	\N	\N	::ffff:127.0.0.1	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0	Firefox 136.0	macOS 10.15	desktop	1	2025-04-04 05:34:30.953+00	0	0
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.role_permissions (id, role_id, permission_id, created_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.roles (id, name, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: setting_audit_log; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.setting_audit_log (id, setting_id, user_id, old_value, new_value, created_at) FROM stdin;
\.


--
-- Data for Name: setting_categories; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.setting_categories (id, name, description, display_order, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.settings (id, category_id, key, description, display_name, value_type, value, is_encrypted, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: source_versions; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.source_versions (id, source_id, version_number, processed_content, processing_config, processed_at) FROM stdin;
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.sources (id, source_type, created_by_user_id, title, description, content, metadata, file_type, file_hash, raw_file_path, url, last_crawled_at, chunking_status, chunking_started_at, chunking_completed_at, chunking_error, chunking_config) FROM stdin;
\.


--
-- Data for Name: user_activities; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.user_activities (id, user_id, activity_type, description, metadata, ip_address, user_agent, created_at) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.user_roles (id, user_id, role_id, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.users (id, uuid, email, name, is_active, last_sign_in, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: visitors; Type: TABLE DATA; Schema: ai_agent; Owner: supabase_admin
--

COPY ai_agent.visitors (id, visitor_id, title, ip_address, user_agent, first_seen_at, last_seen_at, total_conversations, contact_email, contact_phone, location, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	e41dad6c-f0aa-4ea4-b019-26cedf546c96	{"action":"user_signedup","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-03-19 17:04:38.95494+00	
00000000-0000-0000-0000-000000000000	46241dd8-028c-4a9d-9338-de439115c908	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 17:04:38.959341+00	
00000000-0000-0000-0000-000000000000	c2c64af3-6374-4729-ab59-3da051d2ed52	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 17:05:21.232178+00	
00000000-0000-0000-0000-000000000000	3825157f-54ae-44b8-a918-afd22d3c92b2	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 17:10:19.173692+00	
00000000-0000-0000-0000-000000000000	4de9ff08-b9be-46f2-8714-18e18e2f6eca	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 17:11:01.496906+00	
00000000-0000-0000-0000-000000000000	ae182105-dbd1-48e9-8fd6-007b0dfaf868	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-03-19 17:23:59.866479+00	
00000000-0000-0000-0000-000000000000	ec5e0983-d53d-45b3-b9f1-ecf084097ad7	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 17:24:08.980972+00	
00000000-0000-0000-0000-000000000000	827868ca-9716-447d-b4df-8c4df93d90cc	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-19 17:30:11.978921+00	
00000000-0000-0000-0000-000000000000	8f7d10dd-3d38-4a88-94d9-65eec45b1d6f	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 02:26:35.622026+00	
00000000-0000-0000-0000-000000000000	62c19923-091b-4366-a882-2e41cd54b390	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 02:39:36.238404+00	
00000000-0000-0000-0000-000000000000	dd6823cf-92e8-4951-84ea-4654642a3c65	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-21 03:37:46.594021+00	
00000000-0000-0000-0000-000000000000	421e45d0-284f-49cd-b811-1345160752e8	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-21 03:37:46.594505+00	
00000000-0000-0000-0000-000000000000	951f768b-f15b-4964-92f4-ea2017f808e1	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-21 15:05:14.20144+00	
00000000-0000-0000-0000-000000000000	4485f417-4194-4b83-87a2-62663989e967	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-21 15:05:14.202296+00	
00000000-0000-0000-0000-000000000000	c4aad2fd-9478-4a9f-a73f-007b72cc4df0	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 15:05:21.95605+00	
00000000-0000-0000-0000-000000000000	1802931b-1e90-4fa3-ae84-8719fbe29fe0	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-21 15:32:05.397053+00	
00000000-0000-0000-0000-000000000000	a648f8cc-fc5b-4603-86aa-4c4b1e33eedd	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-21 15:32:05.397844+00	
00000000-0000-0000-0000-000000000000	ac851c6d-46c8-4755-811d-4db53530a2df	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-03-21 15:32:13.231381+00	
00000000-0000-0000-0000-000000000000	5275ee28-ef72-4634-bcdc-38792e303255	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 15:32:25.561445+00	
00000000-0000-0000-0000-000000000000	7d19d4d2-a549-43e8-8b55-747a99845a99	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 15:32:38.268457+00	
00000000-0000-0000-0000-000000000000	3309f15b-1d50-46e7-9555-741dcd8666a3	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 15:55:08.832643+00	
00000000-0000-0000-0000-000000000000	e8d727a7-3881-412f-8098-520cae79690b	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-03-21 16:06:48.482017+00	
00000000-0000-0000-0000-000000000000	974d87f9-9613-439f-85b9-88dfa45bd571	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 16:07:06.513415+00	
00000000-0000-0000-0000-000000000000	e5b1c769-3a4a-455f-bb35-b48da9815962	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-03-21 16:21:36.77246+00	
00000000-0000-0000-0000-000000000000	12e5fcc3-dcf0-48dc-8808-65e689430a54	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 16:21:44.75885+00	
00000000-0000-0000-0000-000000000000	12441262-da78-4844-9bc9-2750985e4cab	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-21 16:22:48.616205+00	
00000000-0000-0000-0000-000000000000	431f091e-e17a-48d2-bc0f-41a2be942f37	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 02:16:14.501218+00	
00000000-0000-0000-0000-000000000000	be1d5107-5540-48d3-bb13-ba02ec66ffbb	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 02:16:14.503171+00	
00000000-0000-0000-0000-000000000000	aaf6c9c2-7089-4b1c-82d2-2beb7afb8326	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-22 02:16:23.414807+00	
00000000-0000-0000-0000-000000000000	8c57206d-ab56-45b2-97a9-7a8770350d24	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-03-22 02:17:07.138175+00	
00000000-0000-0000-0000-000000000000	6613e4fa-98b8-4670-8311-a2fcb5564a65	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-22 02:17:24.826363+00	
00000000-0000-0000-0000-000000000000	90e3813b-03ad-462d-9019-9f6816b9bdba	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-22 02:28:04.726436+00	
00000000-0000-0000-0000-000000000000	02d13c3c-48c7-4070-867e-3d91d45f2d4a	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-22 02:55:49.735646+00	
00000000-0000-0000-0000-000000000000	9d8bd217-fd56-43be-959c-50167de1dda0	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-22 03:08:56.529978+00	
00000000-0000-0000-0000-000000000000	de20c5e7-ac95-49d2-a083-6ac7ebfe0f39	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-03-22 03:12:39.109643+00	
00000000-0000-0000-0000-000000000000	30096e08-5f19-484b-adcc-1344d482fdd0	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-22 03:12:45.941222+00	
00000000-0000-0000-0000-000000000000	769f3fe7-976f-4b23-adb5-d273e8215f24	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:19:34.622744+00	
00000000-0000-0000-0000-000000000000	89b836d1-c1e7-4e09-84f8-a950bedf8ac7	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:19:34.623336+00	
00000000-0000-0000-0000-000000000000	33183857-cfd0-4041-97d3-d9452b1cc983	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:04.628384+00	
00000000-0000-0000-0000-000000000000	a1423c56-538e-41a1-9231-6d3ac696d22f	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:04.628785+00	
00000000-0000-0000-0000-000000000000	f69f218d-32db-4ba4-a103-d3d456c63ebc	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:04.642604+00	
00000000-0000-0000-0000-000000000000	f6e641df-013b-48e6-a038-fce528e651cc	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:04.642879+00	
00000000-0000-0000-0000-000000000000	51401300-1d58-48c8-8818-d866a6465952	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:34.632869+00	
00000000-0000-0000-0000-000000000000	c9860dfa-7bda-4bca-aaf9-3619a61e4372	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:34.633313+00	
00000000-0000-0000-0000-000000000000	fae5756f-9408-47ee-8fdc-94d09c3c96a8	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:34.645052+00	
00000000-0000-0000-0000-000000000000	53c423d9-da04-493d-acf2-cfeb56c24fbe	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:20:34.645887+00	
00000000-0000-0000-0000-000000000000	5663e04d-0624-4b08-ab2e-13f441605b82	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:04.647506+00	
00000000-0000-0000-0000-000000000000	6de7871d-70aa-49dd-8f22-5f1fe8d7f52c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:04.647916+00	
00000000-0000-0000-0000-000000000000	0c0e85b4-afb1-4602-a34a-39147bd45941	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:04.657874+00	
00000000-0000-0000-0000-000000000000	12072b1d-4c93-49e6-a591-33a13bc2f456	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:04.658168+00	
00000000-0000-0000-0000-000000000000	f7e40071-1270-4eee-95af-783539c821f6	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:34.651198+00	
00000000-0000-0000-0000-000000000000	311ad61c-d6e5-4049-8a5e-6aef47f18d10	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:34.65155+00	
00000000-0000-0000-0000-000000000000	73d551e3-bdbc-401d-bbe1-07d56cd9183b	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:34.662366+00	
00000000-0000-0000-0000-000000000000	24dd9ebd-6e2f-4e72-8855-0c9e60d447fc	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:21:34.662675+00	
00000000-0000-0000-0000-000000000000	9ed5be79-efa4-413d-b97d-b8155dd6eb66	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:04.667307+00	
00000000-0000-0000-0000-000000000000	2b40b91c-8566-4088-8445-cca7ba51e48c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:04.667714+00	
00000000-0000-0000-0000-000000000000	8801be4d-9ce7-4824-a3ab-2dcd3d782c49	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:04.679226+00	
00000000-0000-0000-0000-000000000000	db7ec4ce-eadd-485a-b8b8-843fd3e981d3	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:04.679478+00	
00000000-0000-0000-0000-000000000000	b893860c-32b5-4ed4-a996-c2a2f4a72ed0	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:34.671759+00	
00000000-0000-0000-0000-000000000000	9f613e8e-fb4f-425a-9948-0e31bbc40473	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:34.672183+00	
00000000-0000-0000-0000-000000000000	d7eafffd-41fa-49f0-a95d-0dffa681ea97	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:34.684197+00	
00000000-0000-0000-0000-000000000000	1fc44aab-f93a-4cc0-9c41-ccc5c7e9e0b4	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:22:34.684542+00	
00000000-0000-0000-0000-000000000000	ea12a9c0-c8b9-4f1b-b515-daf585ec1010	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:04.682227+00	
00000000-0000-0000-0000-000000000000	99cf7a03-8a8a-4e60-a546-b85f0da78cdf	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:04.682616+00	
00000000-0000-0000-0000-000000000000	2723021f-b47b-451f-8a80-8ff70b18679c	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:04.694548+00	
00000000-0000-0000-0000-000000000000	03b35f65-d7ad-49c3-ae76-afe0abb7fe9f	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:04.694879+00	
00000000-0000-0000-0000-000000000000	d3e99c31-0bd8-4566-a71a-00d8f53da0f1	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:34.697429+00	
00000000-0000-0000-0000-000000000000	9b2e7c7c-6226-409e-b2de-f0c07a298f90	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:34.69785+00	
00000000-0000-0000-0000-000000000000	d46e4971-eedc-4edb-9390-cc16f4adb344	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:34.710881+00	
00000000-0000-0000-0000-000000000000	8c29a5bd-160f-49e4-8d11-cc3b443edd57	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:23:34.711224+00	
00000000-0000-0000-0000-000000000000	a9e7918a-81b8-4006-831c-374d3dc7cfd3	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:04.696608+00	
00000000-0000-0000-0000-000000000000	c2f7e26e-c7f4-4772-8852-44af29a91c8f	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:04.696949+00	
00000000-0000-0000-0000-000000000000	8bedf01f-30e4-4357-9ef8-3443dd3caa81	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:04.707633+00	
00000000-0000-0000-0000-000000000000	e247563c-8b98-438d-9a44-91acf4547f04	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:04.707927+00	
00000000-0000-0000-0000-000000000000	865b0eb3-ccd4-435a-9f66-aecfea59f945	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:34.707997+00	
00000000-0000-0000-0000-000000000000	26e2a256-7e04-4de4-aa26-41cc59c11804	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:34.708354+00	
00000000-0000-0000-0000-000000000000	ae4922d2-4b52-4095-920c-75b46fcfc114	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:34.72098+00	
00000000-0000-0000-0000-000000000000	67cb89bf-db5d-439c-9c8f-529e9bea9116	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:24:34.721327+00	
00000000-0000-0000-0000-000000000000	7ae940ba-6834-4ae5-8ad0-62fe56aa74c0	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:04.71109+00	
00000000-0000-0000-0000-000000000000	a5fa8b2b-a9a0-4850-a5eb-d9418fecd39b	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:04.711533+00	
00000000-0000-0000-0000-000000000000	ecae9e12-a8d2-4982-8c2a-004795027cda	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:04.722397+00	
00000000-0000-0000-0000-000000000000	fc37be53-3d70-41aa-b26b-7f0523f1aaaa	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:04.722708+00	
00000000-0000-0000-0000-000000000000	f5db232a-69db-4584-be7e-7e45639d4d5d	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:34.709135+00	
00000000-0000-0000-0000-000000000000	0e4ac1e6-7305-4595-b054-0b1b77a56e01	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:34.709987+00	
00000000-0000-0000-0000-000000000000	c67bb8e2-0410-4ee1-96fd-112d7646be60	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:34.721603+00	
00000000-0000-0000-0000-000000000000	ce48235c-8701-4d52-80eb-6187397fcc80	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:25:34.721941+00	
00000000-0000-0000-0000-000000000000	f1661a62-0105-49ce-b0fe-a026c6d11a3e	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:04.721731+00	
00000000-0000-0000-0000-000000000000	a678707f-dac2-4632-a645-59c6ba14e0bd	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:04.722135+00	
00000000-0000-0000-0000-000000000000	f01a52ee-df4a-412b-807b-b92c923f8f75	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:04.736664+00	
00000000-0000-0000-0000-000000000000	69370e62-5b26-483f-9bab-917e31765c36	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:04.736985+00	
00000000-0000-0000-0000-000000000000	7fe8933b-46b0-4120-bbed-d57fd5d9ab70	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:34.73089+00	
00000000-0000-0000-0000-000000000000	3f3a6e2a-6f2c-49fc-be9f-dd19e252ea68	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:34.731337+00	
00000000-0000-0000-0000-000000000000	0c67739c-b31e-4226-b542-f67fa577a0a5	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:34.743128+00	
00000000-0000-0000-0000-000000000000	290b54a6-7532-4ac1-b7f8-20b12601aeec	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:26:34.743449+00	
00000000-0000-0000-0000-000000000000	e1511bf5-c167-4520-ad69-b8651b4225f2	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:04.743605+00	
00000000-0000-0000-0000-000000000000	49d75cc6-3d9a-40df-b0b7-1a5e7b9450b8	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:04.744017+00	
00000000-0000-0000-0000-000000000000	43b7694d-b118-48fa-9cc8-0a335a7d8f39	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:04.754721+00	
00000000-0000-0000-0000-000000000000	5eebf36f-f3c0-4d7d-b07d-aaf51cac0198	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:04.755034+00	
00000000-0000-0000-0000-000000000000	408c7c03-9e1d-45a7-9973-6b93f49a61f9	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:34.750179+00	
00000000-0000-0000-0000-000000000000	e563c16d-587e-4cc3-b16d-e9c2950cac88	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:34.750646+00	
00000000-0000-0000-0000-000000000000	036b6d02-d191-4da4-98e8-e9a574e82b71	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:34.762802+00	
00000000-0000-0000-0000-000000000000	a2beb1c8-5a1a-4d08-aeb8-5402b582bc73	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:27:34.763123+00	
00000000-0000-0000-0000-000000000000	0e4d795a-d47e-4736-97d8-d625359a4ee4	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:04.754724+00	
00000000-0000-0000-0000-000000000000	9fe42872-f880-44e7-a48d-df2b497e910a	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:04.755174+00	
00000000-0000-0000-0000-000000000000	2681a48c-8fe1-46ca-ad6c-d8a458304b20	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:04.766827+00	
00000000-0000-0000-0000-000000000000	c9d6858d-32bb-42db-97cd-87f2a4bedd9a	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:04.767153+00	
00000000-0000-0000-0000-000000000000	4dc25ff6-8503-46d9-afc1-76fb265b749b	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:34.763154+00	
00000000-0000-0000-0000-000000000000	fe33d968-9d85-4ea7-b011-7b1bce810a02	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:34.763566+00	
00000000-0000-0000-0000-000000000000	66778614-a58d-4451-ad28-f409589a0747	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:34.774215+00	
00000000-0000-0000-0000-000000000000	69d374df-7062-46a7-8f40-a1d17399a9a2	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:28:34.774596+00	
00000000-0000-0000-0000-000000000000	4ed49e72-90ed-477d-b4d5-b71b76f66cff	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:04.760916+00	
00000000-0000-0000-0000-000000000000	bdc999bf-795d-418a-b24a-d0456190a921	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:04.761331+00	
00000000-0000-0000-0000-000000000000	dfd38b1a-dc03-4aff-b221-b357cf39d949	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:04.771377+00	
00000000-0000-0000-0000-000000000000	b40a5546-5441-4b8e-9bb2-0ea143b52646	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:04.77167+00	
00000000-0000-0000-0000-000000000000	3b5f839f-2393-4ca7-a728-313a67db061f	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:34.770989+00	
00000000-0000-0000-0000-000000000000	703b2d2b-80be-4bb6-9dd5-20acde045740	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:34.771361+00	
00000000-0000-0000-0000-000000000000	d2ea4311-4ae5-4a1c-9dd6-33947e65b622	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:34.782792+00	
00000000-0000-0000-0000-000000000000	810788f9-ce47-4216-a1e4-30498fa93d0d	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:29:34.783141+00	
00000000-0000-0000-0000-000000000000	0a9722f9-e4bd-4fed-af5b-ccbb1010acb8	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:04.767652+00	
00000000-0000-0000-0000-000000000000	87c68333-015c-4333-9116-4233ee78cdfd	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:04.768101+00	
00000000-0000-0000-0000-000000000000	cbf925ab-4628-4687-951f-756909796d72	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:04.779675+00	
00000000-0000-0000-0000-000000000000	82951bef-4d92-4d60-ab2c-3e0b5c4c062d	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:04.779936+00	
00000000-0000-0000-0000-000000000000	1e60e33d-074f-4c4a-9aef-8c2c36f8de95	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:34.777264+00	
00000000-0000-0000-0000-000000000000	f458bdfb-a721-43bf-8afc-9494aa358cc5	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:34.777648+00	
00000000-0000-0000-0000-000000000000	10922511-2ad1-43e4-9b02-c562af4fb6e1	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:34.787765+00	
00000000-0000-0000-0000-000000000000	8cfdc4da-6ad5-42f1-9d5a-c1ae88be9a2c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:30:34.788032+00	
00000000-0000-0000-0000-000000000000	977f3900-cda0-4458-8e80-5f4105b4cf7d	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:04.780975+00	
00000000-0000-0000-0000-000000000000	26bdf215-42ea-4e33-8036-50ae7e2ab2e0	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:04.781397+00	
00000000-0000-0000-0000-000000000000	81eca975-5af6-4f7d-883f-89cab4ab9e51	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:04.800513+00	
00000000-0000-0000-0000-000000000000	a84a447e-c2b6-44fa-b683-32148a2a889c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:04.800852+00	
00000000-0000-0000-0000-000000000000	a220a62b-b845-4252-bdff-32be2e6fb636	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:34.793875+00	
00000000-0000-0000-0000-000000000000	861ef7c2-5f6c-4b70-a142-13898f2399e9	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:34.79424+00	
00000000-0000-0000-0000-000000000000	ff54603a-8515-4556-9bff-40cfe4daab1f	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:34.806381+00	
00000000-0000-0000-0000-000000000000	67595b38-0118-491c-bec9-4b7aebde7d1c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:31:34.806717+00	
00000000-0000-0000-0000-000000000000	8d215dbf-7eb0-4c39-8a0d-f1b5a6232c51	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:04.804501+00	
00000000-0000-0000-0000-000000000000	9b1d2992-c90e-4b00-81f1-5494568c581b	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:04.804827+00	
00000000-0000-0000-0000-000000000000	ac30a3c0-c8f1-410f-9ae2-ad8dd2fc2835	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:04.82706+00	
00000000-0000-0000-0000-000000000000	45bbfc74-4958-44a5-93e6-fc4155a23215	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:04.827382+00	
00000000-0000-0000-0000-000000000000	676e63de-90b6-43b5-be7d-0c863aa01611	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:34.809688+00	
00000000-0000-0000-0000-000000000000	c6e083ae-6942-4a05-83cb-5f81e434e2ca	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:34.810078+00	
00000000-0000-0000-0000-000000000000	6c921978-c1a9-4566-a515-3b98e2f23199	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:34.824189+00	
00000000-0000-0000-0000-000000000000	871ce193-bfc6-49ed-b17c-d172db4c4816	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:32:34.824515+00	
00000000-0000-0000-0000-000000000000	db502250-6c7e-4dc6-acbf-5070e26a16fc	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:04.810301+00	
00000000-0000-0000-0000-000000000000	78e6db78-e0a1-4d02-a287-4e6cc062a2b2	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:04.810744+00	
00000000-0000-0000-0000-000000000000	e020de3c-ad81-482d-b888-d31eb41e9fc7	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:04.823921+00	
00000000-0000-0000-0000-000000000000	45e8e6be-e7dd-4f94-8b14-a4aea7a7cca1	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:04.824228+00	
00000000-0000-0000-0000-000000000000	7ae66a7d-98cc-46dc-8da9-a58d6204a10d	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:34.811812+00	
00000000-0000-0000-0000-000000000000	8c362a12-0dcd-4105-aeae-f1d391a97ccf	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:34.812872+00	
00000000-0000-0000-0000-000000000000	957832a4-dd9b-47a0-981a-4e42118beaef	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:34.82778+00	
00000000-0000-0000-0000-000000000000	a76bea90-1b0f-481f-b51c-cf12ece1b6cc	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:33:34.828152+00	
00000000-0000-0000-0000-000000000000	be388529-ed49-464f-a1fd-77e76a98c4fa	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:04.809369+00	
00000000-0000-0000-0000-000000000000	0b67e411-04e9-4a29-ae86-24faa22ed8e1	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:04.809669+00	
00000000-0000-0000-0000-000000000000	abf4bd1b-a495-4ab9-86a1-b55f027034d4	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:04.819421+00	
00000000-0000-0000-0000-000000000000	4cb33ad7-a8d9-4c7c-939c-681a946e9fca	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:04.819707+00	
00000000-0000-0000-0000-000000000000	8415fc19-190b-4f6c-b355-1c725abedc53	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:34.81173+00	
00000000-0000-0000-0000-000000000000	b8f27c02-e93a-4bc3-933b-2338951290f8	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:34.81206+00	
00000000-0000-0000-0000-000000000000	bcd1e0ad-2e56-457d-a6da-6dab885470d1	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:34.822496+00	
00000000-0000-0000-0000-000000000000	972631a2-854c-4312-b6f2-e4e91e199058	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:34:34.822718+00	
00000000-0000-0000-0000-000000000000	0071aa48-ab85-4eff-8187-b357e798035a	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:04.815163+00	
00000000-0000-0000-0000-000000000000	fe749399-86f0-48ad-ac4c-7cde13aa068a	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:04.815627+00	
00000000-0000-0000-0000-000000000000	4205cdc7-d68c-4d87-b066-12238a981687	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:04.826055+00	
00000000-0000-0000-0000-000000000000	7a6ebf8d-3ef6-42b8-a29f-3d9a54b14a22	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:04.826399+00	
00000000-0000-0000-0000-000000000000	f509da99-eb99-40c1-aacb-db4c0b84e93a	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:34.828476+00	
00000000-0000-0000-0000-000000000000	6ae82161-e877-453a-9d92-1c180376c4f3	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:34.828971+00	
00000000-0000-0000-0000-000000000000	11ce8ebd-ac68-4146-9927-9107c98cd929	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:34.845139+00	
00000000-0000-0000-0000-000000000000	57a13849-801b-4286-8dbd-352737f1e57a	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:35:34.845519+00	
00000000-0000-0000-0000-000000000000	7a33cb4c-e57f-4a4d-a95d-7f6d3f4a535e	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:04.827899+00	
00000000-0000-0000-0000-000000000000	50dc6d38-72eb-48c5-8842-e8124b0c1501	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:04.828305+00	
00000000-0000-0000-0000-000000000000	52d24472-078b-4669-8e29-a44723edbbb6	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:04.839922+00	
00000000-0000-0000-0000-000000000000	4e17dc9c-62ce-4d04-8ec0-1a5b18bf7406	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:04.8402+00	
00000000-0000-0000-0000-000000000000	b20538e2-9cd0-43a9-a57e-84854e1238a3	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:34.826052+00	
00000000-0000-0000-0000-000000000000	220d49fa-5529-4ed9-886c-a4cb4747cc8c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:34.826423+00	
00000000-0000-0000-0000-000000000000	78b6f8ca-f57d-4a12-8ba3-1ed7f3fc14c6	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:34.838119+00	
00000000-0000-0000-0000-000000000000	4d0e6d55-793f-481f-9d35-9d042cd805a7	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:36:34.838444+00	
00000000-0000-0000-0000-000000000000	a615a774-d05b-4ed7-864e-4bfd5ffee045	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:04.838354+00	
00000000-0000-0000-0000-000000000000	a5621fde-9b52-46e1-a257-fcd8b717a26c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:04.838836+00	
00000000-0000-0000-0000-000000000000	e2a1ca1f-72bd-402d-83bc-7dc750da13a7	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:04.850831+00	
00000000-0000-0000-0000-000000000000	e30640e9-c1c6-4ef8-961d-28dd3ae32e86	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:04.851133+00	
00000000-0000-0000-0000-000000000000	c7b45a4d-a4d4-4f43-991c-422b73bfa585	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:34.833928+00	
00000000-0000-0000-0000-000000000000	6458cf39-d57e-4318-87b3-4b7e1d4066b5	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:34.834343+00	
00000000-0000-0000-0000-000000000000	6b3a2a7f-950c-4a14-a44e-f300fe760b6f	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:34.846759+00	
00000000-0000-0000-0000-000000000000	a7b99327-2e1e-4b9b-81d8-d9dba1980b3d	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:37:34.847078+00	
00000000-0000-0000-0000-000000000000	26ef2070-c906-43a7-814f-4b0b5e6a694f	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:04.836532+00	
00000000-0000-0000-0000-000000000000	eadf2483-10f4-43a6-b324-1ff32e992d28	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:04.837008+00	
00000000-0000-0000-0000-000000000000	01d18785-bf44-4d7c-bc83-3b0510ec5e5c	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:04.847083+00	
00000000-0000-0000-0000-000000000000	242bf932-3b55-4a11-8c91-e5fbcdf1b275	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:04.847343+00	
00000000-0000-0000-0000-000000000000	eb81d374-8178-42d0-a35a-6036e8e786c1	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:34.843142+00	
00000000-0000-0000-0000-000000000000	28b4218e-29b9-42a3-a7a6-0a72432236f6	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:34.843561+00	
00000000-0000-0000-0000-000000000000	30df2b47-4ce6-4454-91fe-0d7a59d8e95a	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:34.85611+00	
00000000-0000-0000-0000-000000000000	4e04c8e1-a84d-4286-af9f-1b03fc593d92	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:38:34.856521+00	
00000000-0000-0000-0000-000000000000	baa8cd89-795b-4564-904b-39b0fa32614e	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:04.844513+00	
00000000-0000-0000-0000-000000000000	642502e1-aad5-48cb-9bd6-207f487342cf	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:04.844884+00	
00000000-0000-0000-0000-000000000000	8cb6df80-fff3-4e5b-a816-02a5bc43c900	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:04.855472+00	
00000000-0000-0000-0000-000000000000	0a9dc253-9555-45cc-a098-512cc86452df	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:04.855774+00	
00000000-0000-0000-0000-000000000000	80f7c86e-6fbb-45b8-a222-6a42660110f9	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:34.851592+00	
00000000-0000-0000-0000-000000000000	1ca10e13-46c5-4484-aaa3-db71b6536810	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:34.852022+00	
00000000-0000-0000-0000-000000000000	191ae46c-030c-4111-92c8-aec844ff52a2	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:34.864466+00	
00000000-0000-0000-0000-000000000000	892d191e-31d7-4350-84bb-8d8b53aa84a0	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:39:34.864812+00	
00000000-0000-0000-0000-000000000000	b2e5c7ed-e926-4a8b-aa69-430d2c8a71ad	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:04.855985+00	
00000000-0000-0000-0000-000000000000	801385f0-4875-4aec-b873-2d42a111431e	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:04.85645+00	
00000000-0000-0000-0000-000000000000	a7758079-8b78-4dca-bfd4-c446b81a0465	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:04.869133+00	
00000000-0000-0000-0000-000000000000	b3140142-96fd-4326-9b27-24a4fb4d2556	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:04.86941+00	
00000000-0000-0000-0000-000000000000	c3300a68-2bc5-4331-8f6e-39ecbce06aac	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:34.858834+00	
00000000-0000-0000-0000-000000000000	aece37bd-b985-4448-a164-785a8d7af6f5	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:34.859248+00	
00000000-0000-0000-0000-000000000000	6323eb5e-1f47-4830-bb98-10d79bbcabb5	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:34.872636+00	
00000000-0000-0000-0000-000000000000	db1c4c8a-bfd6-42a8-b6ae-a12cfa2e1228	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:40:34.87303+00	
00000000-0000-0000-0000-000000000000	2d6e1ee0-8188-465f-9847-dffb9b69a3db	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:41:04.861024+00	
00000000-0000-0000-0000-000000000000	ce3aa741-dcd8-4c45-bd40-65e59ed4e3ee	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:41:04.861394+00	
00000000-0000-0000-0000-000000000000	bfcd054b-c8e4-46cf-ac08-47b074f5cc14	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:41:04.874997+00	
00000000-0000-0000-0000-000000000000	a5e4e7ff-3e59-4ed1-938c-185353769a61	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 03:41:04.875323+00	
00000000-0000-0000-0000-000000000000	d447f0d5-b5ff-4ff4-84a7-dc399a776bb9	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 12:31:39.778331+00	
00000000-0000-0000-0000-000000000000	5ec118b2-cc1f-4e45-b42b-b7786e29368c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 12:31:39.778648+00	
00000000-0000-0000-0000-000000000000	af758615-7ed0-4e29-b23a-4fef54f07976	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 12:35:21.291059+00	
00000000-0000-0000-0000-000000000000	2468a1ad-038d-46d2-aa4d-168c5bb3851c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-22 12:35:21.2927+00	
00000000-0000-0000-0000-000000000000	ba4c4f70-9e75-4d54-9c2a-fb8dc0510761	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-26 14:45:47.416914+00	
00000000-0000-0000-0000-000000000000	938c97e0-dd46-46fb-9905-d6ba590aca80	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-26 14:45:47.418931+00	
00000000-0000-0000-0000-000000000000	e098b53e-38f4-4eca-8e39-4feaa49b7a29	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 14:46:21.589869+00	
00000000-0000-0000-0000-000000000000	c370426d-c9a7-44c3-b212-0648041271f8	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 15:37:04.777951+00	
00000000-0000-0000-0000-000000000000	26480011-549d-4b04-a55e-ead1fe8006c4	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-26 15:56:19.407377+00	
00000000-0000-0000-0000-000000000000	f0a25931-74c6-4643-a738-2f8780077537	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-26 15:56:19.40939+00	
00000000-0000-0000-0000-000000000000	b5078e37-993e-42ca-89d1-58431fea2587	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 15:59:35.448657+00	
00000000-0000-0000-0000-000000000000	25d26b4e-d77f-4fd0-9615-2acb7d9d7bbb	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 16:03:25.889677+00	
00000000-0000-0000-0000-000000000000	4a43258c-5823-41f3-b249-9cfe85fdb0f6	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-26 16:07:09.499046+00	
00000000-0000-0000-0000-000000000000	0b0e5409-3d35-4860-9b96-33730ad6e03d	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-26 16:07:09.499505+00	
00000000-0000-0000-0000-000000000000	baf2f5cb-1ea4-45fa-81f7-3f67927c924b	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 16:08:29.194292+00	
00000000-0000-0000-0000-000000000000	04e6987e-2d82-4ce5-8ced-aa0757495df6	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 16:11:13.565751+00	
00000000-0000-0000-0000-000000000000	314ad47c-6e60-47e3-91a2-35882ed67067	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:12:15.120213+00	
00000000-0000-0000-0000-000000000000	87eeb069-b627-4f9e-91d0-9d1c90dc9679	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-26 17:25:46.000245+00	
00000000-0000-0000-0000-000000000000	33b3cd8c-efd9-48fb-a3bf-ee24c0b78686	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 12:42:38.954951+00	
00000000-0000-0000-0000-000000000000	0d343581-a42a-4442-9fc3-3ba8709e40da	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 12:49:12.284444+00	
00000000-0000-0000-0000-000000000000	1b859a39-4a12-411a-b7c2-47fa16071ce5	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 13:28:41.562974+00	
00000000-0000-0000-0000-000000000000	39d3919a-2eee-49c6-9b52-bf127e5dee2e	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-27 15:17:13.154902+00	
00000000-0000-0000-0000-000000000000	e4fe03cb-2abd-4e5a-a7b8-c3f0c778cf29	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-27 15:17:13.155559+00	
00000000-0000-0000-0000-000000000000	b44270ed-b0b8-4739-8d89-60963af4c231	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 15:19:22.454981+00	
00000000-0000-0000-0000-000000000000	784e1bf0-803b-4086-9434-6d31b60f72da	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 16:04:49.53655+00	
00000000-0000-0000-0000-000000000000	7f3f4b63-0eea-47b5-93f0-918f5d0913d6	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 16:07:39.587365+00	
00000000-0000-0000-0000-000000000000	ef603893-1b11-4fd4-be9a-ce84fad31aad	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-27 16:14:47.027923+00	
00000000-0000-0000-0000-000000000000	f1f77747-f2ba-49e2-847a-9a59bde13401	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 01:38:06.746263+00	
00000000-0000-0000-0000-000000000000	bf8b84c2-2341-49d6-8b7f-c5dfddf4575a	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 01:49:09.134934+00	
00000000-0000-0000-0000-000000000000	462c044b-3cfd-4225-bd4f-826eb8c30e27	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 01:49:56.107506+00	
00000000-0000-0000-0000-000000000000	5e508f45-b528-434d-8cfa-db310ca9261e	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 01:52:07.071777+00	
00000000-0000-0000-0000-000000000000	3d9607f4-578d-474c-9c22-db23bd298b36	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 02:28:25.476789+00	
00000000-0000-0000-0000-000000000000	54391ed3-901c-460d-bb61-e4887c766ca4	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 02:29:03.08463+00	
00000000-0000-0000-0000-000000000000	f9d7153d-3f08-4a6f-9270-50eee5c33bf6	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 02:32:18.206985+00	
00000000-0000-0000-0000-000000000000	4f3580ab-c89e-4780-9dc8-fc0bc67bebec	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-28 02:39:52.079059+00	
00000000-0000-0000-0000-000000000000	d1d635f9-4729-4d5d-adfd-04e45a9e9e0a	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:45:14.738711+00	
00000000-0000-0000-0000-000000000000	e9efff25-fe38-4770-9a00-63d921b96241	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:45:14.739224+00	
00000000-0000-0000-0000-000000000000	8a82929c-5628-4157-a4db-9cc34e881cb2	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:45:44.57196+00	
00000000-0000-0000-0000-000000000000	eda91732-126b-436f-9bb4-60d2b5a5ad38	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:45:44.572366+00	
00000000-0000-0000-0000-000000000000	73a33dea-20a5-4364-952b-c473eef0b9b8	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:45:44.588064+00	
00000000-0000-0000-0000-000000000000	2df5ce93-b23a-4e05-926e-a2abb4358922	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:45:44.588474+00	
00000000-0000-0000-0000-000000000000	fb9badc6-9bf6-4d2c-993b-b4f9f521dae3	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:14.575994+00	
00000000-0000-0000-0000-000000000000	4824e9e8-eaea-416b-9679-c0823c8f96e7	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:14.576407+00	
00000000-0000-0000-0000-000000000000	4144549d-dba0-421a-8e5e-07e4f5562216	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:14.611347+00	
00000000-0000-0000-0000-000000000000	65636afd-9429-4646-a59a-93c1df74110f	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:14.611774+00	
00000000-0000-0000-0000-000000000000	fa3c2891-d436-4b9e-86d6-4d67dfcec160	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:44.572801+00	
00000000-0000-0000-0000-000000000000	c9d3fa0a-6baf-4287-b088-915f64f023ef	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:44.573165+00	
00000000-0000-0000-0000-000000000000	6e2f5f39-8785-45b2-8513-0c689dec16ae	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:44.586642+00	
00000000-0000-0000-0000-000000000000	7a96ccec-9d48-453c-8019-4e238c96722c	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:46:44.586963+00	
00000000-0000-0000-0000-000000000000	c5f1d54e-9c27-480c-992d-84b410db1cfa	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:14.579818+00	
00000000-0000-0000-0000-000000000000	7b4ba37e-4eb7-4bdb-a1e4-f090a564d872	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:14.580211+00	
00000000-0000-0000-0000-000000000000	f4ee0d61-1347-4b72-902e-b11d3410033d	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:14.592486+00	
00000000-0000-0000-0000-000000000000	8e91f384-d504-4a27-a5b9-b28dcdc94e6d	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:14.592761+00	
00000000-0000-0000-0000-000000000000	e5f92178-acba-4db4-82fb-a96ed9ab09f7	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:44.58083+00	
00000000-0000-0000-0000-000000000000	b9474bfd-3d8f-4b43-ab60-3586975f4d47	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:44.581258+00	
00000000-0000-0000-0000-000000000000	782bd1a9-bf63-4830-8403-130826054961	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:44.594626+00	
00000000-0000-0000-0000-000000000000	9b4fe569-f35e-4782-aef5-d3bf305e8dc8	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:47:44.594971+00	
00000000-0000-0000-0000-000000000000	2b160d7c-e36d-4b51-9b48-6a501fed1cfe	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:48:14.586772+00	
00000000-0000-0000-0000-000000000000	af85e51b-020a-453c-a4d8-3e65c0f9f004	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:48:14.587835+00	
00000000-0000-0000-0000-000000000000	215efc4a-4a9c-408d-ba6e-93d497149883	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:48:14.59848+00	
00000000-0000-0000-0000-000000000000	024412d3-37f8-4164-9c73-f25f7d0031c8	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:48:14.59871+00	
00000000-0000-0000-0000-000000000000	37551796-bb30-4a80-83d2-608d1af7623e	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:48:53.92032+00	
00000000-0000-0000-0000-000000000000	ec7fbc81-beac-4c2c-bc66-41b9671bd600	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 02:48:53.920861+00	
00000000-0000-0000-0000-000000000000	0ae8e34f-d8b0-4261-8622-74b576de215c	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.170078+00	
00000000-0000-0000-0000-000000000000	b33e7b25-b9be-4ffd-83bd-76aad4675fb3	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.170701+00	
00000000-0000-0000-0000-000000000000	d12a8719-63af-4ffe-8647-291c7d16a072	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.22901+00	
00000000-0000-0000-0000-000000000000	7c2b504f-bc3e-486c-b6d8-7c92ce74c27f	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.246405+00	
00000000-0000-0000-0000-000000000000	10cbbaf6-10a6-4ca7-ac2f-d2eea6c77f81	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.294139+00	
00000000-0000-0000-0000-000000000000	9fee914d-6a87-4f65-b1d4-4e8f090b41a8	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.319993+00	
00000000-0000-0000-0000-000000000000	c8c2ed04-be6c-46c9-b449-c453eaa70134	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-28 04:07:32.331971+00	
00000000-0000-0000-0000-000000000000	807dc3f2-e14e-4045-8e28-ac6b0392375b	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.343564+00	
00000000-0000-0000-0000-000000000000	ea69bfb7-877b-4bb4-8be9-31651a6f1704	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.344843+00	
00000000-0000-0000-0000-000000000000	38325489-d39b-48f4-a4ca-4f33937c02bd	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.456636+00	
00000000-0000-0000-0000-000000000000	f7b075f8-126d-486a-b4bb-edfbe5c4abfa	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.493231+00	
00000000-0000-0000-0000-000000000000	8ec930dd-9db1-461a-9d5e-c8f09021cf5a	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.562987+00	
00000000-0000-0000-0000-000000000000	24eef8db-ac21-42b6-8dfa-15d6ec3620f3	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.592629+00	
00000000-0000-0000-0000-000000000000	a1533f16-3428-4a5b-bb94-02f4c32a223c	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-03-31 04:20:58.631826+00	
00000000-0000-0000-0000-000000000000	9f245eb8-629b-40d8-9b87-1220412237c9	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 14:06:58.052923+00	
00000000-0000-0000-0000-000000000000	0c10269d-82ef-4e68-8a04-778d81f07066	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 14:06:58.055248+00	
00000000-0000-0000-0000-000000000000	2aa85cbc-ae2b-4c3f-9c47-0058ba347542	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 14:07:08.39387+00	
00000000-0000-0000-0000-000000000000	b6f7f955-5954-473b-bafb-fcd6fcda547a	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 14:15:55.023075+00	
00000000-0000-0000-0000-000000000000	22b2bb09-9f20-4925-ac15-9b923e9c53d0	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 14:33:31.61782+00	
00000000-0000-0000-0000-000000000000	f80eeb93-b00f-4176-82ea-95ee87da739f	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 14:33:31.762757+00	
00000000-0000-0000-0000-000000000000	db5615ca-8dc0-4781-8f86-31b492e9c6e6	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 14:42:51.20724+00	
00000000-0000-0000-0000-000000000000	439eb0eb-e558-4f00-b927-c4626b583290	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 14:42:51.208445+00	
00000000-0000-0000-0000-000000000000	be2b80f7-10b2-4139-866b-798d701aa1d2	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 15:40:56.82898+00	
00000000-0000-0000-0000-000000000000	22fbbe08-3c27-4a64-8538-c92ad785dc86	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 15:40:56.829465+00	
00000000-0000-0000-0000-000000000000	5ecf71e1-b4e3-4a3f-a89a-2eb0b5548397	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 16:36:30.87557+00	
00000000-0000-0000-0000-000000000000	ddc906a1-405a-455e-80aa-f6ff80051553	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-01 16:36:30.877507+00	
00000000-0000-0000-0000-000000000000	29dde384-abe7-42af-8cc1-4998c3c8487b	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 16:51:58.992299+00	
00000000-0000-0000-0000-000000000000	a90caac9-389b-40e1-95e5-fef4ad35b153	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 17:04:16.474924+00	
00000000-0000-0000-0000-000000000000	03eedd1e-2c84-4ed3-9405-455710ec13d1	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-01 17:08:16.700799+00	
00000000-0000-0000-0000-000000000000	3dca4168-8e48-4d87-8354-686601e7d7a5	{"action":"user_repeated_signup","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-04-03 17:06:48.795523+00	
00000000-0000-0000-0000-000000000000	92ecef28-a0ba-4cce-9cb7-2a5bc0980dea	{"action":"user_repeated_signup","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-04-03 17:35:09.630174+00	
00000000-0000-0000-0000-000000000000	e7e7f2e9-877a-4fda-bb91-c481e67f0ce3	{"action":"user_repeated_signup","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-04-03 17:35:33.04852+00	
00000000-0000-0000-0000-000000000000	b1ba06fe-9d0e-4e16-a058-082bbc1644c3	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-03 17:35:57.69521+00	
00000000-0000-0000-0000-000000000000	b27c843e-7cb3-45d1-adc1-8ba6e0657f80	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-03 18:42:04.131448+00	
00000000-0000-0000-0000-000000000000	54a5b274-254c-4c2b-aeb4-18bd09e952bc	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-03 18:42:04.134924+00	
00000000-0000-0000-0000-000000000000	0e344a69-8ca9-4752-a917-2f1b716f5096	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-03 18:42:05.092457+00	
00000000-0000-0000-0000-000000000000	359fb1db-98fc-4fcc-b05c-63892652dea2	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-04 03:51:59.469809+00	
00000000-0000-0000-0000-000000000000	c687c0c9-935e-447e-a2b3-8c05965df672	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-04 03:51:59.470496+00	
00000000-0000-0000-0000-000000000000	2e0064e2-b2c6-4408-9e22-8ab9f0666585	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-04 03:55:16.414428+00	
00000000-0000-0000-0000-000000000000	eda9d4ed-2c6b-4a17-98cb-3c3fc79c65b6	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-04 04:51:24.50199+00	
00000000-0000-0000-0000-000000000000	3a87cc04-81d8-4582-bf5d-51afc7a68db1	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-04 05:17:51.425243+00	
00000000-0000-0000-0000-000000000000	5d5d5b2d-f160-4647-abbb-69dc73f43e7b	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-07 17:13:52.154854+00	
00000000-0000-0000-0000-000000000000	0ac285e8-8d53-4084-9567-5f6765f37227	{"action":"token_refreshed","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-07 18:13:50.031493+00	
00000000-0000-0000-0000-000000000000	745cfd9a-d64b-4603-8d74-281b1d2c43da	{"action":"token_revoked","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"token"}	2025-04-07 18:13:50.03181+00	
00000000-0000-0000-0000-000000000000	f0abf181-e509-480c-8ea3-419e67efaa6a	{"action":"logout","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account"}	2025-04-07 18:29:07.669028+00	
00000000-0000-0000-0000-000000000000	af6a8f34-79ef-4c4f-a93e-000595cf5e94	{"action":"login","actor_id":"5094b493-e455-4171-862a-bd4bfe7f9005","actor_username":"akhil@qusol.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-04-07 18:29:16.728606+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
5094b493-e455-4171-862a-bd4bfe7f9005	5094b493-e455-4171-862a-bd4bfe7f9005	{"sub": "5094b493-e455-4171-862a-bd4bfe7f9005", "email": "akhil@qusol.in", "last_name": "R S", "first_name": "Akhil", "email_verified": false, "phone_verified": false}	email	2025-03-19 17:04:38.953272+00	2025-03-19 17:04:38.9533+00	2025-03-19 17:04:38.9533+00	7a2e4d85-4486-495c-9e26-a407fa9e4207
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
b7312520-a9bf-4681-a062-58ee486ef984	2025-04-07 18:29:16.730157+00	2025-04-07 18:29:16.730157+00	password	63936b09-6205-4707-a5aa-b9b5856448d1
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	177	DxV4QIyV-7_T9bbFFX66xg	5094b493-e455-4171-862a-bd4bfe7f9005	f	2025-04-07 18:29:16.729385+00	2025-04-07 18:29:16.729385+00	\N	b7312520-a9bf-4681-a062-58ee486ef984
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
b7312520-a9bf-4681-a062-58ee486ef984	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:29:16.728998+00	2025-04-07 18:29:16.728998+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0	10.89.0.3	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	5094b493-e455-4171-862a-bd4bfe7f9005	authenticated	authenticated	akhil@qusol.in	$2a$10$sfP0HeLsEQGtDEGW9zZOZ.0FRwZECQsseMmoqiKwgaTfBP2RnIXB2	2025-03-19 17:04:38.956014+00	\N		\N		\N			\N	2025-04-07 18:29:16.728958+00	{"provider": "email", "providers": ["email"]}	{"sub": "5094b493-e455-4171-862a-bd4bfe7f9005", "email": "akhil@qusol.in", "last_name": "R S", "first_name": "Akhil", "email_verified": true, "phone_verified": false}	\N	2025-03-19 17:04:38.947784+00	2025-04-07 18:29:16.730032+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.activities (id, project_id, user_id, entity_type, entity_id, action, details, created_at) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.comments (id, content, task_id, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (id, date_created, vote, page, metadata) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.files (id, name, size, mime_type, storage_path, project_id, uploaded_by, created_at) FROM stdin;
d3e94f7a-efc2-44d2-9c48-1fe6ef525ba4	11 Columns.3mf	5000489		f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743523385613-qgoe6hcpov.3mf	f6865c7b-5293-49a2-8a4a-017aa785c9c9	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:03:05.801648+00
c21dbc90-f1b1-4cf1-bc86-682812ab7b0e	glider ultralight finale 1.3mf	2565193		f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743523728002-8evnmdntb7l.3mf	f6865c7b-5293-49a2-8a4a-017aa785c9c9	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:08:48.142693+00
ec23cbdb-c628-4fc0-8f3d-1b72e6f2aaca	glider ultralight finale 1.3mf	2565193		f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743523752148-cszjn9mk9id.3mf	f6865c7b-5293-49a2-8a4a-017aa785c9c9	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:09:12.292251+00
f92e8c24-a232-42ac-8733-656ddd14c356	11 Columns.3mf	5000489		f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743524176304-ntip7.3mf	f6865c7b-5293-49a2-8a4a-017aa785c9c9	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:16:16.503606+00
0b2f73a1-f190-4384-9fb2-72da27f3fbbd	11 Columns.3mf	5000489		49383820-94d1-4554-80ac-d9dbb4496dfb/1743524200061-yutjm.3mf	49383820-94d1-4554-80ac-d9dbb4496dfb	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:16:40.224886+00
2121afba-a409-4a7b-9721-1a07486df527	KIMS_Health.pdf	112504	application/pdf	49383820-94d1-4554-80ac-d9dbb4496dfb/1743525997290-j9p8r4r3m2f.pdf	49383820-94d1-4554-80ac-d9dbb4496dfb	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:39:46.956517+00
1ad1f724-ad01-4659-a365-cbfc6e12833f	VAHAN 4.0 (Citizen Services)~SP-MORTH-WS03~175~8001.pdf	203174	application/pdf	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf/1743526190756-e8rhx.pdf	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:49:50.830265+00
d443c0e3-0fbc-42c6-b83a-25aac93884b6	supabase-schema-default.png	232707	image/png	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf/1743738979253-f4teb2wqs4g.png	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-04 03:56:19.476036+00
\.


--
-- Data for Name: last_changed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.last_changed (id, checksum, parent_page, heading, last_updated, last_checked) FROM stdin;
\.


--
-- Data for Name: launch_weeks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.launch_weeks (id, created_at, start_date, end_date) FROM stdin;
lw12	2025-04-09 14:23:19.321186+00	\N	\N
\.


--
-- Data for Name: meetups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetups (id, created_at, launch_week, title, country, start_at, link, display_info, is_live, is_published, timezone, city) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.messages (id, content, project_id, user_id, created_at) FROM stdin;
df475c2a-07ac-4043-a05f-cfcfc10b09e1	test message.\n\nARSTARSTARSTARSTR	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 17:31:30.342355+00
3c8b211b-bee9-4c63-8376-afc9cf4403ec	tst	d449b358-f3ff-4a4d-823a-5e23c4c8dfdd	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 17:45:52.161193+00
05eb8faf-3f29-46b7-9ffb-1ca85d83bc0a	rst	3a26d839-3e36-4439-8037-d29cce39a461	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 17:55:48.001325+00
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page (id, path, checksum, meta, type, source, version, last_refresh, content) FROM stdin;
\.


--
-- Data for Name: page_section; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page_section (id, page_id, content, token_count, embedding, slug, heading, rag_ignore) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.profiles (id, user_id, first_name, last_name, avatar_url, created_at, updated_at, auth_id, email, full_name, display_name, ip_address, last_login_ip, user_agent, browser, os, device_type, login_count, last_login_at) FROM stdin;
5094b493-e455-4171-862a-bd4bfe7f9005	5094b493-e455-4171-862a-bd4bfe7f9005	Akhil	R S		2025-04-07 17:53:47.392507+00	2025-04-07 18:08:18.52+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
\.


--
-- Data for Name: project_members; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.project_members (id, project_id, user_id, role, joined_at) FROM stdin;
e0a6f3cd-c4ea-41ac-966a-47ec5a23e542	d449b358-f3ff-4a4d-823a-5e23c4c8dfdd	5094b493-e455-4171-862a-bd4bfe7f9005	owner	2025-03-26 14:52:06.034+00
04d4d522-ee2a-4911-be7c-3f10562df942	ae2ba128-66c0-44f4-b2f1-c939fefcb264	5094b493-e455-4171-862a-bd4bfe7f9005	owner	2025-03-26 17:03:24.454+00
03524367-8faa-4e06-bfee-a81c35201151	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf	5094b493-e455-4171-862a-bd4bfe7f9005	owner	2025-03-26 17:28:06.109+00
f9f82bf8-842e-47d5-96ac-2aa26ab3ced0	49383820-94d1-4554-80ac-d9dbb4496dfb	5094b493-e455-4171-862a-bd4bfe7f9005	owner	2025-03-27 16:07:51.285+00
2335fb21-6a45-470f-bb92-f9136deb2afd	f6865c7b-5293-49a2-8a4a-017aa785c9c9	5094b493-e455-4171-862a-bd4bfe7f9005	owner	2025-03-28 01:52:18.605+00
465efd58-192d-4ff6-916e-28822951eab7	3a26d839-3e36-4439-8037-d29cce39a461	5094b493-e455-4171-862a-bd4bfe7f9005	owner	2025-03-28 01:56:28.841+00
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.projects (id, name, description, owner_id, status, start_date, end_date, visibility, created_at, updated_at) FROM stdin;
ab4c6de1-4fd4-4b2f-9820-b665eefff0bf	Project 3	\N	5094b493-e455-4171-862a-bd4bfe7f9005	Planning	2025-03-26 17:27:58.875+00	\N	private	2025-03-26 17:28:06.132253+00	2025-03-26 17:28:06.132253+00
49383820-94d1-4554-80ac-d9dbb4496dfb	Project 4	\N	5094b493-e455-4171-862a-bd4bfe7f9005	Planning	2025-03-27 16:07:44.699+00	\N	private	2025-03-27 16:07:51.367421+00	2025-03-27 16:07:51.367421+00
f6865c7b-5293-49a2-8a4a-017aa785c9c9	Project 5	\N	5094b493-e455-4171-862a-bd4bfe7f9005	Planning	2025-03-28 01:52:11.914+00	\N	private	2025-03-28 01:52:20.759884+00	2025-03-28 01:52:20.759884+00
d449b358-f3ff-4a4d-823a-5e23c4c8dfdd	Test Project 1		5094b493-e455-4171-862a-bd4bfe7f9005	Planning	2025-03-26 14:51:58.073+00	\N	private	2025-03-26 14:52:06.059146+00	2025-03-26 14:52:06.059146+00
3a26d839-3e36-4439-8037-d29cce39a461	Project 6666		5094b493-e455-4171-862a-bd4bfe7f9005	Planning	2025-03-28 01:56:22.255+00	\N	private	2025-03-28 01:56:31.015793+00	2025-03-28 01:56:31.015793+00
ae2ba128-66c0-44f4-b2f1-c939fefcb264	Test Project 22		5094b493-e455-4171-862a-bd4bfe7f9005	Planning	2025-03-26 17:03:17.025+00	\N	private	2025-03-26 16:08:39.995245+00	2025-03-26 16:08:39.995245+00
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.tasks (id, title, description, status, priority, due_date, project_id, assignee_id, creator_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, created_at, launch_week, user_id, email, name, username, referred_by, shared_on_twitter, shared_on_linkedin, game_won_at, ticket_number, metadata, role, company, location) FROM stdin;
\.


--
-- Data for Name: troubleshooting_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.troubleshooting_entries (id, title, topics, keywords, api, errors, github_url, date_created, date_updated, github_id, checksum) FROM stdin;
\.


--
-- Data for Name: validation_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validation_history (id, tag, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
project-files	project-files	\N	2025-04-01 14:32:53.176524+00	2025-04-01 14:32:53.176524+00	t	f	\N	\N	\N
avatars	avatars	\N	2025-04-07 17:54:17.423121+00	2025-04-07 17:54:17.423121+00	t	f	5242880	{image/png,image/jpeg,image/gif,image/webp}	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-04-01 14:32:06.668119
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-04-01 14:32:06.673907
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-04-01 14:32:06.675068
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-04-01 14:32:06.694283
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-04-01 14:32:06.709379
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-04-01 14:32:06.710924
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-04-01 14:32:06.712953
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-04-01 14:32:06.714842
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-04-01 14:32:06.715966
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-04-01 14:32:06.717233
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-04-01 14:32:06.719234
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-04-01 14:32:06.721205
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-04-01 14:32:06.725373
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-04-01 14:32:06.726565
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-04-01 14:32:06.728467
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-04-01 14:32:06.742811
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-04-01 14:32:06.745005
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-04-01 14:32:06.74611
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-04-01 14:32:06.747741
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-04-01 14:32:06.751167
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-04-01 14:32:06.752324
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-04-01 14:32:06.755705
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-04-01 14:32:06.767904
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-04-01 14:32:06.779748
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-04-01 14:32:06.782427
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-04-01 14:32:06.783676
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-04-01 14:32:06.785468
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-04-01 14:32:06.797613
28	object-bucket-name-sorting	8f385d71c72f7b9f6388e22f6e393e3b78bf8617	2025-04-01 14:32:06.800709
29	create-prefixes	8416491709bbd2b9f849405d5a9584b4f78509fb	2025-04-01 14:32:06.802527
30	update-object-levels	f5899485e3c9d05891d177787d10c8cb47bae08a	2025-04-01 14:32:06.804376
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-04-01 14:32:06.806294
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-04-01 14:32:06.808674
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-04-01 14:32:06.810594
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-04-01 14:32:06.810812
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-04-01 14:32:06.813337
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
eb7f54be-94fb-419a-a91c-f4dbb130242b	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.7391188720830743.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 14:33:41.86579+00	2025-04-01 14:33:41.86579+00	2025-04-01 14:33:41.86579+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T14:33:41.706Z", "contentLength": 5000489, "httpStatusCode": 200}	46e3fadf-f005-4384-9a86-9f38b4b176d2	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
d46f9c86-759e-4f56-a363-57eeafebf989	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.6125185877604404.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 14:33:50.855408+00	2025-04-01 14:33:50.855408+00	2025-04-01 14:33:50.855408+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T14:33:50.697Z", "contentLength": 5000489, "httpStatusCode": 200}	55613aee-fdfa-412f-9d5a-75281b966c70	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
67ae762c-b255-4d1d-99f5-bfd0800bc6a7	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.09841484059217387.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 14:39:27.186453+00	2025-04-01 14:39:27.186453+00	2025-04-01 14:39:27.186453+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T14:39:27.030Z", "contentLength": 5000489, "httpStatusCode": 200}	870e958d-d8d7-4721-9240-1d0aea29aee0	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
bad3086e-7b13-4366-a44c-a0cf86f6d206	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.8185976248670969.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 14:39:34.759228+00	2025-04-01 14:39:34.759228+00	2025-04-01 14:39:34.759228+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T14:39:34.589Z", "contentLength": 5000489, "httpStatusCode": 200}	7d6b98c1-ef18-4950-b413-7893f93ebd61	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
3b449775-6516-4e37-b61c-7f63c28a44fe	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.20954025528923037.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 14:48:54.37643+00	2025-04-01 14:48:54.37643+00	2025-04-01 14:48:54.37643+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:38:19.014Z", "contentLength": 5000489, "httpStatusCode": 200}	9b22b148-59eb-4a2f-8d2b-886e94a73944	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
c8eb17dc-15f4-4bb3-b4d0-10c192f6e6c5	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.939438305145412.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:38:36.307478+00	2025-04-01 15:38:36.307478+00	2025-04-01 15:38:36.307478+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:38:36.201Z", "contentLength": 5000489, "httpStatusCode": 200}	72e41201-b8d4-4a75-b42b-6c4bc95eded4	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
e6dcac1f-38a0-4f4f-b6e8-edb5a1f76cd8	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.8290939282680629.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:38:42.504243+00	2025-04-01 15:38:42.504243+00	2025-04-01 15:38:42.504243+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:38:42.396Z", "contentLength": 5000489, "httpStatusCode": 200}	66447a55-5ed3-4aac-b759-7add4ec16948	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
8aca3e85-7fb0-49b9-b28b-5592cbb461c3	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.2401114045604119.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:39:00.947327+00	2025-04-01 15:39:00.947327+00	2025-04-01 15:39:00.947327+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:39:00.825Z", "contentLength": 5000489, "httpStatusCode": 200}	649403ff-e19e-4bcc-8f9d-e8eeb53a9a9a	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
72473b28-ef23-4ebd-9198-f7ac9904ea88	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.6677870189896691.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:40:26.35792+00	2025-04-01 15:40:26.35792+00	2025-04-01 15:40:26.35792+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:40:26.244Z", "contentLength": 5000489, "httpStatusCode": 200}	8a7df2ff-c1d1-40a4-acd6-b410c42388a0	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
daf38808-ce50-46b1-9b2a-1748c648aefd	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.33961222663586144.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:42:45.940427+00	2025-04-01 15:42:45.940427+00	2025-04-01 15:42:45.940427+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:42:45.835Z", "contentLength": 5000489, "httpStatusCode": 200}	c33f9ef8-9587-4b16-8cd9-2e0a78603cee	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
1e5f29fb-a23c-4631-a247-e8baadd0e689	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.1553265774906295.pdf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:42:54.764665+00	2025-04-01 15:42:54.764665+00	2025-04-01 15:42:54.764665+00	{"eTag": "\\"5d4ba882004762d3d9d5f7ad14a1efed\\"", "size": 243563, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:42:54.708Z", "contentLength": 243563, "httpStatusCode": 200}	824a32ea-eba1-462f-a3c8-33484b8b9e40	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
a3be6d12-6ca7-4f82-9e5d-0ef93dba2932	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/0.7334641595743365.pdf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:43:00.760309+00	2025-04-01 15:43:00.760309+00	2025-04-01 15:43:00.760309+00	{"eTag": "\\"5d4ba882004762d3d9d5f7ad14a1efed\\"", "size": 243563, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:43:00.704Z", "contentLength": 243563, "httpStatusCode": 200}	365e25e0-92ed-41dc-8f4b-2fd46089bdf9	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
13e7d50a-ad98-48de-bc95-73f6b6d2ec54	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743522996900-9t4l9kbifq.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 15:56:37.059815+00	2025-04-01 15:56:37.059815+00	2025-04-01 15:56:37.059815+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T15:56:36.969Z", "contentLength": 5000489, "httpStatusCode": 200}	a9481539-8634-451e-a4cc-c080e7bb6a41	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
76fb4ed0-3d43-4476-b01c-5dd9badead12	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743523385613-qgoe6hcpov.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:03:05.772718+00	2025-04-01 16:03:05.772718+00	2025-04-01 16:03:05.772718+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:03:05.682Z", "contentLength": 5000489, "httpStatusCode": 200}	70b719e7-064e-40a0-82b3-98bfcdcbd4d8	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
cabe64fd-f37c-409d-89f3-715241e9e2fd	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743523728002-8evnmdntb7l.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:08:48.122635+00	2025-04-01 16:08:48.122635+00	2025-04-01 16:08:48.122635+00	{"eTag": "\\"2d2cd9ff48577e6a21064d8d2815f8aa\\"", "size": 2565193, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:08:48.053Z", "contentLength": 2565193, "httpStatusCode": 200}	cf2e0ea3-9f66-40ae-8eea-d2dcd47e34b2	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
e9056694-1d2c-408a-a67d-a2122706b6a4	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743523752148-cszjn9mk9id.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:09:12.257011+00	2025-04-01 16:09:12.257011+00	2025-04-01 16:09:12.257011+00	{"eTag": "\\"2d2cd9ff48577e6a21064d8d2815f8aa\\"", "size": 2565193, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:09:12.190Z", "contentLength": 2565193, "httpStatusCode": 200}	236b47f8-0ba7-4e3f-bc22-7239ea0ae4a7	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
64d1d0a5-d5bd-41a8-9dd4-9ae906d84a22	project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9/1743524176304-ntip7.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:16:16.468474+00	2025-04-01 16:16:16.468474+00	2025-04-01 16:16:16.468474+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:16:16.382Z", "contentLength": 5000489, "httpStatusCode": 200}	493ec4ce-3a18-4cd7-8c3f-11627f1fdd07	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
0a024669-e733-49d4-9872-ee370092c605	avatars	avatar-1744050564727-qsqfwe4th	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:29:24.784615+00	2025-04-07 18:29:24.784615+00	2025-04-07 18:29:24.784615+00	{"eTag": "\\"c67716abb510dff5050bb1a426f4f9a4\\"", "size": 683329, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:29:24.753Z", "contentLength": 683329, "httpStatusCode": 200}	1db827d1-ee61-4634-ac8d-6e066caf74f1	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
b7510b22-87f2-40e2-88f7-c83fc64529f9	project-files	49383820-94d1-4554-80ac-d9dbb4496dfb/1743524200061-yutjm.3mf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:16:40.199042+00	2025-04-01 16:16:40.199042+00	2025-04-01 16:16:40.199042+00	{"eTag": "\\"91a1d7a834468917cf135dd2f008f16d\\"", "size": 5000489, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:16:40.113Z", "contentLength": 5000489, "httpStatusCode": 200}	b737c9d3-e346-4db8-a80a-b2b9763ee0bf	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
e75cd9df-d1d3-4471-a9b4-b0c7c0497347	project-files	49383820-94d1-4554-80ac-d9dbb4496dfb/1743525997290-j9p8r4r3m2f.pdf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:39:46.920061+00	2025-04-01 16:39:46.920061+00	2025-04-01 16:39:46.920061+00	{"eTag": "\\"ecfa12a97ba3456e209c0efe5281ba97\\"", "size": 112504, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:46:37.316Z", "contentLength": 112504, "httpStatusCode": 200}	7b85b097-4082-40c8-9bad-59ee376cb7ec	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
05de2ecc-e6a3-443c-83e4-4537549cd616	project-files	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf/1743526190756-e8rhx.pdf	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-01 16:49:50.815526+00	2025-04-01 16:49:50.815526+00	2025-04-01 16:49:50.815526+00	{"eTag": "\\"bff0b561efb59b94a71319a5cc3fad53\\"", "size": 203174, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-04-01T16:49:50.791Z", "contentLength": 203174, "httpStatusCode": 200}	625992d5-f10d-48ae-8e08-cd447a396349	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
6d55765e-5575-4dbe-a916-b0e6f26dfad7	project-files	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf/1743738979253-f4teb2wqs4g.png	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-04 03:56:19.448829+00	2025-04-04 03:56:19.448829+00	2025-04-04 03:56:19.448829+00	{"eTag": "\\"c84c9adc12d8992f8db2dfcec0a80f11\\"", "size": 232707, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-04T03:56:19.391Z", "contentLength": 232707, "httpStatusCode": 200}	3e8064e8-51ac-47e1-8bdc-40b40e8f65ba	5094b493-e455-4171-862a-bd4bfe7f9005	{}	2
661c9733-7ad4-4f40-bcb9-6fa92c55bf95	avatars	avatar-1744049672193-7imb62do7	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:14:32.257975+00	2025-04-07 18:14:32.257975+00	2025-04-07 18:14:32.257975+00	{"eTag": "\\"ac82117fb5b9d84f257105485e3c38dd\\"", "size": 800206, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:14:32.219Z", "contentLength": 800206, "httpStatusCode": 200}	92798fc9-2277-496c-8572-762611480fe8	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
ed08ec58-ea28-409d-bf94-f0bfcaeaf777	avatars	avatar-1744049700337-zr5j4rw47	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:15:00.39162+00	2025-04-07 18:15:00.39162+00	2025-04-07 18:15:00.39162+00	{"eTag": "\\"c67716abb510dff5050bb1a426f4f9a4\\"", "size": 683329, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:15:00.356Z", "contentLength": 683329, "httpStatusCode": 200}	9b349920-477d-4457-86ed-3e9c68ea27d2	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
f0f7b5b0-ae49-4d5b-ae85-15017ae50123	avatars	avatar-1744049747241-gfuwhmrva	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:15:47.360642+00	2025-04-07 18:15:47.360642+00	2025-04-07 18:15:47.360642+00	{"eTag": "\\"c67716abb510dff5050bb1a426f4f9a4\\"", "size": 683329, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:15:47.326Z", "contentLength": 683329, "httpStatusCode": 200}	0317512c-e90a-4f40-9ad7-2541804cb783	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
ae9f4b8e-17a5-4858-bc52-d7051a87bffb	avatars	avatar-1744050162239-zxberqukj	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:22:42.340251+00	2025-04-07 18:22:42.340251+00	2025-04-07 18:22:42.340251+00	{"eTag": "\\"ac82117fb5b9d84f257105485e3c38dd\\"", "size": 800206, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:22:42.289Z", "contentLength": 800206, "httpStatusCode": 200}	5fe49137-2a0f-4df2-9129-f01db898ca3c	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
a4d162e0-ff7f-4907-866c-1b0644c4a168	avatars	avatar-1744050189069-1qi6hyl0i	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:23:09.155232+00	2025-04-07 18:23:09.155232+00	2025-04-07 18:23:09.155232+00	{"eTag": "\\"ac82117fb5b9d84f257105485e3c38dd\\"", "size": 800206, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:23:09.119Z", "contentLength": 800206, "httpStatusCode": 200}	35023b4b-dc40-4410-9011-0b835c8f2ede	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
50fef848-a2c8-47d0-9e5b-be7adb9b1fc1	avatars	avatar-1744050271093-xlh3wr5qz	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:24:31.151557+00	2025-04-07 18:24:31.151557+00	2025-04-07 18:24:31.151557+00	{"eTag": "\\"c67716abb510dff5050bb1a426f4f9a4\\"", "size": 683329, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:24:31.119Z", "contentLength": 683329, "httpStatusCode": 200}	d23f9367-d6f1-4004-bf14-cce9d7c61157	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
655826ca-b9c2-4b96-9c09-26f2d1ad4eff	avatars	avatar-1744050424684-651n4c1um	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:27:04.737206+00	2025-04-07 18:27:04.737206+00	2025-04-07 18:27:04.737206+00	{"eTag": "\\"ac82117fb5b9d84f257105485e3c38dd\\"", "size": 800206, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:27:04.705Z", "contentLength": 800206, "httpStatusCode": 200}	0636f012-32af-47a4-941d-1e1156a2c89a	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
776a584e-c87f-4c6f-96fa-ddd4a7a7a516	avatars	avatar-1744050536957-4db2zhwl1	5094b493-e455-4171-862a-bd4bfe7f9005	2025-04-07 18:28:57.003774+00	2025-04-07 18:28:57.003774+00	2025-04-07 18:28:57.003774+00	{"eTag": "\\"c67716abb510dff5050bb1a426f4f9a4\\"", "size": 683329, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-04-07T18:28:56.972Z", "contentLength": 683329, "httpStatusCode": 200}	c5b303b8-2ec1-4f53-bb4a-07a4b7ed26bc	5094b493-e455-4171-862a-bd4bfe7f9005	{}	1
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
project-files	f6865c7b-5293-49a2-8a4a-017aa785c9c9	2025-04-01 14:33:41.86579+00	2025-04-01 14:33:41.86579+00
project-files	49383820-94d1-4554-80ac-d9dbb4496dfb	2025-04-01 16:16:40.199042+00	2025-04-01 16:16:40.199042+00
project-files	ab4c6de1-4fd4-4b2f-9820-b665eefff0bf	2025-04-01 16:49:50.815526+00	2025-04-01 16:49:50.815526+00
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2025-03-19 01:48:42.402238+00
20210809183423_update_grants	2025-03-19 01:48:42.402238+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20230126220613	{"create extension if not exists vector with schema public","create table \\"public\\".\\"page\\" (\n  id bigserial primary key,\n  path text not null unique,\n  checksum text,\n  meta jsonb\n)","create table \\"public\\".\\"page_section\\" (\n  id bigserial primary key,\n  page_id bigint not null references public.page on delete cascade,\n  content text,\n  token_count int,\n  embedding vector(1536)\n)"}	doc_embeddings
20230128004504	{"create or replace function match_page_sections(embedding vector(1536), match_threshold float, match_count int, min_content_length int)\nreturns table (path text, content text, similarity float)\nlanguage plpgsql\nas $$\n#variable_conflict use_variable\nbegin\n  return query\n  select\n    page.path,\n    page_section.content,\n    (page_section.embedding <#> embedding) * -1 as similarity\n  from page_section\n  join page\n    on page_section.page_id = page.id\n\n  -- We only care about sections that have a useful amount of content\n  where length(page_section.content) >= min_content_length\n\n  -- The dot product is negative because of a Postgres limitation, so we negate it\n  and (page_section.embedding <#> embedding) * -1 > match_threshold\n\n  -- OpenAI embeddings are normalized to length 1, so\n  -- cosine similarity and dot product will produce the same results.\n  -- Using dot product which can be computed slightly faster.\n  --\n  -- For the different syntaxes, see https://github.com/pgvector/pgvector\n  order by page_section.embedding <#> embedding\n  \n  limit match_count;\nend;\n$$"}	embedding_similarity_search
20230216195821	{"alter table \\"public\\".\\"page\\"\nadd parent_page_id bigint references public.page"}	page_hierarchy
20230216232739	{"alter table \\"public\\".\\"page_section\\"\nadd column slug text,\nadd column heading text"}	page_section_heading_slug
20230217032716	{"drop function match_page_sections","create or replace function match_page_sections(embedding vector(1536), match_threshold float, match_count int, min_content_length int)\nreturns table (id bigint, page_id bigint, slug text, heading text, content text, similarity float)\nlanguage plpgsql\nas $$\n#variable_conflict use_variable\nbegin\n  return query\n  select\n    page_section.id,\n    page_section.page_id,\n    page_section.slug,\n    page_section.heading,\n    page_section.content,\n    (page_section.embedding <#> embedding) * -1 as similarity\n  from page_section\n\n  -- We only care about sections that have a useful amount of content\n  where length(page_section.content) >= min_content_length\n\n  -- The dot product is negative because of a Postgres limitation, so we negate it\n  and (page_section.embedding <#> embedding) * -1 > match_threshold\n\n  -- OpenAI embeddings are normalized to length 1, so\n  -- cosine similarity and dot product will produce the same results.\n  -- Using dot product which can be computed slightly faster.\n  --\n  -- For the different syntaxes, see https://github.com/pgvector/pgvector\n  order by page_section.embedding <#> embedding\n  \n  limit match_count;\nend;\n$$","create or replace function get_page_parents(page_id bigint)\nreturns table (id bigint, parent_page_id bigint, path text, meta jsonb)\nlanguage sql\nas $$\n  with recursive chain as (\n    select *\n    from page \n    where id = page_id\n\n    union all\n\n    select child.*\n      from page as child\n      join chain on chain.parent_page_id = child.id \n  )\n  select id, parent_page_id, path, meta\n  from chain;\n$$"}	page_hierarchy_function
20230228205709	{"alter table \\"public\\".\\"page\\"\nadd column type text,\nadd column source text"}	page_source
20230403222943	{"-- Return a setof page_section so that we can use PostgREST resource embeddings (joins with other tables)\ncreate or replace function match_page_sections_v2(embedding vector(1536), match_threshold float, min_content_length int)\nreturns setof page_section\nlanguage plpgsql\nas $$\n#variable_conflict use_variable\nbegin\n  return query\n  select *\n  from page_section\n\n  -- We only care about sections that have a useful amount of content\n  where length(page_section.content) >= min_content_length\n\n  -- The dot product is negative because of a Postgres limitation, so we negate it\n  and (page_section.embedding <#> embedding) * -1 > match_threshold\n\n  -- OpenAI embeddings are normalized to length 1, so\n  -- cosine similarity and dot product will produce the same results.\n  -- Using dot product which can be computed slightly faster.\n  --\n  -- For the different syntaxes, see https://github.com/pgvector/pgvector\n  order by page_section.embedding <#> embedding;\nend;\n$$"}	reusable_match_function
20230421193603	{"alter table \\"public\\".\\"page\\"\nadd \\"version\\" uuid,\nadd \\"last_refresh\\" timestamptz"}	page_version
20231115053211	{"alter table \\"public\\".\\"page\\" enable row level security","alter table \\"public\\".\\"page_section\\" enable row level security","create policy \\"Enable read access for anon and authenticated\\"\non \\"public\\".\\"page\\"\nas permissive\nfor select\nto anon, authenticated\nusing (true)","create policy \\"Enable read access for anon and authenticated\\"\non \\"public\\".\\"page_section\\"\nas permissive\nfor select\nto anon, authenticated\nusing (true)"}	remote_schema
20231121164837	{"alter table page_section\nadd column fts_tokens tsvector generated always as (to_tsvector('english', content)) stored","create index fts_search_index on page_section using gin(fts_tokens)","create or replace function docs_search_fts(query text)\nreturns table (\n\tid int8,\n\tpath text,\n\ttype text,\n\ttitle text,\n\tsubtitle text,\n\tdescription text,\n\theadings text[],\n\tslugs text[]\n)\nlanguage plpgsql\nas $$\n#variable_conflict use_variable\nbegin\n\treturn query\n\twith match as (\n\t\tselect *\n\t\tfrom page_section\n\t\twhere fts_tokens @@ websearch_to_tsquery(query)\n\t\tlimit 10\n\t)\n\tselect\n\t\tpage.id,\n\t\tpage.path,\n\t\tpage.type,\n\t\tpage.meta ->> 'title' as title,\n\t\tpage.meta ->> 'subtitle' as title,\n\t\tpage.meta ->> 'description' as description,\n\t\tarray_agg(match.heading) as headings,\n\t\tarray_agg(match.slug) as slugs\n\tfrom page\n\tjoin match on match.page_id = page.id\n\tgroup by page.id;\nend;\n$$","create or replace function docs_search_embeddings(\n\tembedding vector(1536),\n\tmatch_threshold float\n)\nreturns table (\n\tid int8,\n\tpath text,\n\ttype text,\n\ttitle text,\n\tsubtitle text,\n\tdescription text,\n\theadings text[],\n\tslugs text[]\n)\nlanguage plpgsql\nas $$\n#variable_conflict use_variable\nbegin\n\treturn query\n\twith match as(\n\t\tselect *\n\t\tfrom page_section\n\t\t-- The dot product is negative because of a Postgres limitation, so we negate it\n\t\twhere (page_section.embedding <#> embedding) * -1 > match_threshold\t\n\t\t-- OpenAI embeddings are normalized to length 1, so\n\t\t-- cosine similarity and dot product will produce the same results.\n\t\t-- Using dot product which can be computed slightly faster.\n\t\t--\n\t\t-- For the different syntaxes, see https://github.com/pgvector/pgvector\n\t\torder by page_section.embedding <#> embedding\n\t\tlimit 10\n\t)\n\tselect\n\t\tpage.id,\n\t\tpage.path,\n\t\tpage.type,\n\t\tpage.meta ->> 'title' as title,\n\t\tpage.meta ->> 'subtitle' as title,\n\t\tpage.meta ->> 'description' as description,\n\t\tarray_agg(match.heading) as headings,\n\t\tarray_agg(match.slug) as slugs\n\tfrom page\n\tjoin match on match.page_id = page.id\n\tgroup by page.id;\nend;\n$$"}	modify_search_functions
20240722100743	{"create table \\"public\\".\\"active_pgbouncer_projects\\" (\n    \\"id\\" bigint generated by default as identity not null,\n    \\"project_ref\\" text\n)","alter table \\"public\\".\\"active_pgbouncer_projects\\" enable row level security","create table \\"public\\".\\"vercel_project_connections_without_supavisor\\" (\n    \\"id\\" bigint generated by default as identity not null,\n    \\"project_ref\\" text not null\n)","alter table \\"public\\".\\"vercel_project_connections_without_supavisor\\" enable row level security","CREATE UNIQUE INDEX active_pgbouncer_projects_pkey ON public.active_pgbouncer_projects USING btree (id)","CREATE UNIQUE INDEX vercel_project_connections_without_supavisor_pkey ON public.vercel_project_connections_without_supavisor USING btree (id)","alter table \\"public\\".\\"active_pgbouncer_projects\\" add constraint \\"active_pgbouncer_projects_pkey\\" PRIMARY KEY using index \\"active_pgbouncer_projects_pkey\\"","alter table \\"public\\".\\"vercel_project_connections_without_supavisor\\" add constraint \\"vercel_project_connections_without_supavisor_pkey\\" PRIMARY KEY using index \\"vercel_project_connections_without_supavisor_pkey\\"","grant delete on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant insert on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant references on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant select on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant trigger on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant truncate on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant update on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"anon\\"","grant delete on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant insert on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant references on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant select on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant trigger on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant truncate on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant update on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"authenticated\\"","grant delete on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant insert on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant references on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant select on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant trigger on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant truncate on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant update on table \\"public\\".\\"active_pgbouncer_projects\\" to \\"service_role\\"","grant delete on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant insert on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant references on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant select on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant trigger on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant truncate on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant update on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"anon\\"","grant delete on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant insert on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant references on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant select on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant trigger on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant truncate on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant update on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"authenticated\\"","grant delete on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\"","grant insert on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\"","grant references on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\"","grant select on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\"","grant trigger on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\"","grant truncate on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\"","grant update on table \\"public\\".\\"vercel_project_connections_without_supavisor\\" to \\"service_role\\""}	remote_schema
20231127222412	{"-- remove unused column\n\nalter table page\ndrop column parent_page_id","-- move indexed content for fts search from page_section to page\n-- this should allow better rankings as it gives a better overview of\n-- search term frequency on that page\n\ndrop index fts_search_index","alter table page_section\ndrop column fts_tokens","alter table page\nadd column content text","alter table page\nadd column fts_tokens tsvector generated always as (to_tsvector('english', content)) stored","create index fts_search_index_page on page using gin(fts_tokens)","-- also search against the page title if it exists, to give more\n-- intuitive search rankings\n\nalter table page\n\nadd column title_tokens tsvector generated always as (to_tsvector('english', coalesce(meta ->> 'title', ''))) stored","create index fts_search_index_title on page using gin(title_tokens)","-- rank search by best match (title matches tend to rank better than content matches\n-- due to underlying ts_rank algorithm\n\ndrop function docs_search_fts","create or replace function docs_search_fts(query text)\nreturns table (\n\tid int8,\n\tpath text,\n\ttype text,\n\ttitle text,\n\tsubtitle text,\n\tdescription text\n)\nlanguage plpgsql\nas $$\n#variable_conflict use_variable\nbegin\n\treturn query\n\tselect\n\t  page.id,\n\t  page.path,\n\t  page.type,\n\t  page.meta ->> 'title' as title,\n\t  page.meta ->> 'subtitle' as subtitle,\n\t  page.meta ->> 'description' as description\n\tfrom page\n\twhere title_tokens @@ websearch_to_tsquery(query) or fts_tokens @@ websearch_to_tsquery(query)\n\torder by greatest(\n\t\t-- Title is more important than body, so use 10 as the weighting factor\n\t\t-- Cut off at max rank of 1\n\t\tleast(10 * ts_rank(title_tokens, websearch_to_tsquery(query)), 1),\n\t\tts_rank(fts_tokens, websearch_to_tsquery(query))\n\t  ) desc\n\tlimit 10;\nend;\n$$"}	search_full_text_for_fts
20240123195252	{"alter table page_section\nadd column rag_ignore boolean\ndefault false"}	add_rag_ignore_column
20240129101115	{"create\nor replace function ipv6_active_status (project_ref text) returns table (pgbouncer_active boolean, vercel_active boolean) as $$\ndeclare\n  pgbouncer_active boolean;\n  vercel_active boolean;\nbegin\n  select exists (\n    select 1 \n    from active_pgbouncer_projects ap\n    where ap.project_ref = $1\n  ) into pgbouncer_active;\n\n  select exists (\n    select 1\n    from vercel_project_connections_without_supavisor vp\n    where vp.project_ref = $1\n  ) into vercel_active;\n\n  return query select pgbouncer_active, vercel_active;\nend;\n$$ language plpgsql security definer"}	add_ipv6_active_status_rpc
20240208001120	{"create type feedback_vote as enum (\n\t'yes',\n\t'no'\n)","create table feedback (\n\tid bigint primary key generated always as identity,\n\tdate_created date not null default current_date,\n\tvote feedback_vote not null,\n\tpage text not null\n)","alter table feedback enable row level security","create policy \\"Anyone can insert feedback\\"\non feedback\nas permissive for insert\nto public\nwith check (true)"}	add_feedback_table
20240306233728	{"create schema if not exists metrics","create view metrics.feedback_response_aggregate\nas select\n  count(*) filter (where vote = 'yes') as yes,\n  count(*) filter (where vote = 'no') as no\nfrom feedback"}	create_feedback_view
20240403133820	{"alter table public.feedback\nadd column metadata jsonb"}	track_feedback_query_params
20240604035404	{"create table last_changed (\n\tid bigint primary key generated always as identity,\n\tchecksum text not null,\n\tparent_page text not null,\n\theading text not null,\n\tlast_updated timestamp with time zone default now() not null,\n\tlast_checked timestamp with time zone default now() not null,\n\tunique (parent_page, heading)\n)","comment on table last_changed is\n'Records when page sections from docs content were last edited.'","comment on column last_changed.checksum is\n'Checksum of most recent section contents.'","comment on column last_changed.parent_page is\n'Path of the page containing this section.'","comment on column last_changed.last_updated is\n'When the content was last edited.'","comment on column last_changed.last_checked is\n'When the content was last checked. Used to identify and delete obsolete sections.'","alter table last_changed enable row level security","revoke all on last_changed from anon","revoke all on last_changed from authenticated","create index idx_last_changed_parent_page_btree\non last_changed (parent_page)"}	last_changed
20240605171314	{"create or replace function update_last_changed_checksum(\n  new_parent_page text,\n  new_heading text,\n  new_checksum text,\n  git_update_time timestamp with time zone,\n  check_time timestamp with time zone  \n)\nreturns timestamp with time zone\nlanguage plpgsql\nas $$\ndeclare\n  existing_id bigint;\n  previous_checksum text;\n  updated_check_time timestamp with time zone;\nbegin\n  select id, checksum into existing_id, previous_checksum\n    from public.last_changed\n    where\n      parent_page = new_parent_page\n      and heading = new_heading\n  ;\n\n  if existing_id is not null\n    and previous_checksum is not null\n    and previous_checksum = new_checksum\n\n    then\n      update public.last_changed set\n        last_checked = check_time\n        where\n\t\t  last_changed.id = existing_id\n\t\t  and last_changed.last_checked < check_time\n\t\treturning last_checked into updated_check_time\n      ;\n\n    else\n      insert into public.last_changed (\n        parent_page,\n        heading,\n        checksum,\n        last_updated,\n        last_checked\n      ) values (\n        new_parent_page,\n        new_heading,\n        new_checksum,\n        git_update_time,\n        check_time\n      )\n      on conflict\n\t    on constraint last_changed_parent_page_heading_key\n        do update set\n          checksum = new_checksum,\n          last_updated = git_update_time,\n          last_checked = check_time\n        where\n          last_changed.id = existing_id\n\t\t  and last_changed.last_checked < check_time\n\t  returning last_checked into updated_check_time\n      ;\n\n  end if;\n\n  return updated_check_time;\nend;\n$$","revoke all on function public.update_last_changed_checksum\nfrom public, anon, authenticated","create or replace function cleanup_last_changed_pages()\nreturns integer\nlanguage plpgsql\nas $$\ndeclare\n  newest_check_time timestamp with time zone;\n  number_deleted integer;\nbegin\n  select last_checked into newest_check_time\n    from public.last_changed\n    order by last_checked desc\n    limit 1\n  ;\n\n  with deleted as (\n    delete from public.last_changed\n    where last_checked <> newest_check_time\n    returning id\n  )\n  select count(*)\n  from deleted\n  into number_deleted;\n\n  return number_deleted;\nend;\n$$","revoke all on function public.cleanup_last_changed_pages\nfrom public, anon, authenticated"}	last_changed_update
20240626184716	{"alter function public.update_last_changed_checksum\nset search_path = ''","alter function public.cleanup_last_changed_pages\nset search_path = ''","-- Return a setof page_section so that we can use PostgREST resource embeddings (joins with other tables)\ncreate or replace function match_page_sections_v2(\n  embedding vector(1536),\n  match_threshold float,\n  min_content_length int\n)\nreturns setof page_section\nlanguage plpgsql\nset search_path = ''\nas $$\n#variable_conflict use_variable\nbegin\n  return query\n  select *\n  from public.page_section\n\n  -- We only care about sections that have a useful amount of content\n  where length(page_section.content) >= min_content_length\n\n  -- The dot product is negative because of a Postgres limitation, so we negate it\n  and (page_section.embedding operator(public.<#>) embedding) * -1 > match_threshold\n\n  -- OpenAI embeddings are normalized to length 1, so\n  -- cosine similarity and dot product will produce the same results.\n  -- Using dot product which can be computed slightly faster.\n  --\n  -- For the different syntaxes, see https://github.com/pgvector/pgvector\n  order by page_section.embedding operator(public.<#>) embedding;\nend;\n$$","create or replace function ipv6_active_status (\n  project_ref text\n)\nreturns table (\n  pgbouncer_active boolean,\n  vercel_active boolean\n)\nset search_path = '' \nas $$\ndeclare\n  pgbouncer_active boolean;\n  vercel_active boolean;\nbegin\n  select exists (\n    select 1 \n    from public.active_pgbouncer_projects ap\n    where ap.project_ref = $1\n  ) into pgbouncer_active;\n\n  select exists (\n    select 1\n    from public.vercel_project_connections_without_supavisor vp\n    where vp.project_ref = $1\n  ) into vercel_active;\n\n  return query select pgbouncer_active, vercel_active;\nend;\n$$ language plpgsql security definer","create or replace function docs_search_embeddings(\n  embedding vector(1536),\n  match_threshold float\n)\nreturns table (\n  id int8,\n  path text,\n  type text,\n  title text,\n  subtitle text,\n  description text,\n  headings text[],\n  slugs text[]\n)\nlanguage plpgsql\nset search_path = ''\nas $$\n#variable_conflict use_variable\nbegin\n  return query\n  with match as(\n\tselect *\n\tfrom public.page_section\n\t-- The dot product is negative because of a Postgres limitation, so we negate it\n\twhere (page_section.embedding operator(public.<#>) embedding) * -1 > match_threshold\t\n\t-- OpenAI embeddings are normalized to length 1, so\n\t-- cosine similarity and dot product will produce the same results.\n\t-- Using dot product which can be computed slightly faster.\n\t--\n\t-- For the different syntaxes, see https://github.com/pgvector/pgvector\n\torder by page_section.embedding operator(public.<#>) embedding\n\tlimit 10\n  )\n  select\n\tpage.id,\n\tpage.path,\n\tpage.type,\n\tpage.meta ->> 'title' as title,\n\tpage.meta ->> 'subtitle' as title,\n\tpage.meta ->> 'description' as description,\n\tarray_agg(match.heading) as headings,\n\tarray_agg(match.slug) as slugs\n  from public.page\n  join match on match.page_id = page.id\n  group by page.id;\nend;\n$$","create or replace function docs_search_fts(query text)\nreturns table (\n  id int8,\n  path text,\n  type text,\n  title text,\n  subtitle text,\n  description text\n)\nlanguage plpgsql\nset search_path = ''\nas $$\n#variable_conflict use_variable\nbegin\n  return query\n  select\n\tpage.id,\n\tpage.path,\n\tpage.type,\n\tpage.meta ->> 'title' as title,\n\tpage.meta ->> 'subtitle' as subtitle,\n\tpage.meta ->> 'description' as description\n  from public.page\n  where title_tokens @@ websearch_to_tsquery(query) or fts_tokens @@ websearch_to_tsquery(query)\n  order by greatest(\n\t  -- Title is more important than body, so use 10 as the weighting factor\n\t  -- Cut off at max rank of 1\n\t  least(10 * ts_rank(title_tokens, websearch_to_tsquery(query)), 1),\n\t  ts_rank(fts_tokens, websearch_to_tsquery(query))\n  ) desc\n  limit 10;\nend;\n$$","drop function public.match_page_sections","drop function public.get_page_parents"}	misc_database_fixes
20240723131601	{"alter table \\"public\\".\\"active_pgbouncer_projects\\" drop constraint \\"active_pgbouncer_projects_pkey\\"","alter table \\"public\\".\\"vercel_project_connections_without_supavisor\\" drop constraint \\"vercel_project_connections_without_supavisor_pkey\\"","drop index if exists \\"public\\".\\"active_pgbouncer_projects_pkey\\"","drop index if exists \\"public\\".\\"vercel_project_connections_without_supavisor_pkey\\"","drop table \\"public\\".\\"active_pgbouncer_projects\\"","drop table \\"public\\".\\"vercel_project_connections_without_supavisor\\""}	drop_unused_tables
20240723155310	{"create extension if not exists \\"uuid-ossp\\"","create table public.launch_weeks (\n  id text not null primary key, -- 'lw12', 'lw13', etc\n  created_at timestamp with time zone not null default timezone ('utc'::text, now()),\n  start_date timestamp with time zone null,\n  end_date timestamp with time zone null\n)","alter table public.launch_weeks enable row level security","create policy \\"Allow public read access\\"\non \\"public\\".\\"launch_weeks\\"\nas PERMISSIVE\nfor select\nusing ( true )","insert into public.launch_weeks (id) values ('lw12')","create table\n  public.tickets (\n    id uuid not null default uuid_generate_v4(),\n    created_at timestamp with time zone not null default timezone('utc'::text, now()),\n    launch_week text not null references public.launch_weeks (id),\n    user_id uuid not null references auth.users (id),\n    email text null,\n    name text null,\n    username text null,\n    referred_by text null,\n    shared_on_twitter timestamp with time zone null,\n    shared_on_linkedin timestamp with time zone null,\n    game_won_at timestamp with time zone null,\n    ticket_number bigint generated by default as identity,\n    metadata jsonb null,\n    role text null,\n    company text null,\n    location text null,\n    constraint tickets_pkey primary key (id),\n    constraint tickets_email_key unique (email, launch_week),\n    constraint tickets_ticket_number_key unique (ticket_number, launch_week),\n    constraint tickets_username_key unique (username, launch_week),\n    constraint public_tickets_id_fkey foreign key (user_id) references auth.users (id)\n  )","alter table public.tickets enable row level security","alter publication supabase_realtime add table public.tickets","GRANT UPDATE (role) ON TABLE public.tickets TO authenticated","GRANT UPDATE (company) ON TABLE public.tickets TO authenticated","GRANT UPDATE (location) ON TABLE public.tickets TO authenticated","create policy \\"Allow user to select own ticket\\"\non public.tickets\nas PERMISSIVE\nfor SELECT\nto authenticated\nusing (user_id = auth.uid())","create policy \\"Allow authenticated user to update its own ticket\\"\non public.tickets\nas permissive\nfor update\nto authenticated\nusing (user_id = auth.uid())\nwith check (user_id = auth.uid())","create policy \\"Allow insert for authenticated users only\\"\non public.tickets\nas permissive\nfor insert\nto authenticated\nwith check (user_id = auth.uid())","-- public view without sensible data\ncreate or replace view\n  public.tickets_view with (security_invoker=on) as\nwith\n  lw12_referrals as (\n    select\n      tickets_1.referred_by,\n      count(*) as referrals\n    from\n      tickets tickets_1\n    where\n      tickets_1.referred_by is not null\n    group by\n      tickets_1.referred_by\n  )\nselect\n  tickets.id,\n  tickets.name,\n  tickets.username,\n  tickets.ticket_number,\n  tickets.created_at,\n  tickets.launch_week,\n  tickets.shared_on_twitter,\n  tickets.shared_on_linkedin,\n  tickets.metadata,\n  tickets.role,\n  tickets.company,\n  tickets.location,\n  case\n    when lw12_referrals.referrals is null then 0::bigint\n    else lw12_referrals.referrals\n  end as referrals,\n  case\n    when tickets.shared_on_twitter is not null\n    and tickets.shared_on_linkedin is not null then true\n    else false\n  end as platinum,\n  case\n    when tickets.game_won_at is not null then true\n    else false\n  end as secret\nfrom\n  tickets\n  left join lw12_referrals on tickets.username = lw12_referrals.referred_by","-- Create meetups table\ncreate table\n  public.meetups (\n    id uuid not null default uuid_generate_v4(),\n    created_at timestamp with time zone not null default now(),\n    launch_week text not null references public.launch_weeks (id),\n    title text null,\n    country text null,\n    start_at timestamp with time zone null,\n    link text null,\n    display_info text null,\n    is_live boolean not null default false,\n    is_published boolean not null default false,\n    constraint meetups_pkey primary key (id)\n  )","alter table public.meetups enable row level security","alter publication supabase_realtime add table public.meetups","create policy \\"Allow anybody to select all meetups\\"\non public.meetups\nas permissive\nfor select\nusing (true)"}	add_lw12_ticketing_schema
20240911215059	{"create table troubleshooting_entries (\n    id uuid primary key default gen_random_uuid(),\n    title text not null,\n    topics text[] not null,\n    keywords text[],\n    api jsonb,\n    errors jsonb[],\n    github_url text not null,\n    date_created timestamptz not null default now(),\n    date_updated timestamptz not null default now()\n)","alter table troubleshooting_entries enable row level security","create or replace function update_troubleshooting_entry_date_updated() returns trigger as $$\nbegin\n    new.date_updated = now();\n    return new;\nend;\n$$ language plpgsql","create trigger update_troubleshooting_entry_date_updated_trigger before update on troubleshooting_entries for each row\nexecute function update_troubleshooting_entry_date_updated()"}	troubleshooting_entries
20240918220938	{"create table validation_history (\n  id bigint generated always as identity primary key,\n  tag text not null,\n  created_at timestamp with time zone not null default now()\n)","create index validation_history_tag_created_at_idx on validation_history (tag, created_at desc)","alter table validation_history enable row level security","create or replace function get_last_revalidation_for_tags(tags text[])\nreturns table (\n  tag text,\n  created_at timestamp with time zone\n)\nlanguage sql\nas $$\n  select\n    tag,\n    max(created_at) as created_at\n  from validation_history\n  where tag = any(tags)\n  group by tag;\n$$"}	validation_history
20241002215612	{"alter table troubleshooting_entries\nadd column github_id text not null","alter table troubleshooting_entries\nadd column checksum text not null","create index idx_troubleshooting_checksum\non troubleshooting_entries (checksum)","create extension pg_jsonschema","alter table troubleshooting_entries\nadd constraint troubleshooting_api_check\ncheck (\n    api is null or\n    jsonb_matches_schema(\n        schema := '{\n            \\"type\\": \\"object\\",\n            \\"properties\\": {\n                \\"sdk\\": {\n                    \\"type\\": \\"array\\",\n                    \\"items\\": { \\"type\\": \\"string\\" }\n                },\n                \\"management_api\\": {\n                    \\"type\\": \\"array\\",\n                    \\"items\\": { \\"type\\": \\"string\\" }\n                },\n                \\"cli\\": {\n                    \\"type\\": \\"array\\",\n                    \\"items\\": { \\"type\\": \\"string\\" }\n                }\n            },\n            \\"additionalProperties\\": false\n        }',\n        instance := api\n    )\n)","create or replace function validate_troubleshooting_errors(errors jsonb[])\nreturns boolean as $$\ndeclare\n    error jsonb;\nbegin\n    if errors is null then\n        return true;\n    end if;\n\n    foreach error in array errors\n    loop\n        if not jsonb_matches_schema(\n            schema := '{\n                \\"type\\": \\"object\\",\n                \\"properties\\": {\n                    \\"http_status_code\\": { \\"type\\": \\"number\\" },\n                    \\"code\\": { \\"type\\": \\"string\\" },\n                    \\"message\\": { \\"type\\": \\"string\\" }\n                },\n                \\"additionalProperties\\": false\n            }',\n            instance := error\n        ) then\n            return false;\n        end if;\n    end loop;\n\n    return true;\nend;\n$$ language plpgsql","alter table troubleshooting_entries\nadd constraint troubleshooting_errors_check\ncheck (\n    validate_troubleshooting_errors(errors)\n)"}	troubleshooting_validation
20241121205753	{"alter table public.meetups\nadd column timezone text","alter table public.meetups\nadd column city text"}	add_meetups_columns
20241127183137	{"comment on column meetups.timezone is 'Needs to be in America/Los_Angeles format.'"}	comment_meetup_timezone
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 209, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_id_seq', 1, false);


--
-- Name: last_changed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.last_changed_id_seq', 1, false);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.page_id_seq', 1, false);


--
-- Name: page_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.page_section_id_seq', 1, false);


--
-- Name: tickets_ticket_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_ticket_number_seq', 1, false);


--
-- Name: validation_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validation_history_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: chunks chunks_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.chunks
    ADD CONSTRAINT chunks_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: embeddings embeddings_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.embeddings
    ADD CONSTRAINT embeddings_pkey PRIMARY KEY (id);


--
-- Name: message_references message_references_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.message_references
    ADD CONSTRAINT message_references_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: setting_audit_log setting_audit_log_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.setting_audit_log
    ADD CONSTRAINT setting_audit_log_pkey PRIMARY KEY (id);


--
-- Name: setting_categories setting_categories_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.setting_categories
    ADD CONSTRAINT setting_categories_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: source_versions source_versions_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.source_versions
    ADD CONSTRAINT source_versions_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: user_activities user_activities_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.user_activities
    ADD CONSTRAINT user_activities_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: visitors visitors_pkey; Type: CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: last_changed last_changed_parent_page_heading_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.last_changed
    ADD CONSTRAINT last_changed_parent_page_heading_key UNIQUE (parent_page, heading);


--
-- Name: last_changed last_changed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.last_changed
    ADD CONSTRAINT last_changed_pkey PRIMARY KEY (id);


--
-- Name: launch_weeks launch_weeks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.launch_weeks
    ADD CONSTRAINT launch_weeks_pkey PRIMARY KEY (id);


--
-- Name: meetups meetups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetups
    ADD CONSTRAINT meetups_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: page page_path_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_path_key UNIQUE (path);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: page_section page_section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page_section
    ADD CONSTRAINT page_section_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: project_members project_members_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_pkey PRIMARY KEY (id);


--
-- Name: project_members project_members_project_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_project_id_user_id_key UNIQUE (project_id, user_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_email_key UNIQUE (email, launch_week);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_ticket_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_ticket_number_key UNIQUE (ticket_number, launch_week);


--
-- Name: tickets tickets_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_username_key UNIQUE (username, launch_week);


--
-- Name: troubleshooting_entries troubleshooting_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.troubleshooting_entries
    ADD CONSTRAINT troubleshooting_entries_pkey PRIMARY KEY (id);


--
-- Name: validation_history validation_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validation_history
    ADD CONSTRAINT validation_history_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: idx_chunks_source_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_chunks_source_id ON ai_agent.chunks USING btree (source_id);


--
-- Name: idx_conversations_profile_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_conversations_profile_id ON ai_agent.conversations USING btree (profile_id);


--
-- Name: idx_conversations_share_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_conversations_share_id ON ai_agent.conversations USING btree (share_id);


--
-- Name: idx_conversations_user_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_conversations_user_id ON ai_agent.conversations USING btree (user_id);


--
-- Name: idx_conversations_visitor_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_conversations_visitor_id ON ai_agent.conversations USING btree (visitor_id);


--
-- Name: idx_embeddings_chunk_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_embeddings_chunk_id ON ai_agent.embeddings USING btree (chunk_id);


--
-- Name: idx_message_references_message_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_message_references_message_id ON ai_agent.message_references USING btree (message_id);


--
-- Name: idx_messages_conversation_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_messages_conversation_id ON ai_agent.messages USING btree (conversation_id);


--
-- Name: idx_messages_profile_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_messages_profile_id ON ai_agent.messages USING btree (profile_id);


--
-- Name: idx_messages_user_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_messages_user_id ON ai_agent.messages USING btree (user_id);


--
-- Name: idx_profiles_auth_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_profiles_auth_id ON ai_agent.profiles USING btree (auth_id);


--
-- Name: idx_profiles_email; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_profiles_email ON ai_agent.profiles USING btree (email);


--
-- Name: idx_users_email; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_users_email ON ai_agent.users USING btree (email);


--
-- Name: idx_visitors_visitor_id; Type: INDEX; Schema: ai_agent; Owner: supabase_admin
--

CREATE INDEX idx_visitors_visitor_id ON ai_agent.visitors USING btree (visitor_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: activities_entity_type_entity_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX activities_entity_type_entity_id_idx ON public.activities USING btree (entity_type, entity_id);


--
-- Name: activities_project_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX activities_project_id_idx ON public.activities USING btree (project_id);


--
-- Name: activities_user_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX activities_user_id_idx ON public.activities USING btree (user_id);


--
-- Name: comments_task_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX comments_task_id_idx ON public.comments USING btree (task_id);


--
-- Name: comments_user_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX comments_user_id_idx ON public.comments USING btree (user_id);


--
-- Name: files_project_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX files_project_id_idx ON public.files USING btree (project_id);


--
-- Name: files_uploaded_by_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX files_uploaded_by_idx ON public.files USING btree (uploaded_by);


--
-- Name: fts_search_index_page; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fts_search_index_page ON public.page USING gin (fts_tokens);


--
-- Name: fts_search_index_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fts_search_index_title ON public.page USING gin (title_tokens);


--
-- Name: idx_last_changed_parent_page_btree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_last_changed_parent_page_btree ON public.last_changed USING btree (parent_page);


--
-- Name: idx_profiles_auth_id; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX idx_profiles_auth_id ON public.profiles USING btree (auth_id);


--
-- Name: idx_profiles_email; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX idx_profiles_email ON public.profiles USING btree (email);


--
-- Name: idx_troubleshooting_checksum; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_troubleshooting_checksum ON public.troubleshooting_entries USING btree (checksum);


--
-- Name: messages_project_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX messages_project_id_idx ON public.messages USING btree (project_id);


--
-- Name: messages_user_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX messages_user_id_idx ON public.messages USING btree (user_id);


--
-- Name: tasks_assignee_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX tasks_assignee_id_idx ON public.tasks USING btree (assignee_id);


--
-- Name: tasks_creator_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX tasks_creator_id_idx ON public.tasks USING btree (creator_id);


--
-- Name: tasks_project_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX tasks_project_id_idx ON public.tasks USING btree (project_id);


--
-- Name: validation_history_tag_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX validation_history_tag_created_at_idx ON public.validation_history USING btree (tag, created_at DESC);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_unique ON storage.objects USING btree (name COLLATE "C", bucket_id);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: profiles sync_user_ids; Type: TRIGGER; Schema: ai_agent; Owner: supabase_admin
--

CREATE TRIGGER sync_user_ids BEFORE INSERT OR UPDATE ON ai_agent.profiles FOR EACH ROW EXECUTE FUNCTION ai_agent.sync_user_ids();


--
-- Name: users create_profile_on_signup; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER create_profile_on_signup AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.create_profile_for_new_user();


--
-- Name: tasks set_tasks_updated_at; Type: TRIGGER; Schema: public; Owner: supabase_admin
--

CREATE TRIGGER set_tasks_updated_at BEFORE UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: troubleshooting_entries update_troubleshooting_entry_date_updated_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_troubleshooting_entry_date_updated_trigger BEFORE UPDATE ON public.troubleshooting_entries FOR EACH ROW EXECUTE FUNCTION public.update_troubleshooting_entry_date_updated();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN ((new.name <> old.name)) EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: embeddings embeddings_chunk_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.embeddings
    ADD CONSTRAINT embeddings_chunk_id_fkey FOREIGN KEY (chunk_id) REFERENCES ai_agent.chunks(id);


--
-- Name: chunks fk_chunks_source_id; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.chunks
    ADD CONSTRAINT fk_chunks_source_id FOREIGN KEY (source_id) REFERENCES ai_agent.sources(id);


--
-- Name: conversations fk_conversations_profile_id; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.conversations
    ADD CONSTRAINT fk_conversations_profile_id FOREIGN KEY (profile_id) REFERENCES ai_agent.profiles(id) ON DELETE SET NULL;


--
-- Name: messages fk_messages_profile_id; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.messages
    ADD CONSTRAINT fk_messages_profile_id FOREIGN KEY (profile_id) REFERENCES ai_agent.profiles(id) ON DELETE SET NULL;


--
-- Name: settings fk_settings_category_id; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.settings
    ADD CONSTRAINT fk_settings_category_id FOREIGN KEY (category_id) REFERENCES ai_agent.setting_categories(id);


--
-- Name: sources fk_sources_created_by_user_id; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.sources
    ADD CONSTRAINT fk_sources_created_by_user_id FOREIGN KEY (created_by_user_id) REFERENCES ai_agent.users(id);


--
-- Name: message_references message_references_message_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.message_references
    ADD CONSTRAINT message_references_message_id_fkey FOREIGN KEY (message_id) REFERENCES ai_agent.messages(id);


--
-- Name: messages messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.messages
    ADD CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES ai_agent.conversations(id);


--
-- Name: profiles profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.profiles
    ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES ai_agent.permissions(id);


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES ai_agent.roles(id);


--
-- Name: setting_audit_log setting_audit_log_setting_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.setting_audit_log
    ADD CONSTRAINT setting_audit_log_setting_id_fkey FOREIGN KEY (setting_id) REFERENCES ai_agent.settings(id);


--
-- Name: setting_audit_log setting_audit_log_user_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.setting_audit_log
    ADD CONSTRAINT setting_audit_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES ai_agent.users(id);


--
-- Name: user_activities user_activities_user_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.user_activities
    ADD CONSTRAINT user_activities_user_id_fkey FOREIGN KEY (user_id) REFERENCES ai_agent.users(id);


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES ai_agent.roles(id);


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: ai_agent; Owner: supabase_admin
--

ALTER TABLE ONLY ai_agent.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES ai_agent.users(id);


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: activities activities_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: comments comments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: files files_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: meetups meetups_launch_week_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetups
    ADD CONSTRAINT meetups_launch_week_fkey FOREIGN KEY (launch_week) REFERENCES public.launch_weeks(id);


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: page_section page_section_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page_section
    ADD CONSTRAINT page_section_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.page(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);


--
-- Name: profiles profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: project_members project_members_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_members project_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.project_members
    ADD CONSTRAINT project_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: projects projects_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id);


--
-- Name: tickets public_tickets_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT public_tickets_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: tasks tasks_assignee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: tasks tasks_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_launch_week_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_launch_week_fkey FOREIGN KEY (launch_week) REFERENCES public.launch_weeks(id);


--
-- Name: tickets tickets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: profiles Allow insert for anon users; Type: POLICY; Schema: ai_agent; Owner: supabase_admin
--

CREATE POLICY "Allow insert for anon users" ON ai_agent.profiles FOR INSERT TO anon WITH CHECK (true);


--
-- Name: profiles Allow insert for auth users; Type: POLICY; Schema: ai_agent; Owner: supabase_admin
--

CREATE POLICY "Allow insert for auth users" ON ai_agent.profiles FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: profiles Authenticated users manage own profiles; Type: POLICY; Schema: ai_agent; Owner: supabase_admin
--

CREATE POLICY "Authenticated users manage own profiles" ON ai_agent.profiles TO authenticated USING (((auth.uid() = user_id) OR ((((current_setting('request.jwt.claims'::text, true))::jsonb ->> 'sub'::text) IS NOT NULL) AND (user_id = (((current_setting('request.jwt.claims'::text, true))::jsonb ->> 'sub'::text))::uuid)))) WITH CHECK (((user_id = auth.uid()) OR (user_id = (((current_setting('request.jwt.claims'::text, true))::jsonb ->> 'sub'::text))::uuid)));


--
-- Name: profiles Service role has full access; Type: POLICY; Schema: ai_agent; Owner: supabase_admin
--

CREATE POLICY "Service role has full access" ON ai_agent.profiles TO service_role USING (true) WITH CHECK (true);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: meetups Allow anybody to select all meetups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow anybody to select all meetups" ON public.meetups FOR SELECT USING (true);


--
-- Name: tickets Allow authenticated user to update its own ticket; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow authenticated user to update its own ticket" ON public.tickets FOR UPDATE TO authenticated USING ((user_id = auth.uid())) WITH CHECK ((user_id = auth.uid()));


--
-- Name: tickets Allow insert for authenticated users only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow insert for authenticated users only" ON public.tickets FOR INSERT TO authenticated WITH CHECK ((user_id = auth.uid()));


--
-- Name: launch_weeks Allow public read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow public read access" ON public.launch_weeks FOR SELECT USING (true);


--
-- Name: tickets Allow user to select own ticket; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow user to select own ticket" ON public.tickets FOR SELECT TO authenticated USING ((user_id = auth.uid()));


--
-- Name: feedback Anyone can insert feedback; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can insert feedback" ON public.feedback FOR INSERT WITH CHECK (true);


--
-- Name: projects Anyone can view public projects; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Anyone can view public projects" ON public.projects FOR SELECT USING ((visibility = 'public'::text));


--
-- Name: page Enable read access for anon and authenticated; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for anon and authenticated" ON public.page FOR SELECT TO authenticated, anon USING (true);


--
-- Name: page_section Enable read access for anon and authenticated; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for anon and authenticated" ON public.page_section FOR SELECT TO authenticated, anon USING (true);


--
-- Name: projects Members can view projects; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Members can view projects" ON public.projects FOR SELECT USING (public.is_project_member(id, auth.uid()));


--
-- Name: messages Project admins can delete messages; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project admins can delete messages" ON public.messages FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = messages.project_id) AND (project_members.user_id = auth.uid()) AND (project_members.role = ANY (ARRAY['owner'::text, 'admin'::text]))))));


--
-- Name: messages Project members can create messages; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project members can create messages" ON public.messages FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = messages.project_id) AND (project_members.user_id = auth.uid())))) AND (auth.uid() = user_id)));


--
-- Name: files Project members can delete the files; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project members can delete the files" ON public.files FOR DELETE USING (((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = files.project_id) AND (project_members.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.projects
  WHERE ((projects.id = files.project_id) AND (projects.owner_id = auth.uid()))))));


--
-- Name: files Project members can insert files; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project members can insert files" ON public.files FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = files.project_id) AND (project_members.user_id = auth.uid())))));


--
-- Name: files Project members can view files; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project members can view files" ON public.files FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = files.project_id) AND (project_members.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.projects
  WHERE ((projects.id = files.project_id) AND (projects.owner_id = auth.uid()))))));


--
-- Name: messages Project members can view messages; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project members can view messages" ON public.messages FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = messages.project_id) AND (project_members.user_id = auth.uid())))));


--
-- Name: projects Project owners can delete their projects; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project owners can delete their projects" ON public.projects FOR DELETE USING ((owner_id = auth.uid()));


--
-- Name: project_members Project owners can manage memberships; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project owners can manage memberships" ON public.project_members USING ((EXISTS ( SELECT 1
   FROM public.projects
  WHERE ((projects.id = project_members.project_id) AND (projects.owner_id = auth.uid())))));


--
-- Name: projects Project owners have full access; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project owners have full access" ON public.projects USING ((owner_id = auth.uid()));


--
-- Name: activities System can create activities; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "System can create activities" ON public.activities FOR INSERT WITH CHECK (true);


--
-- Name: project_members Users can add themselves as members; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can add themselves as members" ON public.project_members FOR INSERT WITH CHECK (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM public.projects
  WHERE ((projects.id = project_members.project_id) AND (projects.visibility = 'public'::text))))));


--
-- Name: comments Users can delete their own comments; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can delete their own comments" ON public.comments FOR DELETE USING ((user_id = auth.uid()));


--
-- Name: messages Users can delete their own messages; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can delete their own messages" ON public.messages FOR DELETE USING ((user_id = auth.uid()));


--
-- Name: profiles Users can insert their own profile; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: profiles Users can view any profile; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can view any profile" ON public.profiles FOR SELECT TO authenticated USING (true);


--
-- Name: project_members Users can view their own memberships; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can view their own memberships" ON public.project_members FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: profiles Users can view their own profile; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: activities; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;

--
-- Name: comments; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

--
-- Name: feedback; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.feedback ENABLE ROW LEVEL SECURITY;

--
-- Name: files; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.files ENABLE ROW LEVEL SECURITY;

--
-- Name: last_changed; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.last_changed ENABLE ROW LEVEL SECURITY;

--
-- Name: launch_weeks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.launch_weeks ENABLE ROW LEVEL SECURITY;

--
-- Name: meetups; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.meetups ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: page; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.page ENABLE ROW LEVEL SECURITY;

--
-- Name: page_section; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.page_section ENABLE ROW LEVEL SECURITY;

--
-- Name: project_members; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.project_members ENABLE ROW LEVEL SECURITY;

--
-- Name: projects; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;

--
-- Name: tasks; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

--
-- Name: tickets; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tickets ENABLE ROW LEVEL SECURITY;

--
-- Name: troubleshooting_entries; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.troubleshooting_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: validation_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.validation_history ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Avatars are publicly accessible; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Avatars are publicly accessible" ON storage.objects FOR SELECT USING ((bucket_id = 'avatars'::text));


--
-- Name: objects File uploaders and project admins can delete files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "File uploaders and project admins can delete files" ON storage.objects FOR DELETE USING (((bucket_id = 'project-files'::text) AND ((auth.uid() = owner) OR (EXISTS ( SELECT 1
   FROM public.project_members pm
  WHERE ((pm.project_id = ((storage.foldername(objects.name))[1])::uuid) AND (pm.user_id = auth.uid()) AND (pm.role = ANY (ARRAY['owner'::text, 'admin'::text]))))))));


--
-- Name: objects Project members can upload files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Project members can upload files" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'project-files'::text) AND (EXISTS ( SELECT 1
   FROM public.project_members pm
  WHERE ((pm.project_id = ((storage.foldername(objects.name))[1])::uuid) AND (pm.user_id = auth.uid()))))));


--
-- Name: objects Project members can view files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Project members can view files" ON storage.objects FOR SELECT USING (((bucket_id = 'project-files'::text) AND (EXISTS ( SELECT 1
   FROM public.project_members pm
  WHERE ((pm.project_id = ((storage.foldername(objects.name))[1])::uuid) AND (pm.user_id = auth.uid()))))));


--
-- Name: objects Users can delete avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can delete avatars" ON storage.objects FOR DELETE USING (((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text)));


--
-- Name: objects Users can update avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can update avatars" ON storage.objects FOR UPDATE USING (((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text)));


--
-- Name: objects Users can upload avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can upload avatars" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'avatars'::text) AND (auth.role() = 'authenticated'::text)));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime meetups; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.meetups;


--
-- Name: supabase_realtime tickets; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.tickets;


--
-- Name: SCHEMA ai_agent; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA ai_agent TO authenticated;
GRANT USAGE ON SCHEMA ai_agent TO anon;
GRANT USAGE ON SCHEMA ai_agent TO service_role;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- Name: FUNCTION halfvec_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_out(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_out(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_send(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_send(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_out(extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_out(extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_send(extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_send(extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_out(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_out(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_send(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_send(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_halfvec(real[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_halfvec(real[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_sparsevec(real[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_sparsevec(real[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(real[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(real[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_halfvec(double precision[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_halfvec(double precision[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_sparsevec(double precision[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_sparsevec(double precision[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(double precision[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(double precision[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_halfvec(integer[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_halfvec(integer[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_sparsevec(integer[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_sparsevec(integer[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(integer[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(integer[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_halfvec(numeric[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_halfvec(numeric[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_sparsevec(numeric[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_sparsevec(numeric[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION array_to_vector(numeric[], integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.array_to_vector(numeric[], integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_to_float4(extensions.halfvec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_to_float4(extensions.halfvec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec(extensions.halfvec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec(extensions.halfvec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_to_sparsevec(extensions.halfvec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_to_sparsevec(extensions.halfvec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_to_vector(extensions.halfvec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_to_vector(extensions.halfvec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_to_halfvec(extensions.sparsevec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_to_halfvec(extensions.sparsevec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec(extensions.sparsevec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec(extensions.sparsevec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_to_vector(extensions.sparsevec, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_to_vector(extensions.sparsevec, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_to_float4(extensions.vector, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_to_float4(extensions.vector, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_to_halfvec(extensions.vector, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_to_halfvec(extensions.vector, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_to_sparsevec(extensions.vector, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_to_sparsevec(extensions.vector, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector(extensions.vector, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector(extensions.vector, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION binary_quantize(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.binary_quantize(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION binary_quantize(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.binary_quantize(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION cosine_distance(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cosine_distance(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION cosine_distance(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cosine_distance(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION cosine_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cosine_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION halfvec_accum(double precision[], extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_accum(double precision[], extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_add(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_add(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_avg(double precision[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_avg(double precision[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_cmp(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_cmp(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_combine(double precision[], double precision[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_combine(double precision[], double precision[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_concat(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_concat(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_eq(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_eq(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_ge(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_ge(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_gt(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_gt(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_l2_squared_distance(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_l2_squared_distance(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_le(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_le(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_lt(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_lt(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_mul(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_mul(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_ne(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_ne(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_negative_inner_product(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_negative_inner_product(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_spherical_distance(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_spherical_distance(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION halfvec_sub(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.halfvec_sub(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hamming_distance(bit, bit); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hamming_distance(bit, bit) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hnsw_bit_support(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hnsw_bit_support(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hnsw_halfvec_support(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hnsw_halfvec_support(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hnsw_sparsevec_support(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hnsw_sparsevec_support(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hnswhandler(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hnswhandler(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION inner_product(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.inner_product(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION inner_product(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.inner_product(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION inner_product(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.inner_product(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION ivfflat_bit_support(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ivfflat_bit_support(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION ivfflat_halfvec_support(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ivfflat_halfvec_support(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION ivfflathandler(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.ivfflathandler(internal) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION jaccard_distance(bit, bit); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.jaccard_distance(bit, bit) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l1_distance(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l1_distance(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l1_distance(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l1_distance(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l1_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l1_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_distance(extensions.halfvec, extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_distance(extensions.halfvec, extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_distance(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_distance(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_norm(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_norm(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_norm(extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_norm(extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_normalize(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_normalize(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_normalize(extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_normalize(extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION l2_normalize(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.l2_normalize(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_cmp(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_cmp(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_eq(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_eq(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_ge(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_ge(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_gt(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_gt(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_l2_squared_distance(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_l2_squared_distance(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_le(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_le(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_lt(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_lt(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_ne(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_ne(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sparsevec_negative_inner_product(extensions.sparsevec, extensions.sparsevec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sparsevec_negative_inner_product(extensions.sparsevec, extensions.sparsevec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION subvector(extensions.halfvec, integer, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.subvector(extensions.halfvec, integer, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION subvector(extensions.vector, integer, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.subvector(extensions.vector, integer, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_accum(double precision[], extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_accum(double precision[], extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_add(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_add(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_avg(double precision[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_avg(double precision[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_cmp(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_cmp(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_combine(double precision[], double precision[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_combine(double precision[], double precision[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_concat(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_concat(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_dims(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_dims(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_dims(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_dims(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_eq(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_eq(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_ge(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_ge(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_gt(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_gt(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_l2_squared_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_l2_squared_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_le(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_le(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_lt(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_lt(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_mul(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_mul(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_ne(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_ne(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_negative_inner_product(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_negative_inner_product(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_norm(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_norm(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_spherical_distance(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_spherical_distance(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION vector_sub(extensions.vector, extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.vector_sub(extensions.vector, extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION cleanup_last_changed_pages(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.cleanup_last_changed_pages() FROM PUBLIC;
GRANT ALL ON FUNCTION public.cleanup_last_changed_pages() TO service_role;


--
-- Name: FUNCTION create_profile_for_new_user(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.create_profile_for_new_user() TO postgres;
GRANT ALL ON FUNCTION public.create_profile_for_new_user() TO anon;
GRANT ALL ON FUNCTION public.create_profile_for_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.create_profile_for_new_user() TO service_role;


--
-- Name: FUNCTION docs_search_embeddings(embedding extensions.vector, match_threshold double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.docs_search_embeddings(embedding extensions.vector, match_threshold double precision) TO anon;
GRANT ALL ON FUNCTION public.docs_search_embeddings(embedding extensions.vector, match_threshold double precision) TO authenticated;
GRANT ALL ON FUNCTION public.docs_search_embeddings(embedding extensions.vector, match_threshold double precision) TO service_role;


--
-- Name: FUNCTION docs_search_fts(query text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.docs_search_fts(query text) TO anon;
GRANT ALL ON FUNCTION public.docs_search_fts(query text) TO authenticated;
GRANT ALL ON FUNCTION public.docs_search_fts(query text) TO service_role;


--
-- Name: FUNCTION get_last_revalidation_for_tags(tags text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_last_revalidation_for_tags(tags text[]) TO anon;
GRANT ALL ON FUNCTION public.get_last_revalidation_for_tags(tags text[]) TO authenticated;
GRANT ALL ON FUNCTION public.get_last_revalidation_for_tags(tags text[]) TO service_role;


--
-- Name: FUNCTION handle_updated_at(); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.handle_updated_at() TO postgres;
GRANT ALL ON FUNCTION public.handle_updated_at() TO anon;
GRANT ALL ON FUNCTION public.handle_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.handle_updated_at() TO service_role;


--
-- Name: FUNCTION ipv6_active_status(project_ref text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ipv6_active_status(project_ref text) TO anon;
GRANT ALL ON FUNCTION public.ipv6_active_status(project_ref text) TO authenticated;
GRANT ALL ON FUNCTION public.ipv6_active_status(project_ref text) TO service_role;


--
-- Name: FUNCTION is_project_member(project_id uuid, user_id uuid); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.is_project_member(project_id uuid, user_id uuid) TO postgres;
GRANT ALL ON FUNCTION public.is_project_member(project_id uuid, user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.is_project_member(project_id uuid, user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.is_project_member(project_id uuid, user_id uuid) TO service_role;


--
-- Name: FUNCTION json_matches_schema(schema json, instance json); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.json_matches_schema(schema json, instance json) TO postgres;
GRANT ALL ON FUNCTION public.json_matches_schema(schema json, instance json) TO anon;
GRANT ALL ON FUNCTION public.json_matches_schema(schema json, instance json) TO authenticated;
GRANT ALL ON FUNCTION public.json_matches_schema(schema json, instance json) TO service_role;


--
-- Name: FUNCTION jsonb_matches_schema(schema json, instance jsonb); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.jsonb_matches_schema(schema json, instance jsonb) TO postgres;
GRANT ALL ON FUNCTION public.jsonb_matches_schema(schema json, instance jsonb) TO anon;
GRANT ALL ON FUNCTION public.jsonb_matches_schema(schema json, instance jsonb) TO authenticated;
GRANT ALL ON FUNCTION public.jsonb_matches_schema(schema json, instance jsonb) TO service_role;


--
-- Name: FUNCTION jsonschema_is_valid(schema json); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.jsonschema_is_valid(schema json) TO postgres;
GRANT ALL ON FUNCTION public.jsonschema_is_valid(schema json) TO anon;
GRANT ALL ON FUNCTION public.jsonschema_is_valid(schema json) TO authenticated;
GRANT ALL ON FUNCTION public.jsonschema_is_valid(schema json) TO service_role;


--
-- Name: FUNCTION jsonschema_validation_errors(schema json, instance json); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.jsonschema_validation_errors(schema json, instance json) TO postgres;
GRANT ALL ON FUNCTION public.jsonschema_validation_errors(schema json, instance json) TO anon;
GRANT ALL ON FUNCTION public.jsonschema_validation_errors(schema json, instance json) TO authenticated;
GRANT ALL ON FUNCTION public.jsonschema_validation_errors(schema json, instance json) TO service_role;


--
-- Name: TABLE page_section; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.page_section TO anon;
GRANT ALL ON TABLE public.page_section TO authenticated;
GRANT ALL ON TABLE public.page_section TO service_role;


--
-- Name: FUNCTION match_page_sections_v2(embedding extensions.vector, match_threshold double precision, min_content_length integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.match_page_sections_v2(embedding extensions.vector, match_threshold double precision, min_content_length integer) TO anon;
GRANT ALL ON FUNCTION public.match_page_sections_v2(embedding extensions.vector, match_threshold double precision, min_content_length integer) TO authenticated;
GRANT ALL ON FUNCTION public.match_page_sections_v2(embedding extensions.vector, match_threshold double precision, min_content_length integer) TO service_role;


--
-- Name: FUNCTION update_last_changed_checksum(new_parent_page text, new_heading text, new_checksum text, git_update_time timestamp with time zone, check_time timestamp with time zone); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.update_last_changed_checksum(new_parent_page text, new_heading text, new_checksum text, git_update_time timestamp with time zone, check_time timestamp with time zone) FROM PUBLIC;
GRANT ALL ON FUNCTION public.update_last_changed_checksum(new_parent_page text, new_heading text, new_checksum text, git_update_time timestamp with time zone, check_time timestamp with time zone) TO service_role;


--
-- Name: FUNCTION update_troubleshooting_entry_date_updated(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_troubleshooting_entry_date_updated() TO anon;
GRANT ALL ON FUNCTION public.update_troubleshooting_entry_date_updated() TO authenticated;
GRANT ALL ON FUNCTION public.update_troubleshooting_entry_date_updated() TO service_role;


--
-- Name: FUNCTION validate_troubleshooting_errors(errors jsonb[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_troubleshooting_errors(errors jsonb[]) TO anon;
GRANT ALL ON FUNCTION public.validate_troubleshooting_errors(errors jsonb[]) TO authenticated;
GRANT ALL ON FUNCTION public.validate_troubleshooting_errors(errors jsonb[]) TO service_role;


--
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;


--
-- Name: FUNCTION avg(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.avg(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION avg(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.avg(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sum(extensions.halfvec); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sum(extensions.halfvec) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sum(extensions.vector); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sum(extensions.vector) TO postgres WITH GRANT OPTION;


--
-- Name: TABLE chunks; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.chunks TO authenticated;
GRANT SELECT ON TABLE ai_agent.chunks TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.chunks TO service_role;


--
-- Name: TABLE conversations; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT ALL ON TABLE ai_agent.conversations TO authenticated;
GRANT ALL ON TABLE ai_agent.conversations TO anon;
GRANT ALL ON TABLE ai_agent.conversations TO service_role;


--
-- Name: TABLE embeddings; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.embeddings TO authenticated;
GRANT SELECT ON TABLE ai_agent.embeddings TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.embeddings TO service_role;


--
-- Name: TABLE message_references; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.message_references TO authenticated;
GRANT SELECT ON TABLE ai_agent.message_references TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.message_references TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT ALL ON TABLE ai_agent.messages TO authenticated;
GRANT ALL ON TABLE ai_agent.messages TO anon;
GRANT ALL ON TABLE ai_agent.messages TO service_role;


--
-- Name: TABLE permissions; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.permissions TO authenticated;
GRANT SELECT ON TABLE ai_agent.permissions TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.permissions TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT ALL ON TABLE ai_agent.profiles TO authenticated;
GRANT ALL ON TABLE ai_agent.profiles TO anon;
GRANT ALL ON TABLE ai_agent.profiles TO service_role;


--
-- Name: TABLE role_permissions; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.role_permissions TO authenticated;
GRANT SELECT ON TABLE ai_agent.role_permissions TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.role_permissions TO service_role;


--
-- Name: TABLE roles; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.roles TO authenticated;
GRANT SELECT ON TABLE ai_agent.roles TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.roles TO service_role;


--
-- Name: TABLE setting_audit_log; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.setting_audit_log TO authenticated;
GRANT SELECT ON TABLE ai_agent.setting_audit_log TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.setting_audit_log TO service_role;


--
-- Name: TABLE setting_categories; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.setting_categories TO authenticated;
GRANT SELECT ON TABLE ai_agent.setting_categories TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.setting_categories TO service_role;


--
-- Name: TABLE settings; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.settings TO authenticated;
GRANT SELECT ON TABLE ai_agent.settings TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.settings TO service_role;


--
-- Name: TABLE source_versions; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.source_versions TO authenticated;
GRANT SELECT ON TABLE ai_agent.source_versions TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.source_versions TO service_role;


--
-- Name: TABLE sources; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.sources TO authenticated;
GRANT SELECT ON TABLE ai_agent.sources TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.sources TO service_role;


--
-- Name: TABLE user_activities; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.user_activities TO authenticated;
GRANT SELECT ON TABLE ai_agent.user_activities TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.user_activities TO service_role;


--
-- Name: TABLE user_roles; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.user_roles TO authenticated;
GRANT SELECT ON TABLE ai_agent.user_roles TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.user_roles TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.users TO authenticated;
GRANT SELECT ON TABLE ai_agent.users TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.users TO service_role;


--
-- Name: TABLE visitors; Type: ACL; Schema: ai_agent; Owner: supabase_admin
--

GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.visitors TO authenticated;
GRANT SELECT ON TABLE ai_agent.visitors TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE ai_agent.visitors TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE feedback; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.feedback TO anon;
GRANT ALL ON TABLE public.feedback TO authenticated;
GRANT ALL ON TABLE public.feedback TO service_role;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE activities; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.activities TO postgres;
GRANT ALL ON TABLE public.activities TO anon;
GRANT ALL ON TABLE public.activities TO authenticated;
GRANT ALL ON TABLE public.activities TO service_role;


--
-- Name: TABLE comments; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.comments TO postgres;
GRANT ALL ON TABLE public.comments TO anon;
GRANT ALL ON TABLE public.comments TO authenticated;
GRANT ALL ON TABLE public.comments TO service_role;


--
-- Name: SEQUENCE feedback_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.feedback_id_seq TO anon;
GRANT ALL ON SEQUENCE public.feedback_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.feedback_id_seq TO service_role;


--
-- Name: TABLE files; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.files TO postgres;
GRANT ALL ON TABLE public.files TO anon;
GRANT ALL ON TABLE public.files TO authenticated;
GRANT ALL ON TABLE public.files TO service_role;


--
-- Name: TABLE last_changed; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.last_changed TO service_role;


--
-- Name: SEQUENCE last_changed_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.last_changed_id_seq TO anon;
GRANT ALL ON SEQUENCE public.last_changed_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.last_changed_id_seq TO service_role;


--
-- Name: TABLE launch_weeks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.launch_weeks TO anon;
GRANT ALL ON TABLE public.launch_weeks TO authenticated;
GRANT ALL ON TABLE public.launch_weeks TO service_role;


--
-- Name: TABLE meetups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.meetups TO anon;
GRANT ALL ON TABLE public.meetups TO authenticated;
GRANT ALL ON TABLE public.meetups TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.messages TO postgres;
GRANT ALL ON TABLE public.messages TO anon;
GRANT ALL ON TABLE public.messages TO authenticated;
GRANT ALL ON TABLE public.messages TO service_role;


--
-- Name: TABLE page; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.page TO anon;
GRANT ALL ON TABLE public.page TO authenticated;
GRANT ALL ON TABLE public.page TO service_role;


--
-- Name: SEQUENCE page_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.page_id_seq TO anon;
GRANT ALL ON SEQUENCE public.page_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.page_id_seq TO service_role;


--
-- Name: SEQUENCE page_section_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.page_section_id_seq TO anon;
GRANT ALL ON SEQUENCE public.page_section_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.page_section_id_seq TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.profiles TO postgres;
GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE project_members; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.project_members TO postgres;
GRANT ALL ON TABLE public.project_members TO anon;
GRANT ALL ON TABLE public.project_members TO authenticated;
GRANT ALL ON TABLE public.project_members TO service_role;


--
-- Name: TABLE projects; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.projects TO postgres;
GRANT ALL ON TABLE public.projects TO anon;
GRANT ALL ON TABLE public.projects TO authenticated;
GRANT ALL ON TABLE public.projects TO service_role;


--
-- Name: TABLE tasks; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.tasks TO postgres;
GRANT ALL ON TABLE public.tasks TO anon;
GRANT ALL ON TABLE public.tasks TO authenticated;
GRANT ALL ON TABLE public.tasks TO service_role;


--
-- Name: TABLE tickets; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tickets TO anon;
GRANT ALL ON TABLE public.tickets TO authenticated;
GRANT ALL ON TABLE public.tickets TO service_role;


--
-- Name: COLUMN tickets.role; Type: ACL; Schema: public; Owner: postgres
--

GRANT UPDATE(role) ON TABLE public.tickets TO authenticated;


--
-- Name: COLUMN tickets.company; Type: ACL; Schema: public; Owner: postgres
--

GRANT UPDATE(company) ON TABLE public.tickets TO authenticated;


--
-- Name: COLUMN tickets.location; Type: ACL; Schema: public; Owner: postgres
--

GRANT UPDATE(location) ON TABLE public.tickets TO authenticated;


--
-- Name: SEQUENCE tickets_ticket_number_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tickets_ticket_number_seq TO anon;
GRANT ALL ON SEQUENCE public.tickets_ticket_number_seq TO authenticated;
GRANT ALL ON SEQUENCE public.tickets_ticket_number_seq TO service_role;


--
-- Name: TABLE tickets_view; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tickets_view TO anon;
GRANT ALL ON TABLE public.tickets_view TO authenticated;
GRANT ALL ON TABLE public.tickets_view TO service_role;


--
-- Name: TABLE troubleshooting_entries; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.troubleshooting_entries TO anon;
GRANT ALL ON TABLE public.troubleshooting_entries TO authenticated;
GRANT ALL ON TABLE public.troubleshooting_entries TO service_role;


--
-- Name: TABLE validation_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.validation_history TO anon;
GRANT ALL ON TABLE public.validation_history TO authenticated;
GRANT ALL ON TABLE public.validation_history TO service_role;


--
-- Name: SEQUENCE validation_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.validation_history_id_seq TO anon;
GRANT ALL ON SEQUENCE public.validation_history_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.validation_history_id_seq TO service_role;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

