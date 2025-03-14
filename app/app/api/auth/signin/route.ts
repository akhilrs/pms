import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { authenticateUser, createSession, findProfileById, findUserByEmail } from '@/lib/mock-auth/db';

export async function POST(request: NextRequest) {
  try {
    // Parse the request body carefully to handle potential JSON issues
    let reqBody;
    try {
      reqBody = await request.json();
      console.log('Request body parsed successfully:', reqBody);
    } catch (parseError) {
      console.error('Error parsing request body:', parseError);
      return NextResponse.json(
        { error: 'Invalid request format', details: (parseError as Error).message },
        { status: 400 }
      );
    }
    
    const { email, password } = reqBody;
    
    console.log('Signin request received:', { email, hasPassword: !!password });
    
    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
        { status: 400 }
      );
    }
    
    try {
      // Debug check: see if user exists at all
      const userExists = findUserByEmail(email);
      if (!userExists) {
        console.log(`User with email ${email} does not exist in the database`);
        return NextResponse.json(
          { error: 'Invalid email or password' },
          { status: 401 }
        );
      }
      
      console.log(`User found: ${userExists.email}, checking password...`);
      
      // 1. Authenticate user
      console.log('Authenticating user:', email);
      const user = authenticateUser(email, password);
      
      if (!user) {
        console.log('Authentication failed for user:', email);
        return NextResponse.json(
          { error: 'Invalid email or password' },
          { status: 401 }
        );
      }
      
      // 2. Create session
      const session = createSession(user.id);
      console.log('Session created');
      
      // 3. Get profile if available
      const profile = findProfileById(user.id);
      
      // 4. Set cookies for the session
      cookies().set('app-access-token', session.access_token, {
        path: '/',
        maxAge: 60 * 60 * 24 * 7, // 1 week
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax'
      });
      
      cookies().set('app-refresh-token', session.refresh_token, {
        path: '/',
        maxAge: 60 * 60 * 24 * 30, // 30 days
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax'
      });
      
      // Format user data for response (don't include password)
      const userData = {
        id: user.id,
        email: user.email,
        created_at: user.created_at
      };
      
      // Format session data for response
      const sessionData = {
        access_token: session.access_token,
        refresh_token: session.refresh_token,
        expires_at: session.expires_at,
        user: userData
      };
      
      console.log('Signin successful, returning user and session');
      
      return NextResponse.json({
        user: userData,
        session: sessionData,
        profile
      });
    } catch (apiError) {
      console.error('Exception during API call:', apiError);
      return NextResponse.json(
        { error: 'API call failed', details: (apiError as Error).message },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Unexpected error during signin:', error);
    return NextResponse.json(
      { error: 'An unexpected error occurred', details: (error as Error).message },
      { status: 500 }
    );
  }
} 