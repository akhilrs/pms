
CREATE EXTENSION IF NOT EXISTS "pg_jsonschema" WITH SCHEMA "public";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "vector" WITH SCHEMA "extensions";



CREATE OR REPLACE FUNCTION "public"."create_profile_for_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, user_id, first_name, last_name, avatar_url, created_at, updated_at)
  VALUES (NEW.id, NEW.id, '', '', '', NOW(), NOW());
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."create_profile_for_new_user"() OWNER TO "supabase_admin";


CREATE OR REPLACE FUNCTION "public"."is_project_member"("project_id" "uuid", "user_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $_$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM project_members 
    WHERE project_members.project_id = $1 
    AND project_members.user_id = $2
  );
END;
$_$;


ALTER FUNCTION "public"."is_project_member"("project_id" "uuid", "user_id" "uuid") OWNER TO "supabase_admin";

CREATE OR REPLACE FUNCTION "public"."handle_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_updated_at"() OWNER TO "supabase_admin";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid",
    "first_name" "text",
    "last_name" "text",
    "avatar_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "auth_id" "uuid",
    "email" "text",
    "full_name" "text",
    "display_name" "text",
    "ip_address" "text",
    "last_login_ip" "text",
    "user_agent" "text",
    "browser" "text",
    "os" "text",
    "device_type" "text",
    "login_count" integer DEFAULT 0,
    "last_login_at" timestamp with time zone
);


ALTER TABLE "public"."profiles" OWNER TO "supabase_admin";


CREATE TABLE IF NOT EXISTS "public"."project_members" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "text" DEFAULT 'member'::"text" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_members" OWNER TO "supabase_admin";


CREATE TABLE IF NOT EXISTS "public"."projects" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "owner_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'Planning'::"text",
    "start_date" timestamp with time zone DEFAULT "now"(),
    "end_date" timestamp with time zone,
    "visibility" "text" DEFAULT 'private'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."projects" OWNER TO "supabase_admin";



CREATE TABLE IF NOT EXISTS "public"."projects" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "owner_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'Planning'::"text",
    "start_date" timestamp with time zone DEFAULT "now"(),
    "end_date" timestamp with time zone,
    "visibility" "text" DEFAULT 'private'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."projects" OWNER TO "supabase_admin";

CREATE TABLE IF NOT EXISTS "public"."tasks" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "status" "text" NOT NULL,
    "priority" "text" NOT NULL,
    "due_date" timestamp with time zone,
    "project_id" "uuid" NOT NULL,
    "assignee_id" "uuid",
    "creator_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "tasks_priority_check" CHECK (("priority" = ANY (ARRAY['Low'::"text", 'Medium'::"text", 'High'::"text"]))),
    CONSTRAINT "tasks_status_check" CHECK (("status" = ANY (ARRAY['To Do'::"text", 'In Progress'::"text", 'Completed'::"text"])))
);


ALTER TABLE "public"."tasks" OWNER TO "supabase_admin";

CREATE TABLE IF NOT EXISTS "public"."activities" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "entity_type" "text" NOT NULL,
    "entity_id" "uuid" NOT NULL,
    "action" "text" NOT NULL,
    "details" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."activities" OWNER TO "supabase_admin";


ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_members"
    ADD CONSTRAINT "project_members_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_members"
    ADD CONSTRAINT "project_members_project_id_user_id_key" UNIQUE ("project_id", "user_id");



ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");


CREATE INDEX "activities_entity_type_entity_id_idx" ON "public"."activities" USING "btree" ("entity_type", "entity_id");
CREATE INDEX "activities_project_id_idx" ON "public"."activities" USING "btree" ("project_id");
CREATE INDEX "activities_user_id_idx" ON "public"."activities" USING "btree" ("user_id");
CREATE INDEX "idx_profiles_auth_id" ON "public"."profiles" USING "btree" ("auth_id");
CREATE INDEX "idx_profiles_email" ON "public"."profiles" USING "btree" ("email");
CREATE INDEX "tasks_assignee_id_idx" ON "public"."tasks" USING "btree" ("assignee_id");
CREATE INDEX "tasks_creator_id_idx" ON "public"."tasks" USING "btree" ("creator_id");
CREATE INDEX "tasks_project_id_idx" ON "public"."tasks" USING "btree" ("project_id");

