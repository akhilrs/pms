"use client";

import { useState } from "react";
import Link from "next/link";
import { UserWithAuthDetails } from "@/lib/supabase/users";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Table,
  TableHeader,
  TableRow,
  TableHead,
  TableBody,
  TableCell,
} from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  Eye,
  Search,
  Lock,
  Check,
  X,
  Mail,
  UserPlus,
  MoreHorizontal,
} from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { format } from "date-fns";
import { UserDeleteDialog } from "./user-delete-dialog";
import { UserResetPasswordDialog } from "./user-reset-password-dialog";
import { generateInviteLinkAction } from "@/app/admin/users/actions";
import { toast } from "sonner";

interface UserListProps {
  users: UserWithAuthDetails[];
}

export function UserList({ users }: UserListProps) {
  const [searchTerm, setSearchTerm] = useState("");
  const [userToDelete, setUserToDelete] = useState<UserWithAuthDetails | null>(
    null,
  );
  const [userToResetPassword, setUserToResetPassword] =
    useState<UserWithAuthDetails | null>(null);

  // Filter users based on search term
  const filteredUsers = users.filter(
    (user) =>
      user.auth_user.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
      `${user.first_name} ${user.last_name}`
        .toLowerCase()
        .includes(searchTerm.toLowerCase()),
  );

  // Generate initials for avatar
  const getInitials = (firstName?: string | null, lastName?: string | null) => {
    if (!firstName && !lastName) return "?";

    const firstInitial = firstName ? firstName.charAt(0) : "";
    const lastInitial = lastName ? lastName.charAt(0) : "";

    return `${firstInitial}${lastInitial}`.toUpperCase();
  };

  // Handle generating invite link
  const handleInviteUser = async (userId: string) => {
    try {
      const { data, error } = await generateInviteLinkAction(userId);

      if (error) {
        toast.error("Failed to generate invite link", {
          description: error.message,
        });
        return;
      }

      if (data?.inviteLink) {
        // Copy link to clipboard
        await navigator.clipboard.writeText(data.inviteLink);
        toast.success("Invite link copied to clipboard");
      }
    } catch (error) {
      toast.error("An error occurred");
      console.error("Error generating invite link:", error);
    }
  };

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle>Users</CardTitle>
            <CardDescription>Manage user accounts and access</CardDescription>
          </div>
          <div className="flex items-center gap-2">
            <div className="relative">
              <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
              <Input
                type="search"
                placeholder="Search users..."
                className="pl-8 w-[250px]"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        {filteredUsers.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-8 text-center">
            <UserPlus className="h-12 w-12 text-muted-foreground/40" />
            <h3 className="mt-4 text-lg font-semibold">No users found</h3>
            <p className="text-muted-foreground">
              {searchTerm
                ? `No users match "${searchTerm}"`
                : "No users have been created yet"}
            </p>
          </div>
        ) : (
          <div className="overflow-auto">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>User</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead>Created</TableHead>
                  <TableHead>Last Sign In</TableHead>
                  <TableHead className="text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredUsers.map((user) => (
                  <TableRow key={user.user_id}>
                    <TableCell>
                      <div className="flex items-center gap-3">
                        <Avatar>
                          <AvatarImage src={user.avatar_url || undefined} />
                          <AvatarFallback>
                            {getInitials(user.first_name, user.last_name)}
                          </AvatarFallback>
                        </Avatar>
                        <div>
                          <div className="font-medium">
                            {user.first_name
                              ? `${user.first_name} ${user.last_name}`
                              : "Unnamed User"}
                          </div>
                          <div className="text-sm text-muted-foreground">
                            {user.auth_user.email}
                          </div>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      {user.auth_user.is_active ? (
                        <Badge
                          variant="outline"
                          className="bg-green-50 text-green-700 border-green-200"
                        >
                          <Check className="h-3.5 w-3.5 mr-1" />
                          Active
                        </Badge>
                      ) : (
                        <Badge
                          variant="outline"
                          className="bg-red-50 text-red-700 border-red-200"
                        >
                          <X className="h-3.5 w-3.5 mr-1" />
                          Inactive
                        </Badge>
                      )}
                    </TableCell>
                    <TableCell>
                      {user.auth_user.created_at
                        ? format(
                            new Date(user.auth_user.created_at),
                            "MMM d, yyyy",
                          )
                        : "Unknown"}
                    </TableCell>
                    <TableCell>
                      {user.auth_user.last_sign_in_at
                        ? format(
                            new Date(user.auth_user.last_sign_in_at),
                            "MMM d, yyyy",
                          )
                        : "Never"}
                    </TableCell>
                    <TableCell className="text-right">
                      <div className="flex justify-end">
                        <Button variant="ghost" size="icon" asChild>
                          <Link href={`/admin/users/${user.user_id}`}>
                            <Eye className="h-4 w-4" />
                            <span className="sr-only">View</span>
                          </Link>
                        </Button>

                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="icon">
                              <MoreHorizontal className="h-4 w-4" />
                              <span className="sr-only">More</span>
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuLabel>Actions</DropdownMenuLabel>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem asChild>
                              <Link href={`/admin/users/${user.user_id}`}>
                                <Eye className="h-4 w-4 mr-2" />
                                View Details
                              </Link>
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              onClick={() => handleInviteUser(user.user_id)}
                            >
                              <Mail className="h-4 w-4 mr-2" />
                              Send Invite Link
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              onClick={() => setUserToResetPassword(user)}
                            >
                              <Lock className="h-4 w-4 mr-2" />
                              Reset Password
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem
                              onClick={() => setUserToDelete(user)}
                              className="text-red-600"
                            >
                              <X className="h-4 w-4 mr-2" />
                              Delete User
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        )}
      </CardContent>

      {/* Delete confirmation dialog */}
      <UserDeleteDialog
        user={userToDelete}
        open={!!userToDelete}
        onOpenChange={(open) => !open && setUserToDelete(null)}
      />

      {/* Reset password dialog */}
      <UserResetPasswordDialog
        user={userToResetPassword}
        open={!!userToResetPassword}
        onOpenChange={(open) => !open && setUserToResetPassword(null)}
      />
    </Card>
  );
}
