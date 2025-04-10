import { Metadata } from "next";
import { notFound, redirect } from "next/navigation";
import { DashboardLayout } from "@/components/common/layout";
import { TeamForm } from "@/components/teams";
import { getTeam } from "@/lib/supabase/teams";
import { getServerSession } from "@/lib/supabase/server-auth";
import { updateTeam } from "@/app/teams/actions";
import { APP_NAME } from "@/lib/constants";

type Props = {
  params: Promise<{
    id: string;
  }>;
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { id } = await params;

  try {
    const { data: team } = await getTeam(id);
    return {
      title: team
        ? `Edit ${team.name} | ${APP_NAME}`
        : `Edit Team | ${APP_NAME}`,
      description: "Edit team details",
    };
  } catch (error) {
    console.error("Error generating metadata:", error);
    return {
      title: `Edit Team | ${APP_NAME}`,
      description: "Edit team details",
    };
  }
}

export default async function EditTeamPage({ params }: Props) {
  const { id: teamId } = await params;
  
  // Check authentication
  const session = await getServerSession();
  if (!session?.user) {
    redirect('/auth/login');
  }
  
  const userId = session.user.id;
  
  // Get team data
  const { data: team, error } = await getTeam(teamId);
  
  if (error) {
    console.error("Error fetching team:", error);
    throw new Error(`Failed to fetch team: ${error.message}`);
  }
  
  if (!team) {
    console.log("Team not found");
    notFound();
  }
  
  // Check if user is an admin or owner of the team
  const userMember = team.members.find(member => member.user_id === userId);
  if (!userMember || !["admin", "owner"].includes(userMember.role)) {
    // User doesn't have permission to edit this team
    redirect(`/teams/${teamId}`);
  }
  
  // Handle team update
  const handleUpdateTeam = async (formData: any) => {
    return updateTeam(teamId, formData);
  };

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold">Edit Team</h1>
          <p className="text-gray-600">
            Update details for {team.name}
          </p>
        </div>

        <TeamForm
          team={team}
          userId={userId}
          onSubmit={handleUpdateTeam}
          submitLabel="Save Changes"
          title="Team Details"
          description="Update your team's information"
        />
      </div>
    </DashboardLayout>
  );
}