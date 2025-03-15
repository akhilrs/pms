import { NextRequest, NextResponse } from 'next/server';
import { supabase } from '@/lib/supabase/client';
import { getServiceSupabase } from '@/lib/supabase/client';

export async function GET(request: NextRequest) {
  try {
    // Test basic connectivity
    const { data: healthCheck, error: healthError } = await supabase.from('_health').select('*').limit(1);
    
    // Test auth service
    const { data: authData, error: authError } = await supabase.auth.getSession();
    
    // Test service role connection
    const serviceClient = getServiceSupabase();
    const { data: serviceHealthCheck, error: serviceHealthError } = await serviceClient.from('_health').select('*').limit(1);
    
    return NextResponse.json({
      status: 'success',
      supabaseUrl: process.env.NEXT_PUBLIC_SUPABASE_URL || 'http://localhost:8000',
      anonKeyPrefix: (process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '').substring(0, 10) + '...',
      healthCheck: {
        success: !healthError,
        error: healthError ? healthError.message : null,
        data: healthCheck
      },
      auth: {
        success: !authError,
        error: authError ? authError.message : null,
        session: authData.session ? 'Session exists' : 'No session'
      },
      serviceRole: {
        success: !serviceHealthError,
        error: serviceHealthError ? serviceHealthError.message : null,
        data: serviceHealthCheck
      }
    });
  } catch (error: any) {
    console.error('Error testing Supabase:', error);
    
    return NextResponse.json({
      status: 'error',
      message: 'Error testing Supabase connection',
      error: error.message
    }, { status: 500 });
  }
} 