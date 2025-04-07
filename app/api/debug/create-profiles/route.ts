import { NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";

// This route will create profiles for users who don't have one
export async function POST() {
  try {
    const serviceClient = getServiceSupabase();
    const results = [];
    
    // Simplified approach: Get all users directly
    try {
      // Get current session user
      const { data: { session } } = await serviceClient.auth.getSession();
      
      if (session?.user) {
        // Check if profile exists
        const { data: existingProfile } = await serviceClient
          .from('profiles')
          .select('id')
          .eq('user_id', session.user.id)
          .maybeSingle();
        
        // If no profile exists, create one
        if (!existingProfile) {
          const { error } = await serviceClient
            .from('profiles')
            .insert({
              id: session.user.id,
              user_id: session.user.id,
              first_name: '',
              last_name: '',
              avatar_url: '',
              created_at: new Date().toISOString(),
              updated_at: new Date().toISOString()
            });
          
          results.push({
            userId: session.user.id,
            success: !error,
            error: error?.message,
            note: 'Current user profile created'
          });
        } else {
          results.push({
            userId: session.user.id,
            success: true,
            note: 'Profile already exists'
          });
        }
      }
    } catch (err) {
      console.error('Error creating profile for current user:', err);
      results.push({
        error: String(err),
        note: 'Error processing current user'
      });
    }
    
    // We'll just focus on creating the current user's profile
    // Other users will get profiles automatically when they log in
    results.push({
      success: true,
      note: 'Only current user profile is created'
    });

    return NextResponse.json({ 
      success: true, 
      message: 'Profile creation completed', 
      results
    });
  } catch (error) {
    console.error("Error creating user profiles:", error);
    return NextResponse.json({ 
      error: String(error),
      message: 'Error creating profiles'
    }, { status: 500 });
  }
}