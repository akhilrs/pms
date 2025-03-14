import Link from 'next/link';
import { format } from 'date-fns';
import { Calendar, Clock, Users } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import type { ProjectWithDetails } from '@/lib/supabase/projects';

interface ProjectCardProps {
  project: ProjectWithDetails;
}

export function ProjectCard({ project }: ProjectCardProps) {
  // Calculate days remaining if end date exists
  const daysRemaining = project.end_date
    ? Math.ceil((new Date(project.end_date).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24))
    : null;

  // Get project status color
  const statusColor = getStatusColor(project.status);

  // Format members for display
  const memberCount = project.members ? project.members.length : 0;

  return (
    <Link href={`/projects/${project.id}`} className="block">
      <Card className="h-full hover:shadow-md transition-shadow">
        <CardHeader className="pb-2">
          <div className="flex justify-between items-start">
            <CardTitle className="text-xl truncate">{project.name}</CardTitle>
            <Badge variant="outline" className={statusColor}>
              {project.status}
            </Badge>
          </div>
        </CardHeader>
        <CardContent>
          <div className="line-clamp-2 text-sm text-gray-500 mb-4 h-10">
            {project.description || 'No description provided'}
          </div>
          
          <div className="flex flex-col space-y-2">
            <div className="flex items-center text-sm text-gray-500">
              <Calendar className="h-4 w-4 mr-2" />
              <span>Started: {format(new Date(project.start_date), 'PPP')}</span>
            </div>
            
            {project.end_date && (
              <div className="flex items-center text-sm text-gray-500">
                <Clock className="h-4 w-4 mr-2" />
                <span>
                  {daysRemaining && daysRemaining > 0
                    ? `${daysRemaining} day${daysRemaining !== 1 ? 's' : ''} remaining`
                    : daysRemaining === 0
                    ? 'Due today'
                    : `Overdue by ${Math.abs(daysRemaining)} day${Math.abs(daysRemaining) !== 1 ? 's' : ''}`}
                </span>
              </div>
            )}
            
            <div className="flex items-center text-sm text-gray-500">
              <Users className="h-4 w-4 mr-2" />
              <span>{memberCount} member{memberCount !== 1 ? 's' : ''}</span>
            </div>
          </div>
        </CardContent>
        <CardFooter className="pt-2 border-t">
          <div className="flex items-center w-full">
            <div className="flex items-center">
              <Avatar className="h-6 w-6 mr-2">
                <AvatarImage 
                  src={project.owner?.avatar_url || undefined} 
                  alt={`${project.owner?.first_name || ''} ${project.owner?.last_name || ''}`.trim()} 
                />
                <AvatarFallback>
                  {getInitials(`${project.owner?.first_name || ''} ${project.owner?.last_name || ''}`.trim())}
                </AvatarFallback>
              </Avatar>
              <span className="text-xs text-gray-500">
                {project.owner 
                  ? `${project.owner.first_name || ''} ${project.owner.last_name || ''}`.trim() || 'Unknown User'
                  : 'Unknown User'}
              </span>
            </div>
            <span className="text-xs text-gray-400 ml-auto">
              Created {format(new Date(project.created_at), 'PPP')}
            </span>
          </div>
        </CardFooter>
      </Card>
    </Link>
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

// Helper function to get initials from name
function getInitials(name: string): string {
  if (!name) return '?';
  
  return name
    .split(' ')
    .map(part => part[0])
    .join('')
    .toUpperCase()
    .substring(0, 2);
} 