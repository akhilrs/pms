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

-- Add RLS policies for tasks if they don't exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'tasks_select_policy') THEN
    CREATE POLICY tasks_select_policy ON tasks
      FOR SELECT
      USING (
        -- Allow project owners, team members, and assignees to view tasks
        project_id IN (
          SELECT p.id FROM projects p
          WHERE p.owner_id = auth.uid()
          OR p.id IN (
            SELECT tp.project_id FROM team_projects tp
            JOIN team_members tm ON tp.team_id = tm.team_id
            WHERE tm.user_id = auth.uid()
          )
        )
        OR assignee_id = auth.uid()
      );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'tasks_insert_policy') THEN
    CREATE POLICY tasks_insert_policy ON tasks
      FOR INSERT
      WITH CHECK (
        -- Allow project owners and team members to create tasks
        project_id IN (
          SELECT p.id FROM projects p
          WHERE p.owner_id = auth.uid()
          OR p.id IN (
            SELECT tp.project_id FROM team_projects tp
            JOIN team_members tm ON tp.team_id = tm.team_id
            WHERE tm.user_id = auth.uid()
          )
        )
      );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'tasks_update_policy') THEN
    CREATE POLICY tasks_update_policy ON tasks
      FOR UPDATE
      USING (
        -- Allow project owners, team members, and assignees to update tasks
        project_id IN (
          SELECT p.id FROM projects p
          WHERE p.owner_id = auth.uid()
          OR p.id IN (
            SELECT tp.project_id FROM team_projects tp
            JOIN team_members tm ON tp.team_id = tm.team_id
            WHERE tm.user_id = auth.uid()
          )
        )
        OR assignee_id = auth.uid()
      );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'tasks_delete_policy') THEN
    CREATE POLICY tasks_delete_policy ON tasks
      FOR DELETE
      USING (
        -- Allow only project owners to delete tasks
        project_id IN (
          SELECT p.id FROM projects p
          WHERE p.owner_id = auth.uid()
        )
      );
  END IF;
END
$$;

-- Enable RLS on tasks table
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- Fix the query in milestones.ts by modifying the code to use a simpler query
-- This is just documentation for the developer, not actual SQL
COMMENT ON TABLE tasks IS 'Project tasks with assignee relation to profiles table';