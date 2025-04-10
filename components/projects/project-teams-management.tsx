'use client';

import { useState } from 'react';
import { toast } from 'sonner';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Users, MoreHorizontal, UserPlus } from 'lucide-react';
import Link from 'next/link';
import { 
  Table, 
  TableBody, 
  TableCell, 
  TableHead, 
  TableHeader, 
  TableRow 
} from '@/components/ui/table';
import { Button } from '@/components/ui/button';
import { 
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Form, FormField, FormItem, FormMessage } from '@/components/ui/form';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { assignTeamToProject, removeTeamFromProject } from '@/app/teams/actions';

// Team type definitions from our existing components
type TeamMember = {
  id: string;
  user_id: string;
  team_id: string;
  role: 'owner' | 'admin' | 'member';
  created_at: string;
  user?: {
    id: string;
    email?: string;
    first_name?: string;
    last_name?: string;
    avatar_url?: string;
  };
};

type Team = {
  id: string;
  name: string;
  description?: string;
  avatar_url?: string;
  created_at: string;
  updated_at?: string;
  created_by: string;
  members?: TeamMember[];
  memberCount?: number;
};

interface ProjectTeamsManagementProps {
  projectId: string;
  projectName: string;
  assignedTeams: Team[];
  availableTeams: Team[];
}

// Schema for assigning a team
const assignTeamSchema = z.object({
  teamId: z.string().min(1, 'Please select a team'),
});

