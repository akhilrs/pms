import { PostgrestError } from "@supabase/supabase-js";
import { createServerClient } from "./auth-helpers";
import { Database } from "@/types/supabase";

type Project = Database["public"]["Tables"]["projects"]["Row"];
type ProjectInsert = Database["public"]["Tables"]["projects"]["Insert"];
type ProjectUpdate = Database["public"]["Tables"]["projects"]["Update"];

export type ProjectWithDetails = Project & {
  owner: {
    id: string;
    first_name: string | null;
    last_name: string | null;
    avatar_url: string | null;
  } | null;
  members: Array<{
    id: string;
    role: string;
    user: {
      id: string;
      first_name: string | null;
      last_name: string | null;
      avatar_url: string | null;
    } | null;
  }>;
};

/**
 * Get all projects for the current user with basic owner information
 */
export async function getUserProjects(userId: string): Promise<{
  data: ProjectWithDetails[] | null;
  error: PostgrestError | null;
}> {
  if (!userId) {
    console.log("getUserProjects: No userId provided");
    return { data: null, error: null };
  }

  try {
    // Create a server client - updated to await the async function
    const supabase = await createServerClient();

    // First, get projects owned by the user
    const { data: ownedProjects, error: ownedError } = await supabase
      .from("projects")
      .select("*")
      .eq("owner_id", userId);

    if (ownedError) {
      console.error("Error fetching owned projects:", ownedError);
      return { data: null, error: ownedError };
    }

    let memberProjectIds = [];
    let memberError = null;

    try {
      // Modified approach: Use a simpler query without complex joins that could trigger recursion
      const { data: memberRelations, error } = await supabase
        .from("project_members")
        .select("project_id")
        .eq("user_id", userId);

      if (error) {
        console.log("Error fetching member projects:", error);
        memberError = error;
      } else if (memberRelations) {
        memberProjectIds = memberRelations.map(
          (relation) => relation.project_id,
        );
      }
    } catch (err) {
      console.error("Exception fetching member projects:", err);
      // Continue with owned projects even if member fetching fails
    }

    // Get the actual project data for member projects
    let memberProjectData: Project[] = [];
    if (memberProjectIds.length > 0) {
      try {
        const { data: projects, error: projectsError } = await supabase
          .from("projects")
          .select("*")
          .in("id", memberProjectIds);

        if (projectsError) {
          console.error(
            "Error fetching member project details:",
            projectsError,
          );
        } else if (projects) {
          memberProjectData = projects;
        }
      } catch (err) {
        console.error("Exception fetching member project details:", err);
        // Continue with owned projects even if this fails
      }
    }

    const allProjectsMap = new Map<string, Project>();

    // Add owned projects
    if (ownedProjects) {
      ownedProjects.forEach((project) => {
        allProjectsMap.set(project.id, project);
      });
    }

    // Add member projects (will overwrite if already in map)
    memberProjectData.forEach((project) => {
      allProjectsMap.set(project.id, project);
    });

    const allProjects = Array.from(allProjectsMap.values());

    // Collect all owner IDs to fetch user profiles
    const ownerIds = allProjects
      .map((project) => project.owner_id)
      .filter((id) => id !== null && id !== undefined);

    // Get owner profiles in a separate query to avoid RLS issues
    const ownersMap = new Map();
    if (ownerIds.length > 0) {
      try {
        // Direct profiles query to get owner information
        const { data: ownerProfiles } = await supabase
          .from("profiles")
          .select("id, user_id, first_name, last_name, avatar_url")
          .in("user_id", ownerIds);

        if (ownerProfiles) {
          ownerProfiles.forEach((profile) => {
            ownersMap.set(profile.user_id, {
              id: profile.user_id,
              first_name: profile.first_name,
              last_name: profile.last_name,
              avatar_url: profile.avatar_url,
            });
          });
        }
      } catch (error) {
        console.warn("Error fetching owner profiles:", error);
      }
    }

    // Create ProjectWithDetails objects with owner information
    const projectsWithDetails: ProjectWithDetails[] = allProjects.map(
      (project) => {
        // Get owner from map or create empty owner object
        const owner = project.owner_id
          ? ownersMap.get(project.owner_id) || {
              id: project.owner_id,
              first_name: null,
              last_name: null,
              avatar_url: null,
            }
          : null;

        return {
          ...project,
          owner,
          members: [], // Still keep members empty to avoid RLS issues
        };
      },
    );

    console.log(
      `Processed ${projectsWithDetails.length} projects with owner details`,
    );

    return { data: projectsWithDetails, error: null };
  } catch (err) {
    console.error("Error in getUserProjects:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Get a single project by ID with owner information
 */
export async function getProject(
  projectId: string,
): Promise<{ data: ProjectWithDetails | null; error: PostgrestError | null }> {
  console.log(`getProject called with ID: ${projectId}`);

  if (!projectId) {
    console.log("getProject: No project ID provided");
    return { data: null, error: null };
  }

  try {
    // Create a server client
    const supabase = await createServerClient();

    // Get the basic project data without relationships
    const { data: projectData, error: projectError } = await supabase
      .from("projects")
      .select("*")
      .eq("id", projectId)
      .single();

    if (projectError) {
      console.error("Error fetching project:", projectError);
      return { data: null, error: projectError };
    }

    if (!projectData) {
      console.log("Project not found");
      return { data: null, error: null };
    }

    // Fetch owner information if owner_id exists
    let ownerData = null;
    if (projectData.owner_id) {
      try {
        const { data: ownerProfile } = await supabase
          .from("profiles")
          .select("id, user_id, first_name, last_name, avatar_url")
          .eq("user_id", projectData.owner_id)
          .single();

        if (ownerProfile) {
          ownerData = {
            id: projectData.owner_id,
            first_name: ownerProfile.first_name,
            last_name: ownerProfile.last_name,
            avatar_url: ownerProfile.avatar_url,
          };
        }
      } catch (error) {
        console.warn("Error fetching owner profile:", error);
      }
    }

    // If owner data couldn't be fetched, create placeholder with ID
    if (!ownerData && projectData.owner_id) {
      ownerData = {
        id: projectData.owner_id,
        first_name: null,
        last_name: null,
        avatar_url: null,
      };
    }

    const projectWithDetails: ProjectWithDetails = {
      ...projectData,
      owner: ownerData,
      members: [], // Keep members empty to avoid RLS issues
    };

    return { data: projectWithDetails, error: null };
  } catch (err) {
    console.error("Error in getProject:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Create a new project - Compatible with your existing actions
 */
export async function createProject(
  projectData: ProjectInsert,
): Promise<{ data: Project | null; error: PostgrestError | null }> {
  try {
    // Create a server client
    const supabase = await createServerClient();

    if (!projectData || typeof projectData !== "object") {
      throw new Error(
        `createProject: Project data is not an object, received ${typeof projectData}`,
      );
    }

    console.log("Creating project:", {
      name: projectData.name,
      owner_id: projectData.owner_id,
    });

    // Insert project
    const { data, error } = await supabase
      .from("projects")
      .insert(projectData)
      .select()
      .single();

    // Add the creator as a member if successful
    if (data && !error && projectData.owner_id) {
      try {
        await supabase.from("project_members").insert({
          project_id: data.id,
          user_id: projectData.owner_id,
          role: "owner",
          joined_at: new Date().toISOString(),
        });
      } catch (memberError) {
        console.error("Error adding project owner as member:", memberError);
        // Don't throw, as project was created successfully
      }
    }

    return { data, error };
  } catch (err) {
    console.error("Error in createProject:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Update a project - Compatible with your existing actions
 */
export async function updateProject(
  projectId: string,
  updates: ProjectUpdate,
): Promise<{ data: Project | null; error: PostgrestError | null }> {
  try {
    // Create a server client
    const supabase = await createServerClient();

    // Update project
    const { data, error } = await supabase
      .from("projects")
      .update(updates)
      .eq("id", projectId)
      .select()
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in updateProject:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Delete a project - Compatible with your existing actions
 */
export async function deleteProject(
  projectId: string,
): Promise<{ error: PostgrestError | null }> {
  try {
    // Create a server client
    const supabase = await createServerClient();

    // First try to delete all project members to avoid foreign key constraints
    try {
      await supabase
        .from("project_members")
        .delete()
        .eq("project_id", projectId);
    } catch (membersError) {
      console.error("Error deleting project members:", membersError);
      // Continue with project deletion attempt
    }

    // Delete the project
    const { error } = await supabase
      .from("projects")
      .delete()
      .eq("id", projectId);

    return { error };
  } catch (err) {
    console.error("Error in deleteProject:", err);
    return { error: err as PostgrestError };
  }
}
