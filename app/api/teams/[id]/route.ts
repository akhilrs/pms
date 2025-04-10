import { NextResponse } from 'next/server';
import { createServerClient } from '@/lib/supabase/auth-helpers';
import { 
  getTeam, 
  updateTeam, 
  deleteTeam,
  addTeamMember,
  updateTeamMember,
  removeTeamMember,
  assignTeamToProject,
  removeTeamFromProject,
  createTeamInvitation,
  deleteTeamInvitation
} from '@/lib/supabase/teams';

// Utility function to get team and check user permissions
async function getTeamAndCheckPermissions(teamId: string) {
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
  const { data: team, error } = await getTeam(teamId);

  if (error) {
    return { 
      authorized: false, 
      error: 'Failed to fetch team',
      status: 500,
      team: null,
      userId
    };
  }

  if (!team) {
    return { 
      authorized: false, 
      error: 'Team not found',
      status: 404,
      team: null,
      userId
    };
  }

  // Check if user is a member of the team
  const isTeamMember = team.members.some(member => member.user_id === userId);
  if (!isTeamMember) {
    return { 
      authorized: false, 
      error: 'You do not have permission to access this team',
      status: 403,
      team,
      userId
    };
  }

  // Find user's role in the team
  const userMember = team.members.find(member => member.user_id === userId);
  const isOwner = userMember?.role === 'owner';
  const isAdmin = userMember?.role === 'admin' || isOwner;

  return { 
    authorized: true,
    team,
    userId,
    isOwner,
    isAdmin 
  };
}

// GET - Get a team by ID
export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const teamId = params.id;
    const result = await getTeamAndCheckPermissions(teamId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    return NextResponse.json({ team: result.team });
  } catch (error) {
    console.error(`Unexpected error in GET /api/teams/${params.id}:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// PUT - Update a team
export async function PUT(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const teamId = params.id;
    const result = await getTeamAndCheckPermissions(teamId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    // Only owners and admins can update teams
    if (!result.isAdmin) {
      return NextResponse.json(
        { error: 'You do not have permission to update this team' },
        { status: 403 }
      );
    }

    const body = await request.json();
    
    // Validate required fields
    if (!body.name) {
      return NextResponse.json(
        { error: 'Team name is required' },
        { status: 400 }
      );
    }

    const updates = {
      name: body.name,
      description: body.description,
      avatar_url: body.avatar_url,
      updated_at: new Date().toISOString(),
    };

    const { data: updatedTeam, error } = await updateTeam(teamId, updates);

    if (error) {
      console.error('Error updating team:', error);
      return NextResponse.json(
        { error: 'Failed to update team' },
        { status: 500 }
      );
    }

    return NextResponse.json({ team: updatedTeam });
  } catch (error) {
    console.error(`Unexpected error in PUT /api/teams/${params.id}:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// DELETE - Delete a team
export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const teamId = params.id;
    const result = await getTeamAndCheckPermissions(teamId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    // Only owners can delete teams
    if (!result.isOwner) {
      return NextResponse.json(
        { error: 'Only team owners can delete a team' },
        { status: 403 }
      );
    }

    const { error } = await deleteTeam(teamId);

    if (error) {
      console.error('Error deleting team:', error);
      return NextResponse.json(
        { error: 'Failed to delete team' },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error(`Unexpected error in DELETE /api/teams/${params.id}:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}