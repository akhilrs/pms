import { Metadata } from 'next';
import Link from 'next/link';
import { DashboardLayout } from '@/components/common/layout';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { BarChart, CheckSquare, Clock, PlusCircle, Users } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { ProjectCard } from '@/components/projects/project-card';
import { getUserProjects } from '@/lib/supabase/projects';
import { createClient } from '@/lib/supabase/client';
import { Badge } from '@/components/ui/badge';

export const metadata: Metadata = {
  title: 'Dashboard | Basecamp Clone',
  description: 'Project management dashboard',
};

export default async function DashboardPage() {
  const supabase = createClient();
  
  // Get current user
  const { data: { session } } = await supabase.auth.getSession();
  const userId = session?.user?.id;
  
  // Get user projects
  const { data: projects = [] } = userId 
    ? await getUserProjects(userId)
    : { data: [] };

  // Get stats
  const totalProjects = projects.length;
  const activeProjects = projects.filter(p => p.status === 'In Progress').length;
  
  // Get recent projects (last 3)
  const recentProjects = projects.slice(0, 3);

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <h1 className="text-3xl font-bold">Welcome to Basecamp Clone</h1>
        <p className="text-gray-600">
          Your project management hub. Get started by creating a new project or checking your tasks.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between pb-2 space-y-0">
              <CardTitle className="text-sm font-medium">Total Projects</CardTitle>
              <BarChart className="h-4 w-4 text-gray-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalProjects}</div>
              <p className="text-xs text-gray-500">{activeProjects} active projects</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="flex flex-row items-center justify-between pb-2 space-y-0">
              <CardTitle className="text-sm font-medium">Tasks</CardTitle>
              <CheckSquare className="h-4 w-4 text-gray-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">0</div>
              <p className="text-xs text-gray-500">Pending tasks</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="flex flex-row items-center justify-between pb-2 space-y-0">
              <CardTitle className="text-sm font-medium">Team Members</CardTitle>
              <Users className="h-4 w-4 text-gray-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">1</div>
              <p className="text-xs text-gray-500">Active members</p>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="flex flex-row items-center justify-between pb-2 space-y-0">
              <CardTitle className="text-sm font-medium">Upcoming Deadlines</CardTitle>
              <Clock className="h-4 w-4 text-gray-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">0</div>
              <p className="text-xs text-gray-500">Due this week</p>
            </CardContent>
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card>
            <CardHeader className="flex justify-between items-center">
              <div>
                <CardTitle>Recent Projects</CardTitle>
                <CardDescription>Your recently updated projects</CardDescription>
              </div>
              <Button asChild size="sm">
                <Link href="/projects/new">
                  <PlusCircle className="h-4 w-4 mr-2" />
                  New Project
                </Link>
              </Button>
            </CardHeader>
            <CardContent>
              {recentProjects.length > 0 ? (
                <div className="space-y-4">
                  {recentProjects.map((project) => (
                    <div key={project.id} className="border rounded-lg p-4 hover:bg-gray-50">
                      <Link href={`/projects/${project.id}`} className="block">
                        <div className="flex justify-between items-start">
                          <div>
                            <h3 className="font-medium">{project.name}</h3>
                            <p className="text-sm text-gray-500 line-clamp-1">
                              {project.description || 'No description provided'}
                            </p>
                          </div>
                          <Badge variant="outline" className={getStatusColor(project.status)}>
                            {project.status}
                          </Badge>
                        </div>
                      </Link>
                    </div>
                  ))}
                  <div className="pt-2">
                    <Button variant="outline" asChild className="w-full">
                      <Link href="/projects">View All Projects</Link>
                    </Button>
                  </div>
                </div>
              ) : (
                <div className="text-center py-6 text-gray-500">
                  <p>No recent projects</p>
                  <p className="text-sm mt-2">
                    Create a new project to get started
                  </p>
                  <Button className="mt-4" asChild>
                    <Link href="/projects/new">
                      <PlusCircle className="h-4 w-4 mr-2" />
                      Create Project
                    </Link>
                  </Button>
                </div>
              )}
            </CardContent>
          </Card>
          <Card>
            <CardHeader>
              <CardTitle>My Tasks</CardTitle>
              <CardDescription>Tasks assigned to you</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-6 text-gray-500">
                <p>No tasks assigned</p>
                <p className="text-sm mt-2">
                  Tasks assigned to you will appear here
                </p>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}

// Helper function to get the appropriate status color
function getStatusColor(status: string): string {
  switch (status) {
    case 'Planning':
      return 'bg-blue-50 text-blue-700 border-blue-300';
    case 'In Progress':
      return 'bg-green-50 text-green-700 border-green-300';
    case 'On Hold':
      return 'bg-amber-50 text-amber-700 border-amber-300';
    case 'Completed':
      return 'bg-purple-50 text-purple-700 border-purple-300';
    case 'Canceled':
      return 'bg-red-50 text-red-700 border-red-300';
    default:
      return 'bg-gray-50 text-gray-700 border-gray-300';
  }
} 