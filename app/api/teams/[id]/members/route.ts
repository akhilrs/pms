import { NextResponse } from 'next/server';
import { createServerClient } from '@/lib/supabase/auth-helpers';
import {
  getTeam,
  addTeamMember,
  createTeamInvitation
} from '@/lib/supabase/teams';

// Utility function to get team and check admin permissions
async function checkTeamAdminPermissions(teamId: string) {
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

  // Find user's role in the team
  const userMember = team.members.find(member => member.user_id === userId);
  
  if (!userMember) {
    return { 
      authorized: false, 
      error: 'You are not a member of this team',
      status: 403
    };
  }

  const isOwner = userMember.role === 'owner';
  const isAdmin = userMember.role === 'admin' || isOwner;

  if (!isAdmin) {
    return { 
      authorized: false, 
      error: 'Only team admins can manage members',
      status: 403
    };
  }

  return { 
    authorized: true,
    team,
    userId,
    isOwner,
    isAdmin 
  };
}

// POST - Add a new member to the team
export async function POST(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const teamId = params.id;
    const result = await checkTeamAdminPermissions(teamId);

    if (!result.authorized) {
      return NextResponse.json(
        { error: result.error },
        { status: result.status }
      );
    }

    const body = await request.json();
    
    // Check for either userId for direct addition or email for invitation
    if (!body.userId && !body.email) {
      return NextResponse.json(
        { error: 'Either user ID or email is required' },
        { status: 400 }
      );
    }

    // Validate role
    const validRoles = ['admin', 'member'];
    if (body.role && !validRoles.includes(body.role)) {
      return NextResponse.json(
        { error: 'Invalid role. Must be either "admin" or "member"' },
        { status: 400 }
      );
    }

    const role = body.role || 'member';

    // If userId is provided, add the member directly
    if (body.userId) {
      // Check if user is already a member
      const existingMember = result.team.members.find(
        member => member.user_id === body.userId
      );

      if (existingMember) {
        return NextResponse.json(
          { error: 'User is already a member of this team' },
          { status: 400 }
        );
      }

      const { data: member, error } = await addTeamMember({
        team_id: teamId,
        user_id: body.userId,
        role,
      });

      if (error) {
        console.error('Error adding team member:', error);
        return NextResponse.json(
          { error: 'Failed to add team member' },
          { status: 500 }
        );
      }

      return NextResponse.json({ member }, { status: 201 });
    }
    
    // If email is provided, create an invitation
    if (body.email) {
      // Generate expiration date (7 days from now)
      const expiresAt = new Date();
      expiresAt.setDate(expiresAt.getDate() + 7);

      const { data: invitation, error } = await createTeamInvitation({
        team_id: teamId,
        email: body.email,
        role,
        invited_by: result.userId,
        expires_at: expiresAt.toISOString(),
      });

      if (error) {
        console.error('Error creating team invitation:', error);
        return NextResponse.json(
          { error: 'Failed to create team invitation' },
          { status: 500 }
        );
      }

      // Here you would typically send an email with the invitation
      // For now we'll just return the invitation data

      return NextResponse.json(
        { invitation, message: 'Invitation created successfully' },
        { status: 201 }
      );
    }
  } catch (error) {
    console.error(`Unexpected error in POST /api/teams/${params.id}/members:`, error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}