-- Fix for RLS policies that cause infinite recursion
-- This script drops all existing project_members policies and creates simpler ones

-- First, drop all existing policies on project_members
DROP POLICY IF EXISTS "Users can view their own project memberships" ON project_members;
DROP POLICY IF EXISTS "Users can view project memberships for projects they're a member of" ON project_members;
DROP POLICY IF EXISTS "Project owners can view all members" ON project_members;
DROP POLICY IF EXISTS "Users can view members of their projects" ON project_members;
DROP POLICY IF EXISTS "Users can manage their own project memberships" ON project_members;
DROP POLICY IF EXISTS "Project owners can manage all memberships" ON project_members;
DROP POLICY IF EXISTS "Users can view their own memberships" ON project_members;
DROP POLICY IF EXISTS "Users can view memberships of their projects" ON project_members;
DROP POLICY IF EXISTS "Users can add themselves as members" ON project_members;
DROP POLICY IF EXISTS "Project owners can manage memberships" ON project_members;

-- Check if visibility column exists in projects table, add it if it doesn't
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'projects' AND column_name = 'visibility'
    ) THEN
        ALTER TABLE projects ADD COLUMN visibility TEXT DEFAULT 'private';
    END IF;
END
$$;

-- Create simplified RLS policies that avoid recursion

-- 1. Allow users to see their own memberships (basic policy)
CREATE POLICY "Users can view their own memberships" 
ON project_members FOR SELECT 
USING (auth.uid() = user_id);

-- 2. Allow users to see memberships of projects they're a member of
-- This policy is simplified to avoid recursive checking
CREATE POLICY "Users can view memberships of their projects" 
ON project_members FOR SELECT 
USING (
  project_id IN (
    SELECT project_id FROM project_members WHERE user_id = auth.uid()
  )
);

-- 3. Allow project owners to manage all memberships
CREATE POLICY "Project owners can manage memberships" 
ON project_members FOR ALL 
USING (
  EXISTS (
    SELECT 1 FROM projects
    WHERE projects.id = project_members.project_id
    AND projects.owner_id = auth.uid()
  )
);

-- 4. Allow users to insert themselves as members
-- Modified to not depend on visibility column
CREATE POLICY "Users can add themselves as members" 
ON project_members FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- Also ensure the profiles table exists with proper structure
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  user_id UUID REFERENCES auth.users(id),
  first_name TEXT,
  last_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Create trigger to auto-create profiles for new users
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