import { NextRequest, NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";
import { formatDateForSupabase } from "@/lib/utils";
import { createServerClient } from "@/lib/supabase/auth-helpers";

export async function POST(request: NextRequest) {
  try {
    const formData = await request.json();

    // Get authenticated user ID using server client
    const supabase = createServerClient();
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user?.id) {
      return NextResponse.json(
        { error: "Authentication required" },
        { status: 401 },
      );
    }

    const userId = user.id;

    // Create project using service client (bypasses RLS)
    const adminClient = getServiceSupabase();

    // Prepare project data with properly formatted dates
    const projectData = {
      name: formData.name,
      description: formData.description || null,
      status: formData.status,
      start_date: formData.start_date
        ? formatDateForSupabase(new Date(formData.start_date))
        : null,
      end_date: formData.end_date
        ? formatDateForSupabase(new Date(formData.end_date))
        : null,
      owner_id: userId,
    };

    // Transaction-like pattern: Create project and add member in sequence
    const { data: project, error: projectError } = await adminClient
      .from("projects")
      .insert(projectData)
      .select()
      .single();

    if (projectError) {
      return NextResponse.json(
        { error: `Failed to create project: ${projectError.message}` },
        { status: 500 },
      );
    }

    // Add user as project owner
    const { error: memberError } = await adminClient
      .from("project_members")
      .insert({
        project_id: project.id,
        user_id: userId,
        role: "owner",
        joined_at: new Date().toISOString(),
      });

    if (memberError) {
      console.error("Error adding project owner:", memberError);
      // Continue despite error - project was created successfully
    }

    // Return success response
    return NextResponse.json({
      success: true,
      project,
      redirectTo: `/projects/${project.id}`,
    });
  } catch (error) {
    console.error("Project creation error:", error);
    return NextResponse.json(
      { error: "Failed to create project" },
      { status: 500 },
    );
  }
}

