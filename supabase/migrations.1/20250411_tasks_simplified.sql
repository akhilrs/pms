-- Create tasks table if it doesn't exist already
CREATE TABLE IF NOT EXISTS tasks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'Not Started',
  priority TEXT NOT NULL DEFAULT 'Medium',
  due_date TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  assignee_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  milestone_id UUID REFERENCES milestones(id) ON DELETE SET NULL
);

-- Enable RLS on tasks table
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- Very simple RLS policies for tasks
-- Let's use basic policies to avoid complex joins that might be troublesome
-- These can be enhanced later once we've tested that they work

-- Allow users to view tasks for projects they own
CREATE POLICY tasks_select_owner_policy ON tasks
  FOR SELECT
  USING (
    project_id IN (
      SELECT id FROM projects 
      WHERE owner_id = auth.uid()
    )
  );

-- Allow users to view tasks they're assigned to
CREATE POLICY tasks_select_assignee_policy ON tasks
  FOR SELECT
  USING (
    assignee_id = auth.uid()
  );

-- Allow users to create tasks in projects they own
CREATE POLICY tasks_insert_policy ON tasks
  FOR INSERT
  WITH CHECK (
    project_id IN (
      SELECT id FROM projects 
      WHERE owner_id = auth.uid()
    )
  );

-- Allow users to update tasks in projects they own
CREATE POLICY tasks_update_owner_policy ON tasks
  FOR UPDATE
  USING (
    project_id IN (
      SELECT id FROM projects 
      WHERE owner_id = auth.uid()
    )
  );

-- Allow users to update tasks assigned to them
CREATE POLICY tasks_update_assignee_policy ON tasks
  FOR UPDATE
  USING (
    assignee_id = auth.uid()
  );

-- Allow only project owners to delete tasks
CREATE POLICY tasks_delete_policy ON tasks
  FOR DELETE
  USING (
    project_id IN (
      SELECT id FROM projects 
      WHERE owner_id = auth.uid()
    )
  );

-- Add comment on table for documentation
COMMENT ON TABLE tasks IS 'Project tasks with assignee relation to profiles table';