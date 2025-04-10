'use client';

import { useState } from 'react';
import { toast } from 'sonner';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { FolderPlus, MoreHorizontal, Folder } from 'lucide-react';
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
import { Form, FormControl, FormField, FormItem, FormMessage } from '@/components/ui/form';
import { Badge } from '@/components/ui/badge';
import type { TeamWithDetails } from '@/lib/supabase/teams';

interface TeamProjectsProps {
  team: TeamWithDetails;
  canManage: boolean;
  userId: string;
  availableProjects: { id: string; name: string }[];
  onAssignProject: (projectId: string) => Promise<{ success: boolean; error?: string }>;
  onRemoveProject: (projectId: string) => Promise<{ success: boolean; error?: string }>;
}

// Schema for adding a project to a team
const assignProjectSchema = z.object({
  projectId: z.string().min(1, 'Please select a project'),
});

export function TeamProjects({
  team,
  canManage,
  userId,
  availableProjects,
  onAssignProject,
  onRemoveProject,
}: TeamProjectsProps) {
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);

  // Form for assigning a project
  const form = useForm<z.infer<typeof assignProjectSchema>>({
    resolver: zodResolver(assignProjectSchema),
    defaultValues: {
      projectId: '',
    },
  });

  // Handle assign project
  const handleAssignProject = async (values: z.infer<typeof assignProjectSchema>) => {
    setIsProcessing(true);
    try {
      const result = await onAssignProject(values.projectId);
      if (result.success) {
        toast.success('Project assigned to team successfully');
        setIsDialogOpen(false);
        form.reset();
      } else {
        toast.error(result.error || 'Failed to assign project');
      }
    } catch (error) {
      console.error('Error assigning project:', error);
      toast.error('Something went wrong trying to assign the project');
    } finally {
      setIsProcessing(false);
    }
  };

  // Handle remove project
  const handleRemoveProject = async (projectId: string) => {
    if (!confirm('Are you sure you want to remove this project from the team?')) {
      return;
    }

    setIsProcessing(true);
    try {
      const result = await onRemoveProject(projectId);
      if (result.success) {
        toast.success('Project removed from team successfully');
      } else {
        toast.error(result.error || 'Failed to remove project');
      }
    } catch (error) {
      console.error('Error removing project:', error);
      toast.error('Something went wrong trying to remove the project');
    } finally {
      setIsProcessing(false);
    }
  };

  // Filter out projects that are already assigned to the team
  const filteredAvailableProjects = availableProjects.filter(
    (project) => !team.projects.some((p) => p.id === project.id)
  );

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h3 className="text-lg font-medium">Team Projects</h3>
        {canManage && filteredAvailableProjects.length > 0 && (
          <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
            <DialogTrigger asChild>
              <Button size="sm">
                <FolderPlus className="h-4 w-4 mr-2" />
                Assign Project
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Assign Project to Team</DialogTitle>
                <DialogDescription>
                  Select a project to assign to this team. All team members will gain access to the project.
                </DialogDescription>
              </DialogHeader>
              <Form {...form}>
                <form onSubmit={form.handleSubmit(handleAssignProject)} className="space-y-4">
                  <FormField
                    control={form.control}
                    name="projectId"
                    render={({ field }) => (
                      <FormItem>
                        <Select 
                          onValueChange={field.onChange} 
                          defaultValue={field.value}
                        >
                          <SelectTrigger>
                            <SelectValue placeholder="Select a project" />
                          </SelectTrigger>
                          <SelectContent>
                            {filteredAvailableProjects.map((project) => (
                              <SelectItem key={project.id} value={project.id}>
                                {project.name}
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
                      {isProcessing ? 'Assigning...' : 'Assign Project'}
                    </Button>
                  </DialogFooter>
                </form>
              </Form>
            </DialogContent>
          </Dialog>
        )}
      </div>

      {team.projects.length === 0 ? (
        <div className="text-center py-12 border rounded-lg bg-gray-50">
          <p className="text-gray-500">
            No projects assigned to this team yet.
          </p>
          {canManage && (
            <Button 
              onClick={() => setIsDialogOpen(true)} 
              variant="outline" 
              className="mt-4"
              disabled={filteredAvailableProjects.length === 0}
            >
              <FolderPlus className="h-4 w-4 mr-2" />
              Assign Project
            </Button>
          )}
        </div>
      ) : (
        <div className="border rounded-lg overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Project</TableHead>
                <TableHead className="w-[100px]">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {team.projects.map((project) => (
                <TableRow key={project.id}>
                  <TableCell className="flex items-center space-x-3">
                    <Folder className="h-5 w-5 text-blue-500" />
                    <div>
                      <Link href={`/projects/${project.id}`} className="font-medium hover:underline">
                        {project.name}
                      </Link>
                    </div>
                  </TableCell>
                  <TableCell>
                    {canManage && (
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
                            <Link href={`/projects/${project.id}`}>
                              View Project
                            </Link>
                          </DropdownMenuItem>
                          <DropdownMenuItem 
                            onClick={() => handleRemoveProject(project.id)}
                            disabled={isProcessing}
                            className="text-red-600"
                          >
                            Remove from Team
                          </DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    )}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      )}
    </div>
  );
}