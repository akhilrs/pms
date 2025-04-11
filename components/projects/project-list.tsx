import { PlusCircle } from 'lucide-react';
import Link from 'next/link';
import { ProjectCard } from './project-card';
import { Button } from '@/components/ui/button';
import type { ProjectWithDetails } from '@/lib/supabase/projects';

interface ProjectListProps {
  projects: ProjectWithDetails[];
  isLoading?: boolean;
}

export function ProjectList({ projects, isLoading = false }: ProjectListProps) {
  if (isLoading) {
    return (
      <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
        {Array.from({ length: 6 }).map((_, index) => (
          <div key={index} className="h-64 animate-pulse bg-gray-100 rounded-lg"></div>
        ))}
      </div>
    );
  }

  if (projects.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-16 border-2 border-dashed rounded-lg bg-gray-50/50">
        <div className="bg-primary/10 p-4 rounded-full mb-4">
          <PlusCircle className="h-10 w-10 text-primary" />
        </div>
        <h3 className="text-xl font-medium text-gray-900 mb-2">No projects yet</h3>
        <p className="text-gray-500 mb-6 max-w-md text-center">
          Create your first project to get started with project management and collaboration.
        </p>
        <Button size="lg" className="shadow-md hover:shadow-lg transition-all" asChild>
          <Link href="/projects/new">
            <PlusCircle className="h-4 w-4 mr-2" />
            Create Your First Project
          </Link>
        </Button>
      </div>
    );
  }

  return (
    <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
      {projects.map((project) => (
        <ProjectCard key={project.id} project={project} />
      ))}
    </div>
  );
} 