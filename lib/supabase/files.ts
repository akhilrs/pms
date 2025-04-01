import { createServerClient } from "./auth-helpers";
import { PostgrestError } from "@supabase/supabase-js";

/**
 * Get all files for a specific project
 */
export async function getProjectFiles(projectId: string) {
  if (!projectId) {
    console.log("getProjectFiles: No project ID provided");
    return [];
  }

  try {
    const supabase = createServerClient();

    const { data, error } = await supabase
      .from("files")
      .select("*")
      .eq("project_id", projectId)
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Error fetching project files:", error);
      return [];
    }

    return data || [];
  } catch (err) {
    console.error("Error in getProjectFiles:", err);
    return [];
  }
}

/**
 * Get a single file by ID
 */
export async function getFile(fileId: string) {
  if (!fileId) {
    console.log("getFile: No file ID provided");
    return { data: null, error: null };
  }

  try {
    const supabase = createServerClient();

    const { data, error } = await supabase
      .from("files")
      .select("*")
      .eq("id", fileId)
      .single();

    return { data, error };
  } catch (err) {
    console.error("Error in getFile:", err);
    return { data: null, error: err as PostgrestError };
  }
}

