import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';

// For local development with Podman/Docker
// We need to use Kong for routing (on port 8000)
// Kong routes:
//  - /rest -> REST API
//  - /auth -> Auth service
//  - /storage -> Storage service
const supabaseUrl = 'http://localhost:8000'; 

// This key must match exactly what's defined in the Kong config file for the anon consumer
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

// Log the configuration for debugging
if (typeof window !== 'undefined') {
  console.log('Supabase Configuration:', { 
    url: supabaseUrl, 
    key: supabaseAnonKey.substring(0, 20) + '...',
  });
}

// Create a single supabase client for interacting with your database
export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
    url: `${supabaseUrl}/auth/v1`,
    flowType: 'implicit',
    debug: true, // Enable debug mode
    // Add custom error handling
    onAuthStateChange: (event, session) => {
      console.log('Auth state changed:', event, session ? 'Session exists' : 'No session');
    },
  },
  global: {
    headers: {
      'apikey': supabaseAnonKey,
      'Authorization': `Bearer ${supabaseAnonKey}`,
      'Content-Type': 'application/json'
    },
    fetch: (url, options = {}) => {
      // Ensure all URLs are correctly prefixed
      if (url.includes('/rest/v1') && !url.startsWith(supabaseUrl)) {
        url = url.replace(/^.*\/rest\/v1/, `${supabaseUrl}/rest/v1`);
      } else if (url.includes('/auth/v1') && !url.startsWith(supabaseUrl)) {
        url = url.replace(/^.*\/auth\/v1/, `${supabaseUrl}/auth/v1`);
      }
      
      // Log request for debugging
      if (typeof window !== "undefined") {
        console.log(`Supabase fetch:`, { 
          url, 
          method: options?.method,
          headers: options?.headers,
          body: options?.body ? JSON.parse(options.body as string) : undefined
        });
      }
      
      // Ensure the API key is in the headers
      const headers = new Headers(options.headers || {});
      if (!headers.has('apikey')) {
        headers.set('apikey', supabaseAnonKey);
      }
      if (!headers.has('Authorization')) {
        headers.set('Authorization', `Bearer ${supabaseAnonKey}`);
      }
      if (!headers.has('Content-Type') && options.method !== 'GET') {
        headers.set('Content-Type', 'application/json');
      }
      
      // Update options with the new headers
      options.headers = headers;
      
      // Make the fetch request and log the response
      return fetch(url, options)
        .then(async (response) => {
          // Clone the response to read it twice
          const clone = response.clone();
          
          try {
            // Try to parse the response as JSON
            const data = await clone.json();
            if (typeof window !== "undefined") {
              console.log(`Supabase response:`, { 
                status: response.status,
                url: response.url,
                data
              });
            }
          } catch (e) {
            // If it's not JSON, log the text
            const text = await clone.text();
            if (typeof window !== "undefined") {
              console.log(`Supabase response (not JSON):`, { 
                status: response.status,
                url: response.url,
                text: text.substring(0, 500) // Limit text length
              });
            }
          }
          
          return response;
        })
        .catch(error => {
          if (typeof window !== "undefined") {
            console.error(`Supabase fetch error:`, { url, error });
          }
          throw error;
        });
    },
  },
});

// For server-side operations that need admin privileges
export const getServiceSupabase = () => {
  // This key must match exactly what's defined in the Kong config file for the service_role consumer
  const supabaseServiceKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU';
  
  return createClient<Database>(supabaseUrl, supabaseServiceKey, {
    auth: {
      url: `${supabaseUrl}/auth/v1`,
      autoRefreshToken: true,
      persistSession: false,
      flowType: 'implicit',
      debug: true, // Enable debug mode
    },
    global: {
      headers: {
        'apikey': supabaseServiceKey,
        'Authorization': `Bearer ${supabaseServiceKey}`,
        'Content-Type': 'application/json'
      }
    }
  });
}; 