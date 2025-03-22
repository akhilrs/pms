// app/projects/page.tsx
import { Metadata } from "next";
import Link from "next/link";
import { PlusCircle } from "lucide-react";
import { DashboardLayout } from "@/components/common";
import { Button } from "@/components/ui/button";
import { ProjectList } from "@/components/projects/project-list";
import { getUserProjects } from "@/lib/supabase/projects";
import { getUser } from "@/lib/supabase/auth-helpers";

export const metadata: Metadata = {
  title: "Projects | Basecamp Clone",
  description: "Manage your projects",
};

export default async function ProjectsPage() {
  // Get authenticated user using Supabase auth
  const user = await getUser();
  const userId = user?.id;

  console.log(
    "Projects page - Auth check:",
    userId ? `Authenticated as ${userId}` : "Not authenticated",
  );

  // Fetch projects if user is authenticated
  let projects = [];
  let error = null;

  if (userId) {
    try {
      const result = await getUserProjects(userId);
      projects = result.data || [];
      error = result.error;

      console.log(`Found ${projects.length} projects for user ${userId}`);
    } catch (fetchError) {
      console.error("Error fetching projects:", fetchError);
      error = { message: "Failed to fetch projects. Please try again." };
    }
  }

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">Projects</h1>
            <p className="text-gray-600">Manage and organize your projects</p>
          </div>
          <Button asChild>
            <Link href="/projects/new">
              <PlusCircle className="h-4 w-4 mr-2" />
              New Project
            </Link>
          </Button>
        </div>

        {!userId ? (
          <div className="bg-yellow-100 p-4 rounded-md mb-4">
            <p className="font-semibold">Authentication Required</p>
            <p className="text-sm text-gray-700 mt-1">
              Please sign in to view your projects
            </p>
            <Button className="mt-3" asChild>
              <Link href="/auth/login">Sign In</Link>
            </Button>
          </div>
        ) : projects.length === 0 && !error ? (
          <div className="bg-blue-50 p-4 rounded-md mb-4">
            <p className="font-semibold">No Projects Found</p>
            <p className="text-sm text-gray-700 mt-1">
              Create your first project to get started
            </p>
            <Button className="mt-3" asChild>
              <Link href="/projects/new">Create Project</Link>
            </Button>
          </div>
        ) : null}

        {error && (
          <div className="bg-red-100 p-4 rounded-md mb-4">
            <p className="text-red-600 font-semibold">Error Loading Projects</p>
            <p className="text-sm text-red-700 mt-1">{error.message}</p>
          </div>
        )}

        {/* Debug information panel */}
        <div className="bg-gray-100 p-4 rounded-md mb-4 text-sm">
          <p>
            <strong>Debug Info:</strong>
          </p>
          <p>User ID: {userId || "Not logged in"}</p>
          <p>Projects count: {projects?.length || 0}</p>
        </div>

        {projects.length > 0 && <ProjectList projects={projects} />}
      </div>
    </DashboardLayout>
  );
}

