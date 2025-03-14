import { PostgrestError } from '@supabase/supabase-js';
import { supabase } from './client';
import { Database } from '@/types/supabase';

type Project = Database['public']['Tables']['projects']['Row'];
type ProjectInsert = Database['public']['Tables']['projects']['Insert'];
type ProjectUpdate = Database['public']['Tables']['projects']['Update'];

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
 * Get all projects for the current user
 */
export async function getUserProjects(
  userId: string
): Promise<{ data: ProjectWithDetails[] | null; error: PostgrestError | null }> {
  if (!userId) {
    return { data: null, error: null };
  }

  // Get projects where the user is a member
  const { data: memberProjects, error: memberError } = await supabase
    .from('project_members')
    .select('project_id')
    .eq('user_id', userId);

  if (memberError) {
    return { data: null, error: memberError };
  }

  const memberProjectIds = memberProjects.map((p) => p.project_id);
  const projectFilter = memberProjectIds.length
    ? `owner_id.eq.${userId},id.in.(${memberProjectIds.join(',')})`
    : `owner_id.eq.${userId}`;

  const { data, error } = await supabase
    .from('projects')
    .select(`
      *,
      owner:owner_id(id, first_name, last_name, avatar_url),
      members:project_members(id, role, user:user_id(id, first_name, last_name, avatar_url))
    `)
    .or(projectFilter)
    .order('created_at', { ascending: false });

  return { data, error };
}

/**
 * Get a single project by ID
 */
export async function getProject(
  projectId: string
): Promise<{ data: ProjectWithDetails | null; error: PostgrestError | null }> {
  const { data, error } = await supabase
    .from('projects')
    .select(`
      *,
      owner:owner_id(id, first_name, last_name, avatar_url),
      members:project_members(id, role, user:user_id(id, first_name, last_name, avatar_url))
    `)
    .eq('id', projectId)
    .single();

  return { data, error };
}

/**
 * Create a new project
 */
export async function createProject(
  project: ProjectInsert
): Promise<{ data: Project | null; error: PostgrestError | null }> {
  const { data, error } = await supabase
    .from('projects')
    .insert(project)
    .select()
    .single();

  if (!error && data) {
    // Add the owner as a member with 'owner' role
    await supabase.from('project_members').insert({
      project_id: data.id,
      user_id: project.owner_id,
      role: 'owner',
    });
  }

  return { data, error };
}

/**
 * Update a project
 */
export async function updateProject(
  projectId: string,
  updates: ProjectUpdate
): Promise<{ data: Project | null; error: PostgrestError | null }> {
  const { data, error } = await supabase
    .from('projects')
    .update(updates)
    .eq('id', projectId)
    .select()
    .single();

  return { data, error };
}

/**
 * Delete a project
 */
export async function deleteProject(
  projectId: string
): Promise<{ error: PostgrestError | null }> {
  const { error } = await supabase.from('projects').delete().eq('id', projectId);
  return { error };
} 