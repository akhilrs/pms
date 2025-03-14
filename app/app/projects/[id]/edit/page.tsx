import { Metadata } from 'next';
import { notFound, redirect } from 'next/navigation';
import { DashboardLayout } from '@/components/common/layout';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { ProjectForm, type ProjectFormValues } from '@/components/projects/project-form';
import { getProject } from '@/lib/supabase/projects';
import { updateProjectAction } from '../../actions';

export async function generateMetadata({ params }: { params: { id: string } }): Promise<Metadata> {
  const { data: project } = await getProject(params.id);
  
  return {
    title: project ? `Edit ${project.name} | Basecamp Clone` : 'Edit Project | Basecamp Clone',
    description: 'Edit project details',
  };
}

export default async function EditProjectPage({ params }: { params: { id: string } }) {
  const { data: project } = await getProject(params.id);
  
  if (!project) {
    notFound();
  }

  // Pre-populate form with existing values
  const defaultValues: ProjectFormValues = {
    name: project.name,
    description: project.description || '',
    status: project.status as any,
    start_date: new Date(project.start_date),
    end_date: project.end_date ? new Date(project.end_date) : undefined,
  };

  const handleUpdate = async (formData: ProjectFormValues) => {
    'use server';
    
    return updateProjectAction(params.id, formData);
  };
  
  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <Card>
          <CardHeader>
            <CardTitle>Edit Project: {project.name}</CardTitle>
            <CardDescription>
              Update the project details below.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <ProjectForm 
              defaultValues={defaultValues} 
              onSubmit={handleUpdate}
            />
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
} 