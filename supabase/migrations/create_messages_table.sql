-- Create messages table
CREATE TABLE IF NOT EXISTS messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  content TEXT NOT NULL,
  project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for messages
-- 1. Project members can view messages
CREATE POLICY "Project members can view messages" 
ON messages FOR SELECT 
USING (
  EXISTS (
    SELECT 1 FROM project_members
    WHERE project_members.project_id = messages.project_id
    AND project_members.user_id = auth.uid()
  )
);

-- 2. Project members can create messages
CREATE POLICY "Project members can create messages" 
ON messages FOR INSERT 
WITH CHECK (
  EXISTS (
    SELECT 1 FROM project_members
    WHERE project_members.project_id = messages.project_id
    AND project_members.user_id = auth.uid()
  ) AND
  auth.uid() = user_id
);

-- 3. Users can update/delete their own messages
CREATE POLICY "Users can update/delete their own messages" 
ON messages FOR UPDATE 
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own messages" 
ON messages FOR DELETE 
USING (auth.uid() = user_id);

-- 4. Project admins and owners can delete any message in their projects
CREATE POLICY "Project admins can delete messages" 
ON messages FOR DELETE 
USING (
  EXISTS (
    SELECT 1 FROM project_members
    WHERE project_members.project_id = messages.project_id
    AND project_members.user_id = auth.uid()
    AND project_members.role IN ('owner', 'admin')
  )
);