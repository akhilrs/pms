import { NextResponse } from 'next/server';
import { createServerClient } from '@/lib/supabase/auth-helpers';
import {
  getTeam,
  updateTeamMember,
  removeTeamMember
} from '@/lib/supabase/teams';

// Utility function to get team and check admin permissions
async function checkMemberManagementPermissions(teamId: string, memberId: string) {
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

  // Find the target member
  const targetMember = team.members.find(member => member.id === memberId);
  if (!targetMember) {
    return { 
      authorized: false, 
      error: 'Member not found',
      status: 404
    };
  }

  // Find current user's role in the team
  const currentUserMember = team.members.find(member => member.user_id === userId);
  
  if (!currentUserMember) {
    return { 
      authorized: false, 
      error: 'You are not a member of this team',
      status: 403
    };
  }

  const isOwner = currentUserMember.role === 'owner';
  const isAdmin = currentUserMember.role === 'admin' || isOwner;

  // Check permissions based on roles
  if (!isAdmin) {
    return { 
      authorized: false, 
      error: 'Only team admins can manage members',
      status: 403
    };
  }

  // Admins can't manage owners
  if (currentUserMember.role === 'admin' && targetMember.role === 'owner') {
    return { 
      authorized: false, 
      error: 'Admins cannot manage team owners',
      status: 403
    };
  }

  // Users can't manage themselves (to prevent removing yourself as the last owner)
  if (targetMember.user_id === userId) {
    return { 
      authorized: false, 
      error: 'You cannot manage your own membership',
      status: 403
    };
  }

  return { 
    authorized: true,
    team,
    userId,
    targetMember,
    isOwner,
    isAdmin 
  };
}

// PUT - Update a team member
export async function PUT(
  request: Request,
  { params }: { params: { id: string; memberId: string } }
) {
  try {
    const { id: teamId, memberId } = params;
    const result = await checkMemberManagementPermissions(teamId, memberId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    const body = await request.json();
    
    // Validate role
    const validRoles = ['admin', 'member'];
    if (!body.role || !validRoles.includes(body.role)) {
      return NextResponse.json(
        { error: 'Invalid role. Must be either "admin" or "member"' },
        { status: 400 }
      );
    }

    // If the user is not an owner, they can't promote to admin
    if (!result.isOwner && body.role === 'admin') {
      return NextResponse.json(
        { error: 'Only team owners can promote members to admin' },
        { status: 403 }
      );
    }

    const { data: member, error } = await updateTeamMember(memberId, {
      role: body.role,
    });

    if (error) {
      console.error('Error updating team member:', error);
      return NextResponse.json(
        { error: 'Failed to update team member' },
        { status: 500 }
      );
    }

    return NextResponse.json({ member });
  } catch (error) {
    console.error(`Unexpected error in PUT /api/teams/${params.id}/members/${params.memberId}:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// DELETE - Remove a team member
export async function DELETE(
  request: Request,
  { params }: { params: { id: string; memberId: string } }
) {
  try {
    const { id: teamId, memberId } = params;
    const result = await checkMemberManagementPermissions(teamId, memberId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    // Calculate number of owners in the team
    const ownerCount = result.team.members.filter(
      member => member.role === 'owner'
    ).length;

    // If removing the last owner, prevent it
    if (result.targetMember.role === 'owner' && ownerCount <= 1) {
      return NextResponse.json(
        { error: 'Cannot remove the last owner of the team' },
        { status: 400 }
      );
    }

    const { error } = await removeTeamMember(teamId, result.targetMember.user_id);

    if (error) {
      console.error('Error removing team member:', error);
      return NextResponse.json(
        { error: 'Failed to remove team member' },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error(`Unexpected error in DELETE /api/teams/${params.id}/members/${params.memberId}:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}