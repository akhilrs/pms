import { PostgrestError } from "@supabase/supabase-js";
import { createServerClient } from "./auth-helpers";
import { Database } from "@/types/supabase";

// Define types from the Database interface
type Team = Database["public"]["Tables"]["teams"]["Row"];
type TeamInsert = Database["public"]["Tables"]["teams"]["Insert"];
type TeamUpdate = Database["public"]["Tables"]["teams"]["Update"];

type TeamMember = Database["public"]["Tables"]["team_members"]["Row"];
type TeamMemberInsert = Database["public"]["Tables"]["team_members"]["Insert"];
type TeamMemberUpdate = Database["public"]["Tables"]["team_members"]["Update"];

type ProjectTeam = Database["public"]["Tables"]["project_teams"]["Row"];
type ProjectTeamInsert = Database["public"]["Tables"]["project_teams"]["Insert"];

type TeamInvitation = Database["public"]["Tables"]["team_invitations"]["Row"];
type TeamInvitationInsert = Database["public"]["Tables"]["team_invitations"]["Insert"];

// Extended types with additional information
export type TeamWithDetails = Team & {
  members: Array<{
    id: string;
    user_id: string;
    role: string;
    user: {
      id: string;
      first_name: string | null;
      last_name: string | null;
      avatar_url: string | null;
      email?: string | null;
    } | null;
  }>;
  projects: Array<{
    id: string;
    name: string;
  }>;
  _count?: {
    members: number;
    projects: number;
  };
};

export type TeamMemberWithProfile = TeamMember & {
  user: {
    id: string;
    first_name: string | null;
    last_name: string | null;
    avatar_url: string | null;
    email?: string | null;
  } | null;
};

/**
 * Get all teams for the current user
 */
