// app/api/projects/[id]/milestones/route.ts
import { NextRequest, NextResponse } from "next/server";
import { getProjectMilestones } from "@/lib/supabase/milestones";

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } },
) {
  const projectId = params.id;

  try {
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
