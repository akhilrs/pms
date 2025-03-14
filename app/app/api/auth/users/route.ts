import { NextRequest, NextResponse } from 'next/server';
import { getAllUsers } from '@/lib/mock-auth/db';

// This endpoint is purely for debugging and should be removed in production
export async function GET(request: NextRequest) {
  try {
    // Get all users without exposing passwords
    const users = getAllUsers();
    
    console.log(`Debug: Found ${users.length} users in mock database`);
    
    return NextResponse.json({
      message: 'Users retrieved for debugging',
      count: users.length,
      users
    });
  } catch (error) {
    console.error('Error getting users:', error);
    
    return NextResponse.json({
      error: 'Failed to get users',
      details: (error as Error).message
    }, { status: 500 });
  }
} 