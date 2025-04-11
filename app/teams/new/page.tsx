import { Metadata } from "next";
import { redirect } from "next/navigation";
import { DashboardLayout } from "@/components/common/layout";
import { NewTeamForm } from "@/components/teams";
import { getServerSession } from "@/lib/supabase/server-auth";
import { APP_NAME } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Create New Team | ${APP_NAME}`,
  description: `Create a new team in your ${APP_NAME}`,
};

export default async function NewTeamPage() {
  // Check authentication with server-side method
  const session = await getServerSession();
  if (!session?.user) {
    redirect('/auth/login');
  }

  const userId = session.user.id;

  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6">
            <h1 className="text-2xl font-bold">Create New Team</h1>
            <p className="text-gray-600 mb-6">Create a new team to organize people working on projects.</p>
            
            <NewTeamForm
              userId={userId}
              title="Team Details"
              description="Enter information about your new team"
            />
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
}