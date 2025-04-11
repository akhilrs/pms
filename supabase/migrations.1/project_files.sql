
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


