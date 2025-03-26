import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { validateSession, getUserById, findProfileById } from '@/lib/mock-auth/db';

export async function GET(request: NextRequest) {
  try {
    console.log('Session check requested');
    
    // Get cookies - updated to await cookies() for Next.js 15 compatibility
    const cookieStore = await cookies();
    const accessToken = cookieStore.get('app-access-token')?.value;
    
    if (!accessToken) {
      return NextResponse.json({
        user: null,
        session: null,
        profile: null
      });
    }
    
    // Validate session
    const session = validateSession(accessToken);
    
    if (!session) {
      // Clear cookies if session is invalid - properly awaiting cookies
      const cookieStore = await cookies();
      cookieStore.delete('app-access-token');
      cookieStore.delete('app-refresh-token');
      
      return NextResponse.json({
        user: null,
        session: null,
        profile: null
      });
    }
    
    // Get user data
    const user = getUserById(session.user_id);
    
    if (!user) {
      // Clear cookies if user doesn't exist - properly awaiting cookies
      const cookieStore = await cookies();
      cookieStore.delete('app-access-token');
      cookieStore.delete('app-refresh-token');
      
      return NextResponse.json({
        user: null,
        session: null,
        profile: null
      });
    }
    
    // Get profile data
    const profile = findProfileById(user.id);
    
    // Format user data for response (don't include password)
    const userData = {
      id: user.id,
      email: user.email,
      created_at: user.created_at
    };
    
    // Format session data for response
    const sessionData = {
      access_token: session.access_token,
      refresh_token: null, // Don't include refresh token in response
      expires_at: session.expires_at,
      user: userData
    };
    
    console.log('Session check successful, user is logged in');
    
    return NextResponse.json({
      user: userData,
      session: sessionData,
      profile
    });
  } catch (error) {
    console.error('Error checking session:', error);
    return NextResponse.json(
      { error: 'Failed to check session' },
      { status: 500 }
    );
  }
} 