CREATE OR REPLACE TRIGGER "set_tasks_updated_at" BEFORE UPDATE ON "public"."tasks" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();


ALTER TABLE ONLY "public"."activities"
    ADD CONSTRAINT "activities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");

ALTER TABLE ONLY "public"."project_members"
    ADD CONSTRAINT "project_members_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."project_members"
    ADD CONSTRAINT "project_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");

ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "auth"."users"("id");

ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_assignee_id_fkey" FOREIGN KEY ("assignee_id") REFERENCES "auth"."users"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


CREATE POLICY "Anyone can view public projects" ON "public"."projects" FOR SELECT USING (("visibility" = 'public'::"text"));
CREATE POLICY "Project owners can delete their projects" ON "public"."projects" FOR DELETE USING (("owner_id" = "auth"."uid"()));
CREATE POLICY "Project owners can manage memberships" ON "public"."project_members" USING ((EXISTS ( SELECT 1
   FROM "public"."projects"
  WHERE (("projects"."id" = "project_members"."project_id") AND ("projects"."owner_id" = "auth"."uid"())))));
CREATE POLICY "Project owners have full access" ON "public"."projects" USING (("owner_id" = "auth"."uid"()));
CREATE POLICY "System can create activities" ON "public"."activities" FOR INSERT WITH CHECK (true);
CREATE POLICY "Users can add themselves as members" ON "public"."project_members" FOR INSERT WITH CHECK ((("auth"."uid"() = "user_id") AND (EXISTS ( SELECT 1
   FROM "public"."projects"
  WHERE (("projects"."id" = "project_members"."project_id") AND ("projects"."visibility" = 'public'::"text"))))));
CREATE POLICY "Users can insert their own profile" ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can update their own profile" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can view any profile" ON "public"."profiles" FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Users can view their own memberships" ON "public"."project_members" FOR SELECT USING (("user_id" = "auth"."uid"()));
CREATE POLICY "Users can view their own profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "user_id"));

ALTER TABLE "public"."activities" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."project_members" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."projects" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."tasks" ENABLE ROW LEVEL SECURITY;


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON FUNCTION "public"."create_profile_for_new_user"() TO "postgres";
GRANT ALL ON FUNCTION "public"."create_profile_for_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_profile_for_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_profile_for_new_user"() TO "service_role";


GRANT ALL ON FUNCTION "public"."is_project_member"("project_id" "uuid", "user_id" "uuid") TO "postgres";
GRANT ALL ON FUNCTION "public"."is_project_member"("project_id" "uuid", "user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_project_member"("project_id" "uuid", "user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_project_member"("project_id" "uuid", "user_id" "uuid") TO "service_role";


GRANT ALL ON TABLE "public"."activities" TO "postgres";
GRANT ALL ON TABLE "public"."activities" TO "anon";
GRANT ALL ON TABLE "public"."activities" TO "authenticated";
GRANT ALL ON TABLE "public"."activities" TO "service_role";


GRANT ALL ON TABLE "public"."profiles" TO "postgres";
GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."project_members" TO "postgres";
GRANT ALL ON TABLE "public"."project_members" TO "anon";
GRANT ALL ON TABLE "public"."project_members" TO "authenticated";
GRANT ALL ON TABLE "public"."project_members" TO "service_role";



GRANT ALL ON TABLE "public"."projects" TO "postgres";
GRANT ALL ON TABLE "public"."projects" TO "anon";
GRANT ALL ON TABLE "public"."projects" TO "authenticated";
GRANT ALL ON TABLE "public"."projects" TO "service_role";



GRANT ALL ON TABLE "public"."tasks" TO "postgres";
GRANT ALL ON TABLE "public"."tasks" TO "anon";
GRANT ALL ON TABLE "public"."tasks" TO "authenticated";
GRANT ALL ON TABLE "public"."tasks" TO "service_role";


