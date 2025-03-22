-- Create project_members table
CREATE TABLE IF NOT EXISTS public.project_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('owner', 'admin', 'member')),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(project_id, user_id)
);

-- Set up Row Level Security (RLS)
ALTER TABLE public.project_members ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Project owners can manage all members
CREATE POLICY "Project owners can manage members" ON public.project_members
  USING (
    EXISTS (
      SELECT 1 FROM public.projects p
      WHERE p.id = project_id AND p.owner_id = auth.uid()
    )
  );

-- Users can view project members for projects they are a member of
CREATE POLICY "Users can view members of their projects" ON public.project_members
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- Users can see which projects they are members of
CREATE POLICY "Users can see their own memberships" ON public.project_members
  FOR SELECT USING (user_id = auth.uid());

-- Add index for faster project member lookup
CREATE INDEX project_members_project_id_idx ON public.project_members(project_id);
CREATE INDEX project_members_user_id_idx ON public.project_members(user_id); 