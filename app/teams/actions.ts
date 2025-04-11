"use server";

import { revalidatePath } from "next/cache";
import { createServerClient } from "@/lib/supabase/auth-helpers";

// Create a new team
export async function createTeam(formData: {
  name: string;
  description?: string;
  avatar_url?: string;
}) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Create team data object
    const teamData = {
      name: formData.name,
      description: formData.description || null,
      created_by: session.user.id,
      avatar_url: formData.avatar_url || null,
    };

    console.log(teamData);

    // Insert team into database
    const { data, error } = await supabase
      .from("teams")
      .insert(teamData)
      .select()
      .single();

    if (error) {
      console.error("Error creating team:", error);
      return { success: false, error: error.message };
    }

    // Add the creator as an owner using the service role
    if (data) {
      console.log(
        `Adding creator ${session.user.id} as owner to team ${data.id}`,
      );

      // Import the service client
      const { getServiceSupabase } = await import("@/lib/supabase/client");
      const serviceClient = getServiceSupabase();

      // First check if the user is already a member (in case of retries)
      const { data: existingMember, error: checkError } = await serviceClient
        .from("team_members")
        .select("id")
        .eq("team_id", data.id)
        .eq("user_id", session.user.id)
        .maybeSingle();

      if (checkError) {
        console.error(
          "Error checking for existing team membership:",
          checkError,
        );
      }

      if (existingMember) {
        console.log("Creator is already a team member, skipping insertion");
      } else {
        // Add creator as team owner using service role to bypass RLS
        const { error: memberError } = await serviceClient
          .from("team_members")
          .insert({
            team_id: data.id,
            user_id: session.user.id,
            role: "owner",
            joined_at: new Date().toISOString(),
          });

        if (memberError) {
          console.error(
            "Error adding team creator as member (using service role):",
            memberError,
          );
        } else {
          console.log("Successfully added creator as team owner");
        }
      }
    }

    // Revalidate teams page to show the new team
    revalidatePath("/teams");

    return { success: true, team: data };
  } catch (error) {
    console.error("Error in createTeam action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

// Update an existing team
export async function updateTeam(
  teamId: string,
  formData: {
    name: string;
    description?: string;
    avatar_url?: string;
  },
) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Check if user is admin or owner of the team
    const { data: membership } = await supabase
      .from("team_members")
      .select("role")
      .eq("team_id", teamId)
      .eq("user_id", session.user.id)
      .single();

    if (!membership || !["admin", "owner"].includes(membership.role)) {
      return {
        success: false,
        error: "You do not have permission to update this team",
      };
    }

    // Update team
    const { data, error } = await supabase
      .from("teams")
      .update({
        name: formData.name,
        description: formData.description || null,
        avatar_url: formData.avatar_url || null,
        updated_at: new Date().toISOString(),
      })
      .eq("id", teamId)
      .select()
      .single();

    if (error) {
      console.error("Error updating team:", error);
      return { success: false, error: error.message };
    }

    // Revalidate paths
    revalidatePath("/teams");
    revalidatePath(`/teams/${teamId}`);

    return { success: true, team: data };
  } catch (error) {
    console.error("Error in updateTeam action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

// Add a member to a team
export async function addTeamMember(
  teamId: string,
  userId: string,
  role: "admin" | "member" = "member",
) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Check if current user is admin or owner of the team
    const { data: membership } = await supabase
      .from("team_members")
      .select("role")
      .eq("team_id", teamId)
      .eq("user_id", session.user.id)
      .single();

    if (!membership || !["admin", "owner"].includes(membership.role)) {
      return {
        success: false,
        error: "You do not have permission to add members to this team",
      };
    }

    // Check if user is already a member
    const { data: existingMembership } = await supabase
      .from("team_members")
      .select("id")
      .eq("team_id", teamId)
      .eq("user_id", userId)
      .maybeSingle();

    if (existingMembership) {
      return { success: false, error: "User is already a member of this team" };
    }

    // Add member
    const { data, error } = await supabase
      .from("team_members")
      .insert({
        team_id: teamId,
        user_id: userId,
        role,
      })
      .select()
      .single();

    if (error) {
      console.error("Error adding team member:", error);
      return { success: false, error: error.message };
    }

    // Revalidate team page
    revalidatePath(`/teams/${teamId}`);

    return { success: true, member: data };
  } catch (error) {
    console.error("Error in addTeamMember action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

// Update a team member's role
export async function updateTeamMemberRole(
  teamId: string,
  memberId: string,
  newRole: "admin" | "member",
) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Check if current user is owner of the team (only owners can change roles)
    const { data: currentUserMembership } = await supabase
      .from("team_members")
      .select("role")
      .eq("team_id", teamId)
      .eq("user_id", session.user.id)
      .single();

    if (!currentUserMembership || currentUserMembership.role !== "owner") {
      return {
        success: false,
        error: "Only team owners can change member roles",
      };
    }

    // Check if the member exists and isn't an owner (can't demote owners)
    const { data: targetMembership } = await supabase
      .from("team_members")
      .select("role, user_id")
      .eq("id", memberId)
      .eq("team_id", teamId)
      .single();

    if (!targetMembership) {
      return { success: false, error: "Member not found" };
    }

    if (targetMembership.role === "owner") {
      return {
        success: false,
        error: "Cannot change the role of a team owner",
      };
    }

    // Update member role
    const { data, error } = await supabase
      .from("team_members")
      .update({ role: newRole })
      .eq("id", memberId)
      .select()
      .single();

    if (error) {
      console.error("Error updating team member role:", error);
      return { success: false, error: error.message };
    }

    // Revalidate team page
    revalidatePath(`/teams/${teamId}`);

    return { success: true, member: data };
  } catch (error) {
    console.error("Error in updateTeamMemberRole action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

// Remove a member from a team
export async function removeTeamMember(teamId: string, memberId: string) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Check if current user is admin or owner of the team
    const { data: currentUserMembership } = await supabase
      .from("team_members")
      .select("role")
      .eq("team_id", teamId)
      .eq("user_id", session.user.id)
      .single();

    if (
      !currentUserMembership ||
      !["admin", "owner"].includes(currentUserMembership.role)
    ) {
      return {
        success: false,
        error: "You do not have permission to remove members from this team",
      };
    }

    // Get the target member's details (we need to check if they're an owner)
    const { data: targetMembership } = await supabase
      .from("team_members")
      .select("role, user_id")
      .eq("id", memberId)
      .eq("team_id", teamId)
      .single();

    if (!targetMembership) {
      return { success: false, error: "Member not found" };
    }

    // Admins can't remove owners
    if (
      currentUserMembership.role === "admin" &&
      targetMembership.role === "owner"
    ) {
      return { success: false, error: "Admins cannot remove team owners" };
    }

    // Check if removing the last owner
    if (targetMembership.role === "owner") {
      const { count } = await supabase
        .from("team_members")
        .select("id", { count: "exact", head: true })
        .eq("team_id", teamId)
        .eq("role", "owner");

      if (count === 1) {
        return {
          success: false,
          error: "Cannot remove the last owner of the team",
        };
      }
    }

    // Remove the member
    const { error } = await supabase
      .from("team_members")
      .delete()
      .eq("id", memberId);

    if (error) {
      console.error("Error removing team member:", error);
      return { success: false, error: error.message };
    }

    // Revalidate team page
    revalidatePath(`/teams/${teamId}`);

    return { success: true };
  } catch (error) {
    console.error("Error in removeTeamMember action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

// Assign a team to a project
export async function assignTeamToProject(teamId: string, projectId: string) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Check if current user is a project owner (only project owners can assign teams)
    const { data: project } = await supabase
      .from("projects")
      .select("owner_id")
      .eq("id", projectId)
      .single();

    if (!project || project.owner_id !== session.user.id) {
      return {
        success: false,
        error: "Only project owners can assign teams to projects",
      };
    }

    // Check if team exists and user is a member
    const { data: teamMembership } = await supabase
      .from("team_members")
      .select("team_id")
      .eq("team_id", teamId)
      .eq("user_id", session.user.id)
      .maybeSingle();

    if (!teamMembership) {
      return {
        success: false,
        error: "Team not found or you are not a member",
      };
    }

    // Check if team is already assigned to this project
    const { data: existingAssignment } = await supabase
      .from("project_teams")
      .select("id")
      .eq("project_id", projectId)
      .eq("team_id", teamId)
      .maybeSingle();

    if (existingAssignment) {
      return {
        success: false,
        error: "Team is already assigned to this project",
      };
    }

    // Assign team to project
    const { data, error } = await supabase
      .from("project_teams")
      .insert({
        project_id: projectId,
        team_id: teamId,
        created_by: session.user.id,
      })
      .select()
      .single();

    if (error) {
      console.error("Error assigning team to project:", error);
      return { success: false, error: error.message };
    }

    // Revalidate paths
    revalidatePath(`/teams/${teamId}`);
    revalidatePath(`/projects/${projectId}`);

    return { success: true, assignment: data };
  } catch (error) {
    console.error("Error in assignTeamToProject action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

// Remove a team from a project
export async function removeTeamFromProject(teamId: string, projectId: string) {
  try {
    const supabase = await createServerClient();

    // Get current user
    const {
      data: { session },
    } = await supabase.auth.getSession();
    if (!session?.user) {
      return { success: false, error: "Authentication required" };
    }

    // Check if current user is a project owner (only project owners can remove teams)
    const { data: project } = await supabase
      .from("projects")
      .select("owner_id")
      .eq("id", projectId)
      .single();

    if (!project || project.owner_id !== session.user.id) {
      return {
        success: false,
        error: "Only project owners can remove teams from projects",
      };
    }

    // Check if assignment exists
    const { data: assignment } = await supabase
      .from("project_teams")
      .select("id")
      .eq("project_id", projectId)
      .eq("team_id", teamId)
      .maybeSingle();

    if (!assignment) {
      return { success: false, error: "Team is not assigned to this project" };
    }

    // Remove team from project
    const { error } = await supabase
      .from("project_teams")
      .delete()
      .eq("project_id", projectId)
      .eq("team_id", teamId);

    if (error) {
      console.error("Error removing team from project:", error);
      return { success: false, error: error.message };
    }

    // Revalidate paths
    revalidatePath(`/teams/${teamId}`);
    revalidatePath(`/projects/${projectId}`);

    return { success: true };
  } catch (error) {
    console.error("Error in removeTeamFromProject action:", error);
    return {
      success: false,
      error:
        error instanceof Error ? error.message : "An unknown error occurred",
    };
  }
}

