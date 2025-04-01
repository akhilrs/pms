// lib/supabase/files-adapter.ts
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { Database } from "@/types/supabase";

// Client-side version of file operations that doesn't depend on server components
export function useProjectFiles() {
  const supabase = createClientComponentClient<Database>();

  // Fetch project files
  const getProjectFiles = async (projectId: string) => {
    if (!projectId) {
      console.error("No project ID provided for file fetching");
      return [];
    }

    try {
      console.log("Fetching files for project:", projectId);
      
      const { data, error } = await supabase
        .from("files")
        .select("*")
        .eq("project_id", projectId)
        .order("created_at", { ascending: false });

      if (error) {
        console.error("Error fetching project files:", error);
        return [];
      }

      console.log(`Found ${data?.length || 0} files for project:`, projectId);
      return data || [];
    } catch (err) {
      console.error("Error in getProjectFiles:", err);
      return [];
    }
  };

  // Ensure project membership (helper function)
  const ensureProjectMembership = async (userId: string, projectId: string) => {
    if (!userId || !projectId) {
      console.error("Missing userId or projectId in ensureProjectMembership");
      return false;
    }

    try {
      console.log(`Checking membership for user ${userId} in project ${projectId}`);
      
      // Check if membership already exists
      const { data: existingMembership, error: membershipError } = await supabase
        .from("project_members")
        .select("id, role")
        .eq("project_id", projectId)
        .eq("user_id", userId)
        .single();

      if (membershipError && membershipError.code !== 'PGRST116') {
        console.error("Error checking project membership:", membershipError);
      }

      if (existingMembership) {
        console.log(`User ${userId} is already a member of project ${projectId} with role: ${existingMembership.role}`);
        return true;
      }

      console.log(`No membership found for user ${userId} in project ${projectId}, checking if user is owner`);
      
      // Check if user is project owner
      const { data: project, error: projectError } = await supabase
        .from("projects")
        .select("owner_id")
        .eq("id", projectId)
        .single();

      if (projectError) {
        console.error("Error checking project ownership:", projectError);
        return false;
      }

      if (project && project.owner_id === userId) {
        console.log(`User ${userId} is the owner of project ${projectId}, creating membership record`);
        
        // Insert new membership
        const { error: insertError } = await supabase
          .from("project_members")
          .insert({
            project_id: projectId,
            user_id: userId,
            role: "owner",
          });

        if (insertError) {
          console.error("Error creating project membership:", insertError);
          return false;
        }

        console.log(`Created owner membership for user ${userId} in project ${projectId}`);
        return true;
      }

      console.log(`User ${userId} is not the owner of project ${projectId} and has no membership`);
      return false;
    } catch (error) {
      console.error("Error in ensureProjectMembership:", error);
      return false;
    }
  };

  return {
    getProjectFiles,
    ensureProjectMembership,
  };
}
