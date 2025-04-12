-- Create milestones table
CREATE TABLE milestones (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  due_date TIMESTAMP WITH TIME ZONE,
  status TEXT NOT NULL DEFAULT 'Not Started',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add milestone_id to tasks table
ALTER TABLE tasks
ADD COLUMN milestone_id UUID REFERENCES milestones(id) ON DELETE SET NULL;

-- Create index for faster queries
CREATE INDEX milestones_project_id_idx ON milestones(project_id);
CREATE INDEX tasks_milestone_id_idx ON tasks(milestone_id);
