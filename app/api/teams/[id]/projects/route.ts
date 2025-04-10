import { NextResponse } from 'next/server';
import { createServerClient } from '@/lib/supabase/auth-helpers';
import {
  getTeam,
  assignTeamToProject,
  removeTeamFromProject
} from '@/lib/supabase/teams';
import { getProject } from '@/lib/supabase/projects';

// Utility function to check admin permissions
async function checkTeamAndProjectPermissions(teamId: string, projectId?: string) {
  const supabase = await createServerClient();
  const { data: { session } } = await supabase.auth.getSession();

  if (!session?.user) {
    return { 
      authorized: false, 
      error: 'Authentication required',
      status: 401
    };
  }

  const userId = session.user.id;
  const { data: team, error: teamError } = await getTeam(teamId);

  if (teamError) {
    return { 
      authorized: false, 
      error: 'Failed to fetch team',
      status: 500
    };
  }

  if (!team) {
    return { 
      authorized: false, 
      error: 'Team not found',
      status: 404
    };
  }

  // Find user's role in the team
  const userMember = team.members.find(member => member.user_id === userId);
  
  if (!userMember) {
    return { 
      authorized: false, 
      error: 'You are not a member of this team',
      status: 403
    };
  }

  const isTeamOwner = userMember.role === 'owner';
  const isTeamAdmin = userMember.role === 'admin' || isTeamOwner;

  // If we're checking for a specific project (for assignment)
  if (projectId) {
    const { data: project, error: projectError } = await getProject(projectId);

    if (projectError) {
      return { 
        authorized: false, 
        error: 'Failed to fetch project',
        status: 500
      };
    }

    if (!project) {
      return { 
        authorized: false, 
        error: 'Project not found',
        status: 404
      };
    }

    // Check if user has permission to manage this project
    const isProjectOwner = project.owner?.id === userId;
    
    // For assigning a team to a project, need to be both team admin and project owner
    if (!isProjectOwner) {
      return { 
        authorized: false, 
        error: 'You must be the project owner to assign teams',
        status: 403
      };
    }

    return {
      authorized: true,
      team,
      project,
      userId,
      isTeamAdmin,
      isTeamOwner,
      isProjectOwner
    };
  }

  // If no project ID provided, just check team permissions
  return { 
    authorized: true,
    team,
    userId,
    isTeamAdmin,
    isTeamOwner 
  };
}

// POST - Assign team to a project
export async function POST(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const teamId = params.id;
    const body = await request.json();
    
    // Validate required fields
    if (!body.projectId) {
      return NextResponse.json(
        { error: 'Project ID is required' },
        { status: 400 }
      );
    }

    const result = await checkTeamAndProjectPermissions(teamId, body.projectId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    // Check if the team is already assigned to this project
    const isAlreadyAssigned = result.team.projects.some(
      project => project.id === body.projectId
    );

    if (isAlreadyAssigned) {
      return NextResponse.json(
        { error: 'Team is already assigned to this project' },
        { status: 400 }
      );
    }

    const { data, error } = await assignTeamToProject({
      team_id: teamId,
      project_id: body.projectId,
      created_by: result.userId,
    });

    if (error) {
      console.error('Error assigning team to project:', error);
      return NextResponse.json(
        { error: 'Failed to assign team to project' },
        { status: 500 }
      );
    }

    return NextResponse.json({ assignment: data }, { status: 201 });
  } catch (error) {
    console.error(`Unexpected error in POST /api/teams/${params.id}/projects:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// DELETE - Remove team from a project
export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const teamId = params.id;
    // Get projectId from query params
    const { searchParams } = new URL(request.url);
    const projectId = searchParams.get('projectId');
    
    if (!projectId) {
      return NextResponse.json(
        { error: 'Project ID is required as a query parameter' },
        { status: 400 }
      );
    }

    const result = await checkTeamAndProjectPermissions(teamId, projectId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    // Check if the team is assigned to this project
    const isAssigned = result.team.projects.some(
      project => project.id === projectId
    );

    if (!isAssigned) {
      return NextResponse.json(
        { error: 'Team is not assigned to this project' },
        { status: 400 }
      );
    }

    const { error } = await removeTeamFromProject(projectId, teamId);

    if (error) {
      console.error('Error removing team from project:', error);
      return NextResponse.json(
        { error: 'Failed to remove team from project' },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error(`Unexpected error in DELETE /api/teams/${params.id}/projects:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}