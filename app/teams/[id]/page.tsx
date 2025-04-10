import { Metadata } from "next";
import { notFound } from "next/navigation";
import Link from "next/link";
import { format } from "date-fns";
import { DashboardLayout } from "@/components/common/layout";
import { Button } from "@/components/ui/button";
import { TeamDetailClient } from "@/components/teams";
import { getTeam } from "@/lib/supabase/teams";
import { getServerSession } from "@/lib/supabase/server-auth";
import { getUserProjects } from "@/lib/supabase/projects";
import { APP_NAME } from "@/lib/constants";

type Props = {
  params: Promise<{
    id: string;
  }>;
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  // Safely access params
  const { id } = await params;

  try {
    const { data: team } = await getTeam(id);
    return {
      title: team
        ? `${team.name} | Teams | ${APP_NAME}`
        : `Team Details | ${APP_NAME}`,
      description: "View team details",
    };
  } catch (error) {
    console.error("Error generating metadata:", error);
    return {
      title: `Team Details | ${APP_NAME}`,
      description: "View team details",
    };
  }
}

export default async function TeamDetailPage({ params }: Props) {
  // Safely access params
  const { id: teamId } = await params;

  console.log("Team detail page - Team ID:", teamId);

  // Get the user session
  const session = await getServerSession();
  const userId = session?.user?.id;

  if (!userId) {
    return (
      <DashboardLayout>
        <div className="space-y-6">
          <div className="bg-yellow-100 p-4 rounded-lg">
            <h1 className="text-2xl font-bold mb-4">Authentication Required</h1>
            <p className="mb-4">Please sign in to view team details.</p>
            <Button asChild>
              <Link href="/auth/login">Sign In</Link>
            </Button>
          </div>
        </div>
      </DashboardLayout>
    );
  }

  try {
    // Get team details
    const { data: team, error } = await getTeam(teamId);

    if (error) {
      console.error("Error fetching team:", error);
      throw new Error(`Failed to fetch team: ${error.message}`);
    }

    if (!team) {
      console.log("Team not found");
      notFound();
    }

    // Check if user is a member of the team
    const userMember = team.members.find((member) => member.user_id === userId);
    if (!userMember) {
      return (
        <DashboardLayout>
          <div className="space-y-6">
            <div className="bg-red-100 p-4 rounded-lg">
              <h1 className="text-2xl font-bold text-red-800 mb-4">
                Access Denied
              </h1>
              <p className="mb-4">
                You do not have permission to view this team.
              </p>
              <Button variant="outline" asChild>
                <Link href="/teams">Back to Teams</Link>
              </Button>
            </div>
          </div>
        </DashboardLayout>
      );
    }

    // Determine user's role in the team
    const isOwner = userMember.role === "owner";
    const isAdmin = userMember.role === "admin" || isOwner;

    // Get available projects for the user (for assigning to team)
    const { data: userProjects = [] } = await getUserProjects(userId);

    // Format the creation date for logging purposes
    const formattedDate = format(new Date(team.created_at), "MMMM d, yyyy");
    console.log(`Team ${team.name} created on ${formattedDate}`);
    
    return (
      <DashboardLayout>
        <TeamDetailClient 
          team={team}
          userId={userId}
          isOwner={isOwner}
          isAdmin={isAdmin}
          userProjects={userProjects}
        />
      </DashboardLayout>
    );
  } catch (error) {
    console.error("Error in team detail page:", error);
    return (
      <DashboardLayout>
        <div className="space-y-6">
          <div className="bg-red-100 p-6 rounded-lg">
            <h1 className="text-2xl font-bold text-red-800 mb-4">
              Error Loading Team
            </h1>
            <p className="mb-4">
              There was an error loading the team details.
            </p>
            <p className="font-mono text-sm bg-white p-4 rounded mb-4 overflow-auto">
              {error instanceof Error
                ? error.message
                : "Unknown error occurred"}
            </p>
            <div className="flex gap-4">
              <Button variant="outline" asChild>
                <Link href="/teams">Back to Teams</Link>
              </Button>
              <Button onClick={() => window.location.reload()}>
                Try Again
              </Button>
            </div>
          </div>
        </div>
      </DashboardLayout>
    );
  }
}