export function ProjectTeamsManagement({
  projectId,
  projectName,
  assignedTeams,
  availableTeams,
}: ProjectTeamsManagementProps) {
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);

  // Form for assigning a team
  const form = useForm<z.infer<typeof assignTeamSchema>>({
    resolver: zodResolver(assignTeamSchema),
    defaultValues: {
      teamId: '',
    },
  });

  // Handle assign team to project
  const handleAssignTeam = async (values: z.infer<typeof assignTeamSchema>) => {
    setIsProcessing(true);
    try {
      const result = await assignTeamToProject(values.teamId, projectId);
      if (result.success) {
        toast.success('Team assigned to project successfully');
        setIsDialogOpen(false);
        form.reset();
        // Force a page refresh to show updated data
        window.location.reload();
      } else {
        toast.error(result.error || 'Failed to assign team');
      }
    } catch (error) {
      console.error('Error assigning team:', error);
      toast.error('Something went wrong trying to assign the team');
    } finally {
      setIsProcessing(false);
    }
  };

  // Handle remove team from project
  const handleRemoveTeam = async (teamId: string) => {
    if (!confirm('Are you sure you want to remove this team from the project?')) {
      return;
    }

    setIsProcessing(true);
    try {
      const result = await removeTeamFromProject(teamId, projectId);
      if (result.success) {
        toast.success('Team removed from project successfully');
        // Force a page refresh to show updated data
        window.location.reload();
      } else {
        toast.error(result.error || 'Failed to remove team');
      }
    } catch (error) {
      console.error('Error removing team:', error);
      toast.error('Something went wrong trying to remove the team');
    } finally {
      setIsProcessing(false);
    }
  };

  // Helper function to get initials from name
  const getInitials = (name: string): string => {
    if (!name) return "?";

    return name
      .split(" ")
      .map((part) => part[0])
      .join("")
      .toUpperCase()
      .substring(0, 2);
  };

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h3 className="text-lg font-medium">Teams with Access to {projectName}</h3>
        {availableTeams.length > 0 && (
          <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
            <DialogTrigger asChild>
              <Button size="sm">
                <UserPlus className="h-4 w-4 mr-2" />
                Assign Team
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Assign Team to Project</DialogTitle>
                <DialogDescription>
                  Select a team to assign to this project. All team members will gain access to the project.
                </DialogDescription>
              </DialogHeader>
              <Form {...form}>
                <form onSubmit={form.handleSubmit(handleAssignTeam)} className="space-y-4">
                  <FormField
                    control={form.control}
                    name="teamId"
                    render={({ field }) => (
                      <FormItem>
                        <Select 
                          onValueChange={field.onChange} 
                          defaultValue={field.value}
                        >
                          <SelectTrigger>
                            <SelectValue placeholder="Select a team" />
                          </SelectTrigger>
                          <SelectContent>
                            {availableTeams.map((team) => (
                              <SelectItem key={team.id} value={team.id}>
                                {team.name}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <DialogFooter>
                    <Button 
                      variant="outline" 
                      type="button" 
                      onClick={() => setIsDialogOpen(false)}
                      disabled={isProcessing}
                    >
                      Cancel
                    </Button>
                    <Button type="submit" disabled={isProcessing}>
                      {isProcessing ? 'Assigning...' : 'Assign Team'}
                    </Button>
                  </DialogFooter>
                </form>
              </Form>
            </DialogContent>
          </Dialog>
        )}
      </div>

      {assignedTeams.length === 0 ? (
        <div className="text-center py-12 border rounded-lg bg-gray-50">
          <Users className="h-12 w-12 mx-auto text-gray-400" />
          <p className="text-gray-500 mt-4">
            No teams are assigned to this project yet.
          </p>
          {availableTeams.length > 0 ? (
            <Button 
              onClick={() => setIsDialogOpen(true)} 
              variant="outline" 
              className="mt-4"
            >
              <UserPlus className="h-4 w-4 mr-2" />
              Assign Team
            </Button>
          ) : (
            <div className="mt-4 text-sm text-gray-500">
              <p>You don&apos;t have any teams available to assign.</p>
              <Button variant="link" className="p-0 h-auto" asChild>
                <Link href="/teams/new">Create a Team</Link>
              </Button>
            </div>
          )}
        </div>
      ) : (
        <div className="border rounded-lg overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Team</TableHead>
                <TableHead>Members</TableHead>
                <TableHead className="w-[100px]">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {assignedTeams.map((team) => (
                <TableRow key={team.id}>
                  <TableCell className="flex items-center space-x-3">
                    <Avatar className="h-8 w-8">
                      <AvatarImage 
                        src={team.avatar_url || undefined} 
                        alt={team.name}
                      />
                      <AvatarFallback>
                        {getInitials(team.name)}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <Link href={`/teams/${team.id}`} className="font-medium hover:underline">
                        {team.name}
                      </Link>
                      {team.description && (
                        <p className="text-xs text-gray-500 truncate max-w-md">
                          {team.description}
                        </p>
                      )}
                    </div>
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center">
                      <div className="flex -space-x-2 mr-2">
                        {team.members && team.members.length > 0 ? (
                          team.members.slice(0, 3).map((member) => (
                            <Avatar key={member.id} className="h-6 w-6 border-2 border-white">
                              <AvatarImage
                                src={member.user?.avatar_url || undefined}
                                alt={`${member.user?.first_name || ""} ${member.user?.last_name || ""}`.trim()}
                              />
                              <AvatarFallback>
                                {getInitials(
                                  `${member.user?.first_name || ""} ${member.user?.last_name || ""}`.trim(),
                                )}
                              </AvatarFallback>
                            </Avatar>
                          ))
                        ) : null}
                      </div>
                      <span className="text-xs text-gray-500">
                        {team.memberCount || team.members?.length || 0} members
                      </span>
                    </div>
                  </TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="sm">
                          <MoreHorizontal className="h-4 w-4" />
                          <span className="sr-only">Open menu</span>
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuLabel>Actions</DropdownMenuLabel>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem asChild>
                          <Link href={`/teams/${team.id}`}>
                            View Team
                          </Link>
                        </DropdownMenuItem>
                        <DropdownMenuItem 
                          onClick={() => handleRemoveTeam(team.id)}
                          disabled={isProcessing}
                          className="text-red-600"
                        >
                          Remove from Project
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      )}

      {availableTeams.length > 0 && assignedTeams.length > 0 && (
        <div className="flex justify-end mt-4">
          <Button 
            onClick={() => setIsDialogOpen(true)} 
            size="sm"
            disabled={isProcessing}
          >
            <UserPlus className="h-4 w-4 mr-2" />
            Assign Another Team
          </Button>
        </div>
      )}
    </div>
  );
}