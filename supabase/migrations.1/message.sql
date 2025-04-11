
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
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: messages_project_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX messages_project_id_idx ON public.messages USING btree (project_id);


--
-- Name: messages_user_id_idx; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX messages_user_id_idx ON public.messages USING btree (user_id);


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


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
-- Name: messages Project members can view messages; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Project members can view messages" ON public.messages FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.project_members
  WHERE ((project_members.project_id = messages.project_id) AND (project_members.user_id = auth.uid())))));


--
-- Name: messages Users can delete their own messages; Type: POLICY; Schema: public; Owner: supabase_admin
--

CREATE POLICY "Users can delete their own messages" ON public.messages FOR DELETE USING ((user_id = auth.uid()));


--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.messages TO postgres;
GRANT ALL ON TABLE public.messages TO anon;
GRANT ALL ON TABLE public.messages TO authenticated;
GRANT ALL ON TABLE public.messages TO service_role;


