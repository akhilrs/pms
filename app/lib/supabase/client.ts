import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';

// Supabase configuration based on official Docker setup
// The URL should point to the Kong gateway
// Default port is 8000 for local development
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'http://localhost:8000';

// The anon key from the official Supabase setup
// This should be the ANON_KEY from your .env file or environment variables
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

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
    // In the official Supabase setup, auth routes follow the /auth/v1 pattern
    flowType: 'pkce', // More secure flow that works better with Next.js
  },
  global: {
    fetch: (url, options = {}) => {
      // Log request for debugging
      if (typeof window !== "undefined") {
        console.log(`Supabase fetch:`, { 
          url, 
          method: options?.method || 'GET',
          headers: options?.headers
        });
      }
      
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
                data: data
              });
            }
          } catch (e) {
            // If it's not JSON, log the text
            try {
              const text = await clone.text();
              if (typeof window !== "undefined") {
                console.log(`Supabase response (not JSON):`, { 
                  status: response.status,
                  url: response.url,
                  text: text.substring(0, 500) // Limit text length
                });
              }
            } catch (textError) {
              console.error('Failed to read response body:', textError);
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
  // This should be the SERVICE_ROLE_KEY from your .env file or environment variables
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU';
  
  return createClient<Database>(supabaseUrl, supabaseServiceKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    }
  });
}; 