import { Metadata } from 'next';
import { DashboardLayout } from '@/components/common/layout';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { ProjectForm } from '@/components/projects/project-form';
import { createProjectAction } from '../actions';

export const metadata: Metadata = {
  title: 'Create Project | Basecamp Clone',
  description: 'Create a new project',
};

export default function NewProjectPage() {
  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <Card>
          <CardHeader>
            <CardTitle>Create New Project</CardTitle>
            <CardDescription>
              Fill out the form below to create a new project.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <ProjectForm onSubmit={createProjectAction} />
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
} 