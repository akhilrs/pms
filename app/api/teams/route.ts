import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/client';
import { createServerClient } from '@/lib/supabase/auth-helpers';
import { getUserTeams, createTeam } from '@/lib/supabase/teams';

// GET - Get all teams for the authenticated user
export async function GET() {
  try {
    // Get current user from auth
    const supabase = await createServerClient();
    const { data: { session } } = await supabase.auth.getSession();

    if (!session?.user) {
      return NextResponse.json(
        { error: 'Authentication required' },
        { status: 401 }
      );
    }

    const userId = session.user.id;
    const { data: teams, error } = await getUserTeams(userId);

    if (error) {
      console.error('Error fetching teams:', error);
      return NextResponse.json(
        { error: 'Failed to fetch teams' },
        { status: 500 }
      );
    }

    return NextResponse.json({ teams });
  } catch (error) {
    console.error('Unexpected error in GET /api/teams:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// POST - Create a new team
export async function POST(request: Request) {
  try {
    const body = await request.json();
    
    // Validate required fields
    if (!body.name) {
      return NextResponse.json(
        { error: 'Team name is required' },
        { status: 400 }
      );
    }

    // Get current user
    const supabase = await createServerClient();
    const { data: { session } } = await supabase.auth.getSession();

    if (!session?.user) {
      return NextResponse.json(
        { error: 'Authentication required' },
        { status: 401 }
      );
    }

    const teamData = {
      name: body.name,
      description: body.description || null,
      created_by: session.user.id,
      avatar_url: body.avatar_url || null,
    };

    const { data: team, error } = await createTeam(teamData);

    if (error) {
      console.error('Error creating team:', error);
      return NextResponse.json(
        { error: 'Failed to create team' },
        { status: 500 }
      );
    }

    return NextResponse.json({ team }, { status: 201 });
  } catch (error) {
    console.error('Unexpected error in POST /api/teams:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}