import { NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";

// This route will create profiles for users who don't have one
export async function POST() {
  try {
    const serviceClient = getServiceSupabase();
    
    // Find users without profiles
    const { data: usersWithoutProfiles, error: queryError } = await serviceClient
      .from('auth.users AS au')
      .select('au.id')
      .not('au.id', 'in', serviceClient.from('profiles').select('user_id'));
    
    if (queryError) {
      console.error('Error finding users without profiles:', queryError);
      return NextResponse.json({ error: queryError.message }, { status: 500 });
    }

    const userIds = usersWithoutProfiles || [];
    const results = [];

    // Create profiles for each user
    for (const user of userIds) {
      const { data, error } = await serviceClient
        .from('profiles')
        .insert({
          id: user.id,
          user_id: user.id,
          first_name: '',
          last_name: '',
          avatar_url: '',
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        });
      
      results.push({
        userId: user.id,
        success: !error,
        error: error?.message
      });
    }

    // Create current user profile if not provided
    const { data: { session } } = await serviceClient.auth.getSession();
    if (session?.user) {
      const { data: existingProfile } = await serviceClient
        .from('profiles')
        .select('*')
        .eq('user_id', session.user.id)
        .single();
      
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
      }
    }

    return NextResponse.json({ 
      success: true, 
      message: `Created ${results.length} profiles`, 
      results
    });
  } catch (error) {
    console.error("Error creating user profiles:", error);
    return NextResponse.json({ error: String(error) }, { status: 500 });
  }
}