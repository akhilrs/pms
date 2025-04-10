'use client';

import { useState } from 'react';
import { toast } from 'sonner';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { UserPlus, X, Shield, User, MoreHorizontal, Mail } from 'lucide-react';
import { 
  Table, 
  TableBody, 
  TableCell, 
  TableHead, 
  TableHeader, 
  TableRow 
} from '@/components/ui/table';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Form, FormControl, FormField, FormItem, FormMessage } from '@/components/ui/form';
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
import { Badge } from '@/components/ui/badge';
import type { TeamWithDetails, TeamMemberWithProfile } from '@/lib/supabase/teams';

interface TeamMembersProps {
  team: TeamWithDetails;
  isOwner: boolean; // If current user is a team owner
  isAdmin: boolean; // If current user is a team admin
  currentUserId: string;
  onAddMember: (email: string, role: string) => Promise<{ success: boolean; error?: string }>;
  onUpdateMember: (memberId: string, role: string) => Promise<{ success: boolean; error?: string }>;
  onRemoveMember: (memberId: string) => Promise<{ success: boolean; error?: string }>;
  onInviteMember: (email: string, role: string) => Promise<{ success: boolean; error?: string }>;
}

// Schema for adding a member by ID
const addMemberSchema = z.object({
  userId: z.string().min(1, 'User ID is required'),
  role: z.enum(['admin', 'member']),
});

// Schema for inviting a member by email
const inviteMemberSchema = z.object({
  email: z.string().email('Please enter a valid email'),
  role: z.enum(['admin', 'member']),
});