export async function getUserTeams(userId: string): Promise<{
  data: TeamWithDetails[] | null;
  error: PostgrestError | null;
}> {
  if (!userId) {
    console.log("getUserTeams: No userId provided");
    return { data: null, error: null };
  }

  try {
    const supabase = await createServerClient();
    let allTeamIds = new Set<string>();

    // Get teams where the user is a member
    const { data: teamMemberships, error: membershipError } = await supabase
      .from("team_members")
      .select("team_id, role")
      .eq("user_id", userId);

    if (membershipError) {
      console.error("Error fetching team memberships:", membershipError);
      return { data: null, error: membershipError };
    }

    // Add member teams to the set
    if (teamMemberships && teamMemberships.length > 0) {
      teamMemberships.forEach(member => allTeamIds.add(member.team_id));
      console.log(`Found ${teamMemberships.length} team memberships for user ${userId}`);
    } else {
      console.log("No team memberships found for user", userId);
    }

    // Also get teams where the user is the creator
    const { data: createdTeams, error: createdTeamsError } = await supabase
      .from("teams")
      .select("id")
      .eq("created_by", userId);

    if (createdTeamsError) {
      console.error("Error fetching created teams:", createdTeamsError);
      return { data: null, error: createdTeamsError };
    }

    // Add created teams to the set
    if (createdTeams && createdTeams.length > 0) {
      createdTeams.forEach(team => allTeamIds.add(team.id));
      console.log(`Found ${createdTeams.length} teams created by user ${userId}`);
    } else {
      console.log("No teams created by user", userId);
    }

    // If no teams found at all, return empty array
    if (allTeamIds.size === 0) {
      console.log("No teams found for user", userId);
      return { data: [], error: null };
    }

    const teamIds = Array.from(allTeamIds);
    console.log(`Total unique teams for user ${userId}: ${teamIds.length}`);

    // Get the team details
    const { data: teams, error: teamsError } = await supabase
      .from("teams")
      .select("*")
      .in("id", teamIds);

    if (teamsError) {
      console.error("Error fetching teams:", teamsError);
      return { data: null, error: teamsError };
    }

    if (!teams || teams.length === 0) {
      console.log("No teams found for the given IDs");
      return { data: [], error: null };
    }

    // Create map of team roles for each user
    const teamRoles = teamMemberships.reduce((acc, membership) => {
      acc[membership.team_id] = membership.role;
      return acc;
    }, {} as Record<string, string>);

    // Enhancement: Count members in each team
    const teamCounts = await Promise.all(
      teams.map(async (team) => {
        const { count, error } = await supabase
          .from("team_members")
          .select("*", { count: "exact", head: true })
          .eq("team_id", team.id);

        const { count: projectCount, error: projectError } = await supabase
          .from("project_teams")
          .select("*", { count: "exact", head: true })
          .eq("team_id", team.id);

        return {
          teamId: team.id,
          memberCount: count || 0,
          projectCount: projectCount || 0,
        };
      }),
    );

    const countMap = teamCounts.reduce(
      (acc, { teamId, memberCount, projectCount }) => {
        acc[teamId] = { members: memberCount, projects: projectCount };
        return acc;
      },
      {} as Record<string, { members: number; projects: number }>,
    );

    // Convert to TeamWithDetails format
    const teamsWithDetails: TeamWithDetails[] = teams.map((team) => ({
      ...team,
      members: [], // Will be fetched separately for detailed views
      projects: [], // Will be fetched separately for detailed views
      _count: countMap[team.id] || { members: 0, projects: 0 },
    }));

    console.log("getUserTeams returning data:", JSON.stringify(teamsWithDetails));
    return { data: teamsWithDetails, error: null };
  } catch (err) {
    console.error("Error in getUserTeams:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Get a team by ID with detailed member information
 */
export async function getTeam(
  teamId: string,
): Promise<{ data: TeamWithDetails | null; error: PostgrestError | null }> {
  if (!teamId) {
    console.log("getTeam: No team ID provided");
    return { data: null, error: null };
  }

  try {
    const supabase = await createServerClient();

    // Get the team
    const { data: team, error: teamError } = await supabase
      .from("teams")
      .select("*")
      .eq("id", teamId)
      .single();

    if (teamError) {
      console.error("Error fetching team:", teamError);
      return { data: null, error: teamError };
    }

    if (!team) {
      console.log("Team not found");
      return { data: null, error: null };
    }

    // Get team members with profiles
    const { data: members, error: membersError } = await supabase
      .from("team_members")
      .select(
        `
        id,
        team_id,
        user_id,
        role,
        joined_at,
        created_at
      `,
      )
      .eq("team_id", teamId);

    if (membersError) {
      console.error("Error fetching team members:", membersError);
      // Continue with partial data
    }

    // Get profile information for each member
    const memberProfilePromises = (members || []).map(async (member) => {
      try {
        const { data: profile } = await supabase
          .from("profiles")
          .select("id, user_id, first_name, last_name, avatar_url, email")
          .eq("user_id", member.user_id)
          .single();

        return {
          ...member,
          user: profile
            ? {
                id: profile.user_id,
                first_name: profile.first_name,
                last_name: profile.last_name,
                avatar_url: profile.avatar_url,
                email: profile.email,
              }
            : null,
        };
      } catch (error) {
        console.warn(`Error fetching profile for user ${member.user_id}:`, error);
        return {
          ...member,
          user: null,
        };
      }
    });

    const membersWithProfiles = await Promise.all(memberProfilePromises);

    // Get associated projects
    const { data: projectTeams, error: projectsError } = await supabase
      .from("project_teams")
      .select("project_id")
      .eq("team_id", teamId);

    if (projectsError) {
      console.error("Error fetching team projects:", projectsError);
      // Continue with partial data
    }

    let projects: Array<{ id: string; name: string }> = [];

    if (projectTeams && projectTeams.length > 0) {
      const projectIds = projectTeams.map((pt) => pt.project_id);
      
      const { data: projectData } = await supabase
        .from("projects")
        .select("id, name")
        .in("id", projectIds);

      projects = projectData || [];
    }

    const teamWithDetails: TeamWithDetails = {
      ...team,
      members: membersWithProfiles,
      projects: projects,
      _count: {
        members: membersWithProfiles.length,
        projects: projects.length,
      },
    };

    return { data: teamWithDetails, error: null };
  } catch (err) {
    console.error("Error in getTeam:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Create a new team
 */
export async function createTeam(
  teamData: TeamInsert,
): Promise<{ data: Team | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    // Insert the team
    const { data, error } = await supabase
      .from("teams")
      .insert(teamData)
      .select()
      .single();

    if (error) {
      console.error("Error creating team:", error);
      return { data: null, error };
    }

    if (!data) {
      return { data: null, error: null };
    }

    // Add the creator as an owner
    try {
      await supabase.from("team_members").insert({
        team_id: data.id,
        user_id: teamData.created_by,
        role: "owner",
      });
    } catch (memberError) {
      console.error("Error adding team creator as member:", memberError);
      // Don't throw, as team was created successfully
    }

    return { data, error: null };
  } catch (err) {
    console.error("Error in createTeam:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Update a team
 */
export async function updateTeam(
  teamId: string,
  updates: TeamUpdate,
): Promise<{ data: Team | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("teams")
      .update(updates)
      .eq("id", teamId)
      .select()
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in updateTeam:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Delete a team
 */
export async function deleteTeam(
  teamId: string,
): Promise<{ error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    // First remove all team memberships
    try {
      await supabase.from("team_members").delete().eq("team_id", teamId);
    } catch (memberError) {
      console.error("Error deleting team members:", memberError);
      // Continue with deletion
    }

    // Remove project team associations
    try {
      await supabase.from("project_teams").delete().eq("team_id", teamId);
    } catch (projectError) {
      console.error("Error removing team from projects:", projectError);
      // Continue with deletion
    }

    // Delete the team
    const { error } = await supabase.from("teams").delete().eq("id", teamId);

    return { error };
  } catch (err) {
    console.error("Error in deleteTeam:", err);
    return { error: err as PostgrestError };
  }
}

/**
 * Add a member to a team
 */
export async function addTeamMember(
  teamMemberData: TeamMemberInsert,
): Promise<{ data: TeamMember | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("team_members")
      .insert(teamMemberData)
      .select()
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in addTeamMember:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Update a team member's role
 */
export async function updateTeamMember(
  teamMemberId: string,
  updates: TeamMemberUpdate,
): Promise<{ data: TeamMember | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("team_members")
      .update(updates)
      .eq("id", teamMemberId)
      .select()
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in updateTeamMember:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Remove a member from a team
 */
export async function removeTeamMember(
  teamId: string,
  userId: string,
): Promise<{ error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { error } = await supabase
      .from("team_members")
      .delete()
      .eq("team_id", teamId)
      .eq("user_id", userId);

    return { error };
  } catch (err) {
    console.error("Error in removeTeamMember:", err);
    return { error: err as PostgrestError };
  }
}

/**
 * Assign a team to a project
 */
export async function assignTeamToProject(
  projectTeamData: ProjectTeamInsert,
): Promise<{ data: ProjectTeam | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("project_teams")
      .insert(projectTeamData)
      .select()
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in assignTeamToProject:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Remove a team from a project
 */
export async function removeTeamFromProject(
  projectId: string,
  teamId: string,
): Promise<{ error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { error } = await supabase
      .from("project_teams")
      .delete()
      .eq("project_id", projectId)
      .eq("team_id", teamId);

    return { error };
  } catch (err) {
    console.error("Error in removeTeamFromProject:", err);
    return { error: err as PostgrestError };
  }
}

/**
 * Get teams assigned to a project
 */
export async function getProjectTeams(
  projectId: string,
): Promise<{
  data: TeamWithDetails[] | null;
  error: PostgrestError | null;
}> {
  try {
    const supabase = await createServerClient();

    // Get team IDs for the project
    const { data: projectTeams, error: projectError } = await supabase
      .from("project_teams")
      .select("team_id")
      .eq("project_id", projectId);

    if (projectError) {
      console.error("Error fetching project teams:", projectError);
      return { data: null, error: projectError };
    }

    if (!projectTeams || projectTeams.length === 0) {
      return { data: [], error: null };
    }

    const teamIds = projectTeams.map((pt) => pt.team_id);

    // Get the team details
    const { data: teams, error: teamsError } = await supabase
      .from("teams")
      .select("*")
      .in("id", teamIds);

    if (teamsError) {
      console.error("Error fetching teams:", teamsError);
      return { data: null, error: teamsError };
    }

    // Count members for each team
    const teamCounts = await Promise.all(
      teams.map(async (team) => {
        const { count } = await supabase
          .from("team_members")
          .select("*", { count: "exact", head: true })
          .eq("team_id", team.id);

        return {
          teamId: team.id,
          count: count || 0,
        };
      }),
    );

    const countMap = teamCounts.reduce(
      (acc, { teamId, count }) => {
        acc[teamId] = { members: count, projects: 1 };
        return acc;
      },
      {} as Record<string, { members: number; projects: number }>,
    );

    const teamsWithDetails: TeamWithDetails[] = teams.map((team) => ({
      ...team,
      members: [], // Will be fetched separately if needed
      projects: [{ id: projectId, name: "" }], // Just the current project
      _count: countMap[team.id],
    }));

    return { data: teamsWithDetails, error: null };
  } catch (err) {
    console.error("Error in getProjectTeams:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Create a team invitation
 */
export async function createTeamInvitation(
  invitationData: TeamInvitationInsert,
): Promise<{ data: TeamInvitation | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    // Set expiration to 7 days from now if not provided
    if (!invitationData.expires_at) {
      const expiresAt = new Date();
      expiresAt.setDate(expiresAt.getDate() + 7);
      invitationData.expires_at = expiresAt.toISOString();
    }

    const { data, error } = await supabase
      .from("team_invitations")
      .insert(invitationData)
      .select()
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in createTeamInvitation:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Delete a team invitation
 */
export async function deleteTeamInvitation(
  invitationId: string,
): Promise<{ error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { error } = await supabase
      .from("team_invitations")
      .delete()
      .eq("id", invitationId);

    return { error };
  } catch (err) {
    console.error("Error in deleteTeamInvitation:", err);
    return { error: err as PostgrestError };
  }
}

/**
 * Accept a team invitation
 */
export async function acceptTeamInvitation(
  token: string,
  userId: string,
): Promise<{ success: boolean; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    // Find the invitation
    const { data: invitation, error: inviteError } = await supabase
      .from("team_invitations")
      .select("*")
      .eq("token", token)
      .single();

    if (inviteError || !invitation) {
      console.error("Error finding invitation:", inviteError);
      return { success: false, error: inviteError };
    }

    // Check if invitation has expired
    if (new Date(invitation.expires_at) < new Date()) {
      return {
        success: false,
        error: {
          message: "Invitation has expired",
          details: "",
          hint: "",
          code: "INVITATION_EXPIRED",
        } as PostgrestError,
      };
    }

    // Add user to team
    const { error: memberError } = await supabase
      .from("team_members")
      .insert({
        team_id: invitation.team_id,
        user_id: userId,
        role: invitation.role,
      });

    if (memberError) {
      console.error("Error adding user to team:", memberError);
      return { success: false, error: memberError };
    }

    // Delete the invitation
    await supabase.from("team_invitations").delete().eq("id", invitation.id);

    return { success: true, error: null };
  } catch (err) {
    console.error("Error in acceptTeamInvitation:", err);
    return { success: false, error: err as PostgrestError };
  }
}

/**
 * Get all team invitations for a team
 */
export async function getTeamInvitations(
  teamId: string,
): Promise<{ data: TeamInvitation[] | null; error: PostgrestError | null }> {
  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("team_invitations")
      .select("*")
      .eq("team_id", teamId);

    return { data, error };
  } catch (err) {
    console.error("Error in getTeamInvitations:", err);
    return { data: null, error: err as PostgrestError };
  }
}