-- Create activities table
CREATE TABLE IF NOT EXISTS public.activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  entity_type TEXT NOT NULL,
  entity_id UUID NOT NULL,
  action TEXT NOT NULL,
  details JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Set up Row Level Security (RLS)
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Project members can view activities
CREATE POLICY "Project members can view activities" ON public.activities
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- System can create activities (all activities are created by the system)
CREATE POLICY "System can create activities" ON public.activities
  FOR INSERT WITH CHECK (true);

-- No deletion policy (activities are permanent records)

-- Add indexes for faster activity lookups
CREATE INDEX activities_project_id_idx ON public.activities(project_id);
CREATE INDEX activities_user_id_idx ON public.activities(user_id);
CREATE INDEX activities_entity_type_entity_id_idx ON public.activities(entity_type, entity_id); 