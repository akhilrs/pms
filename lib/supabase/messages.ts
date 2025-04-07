import { createServerClient } from "./auth-helpers";
import { PostgrestError } from "@supabase/supabase-js";
import { Database } from "@/types/supabase";

type Message = Database["public"]["Tables"]["messages"]["Row"];

/**
 * Get all messages for a specific project
 */
export async function getProjectMessages(projectId: string) {
  if (!projectId) {
    console.log("getProjectMessages: No project ID provided");
    return { data: [], error: null };
  }

  try {
    const supabase = createServerClient();

    const { data, error } = await supabase
      .from("messages")
      .select(`
        *,
        user:user_id (
          id,
          first_name,
          last_name,
          avatar_url
        )
      `)
      .eq("project_id", projectId)
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Error fetching project messages:", error);
      return { data: [], error };
    }

    return { data: data || [], error: null };
  } catch (err) {
    console.error("Error in getProjectMessages:", err);
    return { data: [], error: err as PostgrestError };
  }
}

/**
 * Create a new message in a project
 */
export async function createMessage(
  projectId: string,
  userId: string,
  content: string
) {
  if (!projectId || !userId || !content) {
    console.log("createMessage: Missing required parameters");
    return { data: null, error: new Error("Missing required parameters") };
  }

  try {
    const supabase = createServerClient();

    const { data, error } = await supabase
      .from("messages")
      .insert({
        project_id: projectId,
        user_id: userId,
        content,
      })
      .select()
      .single();

    if (error) {
      console.error("Error creating message:", error);
      return { data: null, error };
    }

    return { data, error: null };
  } catch (err) {
    console.error("Error in createMessage:", err);
    return { data: null, error: err as PostgrestError };
  }
}

/**
 * Delete a message
 */
export async function deleteMessage(messageId: string) {
  if (!messageId) {
    console.log("deleteMessage: No message ID provided");
    return { success: false, error: new Error("No message ID provided") };
  }

  try {
    const supabase = createServerClient();

    const { error } = await supabase
      .from("messages")
      .delete()
      .eq("id", messageId);

    if (error) {
      console.error("Error deleting message:", error);
      return { success: false, error };
    }

    return { success: true, error: null };
  } catch (err) {
    console.error("Error in deleteMessage:", err);
    return { success: false, error: err as PostgrestError };
  }
}