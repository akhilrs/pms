import { Metadata } from 'next';
import Link from 'next/link';
import { PlusCircle } from 'lucide-react';
import { DashboardLayout } from '@/components/common/layout';
import { Button } from '@/components/ui/button';
import { ProjectList } from '@/components/projects/project-list';
import { getUserProjects } from '@/lib/supabase/projects';
import { createClient } from '@/lib/supabase/client';

export const metadata: Metadata = {
  title: 'Projects | Basecamp Clone',
  description: 'Manage your projects',
};

export default async function ProjectsPage() {
  const supabase = createClient();
  
  // Get current user
  const { data: { session } } = await supabase.auth.getSession();
  const userId = session?.user?.id;
  
  // Get user projects
  const { data: projects = [] } = userId 
    ? await getUserProjects(userId)
    : { data: [] };

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

        <ProjectList projects={projects} />
      </div>
    </DashboardLayout>
  );
} 