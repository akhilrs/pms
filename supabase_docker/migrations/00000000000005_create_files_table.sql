-- Create files table
CREATE TABLE IF NOT EXISTS public.files (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  size INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  storage_path TEXT NOT NULL,
  project_id UUID NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  uploaded_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Set up Row Level Security (RLS)
ALTER TABLE public.files ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Project members can view files
CREATE POLICY "Project members can view files" ON public.files
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- Project members can upload files
CREATE POLICY "Project members can upload files" ON public.files
  FOR INSERT WITH CHECK (
    uploaded_by = auth.uid() AND
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- File uploaders and project admins can delete files
CREATE POLICY "File uploaders and project admins can delete files" ON public.files
  FOR DELETE USING (
    uploaded_by = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid() AND pm.role IN ('owner', 'admin')
    )
  );

-- Add indexes for faster file lookups
CREATE INDEX files_project_id_idx ON public.files(project_id);
CREATE INDEX files_uploaded_by_idx ON public.files(uploaded_by); 