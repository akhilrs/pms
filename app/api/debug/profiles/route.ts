import { NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase/auth-helpers";
import { getServiceSupabase } from "@/lib/supabase/client";

// This is a debug route to check the profiles in the database
export async function GET() {
  try {
    const supabase = await createServerClient();
    const serviceClient = getServiceSupabase();
    
    // Check auth session
    const { data: { session } } = await supabase.auth.getSession();
    
    // Get profiles using service role (bypasses RLS)
    const { data: profiles, error: profilesError } = await serviceClient
      .from("profiles")
      .select("*")
      .limit(10);
    
    // Get user using service role
    const { data: user, error: userError } = session?.user?.id 
      ? await serviceClient.auth.admin.getUserById(session.user.id)
      : { data: null, error: null };
    
    return NextResponse.json({
      profiles: profiles || [],
      profilesError,
      user: user?.user || null,
      userError,
      session: session ? {
        user: session.user,
        expiresAt: session.expires_at,
      } : null,
    });
  } catch (error) {
    console.error("Error in debug profiles:", error);
    return NextResponse.json({ error: String(error) }, { status: 500 });
  }
}