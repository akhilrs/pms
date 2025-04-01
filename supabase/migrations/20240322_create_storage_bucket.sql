-- Create a new storage bucket for project files
INSERT INTO storage.buckets (id, name, public)
VALUES ('project-files', 'project-files', true);

-- Set up storage policies
CREATE POLICY "Project members can view files"
ON storage.objects FOR SELECT
USING (
  bucket_id = 'project-files' AND
  EXISTS (
    SELECT 1 FROM public.project_members pm
    WHERE pm.project_id = (storage.foldername(name))[1]::uuid
    AND pm.user_id = auth.uid()
  )
);

CREATE POLICY "Project members can upload files"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'project-files' AND
  EXISTS (
    SELECT 1 FROM public.project_members pm
    WHERE pm.project_id = (storage.foldername(name))[1]::uuid
    AND pm.user_id = auth.uid()
  )
);

CREATE POLICY "File uploaders and project admins can delete files"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'project-files' AND
  (
    auth.uid() = owner OR
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = (storage.foldername(name))[1]::uuid
      AND pm.user_id = auth.uid()
      AND pm.role IN ('owner', 'admin')
    )
  )
); 