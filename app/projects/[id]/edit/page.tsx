import { Metadata } from "next";
import { notFound } from "next/navigation";
import { DashboardLayout } from "@/components/common";
import { EditProjectForm } from "@/components/projects/edit-project-form";
import { getProject } from "@/lib/supabase/projects";
import { getServerSession } from "@/lib/supabase/server-auth";

type Props = {
  params: Promise<{
    id: string;
  }>;
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  try {
    const { id } = await params;
    const { data: project } = await getProject(id);
    return {
      title: `Edit ${project?.name} | Basecamp`,
      description: `Edit project details for ${project?.name}`,
    };
  } catch (error) {
    return {
      title: "Edit Project | Basecamp",
      description: "Edit project details",
    };
  }
}

export default async function EditProjectPage({ params }: Props) {
  try {
    const { id } = await params;
    const { data: project } = await getProject(id);
    const session = await getServerSession();

    const userId = session?.user?.id;

    console.log("Edit page - User authenticated: ", userId);
    if (!project) {
      notFound();
    }

    const initialData = {
      name: project.name,
      description: project.description || "",
      status: project.status,
      start_date: project.start_date ? new Date(project.start_date) : undefined,
      end_date: project.end_date ? new Date(project.end_date) : undefined,
    };

    return (
      <DashboardLayout>
        <div className="max-w-3xl mx-auto">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200">
            <div className="p-6">
              <h1 className="text-2xl font-bold">Edit Project</h1>
              <p className="text-gray-600 mb-6">
                Update the details of your project
              </p>
              <EditProjectForm projectId={id} initialData={initialData} />
            </div>
          </div>
        </div>
      </DashboardLayout>
    );
  } catch (error) {
    console.error("Error loading project:", error);
    return (
      <DashboardLayout>
        <div className="max-w-3xl mx-auto">
          <div className="bg-white rounded-lg shadow-sm border border-gray-200">
            <div className="p-6">
              <h1 className="text-2xl font-bold">Edit Project</h1>
              <p className="text-gray-600 mb-6">
                Update the details of your project
              </p>
              <div className="bg-red-100 p-4 rounded-md">
                <p className="text-red-600 font-semibold">
                  {error instanceof Error
                    ? error.message
                    : "Failed to load project"}
                </p>
              </div>
            </div>
          </div>
        </div>
      </DashboardLayout>
    );
  }
}
