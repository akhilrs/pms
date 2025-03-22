-- Create tasks table
CREATE TABLE IF NOT EXISTS public.tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL CHECK (status IN ('To Do', 'In Progress', 'Completed')),
  priority TEXT NOT NULL CHECK (priority IN ('Low', 'Medium', 'High')),
  due_date TIMESTAMPTZ,
  project_id UUID NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
  assignee_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  creator_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Set up Row Level Security (RLS)
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Users can view tasks for projects they are a member of
CREATE POLICY "Users can view tasks of their projects" ON public.tasks
  FOR SELECT USING (
    creator_id = auth.uid() OR
    assignee_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- Project members can create tasks
CREATE POLICY "Project members can create tasks" ON public.tasks
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
    )
  );

-- Task creators and assignees can update tasks
CREATE POLICY "Task creators and assignees can update tasks" ON public.tasks
  FOR UPDATE USING (
    creator_id = auth.uid() OR
    assignee_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid() AND pm.role IN ('owner', 'admin')
    )
  );

-- Task creators and project admins can delete tasks
CREATE POLICY "Task creators and project admins can delete tasks" ON public.tasks
  FOR DELETE USING (
    creator_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = project_id AND pm.user_id = auth.uid() AND pm.role IN ('owner', 'admin')
    )
  );

-- Create triggers for updated_at
CREATE TRIGGER set_tasks_updated_at
BEFORE UPDATE ON public.tasks
FOR EACH ROW
EXECUTE FUNCTION public.handle_updated_at();

-- Add indexes for faster task lookups
CREATE INDEX tasks_project_id_idx ON public.tasks(project_id);
CREATE INDEX tasks_assignee_id_idx ON public.tasks(assignee_id);
CREATE INDEX tasks_creator_id_idx ON public.tasks(creator_id); 