export function TeamMembers({
  team,
  isOwner,
  isAdmin,
  currentUserId,
  onAddMember,
  onUpdateMember,
  onRemoveMember,
  onInviteMember,
}: TeamMembersProps) {
  const [isAddDialogOpen, setIsAddDialogOpen] = useState(false);
  const [isInviteDialogOpen, setIsInviteDialogOpen] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);

  // Role icons mapping
  const roleIcons = {
    owner: <Shield className="h-4 w-4 text-blue-600" />,
    admin: <Shield className="h-4 w-4 text-purple-600" />,
    member: <User className="h-4 w-4 text-gray-600" />,
  };

  // Get member details by userId
  const getMemberDetails = (userId: string) => {
    return team.members.find((m) => m.user_id === userId);
  };

  // Get current user's member details
  const currentMember = getMemberDetails(currentUserId);
  const currentUserRole = currentMember?.role || '';

  // Form for inviting a member by email
  const inviteForm = useForm<z.infer<typeof inviteMemberSchema>>({
    resolver: zodResolver(inviteMemberSchema),
    defaultValues: {
      email: '',
      role: 'member',
    },
  });

  // Form for adding a member by user ID
  const addForm = useForm<z.infer<typeof addMemberSchema>>({
    resolver: zodResolver(addMemberSchema),
    defaultValues: {
      userId: '',
      role: 'member',
    },
  });

  // Handle invite a member
  const handleInvite = async (values: z.infer<typeof inviteMemberSchema>) => {
    setIsProcessing(true);
    try {
      const result = await onInviteMember(values.email, values.role);
      if (result.success) {
        toast.success(`Invitation sent to ${values.email}`);
        setIsInviteDialogOpen(false);
        inviteForm.reset();
      } else {
        toast.error(result.error || 'Failed to send invitation');
      }
    } catch (error) {
      console.error('Error inviting member:', error);
      toast.error('Something went wrong trying to send the invitation');
    } finally {
      setIsProcessing(false);
    }
  };

  // Handle add a member
  const handleAdd = async (values: z.infer<typeof addMemberSchema>) => {
    setIsProcessing(true);
    try {
      const result = await onAddMember(values.userId, values.role);
      if (result.success) {
        toast.success('Member added successfully');
        setIsAddDialogOpen(false);
        addForm.reset();
      } else {
        toast.error(result.error || 'Failed to add member');
      }
    } catch (error) {
      console.error('Error adding member:', error);
      toast.error('Something went wrong trying to add the member');
    } finally {
      setIsProcessing(false);
    }
  };

  // Handle update a member's role
  const handleUpdateRole = async (memberId: string, newRole: string) => {
    setIsProcessing(true);
    try {
      const result = await onUpdateMember(memberId, newRole);
      if (result.success) {
        toast.success('Member role updated successfully');
      } else {
        toast.error(result.error || 'Failed to update member role');
      }
    } catch (error) {
      console.error('Error updating member:', error);
      toast.error('Something went wrong trying to update the member');
    } finally {
      setIsProcessing(false);
    }
  };

  // Handle remove a member
  const handleRemove = async (memberId: string) => {
    if (!confirm('Are you sure you want to remove this member from the team?')) {
      return;
    }

    setIsProcessing(true);
    try {
      const result = await onRemoveMember(memberId);
      if (result.success) {
        toast.success('Member removed successfully');
      } else {
        toast.error(result.error || 'Failed to remove member');
      }
    } catch (error) {
      console.error('Error removing member:', error);
      toast.error('Something went wrong trying to remove the member');
    } finally {
      setIsProcessing(false);
    }
  };

  // Helper to get initials from name
  const getInitials = (member: any): string => {
    if (!member?.user) return "?";
    
    const firstName = member.user.first_name || '';
    const lastName = member.user.last_name || '';
    
    if (firstName && lastName) {
      return `${firstName[0]}${lastName[0]}`.toUpperCase();
    } else if (firstName) {
      return firstName.substring(0, 2).toUpperCase();
    } else {
      return "??";
    }
  };

  // Check if current user can manage a specific member
  const canManageMember = (memberRole: string): boolean => {
    if (!isAdmin && !isOwner) return false; // Only admins or owners can manage members
    if (currentUserRole === 'owner') return true; // Owners can manage everyone
    if (currentUserRole === 'admin' && memberRole !== 'owner') return true; // Admins can manage regular members but not owners
    return false; // In all other cases
  };

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h3 className="text-lg font-medium">Team Members</h3>
        {(isAdmin || isOwner) && (
          <div className="flex gap-2">
            <Dialog open={isInviteDialogOpen} onOpenChange={setIsInviteDialogOpen}>
              <DialogTrigger asChild>
                <Button variant="outline" size="sm">
                  <Mail className="h-4 w-4 mr-2" />
                  Invite Member
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>Invite Team Member</DialogTitle>
                  <DialogDescription>
                    Send an email invitation to join this team.
                  </DialogDescription>
                </DialogHeader>
                <Form {...inviteForm}>
                  <form onSubmit={inviteForm.handleSubmit(handleInvite)} className="space-y-4">
                    <FormField
                      control={inviteForm.control}
                      name="email"
                      render={({ field }) => (
                        <FormItem>
                          <FormControl>
                            <Input placeholder="Email address" {...field} />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    <FormField
                      control={inviteForm.control}
                      name="role"
                      render={({ field }) => (
                        <FormItem>
                          <Select 
                            onValueChange={field.onChange} 
                            defaultValue={field.value}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select role" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="admin">Admin</SelectItem>
                              <SelectItem value="member">Member</SelectItem>
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
                        onClick={() => setIsInviteDialogOpen(false)}
                        disabled={isProcessing}
                      >
                        Cancel
                      </Button>
                      <Button type="submit" disabled={isProcessing}>
                        {isProcessing ? 'Sending...' : 'Send Invitation'}
                      </Button>
                    </DialogFooter>
                  </form>
                </Form>
              </DialogContent>
            </Dialog>

            <Dialog open={isAddDialogOpen} onOpenChange={setIsAddDialogOpen}>
              <DialogTrigger asChild>
                <Button size="sm">
                  <UserPlus className="h-4 w-4 mr-2" />
                  Add Member
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>Add Team Member</DialogTitle>
                  <DialogDescription>
                    Add an existing user to this team.
                  </DialogDescription>
                </DialogHeader>
                <Form {...addForm}>
                  <form onSubmit={addForm.handleSubmit(handleAdd)} className="space-y-4">
                    <FormField
                      control={addForm.control}
                      name="userId"
                      render={({ field }) => (
                        <FormItem>
                          <FormControl>
                            <Input placeholder="User ID" {...field} />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    <FormField
                      control={addForm.control}
                      name="role"
                      render={({ field }) => (
                        <FormItem>
                          <Select 
                            onValueChange={field.onChange} 
                            defaultValue={field.value}
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Select role" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="admin">Admin</SelectItem>
                              <SelectItem value="member">Member</SelectItem>
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
                        onClick={() => setIsAddDialogOpen(false)}
                        disabled={isProcessing}
                      >
                        Cancel
                      </Button>
                      <Button type="submit" disabled={isProcessing}>
                        {isProcessing ? 'Adding...' : 'Add Member'}
                      </Button>
                    </DialogFooter>
                  </form>
                </Form>
              </DialogContent>
            </Dialog>
          </div>
        )}
      </div>

      {team.members.length === 0 ? (
        <div className="text-center py-12 border rounded-lg bg-gray-50">
          <p className="text-gray-500">
            No team members yet.
          </p>
        </div>
      ) : (
        <div className="border rounded-lg overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Member</TableHead>
                <TableHead>Role</TableHead>
                <TableHead>Email</TableHead>
                <TableHead className="w-[100px]">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {team.members.map((member) => (
                <TableRow key={member.id}>
                  <TableCell className="flex items-center space-x-3">
                    <Avatar className="h-8 w-8">
                      <AvatarImage src={member.user?.avatar_url || undefined} alt="User avatar" />
                      <AvatarFallback>{getInitials(member)}</AvatarFallback>
                    </Avatar>
                    <div>
                      <div className="font-medium">
                        {member.user 
                          ? `${member.user.first_name || ''} ${member.user.last_name || ''}`.trim() || 'Unnamed User'
                          : 'Unknown User'
                        }
                      </div>
                      {member.user_id === currentUserId && (
                        <Badge variant="outline" className="text-xs bg-blue-50">You</Badge>
                      )}
                    </div>
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center space-x-1">
                      {roleIcons[member.role as keyof typeof roleIcons]}
                      <span className="capitalize">{member.role}</span>
                    </div>
                  </TableCell>
                  <TableCell>{member.user?.email || '-'}</TableCell>
                  <TableCell>
                    {canManageMember(member.role) && member.user_id !== currentUserId && (
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
                          {member.role !== 'admin' && (
                            <DropdownMenuItem 
                              onClick={() => handleUpdateRole(member.id, 'admin')}
                              disabled={isProcessing}
                            >
                              Make Admin
                            </DropdownMenuItem>
                          )}
                          {member.role !== 'member' && member.role !== 'owner' && (
                            <DropdownMenuItem 
                              onClick={() => handleUpdateRole(member.id, 'member')}
                              disabled={isProcessing}
                            >
                              Make Member
                            </DropdownMenuItem>
                          )}
                          <DropdownMenuItem 
                            onClick={() => handleRemove(member.id)}
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