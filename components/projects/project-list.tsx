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
      <div className="text-center py-12 border rounded-lg bg-gray-50">
        <h3 className="text-lg font-medium text-gray-900 mb-2">No projects yet</h3>
        <p className="text-gray-500 mb-6">
          Create your first project to get started with project management.
        </p>
        <Button asChild>
          <Link href="/projects/new">
            <PlusCircle className="h-4 w-4 mr-2" />
            Create Project
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