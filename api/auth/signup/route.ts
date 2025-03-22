import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { createUser, createProfile, createSession, findUserByEmail } from '@/lib/mock-auth/db';

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
    
    const { email, password, first_name, last_name } = reqBody;
    
    console.log('Signup request received:', { email, hasPassword: !!password, first_name, last_name });
    
    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
        { status: 400 }
      );
    }
    
    try {
      // Check if user already exists
      const existingUser = findUserByEmail(email);
      if (existingUser) {
        return NextResponse.json(
          { error: 'User already exists' },
          { status: 409 }
        );
      }
      
      // 1. Create user
      console.log('Creating user:', email);
      const user = createUser(email, password);
      
      // 2. Create profile
      let profile = null;
      if (user.id && (first_name || last_name)) {
        profile = createProfile(
          user.id, 
          first_name ? String(first_name).trim() : null, 
          last_name ? String(last_name).trim() : null
        );
        console.log('Profile created');
      }
      
      // 3. Create session
      const session = createSession(user.id);
      console.log('Session created');
      
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
      
      console.log('Signup successful, returning user and session');
      
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
    console.error('Unexpected error during signup:', error);
    return NextResponse.json(
      { error: 'An unexpected error occurred', details: (error as Error).message },
      { status: 500 }
    );
  }
} 