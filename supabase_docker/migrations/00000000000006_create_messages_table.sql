-- Create messages table
CREATE TABLE IF NOT EXISTS public.messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content TEXT NOT NULL,
  project_id UUID NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Set up Row Level Security (RLS)
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Project members can view messages
CREATE POLICY "Project members can view messages" ON public.messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- Project members can send messages
CREATE POLICY "Project members can send messages" ON public.messages
  FOR INSERT WITH CHECK (
    user_id = auth.uid() AND
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- Users can delete their own messages
CREATE POLICY "Users can delete their own messages" ON public.messages
  FOR DELETE USING (user_id = auth.uid());

-- Project admins and owners can delete any message
CREATE POLICY "Project admins can delete any message" ON public.messages
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid() AND pm.role IN ('owner', 'admin')
    )
  );

-- Add indexes for faster message lookups
CREATE INDEX messages_project_id_idx ON public.messages(project_id);
CREATE INDEX messages_user_id_idx ON public.messages(user_id); 