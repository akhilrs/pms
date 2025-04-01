"use server";

import { createServerClient } from "@/lib/supabase/auth-helpers";

export async function getProjectFiles(projectId: string) {
  console.log("Server Action - Fetching files for project:", projectId);
  
  try {
    const supabase = await createServerClient();
    
    const { data, error } = await supabase
      .from("files")
      .select("*")
      .eq("project_id", projectId)
      .order("created_at", { ascending: false });
    
    if (error) {
      console.error("Server Action - Error fetching files:", error);
      return [];
    }
    
    console.log(`Server Action - Found ${data.length} files for project ${projectId}`);
    return data;
  } catch (error) {
    console.error("Server Action - Exception fetching files:", error);
    return [];
  }
} 