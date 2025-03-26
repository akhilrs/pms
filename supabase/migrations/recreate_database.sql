-- Clean Slate Database Recreation
-- This script drops all existing tables and recreates them with proper structure and policies

-- STEP 1: Drop existing tables (in correct order to respect foreign key constraints)
DROP TABLE IF EXISTS project_members CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;

-- STEP 2: Create profiles table
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  user_id UUID REFERENCES auth.users(id),
  first_name TEXT,
  last_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for profiles
CREATE POLICY "Users can view any profile" 
ON profiles FOR SELECT 
TO authenticated 
USING (true);

CREATE POLICY "Users can update their own profile" 
ON profiles FOR UPDATE 
USING (auth.uid() = id);

-- Create trigger to automatically create profile entry for new users
CREATE OR REPLACE FUNCTION create_profile_for_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, user_id, first_name, last_name, avatar_url, created_at)
  VALUES (NEW.id, NEW.id, '', '', '', NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS create_profile_on_signup ON auth.users;

-- Create trigger to auto-create profiles for new users
CREATE TRIGGER create_profile_on_signup
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION create_profile_for_new_user();

-- STEP 3: Create a helper function to avoid RLS recursion
-- This function will check if a user is a member of a project
CREATE OR REPLACE FUNCTION is_project_member(project_id UUID, user_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM project_members 
    WHERE project_members.project_id = $1 
    AND project_members.user_id = $2
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- STEP 4: Create projects table
CREATE TABLE projects (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  owner_id UUID NOT NULL REFERENCES auth.users(id),
  status TEXT DEFAULT 'Planning',
  start_date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  end_date TIMESTAMP WITH TIME ZONE,
  visibility TEXT DEFAULT 'private',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for projects with NO circular references
-- 1. Project owners can do anything with their projects
CREATE POLICY "Project owners have full access" 
ON projects FOR ALL 
USING (owner_id = auth.uid());

-- 2. Users can view public projects
CREATE POLICY "Anyone can view public projects" 
ON projects FOR SELECT 
USING (visibility = 'public');

-- STEP 5: Create project_members table
CREATE TABLE project_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id),
  role TEXT NOT NULL DEFAULT 'member',
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  UNIQUE(project_id, user_id)
);

-- Enable Row Level Security
ALTER TABLE project_members ENABLE ROW LEVEL SECURITY;

-- Create simplified RLS policies for project_members
-- 1. Users can see their own memberships
CREATE POLICY "Users can view their own memberships" 
ON project_members FOR SELECT 
USING (user_id = auth.uid());

-- 2. Project owners can manage all memberships
CREATE POLICY "Project owners can manage memberships" 
ON project_members FOR ALL 
USING (
  EXISTS (
    SELECT 1 FROM projects
    WHERE projects.id = project_id
    AND projects.owner_id = auth.uid()
  )
);

-- 3. Users can add themselves to projects (with admin approval or public projects)
CREATE POLICY "Users can add themselves as members" 
ON project_members FOR INSERT 
WITH CHECK (
  auth.uid() = user_id AND
  (
    -- Either the project is public
    EXISTS (
      SELECT 1 FROM projects
      WHERE projects.id = project_id
      AND projects.visibility = 'public'
    )
    -- OR the user is already being added by the project owner (handled by policy #2)
  )
);

-- STEP 6: Now that project_members exists, add the additional policy to projects
-- Users can view projects they're a member of (using the helper function)
CREATE POLICY "Members can view projects" 
ON projects FOR SELECT 
USING (is_project_member(id, auth.uid()));

-- STEP 7: Create sample data (uncomment if needed)
-- INSERT INTO projects (name, description, owner_id, status, visibility)
-- VALUES 
--   ('Demo Project', 'A test project for demonstration', 'your-user-id-here', 'In Progress', 'public'),
--   ('Private Project', 'A private project', 'your-user-id-here', 'Planning', 'private');

-- INSERT INTO project_members (project_id, user_id, role)
-- VALUES
--   ((SELECT id FROM projects WHERE name = 'Demo Project'), 'your-user-id-here', 'owner'); 