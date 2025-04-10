import { Metadata } from "next";
import { notFound } from "next/navigation";
import Link from "next/link";
import { ArrowLeft } from "lucide-react";

import { APP_NAME } from "@/lib/constants";
import { DashboardLayout } from "@/components/common/layout";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

import { getProject } from "@/lib/supabase/projects";
import { getProjectTeams, getUserTeams } from "@/lib/supabase/teams";
import { getServerSession } from "@/lib/supabase/server-auth";
import { ProjectTeamsManagement } from "@/components/projects/project-teams-management";

type Props = {
  params: Promise<{
    id: string;
  }>;
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  // Safely access params
  const { id } = await params;

  try {
    const { data: project } = await getProject(id);
    return {
      title: project
        ? `Manage Teams - ${project.name} | ${APP_NAME}`
        : `Manage Project Teams | ${APP_NAME}`,
      description: "Manage teams for this project",
    };
  } catch (error) {
    console.error("Error generating metadata:", error);
    return {
      title: `Manage Project Teams | ${APP_NAME}`,
      description: "Manage teams for this project",
    };
  }
}

export default async function ProjectTeamsPage({ params }: Props) {
  // Safely access params
  const { id: projectId } = await params;

  // Get the current user session
  const session = await getServerSession();
  const userId = session?.user?.id;

  if (!userId) {
    return (
      <DashboardLayout>
        <Card className="border-destructive">
          <CardHeader>
            <CardTitle>Authentication Required</CardTitle>
            <CardDescription>
              You must be logged in to view this page.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Button asChild>
              <Link href="/auth/login">Log In</Link>
            </Button>
          </CardContent>
        </Card>
      </DashboardLayout>
    );
  }

  try {
    // Get project details
    const { data: project, error: projectError } = await getProject(projectId);

    if (projectError || !project) {
      console.error("Error fetching project:", projectError);
      notFound();
    }

    // Check if current user is the project owner
    const isOwner = project.owner_id === userId;
    if (!isOwner) {
      return (
        <DashboardLayout>
          <div className="mb-4">
            <Button variant="outline" size="sm" asChild>
              <Link href={`/projects/${projectId}`}>
                <ArrowLeft className="h-4 w-4 mr-2" />
                Back to Project
              </Link>
            </Button>
          </div>
          <Card className="border-destructive">
            <CardHeader>
              <CardTitle>Permission Denied</CardTitle>
              <CardDescription>
                Only the project owner can manage teams for this project.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p>
                You need to be the owner of this project to manage team assignments.
                Please contact the project owner if you need to make changes.
              </p>
            </CardContent>
          </Card>
        </DashboardLayout>
      );
    }

    // Get teams assigned to this project
    const { data: assignedTeams } = await getProjectTeams(projectId);

    // Get teams the current user belongs to (potential teams to assign)
    const { data: userTeams } = await getUserTeams(userId);

    // Filter out teams that are already assigned
    const assignedTeamIds = assignedTeams.map(team => team.id);
    const availableTeams = userTeams.filter(team => !assignedTeamIds.includes(team.id));

    return (
      <DashboardLayout>
        <div className="space-y-6">
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
            <div>
              <div className="flex items-center gap-2">
                <Button variant="outline" size="sm" asChild className="mb-2">
                  <Link href={`/projects/${projectId}`}>
                    <ArrowLeft className="h-4 w-4 mr-2" />
                    Back to Project
                  </Link>
                </Button>
              </div>
              <h1 className="text-3xl font-bold">Manage Teams</h1>
              <p className="text-gray-600 mt-1">
                Assign teams to {project.name} to give team members access
              </p>
            </div>
          </div>

          <Card>
            <CardHeader>
              <CardTitle>Project Teams</CardTitle>
              <CardDescription>
                Manage which teams have access to this project
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ProjectTeamsManagement
                projectId={projectId}
                projectName={project.name}
                assignedTeams={assignedTeams}
                availableTeams={availableTeams}
              />
            </CardContent>
          </Card>
        </div>
      </DashboardLayout>
    );
  } catch (error) {
    console.error("Error in ProjectTeamsPage:", error);
    return (
      <DashboardLayout>
        <div className="space-y-6">
          <div className="bg-red-100 p-6 rounded-lg">
            <h1 className="text-2xl font-bold text-red-800 mb-4">
              Error Loading Project Teams
            </h1>
            <p className="mb-4">
              There was an error loading the project teams.
            </p>
            <p className="font-mono text-sm bg-white p-4 rounded mb-4 overflow-auto">
              {error instanceof Error
                ? error.message
                : "Unknown error occurred"}
            </p>
            <div className="flex gap-4">
              <Button variant="outline" asChild>
                <Link href={`/projects/${projectId}`}>Back to Project</Link>
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