import { NextRequest, NextResponse } from 'next/server';

// This endpoint is purely for testing/debugging and should be removed in production
export async function GET(request: NextRequest) {
  try {
    const supabaseUrl = 'http://localhost:8000';
    const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
    
    // Try different URL patterns
    const urlPatterns = [
      `${supabaseUrl}/auth`,
      `${supabaseUrl}/auth/signup`,
      `${supabaseUrl}/auth/v1`,
      `${supabaseUrl}/auth/v1/signup`,
      `${supabaseUrl}/v1/signup`,
      `${supabaseUrl}/v1/auth/signup`,
      `${supabaseUrl}/signup`,
      `${supabaseUrl}/rest/v1`,
      `${supabaseUrl}/storage`
    ];
    
    // The result object to store response statuses
    const results = {};
    
    // Test each URL with a simple GET request
    for (const url of urlPatterns) {
      try {
        console.log(`Testing URL: ${url}`);
        const response = await fetch(url, {
          method: 'GET',
          headers: {
            'apikey': supabaseAnonKey
          }
        });
        
        results[url] = {
          status: response.status,
          statusText: response.statusText
        };
        
        // If response is successful, try to get response body
        if (response.status < 400) {
          try {
            const responseBody = await response.text();
            if (responseBody) {
              results[url].body = responseBody.substring(0, 100) + (responseBody.length > 100 ? '...' : '');
            }
          } catch (err) {
            results[url].bodyError = `Error reading body: ${(err as Error).message}`;
          }
        }
      } catch (err) {
        results[url] = {
          error: `Request failed: ${(err as Error).message}`
        };
      }
    }
    
    // Now try a specific POST request to test auth endpoints
    try {
      const testEmail = `test${Date.now()}@example.com`;
      const testPassword = 'test123456';
      
      console.log(`Testing signup with: ${testEmail}`);
      const authTestUrl = `${supabaseUrl}/auth/v1/signup`;
      
      const signupResponse = await fetch(authTestUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'apikey': supabaseAnonKey
        },
        body: JSON.stringify({
          email: testEmail,
          password: testPassword
        })
      });
      
      results['POST signup test'] = {
        url: authTestUrl,
        status: signupResponse.status,
        statusText: signupResponse.statusText
      };
      
      try {
        const responseBody = await signupResponse.text();
        if (responseBody) {
          results['POST signup test'].body = responseBody.substring(0, 100) + 
            (responseBody.length > 100 ? '...' : '');
        }
      } catch (err) {
        results['POST signup test'].bodyError = `Error reading body: ${(err as Error).message}`;
      }
    } catch (err) {
      results['POST signup test'] = {
        error: `Request failed: ${(err as Error).message}`
      };
    }
    
    return NextResponse.json({
      message: 'URL testing completed',
      results
    });
  } catch (error) {
    console.error('Unexpected error in test endpoint:', error);
    return NextResponse.json({
      status: 'error',
      message: 'An unexpected error occurred',
      error: (error as Error).message
    });
  }
} 