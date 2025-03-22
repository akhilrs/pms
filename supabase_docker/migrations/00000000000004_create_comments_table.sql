-- Create comments table
CREATE TABLE IF NOT EXISTS public.comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content TEXT NOT NULL,
  task_id UUID NOT NULL REFERENCES public.tasks(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Set up Row Level Security (RLS)
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Users can view comments on tasks they can access
CREATE POLICY "Users can view comments on accessible tasks" ON public.comments
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.tasks t
      JOIN public.project_members pm ON t.project_id = pm.project_id
      WHERE t.id = task_id AND pm.user_id = auth.uid()
    )
  );

-- Users can add comments to tasks they can access
CREATE POLICY "Users can comment on accessible tasks" ON public.comments
  FOR INSERT WITH CHECK (
    user_id = auth.uid() AND
    EXISTS (
      SELECT 1 FROM public.tasks t
      JOIN public.project_members pm ON t.project_id = pm.project_id
      WHERE t.id = task_id AND pm.user_id = auth.uid()
    )
  );

-- Users can only delete their own comments
CREATE POLICY "Users can delete their own comments" ON public.comments
  FOR DELETE USING (user_id = auth.uid());

-- Project admins and owners can delete any comment
CREATE POLICY "Project admins can delete any comment" ON public.comments
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM public.tasks t
      JOIN public.project_members pm ON t.project_id = pm.project_id
      WHERE t.id = task_id AND pm.user_id = auth.uid() AND pm.role IN ('owner', 'admin')
    )
  );

-- Add indexes for faster comment lookups
CREATE INDEX comments_task_id_idx ON public.comments(task_id);
CREATE INDEX comments_user_id_idx ON public.comments(user_id); 