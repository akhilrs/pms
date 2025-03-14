'use server';

import { revalidatePath } from 'next/cache';
import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';
import { createProject, updateProject, deleteProject } from '@/lib/supabase/projects';
import type { ProjectFormValues } from '@/components/projects/project-form';

/**
 * Create a new project
 */
export async function createProjectAction(formData: ProjectFormValues) {
  const supabase = createClient();
  
  // Get current user
  const { data: { session } } = await supabase.auth.getSession();
  const userId = session?.user?.id;
  
  if (!userId) {
    throw new Error('User not authenticated');
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
    throw new Error(`Failed to create project: ${error.message}`);
  }
  
  // Revalidate projects path
  revalidatePath('/projects');
  
  // Redirect to project page
  redirect(`/projects/${project.id}`);
}

/**
 * Update an existing project
 */
export async function updateProjectAction(projectId: string, formData: ProjectFormValues) {
  const supabase = createClient();
  
  // Get current user
  const { data: { session } } = await supabase.auth.getSession();
  const userId = session?.user?.id;
  
  if (!userId) {
    throw new Error('User not authenticated');
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
  revalidatePath('/projects');
  revalidatePath(`/projects/${projectId}`);
  
  return { success: true, project };
}

/**
 * Delete a project
 */
export async function deleteProjectAction(projectId: string) {
  const supabase = createClient();
  
  // Get current user
  const { data: { session } } = await supabase.auth.getSession();
  const userId = session?.user?.id;
  
  if (!userId) {
    throw new Error('User not authenticated');
  }
  
  // Delete project
  const { error } = await deleteProject(projectId);
  
  if (error) {
    throw new Error(`Failed to delete project: ${error.message}`);
  }
  
  // Revalidate projects path
  revalidatePath('/projects');
  
  // Redirect to projects page
  redirect('/projects');
} 