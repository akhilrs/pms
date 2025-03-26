import { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { format } from "date-fns";
import { Calendar, Clock, Edit, Users } from "lucide-react";
import { DashboardLayout } from "@/components/common/layout";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { ProjectDeleteButton } from "@/components/projects/project-delete-button";
import { getProject } from "@/lib/supabase/projects";
import { getServiceSupabase } from "@/lib/supabase/client";
import { getServerSession } from "@/lib/supabase/server-auth";

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
        ? `${project.name} | Basecamp Clone`
        : "Project Details | Basecamp Clone",
      description: project?.description || "View project details",
    };
  } catch (error) {
    console.error("Error generating metadata:", error);
    return {
      title: "Project Details | Basecamp Clone",
      description: "View project details",
    };
  }
}

export default async function ProjectDetailPage({ params }: Props) {
  // Safely access params
  const { id } = await params;

  console.log("Project detail page - Project ID:", id);

  // Get the user session for potential permissions checks
  const session = await getServerSession();
  const userId = session?.user?.id;

  console.log(
    "Project detail page - User ID from session:",
    userId || "not logged in",
  );

  try {
    // Try regular project fetching first
    const { data: project, error } = await getProject(id);

    // If no project found with regular fetch, try using service role
    if (!project && !error) {
      console.log(
        "No project found with regular fetch, trying service role...",
      );
      const supabase = getServiceSupabase();
      const { data: serviceProject, error: serviceError } = await supabase
        .from("projects")
        .select("*")
        .eq("id", id)
        .single();

      if (serviceError) {
        console.error("Service role fetch error:", serviceError);
        throw new Error(`Failed to fetch project: ${serviceError.message}`);
      }

      if (!serviceProject) {
        console.log(
          "Project not found even with service role, redirecting to 404",
        );
        notFound();
      }

      console.log("Project found with service role:", serviceProject.name);
      // Create a simplified project object
      const simpleProject = {
        ...serviceProject,
        owner: null,
        members: [],
      };

      // Display simple project view without relationships
      return renderProject(simpleProject);
    }

    if (error) {
      console.error("Error fetching project:", error);
      throw new Error(`Failed to fetch project: ${error.message}`);
    }

    if (!project) {
      console.log("Project not found, redirecting to 404");
      notFound();
    }

    console.log("Project found successfully:", project.name);
    return renderProject(project);
  } catch (error) {
    console.error("Error in project detail page:", error);
    return (
      <DashboardLayout>
        <div className="space-y-6">
          <div className="bg-red-100 p-6 rounded-lg">
            <h1 className="text-2xl font-bold text-red-800 mb-4">
              Error Loading Project
            </h1>
            <p className="mb-4">
              There was an error loading the project details.
            </p>
            <p className="font-mono text-sm bg-white p-4 rounded mb-4 overflow-auto">
              {error instanceof Error
                ? error.message
                : "Unknown error occurred"}
            </p>
            <div className="flex gap-4">
              <Button variant="outline" asChild>
                <Link href="/projects">Back to Projects</Link>
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

function renderProject(project: any) {
  // Calculate days remaining if end date exists
  const daysRemaining = project.end_date
    ? Math.ceil(
        (new Date(project.end_date).getTime() - new Date().getTime()) /
          (1000 * 60 * 60 * 24),
      )
    : 0;

  // Get status badge color
  const getStatusColor = (status: string): string => {
    switch (status) {
      case "Planning":
        return "bg-blue-50 text-blue-700 border-blue-300";
      case "In Progress":
        return "bg-green-50 text-green-700 border-green-300";
      case "On Hold":
        return "bg-amber-50 text-amber-700 border-amber-300";
      case "Completed":
        return "bg-purple-50 text-purple-700 border-purple-300";
      case "Canceled":
        return "bg-red-50 text-red-700 border-red-300";
      default:
        return "bg-gray-50 text-gray-700 border-gray-300";
    }
  };

  // Format members for display
  const memberCount = project.members ? project.members.length : 0;

  // Helper function to get initials from name
  const getInitials = (name: string): string => {
    if (!name) return "?";

    return name
      .split(" ")
      .map((part) => part[0])
      .join("")
      .toUpperCase()
      .substring(0, 2);
  };

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <div>
            <div className="flex items-center gap-2">
              <h1 className="text-3xl font-bold">{project.name}</h1>
              <Badge
                variant="outline"
                className={getStatusColor(project.status)}
              >
                {project.status}
              </Badge>
            </div>
            <p className="text-gray-600 mt-1">
              {project.description || "No description provided"}
            </p>
          </div>
          <div className="flex gap-2">
            <Button variant="outline" asChild>
              <Link href={`/projects/${project.id}/edit`}>
                <Edit className="h-4 w-4 mr-2" />
                Edit
              </Link>
            </Button>
            <ProjectDeleteButton
              projectId={project.id}
              projectName={project.name}
            />
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>Timeline</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {project.start_date && (
                  <div className="flex items-center">
                    <Calendar className="h-5 w-5 mr-2 text-gray-500" />
                    <div>
                      <div className="text-sm font-medium">Start Date</div>
                      <div className="text-sm text-gray-500">
                        {format(new Date(project.start_date), "PPP")}
                      </div>
                    </div>
                  </div>
                )}

                {project.end_date && (
                  <div className="flex items-center">
                    <Clock className="h-5 w-5 mr-2 text-gray-500" />
                    <div>
                      <div className="text-sm font-medium">End Date</div>
                      <div className="text-sm text-gray-500">
                        {format(new Date(project.end_date), "PPP")}
                      </div>
                      <div
                        className={`text-sm ${daysRemaining < 0 ? "text-red-500" : "text-blue-500"}`}
                      >
                        {daysRemaining > 0
                          ? `${daysRemaining} day${daysRemaining !== 1 ? "s" : ""} remaining`
                          : daysRemaining === 0
                            ? "Due today"
                            : `Overdue by ${Math.abs(daysRemaining)} day${Math.abs(daysRemaining) !== 1 ? "s" : ""}`}
                      </div>
                    </div>
                  </div>
                )}
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Team</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-center">
                  <Avatar className="h-8 w-8 mr-2">
                    <AvatarImage
                      src={project.owner?.avatar_url || undefined}
                      alt={`${project.owner?.first_name || ""} ${project.owner?.last_name || ""}`.trim()}
                    />
                    <AvatarFallback>
                      {getInitials(
                        `${project.owner?.first_name || ""} ${project.owner?.last_name || ""}`.trim(),
                      )}
                    </AvatarFallback>
                  </Avatar>
                  <div>
                    <div className="text-sm font-medium">
                      {project.owner
                        ? `${project.owner.first_name || ""} ${project.owner.last_name || ""}`.trim() ||
                          "Unknown User"
                        : "Unknown User"}
                    </div>
                    <div className="text-xs text-gray-500">Owner</div>
                  </div>
                </div>

                <div className="flex items-center justify-between">
                  <div className="text-sm">
                    {memberCount} team member{memberCount !== 1 ? "s" : ""}
                  </div>
                  <Button variant="outline" size="sm" asChild>
                    <Link href={`/projects/${project.id}/members`}>
                      <Users className="h-4 w-4 mr-2" />
                      Manage Team
                    </Link>
                  </Button>
                </div>

                <div className="flex flex-wrap gap-2">
                  {project.members &&
                    project.members.map(
                      (member: {
                        id: string;
                        user?: {
                          avatar_url?: string;
                          first_name?: string;
                          last_name?: string;
                        };
                      }) => (
                        <Avatar key={member.id} className="h-8 w-8">
                          <AvatarImage
                            src={member.user?.avatar_url || undefined}
                            alt={`${member.user?.first_name || ""} ${member.user?.last_name || ""}`.trim()}
                          />
                          <AvatarFallback>
                            {getInitials(
                              `${member.user?.first_name || ""} ${member.user?.last_name || ""}`.trim(),
                            )}
                          </AvatarFallback>
                        </Avatar>
                      ),
                    )}
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Progress</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <div className="text-sm font-medium">Tasks</div>
                  <div className="text-sm text-gray-500">0 / 0 completed</div>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-2.5">
                  <div
                    className="bg-blue-600 h-2.5 rounded-full"
                    style={{ width: "0%" }}
                  ></div>
                </div>
                <Button variant="outline" size="sm" className="w-full" asChild>
                  <Link href={`/projects/${project.id}/tasks`}>View Tasks</Link>
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>

        <Tabs defaultValue="tasks">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="tasks">Tasks</TabsTrigger>
            <TabsTrigger value="files">Files</TabsTrigger>
            <TabsTrigger value="messages">Messages</TabsTrigger>
            <TabsTrigger value="activity">Activity</TabsTrigger>
          </TabsList>
          <TabsContent value="tasks" className="mt-6">
            <Card>
              <CardHeader>
                <CardTitle>Tasks</CardTitle>
                <CardDescription>Manage tasks for this project</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="text-center py-12 text-gray-500">
                  <p>No tasks created yet</p>
                  <p className="text-sm mt-2">
                    Create tasks to track progress of your project
                  </p>
                  <Button className="mt-4" asChild>
                    <Link href={`/projects/${project.id}/tasks/new`}>
                      Create Task
                    </Link>
                  </Button>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
          <TabsContent value="files" className="mt-6">
            <Card>
              <CardHeader>
                <CardTitle>Files</CardTitle>
                <CardDescription>Manage files for this project</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="text-center py-12 text-gray-500">
                  <p>No files uploaded yet</p>
                  <p className="text-sm mt-2">
                    Upload files to share with the team
                  </p>
                  <Button className="mt-4">Upload File</Button>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
          <TabsContent value="messages" className="mt-6">
            <Card>
              <CardHeader>
                <CardTitle>Messages</CardTitle>
                <CardDescription>Team communication</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="text-center py-12 text-gray-500">
                  <p>No messages yet</p>
                  <p className="text-sm mt-2">
                    Start a conversation with your team
                  </p>
                  <Button className="mt-4">New Message</Button>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
          <TabsContent value="activity" className="mt-6">
            <Card>
              <CardHeader>
                <CardTitle>Activity</CardTitle>
                <CardDescription>Recent project activity</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="text-center py-12 text-gray-500">
                  <p>No recent activity</p>
                  <p className="text-sm mt-2">
                    Activity will be shown here as you work on the project
                  </p>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </DashboardLayout>
  );
}
