-- Create teams module
-- This migration adds tables and functions for team management

-- Teams table
CREATE TABLE public.teams (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    avatar_url text,
    PRIMARY KEY (id)
);

COMMENT ON TABLE public.teams IS 'Teams that can be assigned to projects';

-- Team members table
CREATE TABLE public.team_members (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    team_id uuid NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    user_id uuid NOT NULL,
    role text NOT NULL CHECK (role IN ('owner', 'admin', 'member')),
    joined_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    PRIMARY KEY (id),
    UNIQUE (team_id, user_id)
);

COMMENT ON TABLE public.team_members IS 'Users who belong to teams with their roles';

-- Project teams table (links projects to teams)
CREATE TABLE public.project_teams (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    project_id uuid NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
    team_id uuid NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    created_at timestamp with time zone DEFAULT now(),
    created_by uuid NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (project_id, team_id)
);

COMMENT ON TABLE public.project_teams IS 'Teams assigned to projects';

-- Team invitations table
CREATE TABLE public.team_invitations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    team_id uuid NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
    email text NOT NULL,
    role text NOT NULL CHECK (role IN ('admin', 'member')),
    invited_by uuid NOT NULL,
    token uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    PRIMARY KEY (id),
    UNIQUE (team_id, email)
);

COMMENT ON TABLE public.team_invitations IS 'Invitations for users to join teams';

-- Add indexes for performance
CREATE INDEX idx_team_members_team_id ON public.team_members (team_id);
CREATE INDEX idx_team_members_user_id ON public.team_members (user_id);
CREATE INDEX idx_project_teams_project_id ON public.project_teams (project_id);
CREATE INDEX idx_project_teams_team_id ON public.project_teams (team_id);
CREATE INDEX idx_team_invitations_team_id ON public.team_invitations (team_id);
CREATE INDEX idx_team_invitations_token ON public.team_invitations (token);

-- Update project_members to include team_id (optional, for tracking which team a member came from)
ALTER TABLE public.project_members ADD COLUMN team_id uuid REFERENCES public.teams(id) ON DELETE SET NULL;
COMMENT ON COLUMN public.project_members.team_id IS 'The team through which this user is a member of the project (if applicable)';

-- Create or replace function to get all projects for a user, including team-based access
CREATE OR REPLACE FUNCTION get_user_projects(p_user_id uuid)
RETURNS SETOF public.projects AS $$
BEGIN
  RETURN QUERY
  SELECT DISTINCT p.*
  FROM public.projects p
  WHERE 
    -- Direct ownership
    p.owner_id = p_user_id
    
    -- Direct project membership
    OR EXISTS (
      SELECT 1 FROM public.project_members pm
      WHERE pm.project_id = p.id AND pm.user_id = p_user_id
    )
    
    -- Team-based project access
    OR EXISTS (
      SELECT 1 FROM public.project_teams pt
      JOIN public.team_members tm ON tm.team_id = pt.team_id
      WHERE pt.project_id = p.id AND tm.user_id = p_user_id
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to check if a user is a member of a team (for RLS)
CREATE OR REPLACE FUNCTION is_team_member(team_uuid uuid, user_uuid uuid)
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.team_members
    WHERE team_id = team_uuid AND user_id = user_uuid
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to check if a user is a team admin or owner (for RLS)
CREATE OR REPLACE FUNCTION is_team_admin_or_owner(team_uuid uuid, user_uuid uuid)
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.team_members
    WHERE team_id = team_uuid AND user_id = user_uuid AND role IN ('admin', 'owner')
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Enable RLS on new tables
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.project_teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_invitations ENABLE ROW LEVEL SECURITY;

-- RLS policies for teams
CREATE POLICY "Users can view teams they belong to" ON public.teams
  FOR SELECT USING (
    auth.uid() IN (
      SELECT user_id FROM public.team_members WHERE team_id = id
    )
  );

CREATE POLICY "Team creator can update team" ON public.teams
  FOR UPDATE USING (auth.uid() = created_by);

CREATE POLICY "Team admins can update team" ON public.teams
  FOR UPDATE USING (
    is_team_admin_or_owner(id, auth.uid())
  );

CREATE POLICY "Any authenticated user can create a team" ON public.teams
  FOR INSERT WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Only team owner can delete a team" ON public.teams
  FOR DELETE USING (
    auth.uid() IN (
      SELECT user_id FROM public.team_members 
      WHERE team_id = id AND role = 'owner'
    )
  );

-- RLS policies for team members
CREATE POLICY "Users can view members of their teams" ON public.team_members
  FOR SELECT USING (
    is_team_member(team_id, auth.uid())
  );

CREATE POLICY "Team admins can manage team members" ON public.team_members
  FOR ALL USING (
    is_team_admin_or_owner(team_id, auth.uid())
  );

-- RLS policies for project teams
CREATE POLICY "Users can view project teams they have access to" ON public.project_teams
  FOR SELECT USING (
    -- User is a member of the team
    is_team_member(team_id, auth.uid())
    -- OR user is a member/owner of the project
    OR auth.uid() IN (
      SELECT user_id FROM public.project_members WHERE project_id = project_id
      UNION
      SELECT owner_id FROM public.projects WHERE id = project_id
    )
  );

CREATE POLICY "Project owners can manage project teams" ON public.project_teams
  FOR ALL USING (
    auth.uid() IN (
      SELECT owner_id FROM public.projects WHERE id = project_id
      UNION
      SELECT user_id FROM public.project_members 
      WHERE project_id = project_id AND role = 'admin'
    )
  );

-- RLS policies for team invitations
CREATE POLICY "Team members can view invitations for their team" ON public.team_invitations
  FOR SELECT USING (
    is_team_member(team_id, auth.uid())
  );

CREATE POLICY "Team admins can manage invitations" ON public.team_invitations
  FOR ALL USING (
    is_team_admin_or_owner(team_id, auth.uid())
  );