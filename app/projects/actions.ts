"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { cookies } from "next/headers";
import { createServerClient } from '@supabase/ssr';
import { supabase } from "@/lib/supabase/client";
import {
  createProject,
  updateProject,
  deleteProject,
} from "@/lib/supabase/projects";
import type { ProjectFormValues } from "@/components/projects/project-form";

// Create a server-side Supabase client
const createServerSupabaseClient = () => {
  const cookieStore = cookies();
  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        async get(name: string) {
          const cookie = await cookieStore.get(name);
          return cookie?.value;
        },
        async set(name: string, value: string, options: any) {
          try {
            await cookieStore.set({ name, value, ...options });
          } catch (error) {
            // Handle cookie errors
          }
        },
        async remove(name: string, options: any) {
          try {
            await cookieStore.set({ name, value: '', ...options });
          } catch (error) {
            // Handle cookie errors
          }
        },
      },
    }
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
    console.error('Session error:', sessionError);
    throw new Error("Authentication error");
  }

  if (session?.user) {
    return session.user.id;
  }

  const { data: { user }, error: userError } = await supabase.auth.getUser();
  
  if (userError || !user) {
    console.error('User error:', userError);
    throw new Error("User not authenticated");
  }

  return user.id;
}

/**
 * Create a new project
 */
export async function createProjectAction(formData: ProjectFormValues) {
  try {
    const supabase = createServerSupabaseClient();
    
    // Get current user from session
    const {
      data: { session },
    } = await supabase.auth.getSession();
    let userId = session?.user?.id;

    // If no session is found, try to get it from server-side auth
    if (!userId) {
      const { data, error } = await supabase.auth.getUser();
      if (error || !data.user) {
        throw new Error("User not authenticated");
      }
      userId = data.user.id;
    }

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
  // Get current user
  const {
    data: { session },
  } = await supabase.auth.getSession();
  let userId = session?.user?.id;

  // If no session is found, try to get it from server-side auth
  if (!userId) {
    const { data, error } = await supabase.auth.getUser();
    if (error || !data.user) {
      throw new Error("User not authenticated");
    }
    userId = data.user.id;
  }

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
    throw new Error(`Failed to update project: ${error.message}`);
  }

  // Revalidate project paths
  revalidatePath("/projects");
  revalidatePath(`/projects/${projectId}`);

  return { success: true, project };
}

/**
 * Delete a project
 */
export async function deleteProjectAction(projectId: string) {
  // Get current user
  const {
    data: { session },
  } = await supabase.auth.getSession();
  let userId = session?.user?.id;

  // If no session is found, try to get it from server-side auth
  if (!userId) {
    const { data, error } = await supabase.auth.getUser();
    if (error || !data.user) {
      throw new Error("User not authenticated");
    }
    userId = data.user.id;
  }

  if (!userId) {
    throw new Error("User not authenticated");
  }

  // Delete project
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
    // Get current user from session
    const {
      data: { session },
    } = await supabase.auth.getSession();
    let userId = session?.user?.id;

    // If no session is found, try to get it from server-side auth
    if (!userId) {
      const { data, error } = await supabase.auth.getUser();
      if (error || !data.user) {
        throw new Error("User not authenticated");
      }
      userId = data.user.id;
    }

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { data: project, error: projectError } = await supabase
      .from('projects')
      .select('*')
      .eq('id', id)
      .eq('owner_id', userId)
      .single();

    if (projectError) {
      console.error('Error fetching project:', projectError);
      throw projectError;
    }

    if (!project) {
      throw new Error('Project not found');
    }

    return project;
  } catch (error) {
    console.error('Error in getProject:', error);
    throw error;
  }
}

