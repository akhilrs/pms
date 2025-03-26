import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';

export async function POST(request: NextRequest) {
  try {
    console.log('Signout request received');
    
    // Clear cookies - updated to await cookies() for Next.js 15 compatibility
    const cookieStore = await cookies();
    cookieStore.delete('app-access-token');
    cookieStore.delete('app-refresh-token');
    
    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error during signout:', error);
    return NextResponse.json(
      { error: 'Failed to sign out' },
      { status: 500 }
    );
  }
} 