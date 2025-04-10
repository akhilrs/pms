'use client';

import Link from 'next/link';
import { format } from 'date-fns';
import { Users, FolderKanban } from 'lucide-react';
import { Card, CardContent, CardFooter } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import type { TeamWithDetails } from '@/lib/supabase/teams';

interface TeamCardProps {
  team: TeamWithDetails;
}

export function TeamCard({ team }: TeamCardProps) {
  // Format date nicely
  const formattedDate = format(new Date(team.created_at), 'MMM d, yyyy');
  
  // Get first 3 members for display - ensure we handle empty/undefined members
  const displayMembers = team.members?.slice?.(0, 3) || [];
  
  // Handle cases where _count might not be available
  const memberCount = team._count?.members || team.members?.length || 0;
  const additionalMembers = Math.max(0, memberCount - displayMembers.length);

  // Get initials for avatar fallback
  const getInitials = (name: string | null): string => {
    if (!name) return "T";
    return name.substring(0, 1).toUpperCase();
  };

  const teamInitials = getInitials(team.name);
  
  // Ensure team has the properties we need to avoid errors
  const safeTeam = {
    ...team,
    name: team.name || 'Unnamed Team',
    description: team.description || '',
    avatar_url: team.avatar_url || undefined,
    members: team.members || [],
    _count: team._count || { members: 0, projects: 0 }
  };

  return (
    <Card className="overflow-hidden hover:shadow-md transition-shadow">
      <Link href={`/teams/${team.id}`} className="block">
        <div className="bg-blue-50 p-4 border-b">
          <div className="flex items-center space-x-3">
            <Avatar className="h-10 w-10 bg-blue-100">
              <AvatarImage src={safeTeam.avatar_url} alt={safeTeam.name} />
              <AvatarFallback className="bg-blue-500 text-white">
                {teamInitials}
              </AvatarFallback>
            </Avatar>
            <div>
              <h3 className="font-medium text-lg">{safeTeam.name}</h3>
              <p className="text-xs text-gray-500">Created {formattedDate}</p>
            </div>
          </div>
        </div>
      </Link>
      
      <CardContent className="pt-4">
        <p className="text-sm text-gray-700 mb-4 line-clamp-2 min-h-[40px]">
          {safeTeam.description || "No description provided"}
        </p>
        
        <div className="flex items-center justify-between text-sm text-gray-500 mb-2">
          <div className="flex items-center">
            <Users className="h-4 w-4 mr-1" />
            <span>{memberCount} member{memberCount !== 1 ? 's' : ''}</span>
          </div>
          <div className="flex items-center">
            <FolderKanban className="h-4 w-4 mr-1" />
            <span>{safeTeam._count?.projects || 0} project{(safeTeam._count?.projects || 0) !== 1 ? 's' : ''}</span>
          </div>
        </div>
        
        {displayMembers.length > 0 && (
          <div className="flex -space-x-2">
            {displayMembers.map((member) => (
              <Avatar key={member.id || Math.random().toString()} className="h-8 w-8 border-2 border-white">
                <AvatarImage 
                  src={member.user?.avatar_url || undefined} 
                  alt={`${member.user?.first_name || ''} ${member.user?.last_name || ''}`.trim()} 
                />
                <AvatarFallback className="bg-gray-200 text-gray-600 text-xs">
                  {getInitials(`${member.user?.first_name || ''}`)}
                </AvatarFallback>
              </Avatar>
            ))}
            
            {additionalMembers > 0 && (
              <div className="h-8 w-8 rounded-full bg-gray-100 border-2 border-white flex items-center justify-center text-xs text-gray-600">
                +{additionalMembers}
              </div>
            )}
          </div>
        )}
      </CardContent>
      
      <CardFooter className="bg-gray-50 flex justify-end pt-2 pb-2">
        <Button variant="ghost" asChild size="sm">
          <Link href={`/teams/${team.id}`}>
            View Details
          </Link>
        </Button>
      </CardFooter>
    </Card>
  );
}