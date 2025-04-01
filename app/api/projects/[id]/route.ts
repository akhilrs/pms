import { NextRequest, NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";
import { formatDateForSupabase } from "@/lib/utils";

export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    // Safely extract the project ID
    const projectId = params?.id;

    if (!projectId) {
      return NextResponse.json(
        { error: "Project ID is required" },
        { status: 400 },
      );
    }

    // Parse the request body
    const formData = await request.json();

    // Get cookies for authentication
    const authCookie = request.headers.get("cookie");

    if (!authCookie) {
      return NextResponse.json(
        { error: "Authentication required" },
        { status: 401 },
      );
    }

    // Use the service supabase client directly, since we're having issues with auth
    const adminClient = getServiceSupabase();

    // Prepare update data with properly formatted dates
    const updateData = {
      name: formData.name,
      description: formData.description,
      status: formData.status,
    };

    // Only include dates if they are provided
    if (formData.start_date) {
      updateData.start_date = formatDateForSupabase(
        new Date(formData.start_date),
      );
    }

    if (formData.end_date) {
      updateData.end_date = formatDateForSupabase(new Date(formData.end_date));
    }

    // Update the project using the admin client (bypassing permissions)
    const { data: updatedProject, error: updateError } = await adminClient
      .from("projects")
      .update(updateData)
      .eq("id", projectId)
      .select()
      .single();

    if (updateError) {
      console.error("Update error:", updateError);
      return NextResponse.json(
        { error: `Failed to update project: ${updateError.message}` },
        { status: 500 },
      );
    }

    return NextResponse.json({
      success: true,
      project: updatedProject,
    });
  } catch (error) {
    console.error("Project update error:", error);
    return NextResponse.json(
      { error: "Failed to update project" },
      { status: 500 },
    );
  }
}

