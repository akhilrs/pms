import { NextRequest, NextResponse } from 'next/server';
import { getServiceSupabase } from '@/lib/supabase/client';

export async function GET(request: NextRequest) {
  try {
    console.log('Auth debug endpoint called');
    
    // Use the service role client to test API operations
    const serviceClient = getServiceSupabase();
    
    // Test the Supabase connection and auth service
    try {
      const { data, error } = await serviceClient.auth.getSession();
      
      if (error) {
        console.error('Error getting session:', error);
        return NextResponse.json(
          { status: 'error', message: 'Failed to get session', details: error.message },
          { status: 500 }
        );
      }
      
      // Check if we can access the profiles table
      const { data: profilesData, error: profilesError } = await serviceClient
        .from('profiles')
        .select('count(*)')
        .limit(1);
        
      const result = {
        status: 'success',
        auth_service: 'working',
        session: data.session ? 'exists' : 'none',
        profiles_table: profilesError ? 'error' : 'accessible',
        profiles_count: profilesData?.[0]?.count || 0,
        error: profilesError ? profilesError.message : null
      };
      
      console.log('Auth debug result:', result);
      
      return NextResponse.json(result);
    } catch (apiError) {
      console.error('Exception during API call:', apiError);
      return NextResponse.json(
        { status: 'error', message: 'API call failed', details: (apiError as Error).message },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Unexpected error in debug endpoint:', error);
    return NextResponse.json(
      { status: 'error', message: 'An unexpected error occurred', details: (error as Error).message },
      { status: 500 }
    );
  }
} 