import { NextRequest, NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";
import { formatDateForSupabase } from "@/lib/utils";
import { createServerClient } from "@/lib/supabase/auth-helpers";

export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    // Get project ID from URL params
    const projectId = params.id;
    if (!projectId) {
      return NextResponse.json(
        { error: "Project ID is required" },
        { status: 400 },
      );
    }

    // Parse the request body
    const formData = await request.json();

    // Get authenticated user
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

    // Check if user has permission to update this project
    const { data: membership } = await supabase
      .from("project_members")
      .select("role")
      .eq("project_id", projectId)
      .eq("user_id", user.id)
      .single();

    if (!membership) {
      return NextResponse.json(
        { error: "You do not have permission to update this project" },
        { status: 403 },
      );
    }

    // Prepare update data with properly formatted dates
    const updateData = {
      name: formData.name,
      description: formData.description,
      status: formData.status,
      start_date: formData.start_date
        ? formatDateForSupabase(new Date(formData.start_date))
        : undefined,
      end_date: formData.end_date
        ? formatDateForSupabase(new Date(formData.end_date))
        : undefined,
      // Don't update owner_id as that should remain constant
    };

    // Remove undefined values to avoid overwriting with null
    Object.keys(updateData).forEach((key) => {
      if (updateData[key] === undefined) {
        delete updateData[key];
      }
    });

    // Use service client to bypass RLS for update
    const adminClient = getServiceSupabase();

    const { data: updatedProject, error: updateError } = await adminClient
      .from("projects")
      .update(updateData)
      .eq("id", projectId)
      .select()
      .single();

    if (updateError) {
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

// Optional: Add DELETE method to the same file for project deletion
export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    const projectId = params.id;
    if (!projectId) {
      return NextResponse.json(
        { error: "Project ID is required" },
        { status: 400 },
      );
    }

    // Get authenticated user
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

    // Check if user is the owner of the project
    const { data: membership } = await supabase
      .from("project_members")
      .select("role")
      .eq("project_id", projectId)
      .eq("user_id", user.id)
      .eq("role", "owner") // Only project owners can delete
      .single();

    if (!membership) {
      return NextResponse.json(
        { error: "Only the project owner can delete this project" },
        { status: 403 },
      );
    }

    // Use service client for deletion
    const adminClient = getServiceSupabase();

    // First delete project members to avoid foreign key constraints
    await adminClient
      .from("project_members")
      .delete()
      .eq("project_id", projectId);

    // Then delete the project
    const { error: deleteError } = await adminClient
      .from("projects")
      .delete()
      .eq("id", projectId);

    if (deleteError) {
      return NextResponse.json(
        { error: `Failed to delete project: ${deleteError.message}` },
        { status: 500 },
      );
    }

    return NextResponse.json({
      success: true,
      message: "Project deleted successfully",
    });
  } catch (error) {
    console.error("Project deletion error:", error);
    return NextResponse.json(
      { error: "Failed to delete project" },
      { status: 500 },
    );
  }
}
