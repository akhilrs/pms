// app/api/projects/[id]/milestones/route.ts
import { NextRequest, NextResponse } from "next/server";
import { getProjectMilestones } from "@/lib/supabase/milestones";

// GET - Get all milestones for a project
export async function GET(
  request: NextRequest,
  context: { params: { id: string } }
) {
  try {
    // Extract the ID from the URL path segments to avoid the params.id issue
    const pathSegments = request.nextUrl.pathname.split('/');
    // The pattern is /api/projects/:id/milestones, so project ID is the 4th segment
    const projectId = pathSegments[3];
    
    console.log("Fetching milestones for project:", projectId);
    const { data, error } = await getProjectMilestones(projectId);

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 400 });
    }

    return NextResponse.json({ data });
  } catch (error) {
    console.error("Error fetching milestones:", error);
    return NextResponse.json(
      { error: "Failed to fetch milestones" },
      { status: 500 },
    );
  }
}