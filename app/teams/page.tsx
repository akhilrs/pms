import { Metadata } from "next";
import Link from "next/link";
import { PlusCircle } from "lucide-react";
import { DashboardLayout } from "@/components/common";
import { Button } from "@/components/ui/button";
import { TeamList } from "@/components/teams";
import { getUserTeams } from "@/lib/supabase/teams";
import { getUser } from "@/lib/supabase/auth-helpers";
import { APP_NAME } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Teams | ${APP_NAME}`,
  description: "Manage your teams",
};

export default async function TeamsPage() {
  // Get authenticated user using Supabase auth
  const user = await getUser();
  const userId = user?.id;

  console.log(
    "Teams page - Auth check:",
    userId ? `Authenticated as ${userId}` : "Not authenticated",
  );

  // Fetch teams if user is authenticated
  let teams = [];
  let error = null;

  if (userId) {
    try {
      const result = await getUserTeams(userId);
      teams = result.data || [];
      error = result.error;

      console.log(`Found ${teams.length} teams for user ${userId}`);
      console.log("Teams data:", JSON.stringify(teams));
      
      // Check if any team doesn't have members array initialized
      if (teams.length > 0 && !teams[0].members) {
        console.log("Initializing missing team member arrays");
        teams = teams.map(team => ({
          ...team,
          members: [],
          projects: [],
        }));
      }
    } catch (fetchError) {
      console.error("Error fetching teams:", fetchError);
      error = { message: "Failed to fetch teams. Please try again." };
    }
  }

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">Teams</h1>
            <p className="text-gray-600">
              Create and manage teams for your projects
            </p>
          </div>
          <Button asChild>
            <Link href="/teams/new">
              <PlusCircle className="h-4 w-4 mr-2" />
              New Team
            </Link>
          </Button>
        </div>

        {!userId ? (
          <div className="bg-yellow-100 p-4 rounded-md mb-4">
            <p className="font-semibold">Authentication Required</p>
            <p className="text-sm text-gray-700 mt-1">
              Please sign in to view your teams
            </p>
            <Button className="mt-3" asChild>
              <Link href="/auth/login">Sign In</Link>
            </Button>
          </div>
        ) : error ? (
          <div className="bg-red-100 p-4 rounded-md mb-4">
            <p className="text-red-600 font-semibold">Error Loading Teams</p>
            <p className="text-sm text-red-700 mt-1">{error.message}</p>
          </div>
        ) : null}

        <TeamList teams={teams} />
      </div>
    </DashboardLayout>
  );
}