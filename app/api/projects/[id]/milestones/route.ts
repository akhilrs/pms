import { NextRequest, NextResponse } from "next/server";
import { getProjectMilestones } from "@/lib/supabase/milestones";
import { requireAuth } from "@/lib/supabase/auth-helpers";

// GET /api/projects/[id]/milestones
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    // Extract the id from params first
    const projectId = params.id;
    console.log("Fetching milestones for project:", projectId);

    // Check if user is authenticated
    const user = await requireAuth();

    // Get project milestones
    const { data, error } = await getProjectMilestones(projectId);

    if (error) {
      return NextResponse.json(
        { error: error.message || "Failed to fetch milestones" },
        { status: 500 },
      );
    }

    return NextResponse.json({ data });
  } catch (error) {
    console.error("Error in milestones GET route:", error);

    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}

