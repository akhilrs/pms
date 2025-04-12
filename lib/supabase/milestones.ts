// lib/supabase/milestones.ts
import { createServerClient } from "./auth-helpers";
import { PostgrestError } from "@supabase/supabase-js";
import { Database } from "@/types/supabase";

type Milestone = Database["public"]["Tables"]["milestones"]["Row"];
type MilestoneInsert = Database["public"]["Tables"]["milestones"]["Insert"];
type MilestoneUpdate = Database["public"]["Tables"]["milestones"]["Update"];
type Task = Database["public"]["Tables"]["tasks"]["Row"];

export type MilestoneWithTasks = Milestone & {
  tasks: Task[];
};

/**
 * Get all milestones for a specific project with their tasks
 */
export async function getProjectMilestones(projectId: string) {
  if (!projectId) {
    console.log("getProjectMilestones: No project ID provided");
    return { data: [], error: null };
  }

  try {
    const supabase = await createServerClient();

    // Get milestones for the project
    const { data: milestones, error } = await supabase
      .from("milestones")
      .select("*")
      .eq("project_id", projectId)
      .order("due_date", { ascending: true });

    if (error) {
      console.error("Error fetching project milestones:", error);
      return { data: [], error };
    }

    // Get tasks for each milestone
    const milestonesWithTasks: MilestoneWithTasks[] = [];

    for (const milestone of milestones || []) {
      // Fetch tasks for this milestone - without the foreign key relation that's causing issues
      const { data: tasks, error: tasksError } = await supabase
        .from("tasks")
        .select("*")
        .eq("milestone_id", milestone.id);

      if (tasksError) {
        console.error("Error fetching tasks for milestone:", tasksError);
      }
      
      // If needed, we can fetch assignee details separately once the migration has been applied
      // This temporary solution allows the application to function until the migration is applied

      milestonesWithTasks.push({
        ...milestone,
        tasks: tasks || [],
      });
    }

    return { data: milestonesWithTasks, error: null };
  } catch (err) {
    console.error("Error in getProjectMilestones:", err);
    return { data: [], error: err as PostgrestError };
  }
}

/**
 * Get a single milestone with its tasks
 */
export async function getMilestone(milestoneId: string) {
  if (!milestoneId) {
    console.log("getMilestone: No milestone ID provided");
    return { data: null, error: null };
  }

  try {
    const supabase = await createServerClient();

    // Get the milestone
    const { data: milestone, error } = await supabase
      .from("milestones")
      .select("*")
      .eq("id", milestoneId)
      .single();

    if (error) {
      console.error("Error fetching milestone:", error);
      return { data: null, error };
    }

    // Get tasks for this milestone - without the foreign key relation that's causing issues
    const { data: tasks, error: tasksError } = await supabase
      .from("tasks")
      .select("*")
      .eq("milestone_id", milestoneId);

    if (tasksError) {
      console.error("Error fetching tasks for milestone:", tasksError);
    }

    const milestoneWithTasks = {
      ...milestone,
      tasks: tasks || [],
    };

    return { data: milestoneWithTasks, error: null };
  } catch (err) {
    console.error("Error in getMilestone:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Create a new milestone
 */
export async function createMilestone(milestoneData: MilestoneInsert) {
  if (!milestoneData.project_id || !milestoneData.title) {
    console.log("createMilestone: Missing required parameters");
    return { data: null, error: new Error("Missing required parameters") };
  }

  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("milestones")
      .insert(milestoneData)
      .select()
      .single();

    if (error) {
      console.error("Error creating milestone:", error);
      return { data: null, error };
    }

    return { data, error: null };
  } catch (err) {
    console.error("Error in createMilestone:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Update a milestone
 */
export async function updateMilestone(
  milestoneId: string,
  updates: MilestoneUpdate,
) {
  if (!milestoneId) {
    console.log("updateMilestone: No milestone ID provided");
    return { data: null, error: new Error("No milestone ID provided") };
  }

  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("milestones")
      .update(updates)
      .eq("id", milestoneId)
      .select()
      .single();

    if (error) {
      console.error("Error updating milestone:", error);
      return { data: null, error };
    }

    return { data, error: null };
  } catch (err) {
    console.error("Error in updateMilestone:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Delete a milestone
 */
export async function deleteMilestone(milestoneId: string) {
  if (!milestoneId) {
    console.log("deleteMilestone: No milestone ID provided");
    return { success: false, error: new Error("No milestone ID provided") };
  }

  try {
    const supabase = createServerClient();

    // First, unlink any tasks from this milestone
    try {
      await supabase
        .from("tasks")
        .update({ milestone_id: null })
        .eq("milestone_id", milestoneId);
    } catch (unlinkError) {
      console.warn("Error unlinking tasks from milestone:", unlinkError);
      // Continue with deletion attempt even if unlinking fails
    }

    // Now delete the milestone
    const { error } = await supabase
      .from("milestones")
      .delete()
      .eq("id", milestoneId);

    if (error) {
      console.error("Error deleting milestone:", error);
      return { success: false, error };
    }

    return { success: true, error: null };
  } catch (err) {
    console.error("Error in deleteMilestone:", err);
    return { success: false, error: err as PostgrestError };
  }
}

/**
 * Assign a task to a milestone
 */
export async function assignTaskToMilestone(
  taskId: string,
  milestoneId: string | null,
) {
  if (!taskId) {
    console.log("assignTaskToMilestone: No task ID provided");
    return { success: false, error: new Error("No task ID provided") };
  }

  try {
    const supabase = createServerClient();

    const { error } = await supabase
      .from("tasks")
      .update({ milestone_id: milestoneId })
      .eq("id", taskId);

    if (error) {
      console.error("Error assigning task to milestone:", error);
      return { success: false, error };
    }

    return { success: true, error: null };
  } catch (err) {
    console.error("Error in assignTaskToMilestone:", err);
    return { success: false, error: err as PostgrestError };
  }
}

/**
 * Get all tasks not assigned to any milestone for a project
 */
export async function getUnassignedTasks(projectId: string) {
  if (!projectId) {
    console.log("getUnassignedTasks: No project ID provided");
    return { data: [], error: null };
  }

  try {
    const supabase = await createServerClient();

    const { data, error } = await supabase
      .from("tasks")
      .select(
        `
        *,
        assignee:assignee_id (
          id,
          first_name,
          last_name,
          avatar_url
        )
      `,
      )
      .eq("project_id", projectId)
      .is("milestone_id", null);

    if (error) {
      console.error("Error fetching unassigned tasks:", error);
      return { data: [], error };
    }

    return { data: data || [], error: null };
  } catch (err) {
    console.error("Error in getUnassignedTasks:", err);
    return { data: [], error: err as PostgrestError };
  }
}
