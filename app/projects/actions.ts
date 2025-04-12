"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { cookies } from "next/headers";
import { createServerClient } from "@supabase/ssr";
import { supabase } from "@/lib/supabase/client";
import {
  createProject,
  updateProject,
  deleteProject,
} from "@/lib/supabase/projects";
import {
  getProjectMilestones as getProjectMilestonesServer,
  createMilestone as createMilestoneServer,
  updateMilestone as updateMilestoneServer,
  deleteMilestone as deleteMilestoneServer,
  assignTaskToMilestone as assignTaskToMilestoneServer,
  getUnassignedTasks as getUnassignedTasksServer,
} from "@/lib/supabase/milestones";
import type { ProjectFormValues } from "@/components/projects/project-form";

// Create a server-side Supabase client
const createServerSupabaseClient = () => {
  const cookieStore = cookies();
  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
          return cookieStore.get(name)?.value;
        },
        set(name: string, value: string, options: any) {
          try {
            cookieStore.set({ name, value, ...options });
          } catch (error) {
            // Handle cookie errors
          }
        },
        remove(name: string, options: any) {
          try {
            cookieStore.set({ name, value: "", ...options });
          } catch (error) {
            // Handle cookie errors
          }
        },
      },
    },
  );
};

// Helper function to get authenticated user
async function getAuthenticatedUser() {
  const supabase = createServerSupabaseClient();

  const {
    data: { session },
    error: sessionError,
  } = await supabase.auth.getSession();

  if (sessionError) {
    console.error("Session error:", sessionError);
    throw new Error("Authentication error");
  }

  if (session?.user) {
    return session.user.id;
  }

  const {
    data: { user },
    error: userError,
  } = await supabase.auth.getUser();

  if (userError || !user) {
    console.error("User error:", userError);
    throw new Error("User not authenticated");
  }

  return user.id;
}

/**
 * Create a new project
 */
export async function createProjectAction(formData: ProjectFormValues) {
  try {
    // Get current user from session

    const userId = await getAuthenticatedUser();

    if (!userId) {
      throw new Error("User not authenticated");
    }

    // Create project
    const { data: project, error } = await createProject({
      name: formData.name,
      description: formData.description || null,
      status: formData.status,
      start_date: formData.start_date,
      end_date: formData.end_date || null,
      owner_id: userId,
    });

    if (error) {
      console.error("Project creation error:", error);
      throw new Error(`Failed to create project: ${error.message}`);
    }

    // Revalidate projects path
    revalidatePath("/projects");

    // Redirect to project page
    redirect(`/projects/${project.id}`);
  } catch (error) {
    console.error("Project creation action error:", error);
    throw error;
  }
}

/**
 * Update an existing project
 */
export async function updateProjectAction(
  projectId: string,
  formData: ProjectFormValues,
) {
  try {
    const userId = await getAuthenticatedUser();

    if (!userId) {
      throw new Error("User not authenticated");
    }

    // Update project
    const { data: project, error } = await updateProject(projectId, {
      name: formData.name,
      description: formData.description || null,
      status: formData.status,
      start_date: formData.start_date,
      end_date: formData.end_date || null,
    });

    if (error) {
      console.error("Project update error:", error);
      throw new Error(`Failed to update project: ${error.message}`);
    }

    // Revalidate project paths
    revalidatePath("/projects");
    revalidatePath(`/projects/${projectId}`);

    return { success: true, project };
  } catch (error) {
    console.error("Project update action error:", error);
    throw error;
  }
}

/**
 * Delete a project
 */
export async function deleteProjectAction(projectId: string) {
  const userId = await getAuthenticatedUser();

  if (!userId) {
    throw new Error("User not authenticated");
  }

  const { error } = await deleteProject(projectId);

  if (error) {
    throw new Error(`Failed to delete project: ${error.message}`);
  }

  // Revalidate projects path
  revalidatePath("/projects");

  // Redirect to projects page
  redirect("/projects");
}

export async function getProject(id: string) {
  try {
    const userId = await getAuthenticatedUser();

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { data: project, error: projectError } = await supabase
      .from("projects")
      .select("*")
      .eq("id", id)
      .eq("owner_id", userId)
      .single();

    if (projectError) {
      console.error("Error fetching project:", projectError);
      throw projectError;
    }

    if (!project) {
      throw new Error("Project not found");
    }

    return project;
  } catch (error) {
    console.error("Error in getProject:", error);
    throw error;
  }
}

// Milestone Actions
export async function getProjectMilestonesAction(projectId: string) {
  try {
    // Use direct Supabase client instead of trying to authenticate
    const result = await getProjectMilestonesServer(projectId);
    
    if (result.error) {
      console.error("Error getting project milestones:", result.error);
      throw new Error(`Failed to get project milestones: ${result.error.message}`);
    }
    
    return result;
  } catch (error) {
    console.error("Error getting project milestones:", error);
    throw error;
  }
}

export async function createMilestoneAction(data: any) {
  try {
    // Use direct Supabase client instead of trying to authenticate
    const result = await createMilestoneServer(data);
    
    if (result.error) {
      console.error("Error creating milestone:", result.error);
      throw new Error(`Failed to create milestone: ${result.error.message}`);
    }
    
    revalidatePath(`/projects/${data.project_id}`);
    return result;
  } catch (error) {
    console.error("Error creating milestone:", error);
    throw error;
  }
}

export async function updateMilestoneAction(milestoneId: string, data: any, projectId: string) {
  try {
    // Use direct Supabase client instead of trying to authenticate
    const result = await updateMilestoneServer(milestoneId, data);
    
    if (result.error) {
      console.error("Error updating milestone:", result.error);
      throw new Error(`Failed to update milestone: ${result.error.message}`);
    }
    
    revalidatePath(`/projects/${projectId}`);
    return result;
  } catch (error) {
    console.error("Error updating milestone:", error);
    throw error;
  }
}

export async function deleteMilestoneAction(milestoneId: string, projectId: string) {
  try {
    // Use direct Supabase client instead of trying to authenticate
    const result = await deleteMilestoneServer(milestoneId);
    
    if (result.error) {
      console.error("Error deleting milestone:", result.error);
      throw new Error(`Failed to delete milestone: ${result.error.message}`);
    }
    
    revalidatePath(`/projects/${projectId}`);
    return result;
  } catch (error) {
    console.error("Error deleting milestone:", error);
    throw error;
  }
}

export async function getUnassignedTasksAction(projectId: string) {
  try {
    // Use direct Supabase client instead of trying to authenticate
    const result = await getUnassignedTasksServer(projectId);
    
    if (result.error) {
      console.error("Error getting unassigned tasks:", result.error);
      throw new Error(`Failed to get unassigned tasks: ${result.error.message}`);
    }
    
    return result;
  } catch (error) {
    console.error("Error getting unassigned tasks:", error);
    throw error;
  }
}

export async function assignTaskToMilestoneAction(taskId: string, milestoneId: string | null, projectId: string) {
  try {
    // Use direct Supabase client instead of trying to authenticate
    const result = await assignTaskToMilestoneServer(taskId, milestoneId);
    
    if (result.error) {
      console.error("Error assigning task to milestone:", result.error);
      throw new Error(`Failed to assign task to milestone: ${result.error.message}`);
    }
    
    revalidatePath(`/projects/${projectId}`);
    return result;
  } catch (error) {
    console.error("Error assigning task to milestone:", error);
    throw error;
  }
}
