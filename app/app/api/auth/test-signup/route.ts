import { NextRequest, NextResponse } from 'next/server';
import { getServiceSupabase } from '@/lib/supabase/client';
import { createClient } from '@supabase/supabase-js';

// This endpoint is purely for testing/debugging and should be removed in production
export async function GET(request: NextRequest) {
  try {
    // Extract URL parameters if provided
    const searchParams = request.nextUrl.searchParams;
    const email = searchParams.get('email') || `test${Date.now()}@example.com`;
    const password = searchParams.get('password') || 'test123456';
    
    console.log('Testing auth signup with:', { email });
    
    // Create a fresh Supabase client to avoid any request body issues
    const supabaseUrl = 'http://localhost:8000';
    const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
    
    const testClient = createClient(supabaseUrl, supabaseAnonKey, {
      auth: {
        persistSession: false, // Don't persist the session to avoid issues
        autoRefreshToken: false
      }
    });
    
    // Test direct HTTP request to verify the auth service
    try {
      const response = await fetch(`${supabaseUrl}/auth/v1/signup`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'apikey': supabaseAnonKey
        },
        body: JSON.stringify({
          email,
          password
        })
      });
      
      const responseStatus = response.status;
      let responseBody;
      
      try {
        responseBody = await response.json();
      } catch (e) {
        responseBody = { error: 'Cannot parse response as JSON' };
      }
      
      // Now try with direct supabase client
      const clientResponse = await testClient.auth.signUp({
        email: `test2_${Date.now()}@example.com`, // Use a different email to avoid conflicts
        password
      });
      
      return NextResponse.json({
        message: 'Auth tests completed',
        directHttpRequest: {
          url: `${supabaseUrl}/auth/v1/signup`,
          status: responseStatus,
          body: responseBody
        },
        supabaseClient: {
          success: !clientResponse.error,
          error: clientResponse.error?.message || null,
          user: clientResponse.data?.user ? {
            id: clientResponse.data.user.id,
            email: clientResponse.data.user.email,
          } : null,
          hasSession: !!clientResponse.data?.session
        }
      });
    } catch (error) {
      console.error('Error in auth test:', error);
      return NextResponse.json({
        status: 'error',
        message: 'Test failed',
        error: (error as Error).message
      });
    }
  } catch (error) {
    console.error('Unexpected error in test endpoint:', error);
    return NextResponse.json({
      status: 'error',
      message: 'An unexpected error occurred',
      error: (error as Error).message
    });
  }
} 