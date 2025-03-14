import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';

export async function POST(request: NextRequest) {
  try {
    console.log('User signing out');
    
    // Clear auth cookies
    cookies().delete('app-access-token');
    cookies().delete('app-refresh-token');
    
    return NextResponse.json({
      success: true,
      message: 'Successfully signed out'
    });
  } catch (error) {
    console.error('Error during signout:', error);
    
    return NextResponse.json(
      { 
        success: false,
        error: 'An error occurred during signout' 
      },
      { status: 500 }
    );
  }
} 