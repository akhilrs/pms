"use client";

import { useState } from "react";
import Link from "next/link";
import { UserWithAuthDetails } from "@/lib/supabase/users";
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
import {
  Eye,
  Search,
  Check,
  X,
  Trash,
  MoreHorizontal,
  Mail,
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
import {
  deleteUserAction,
  generateInviteLinkAction,
} from "@/app/users/actions";
import { toast } from "sonner";

interface UserListSimpleProps {
  users: UserWithAuthDetails[];
}

export function UserListSimple({ users }: UserListSimpleProps) {
  const [searchTerm, setSearchTerm] = useState("");

  // Filter users based on search term
  const filteredUsers = users.filter((user) => {
    // Handle optional email field
    const userEmail = user.email || "";
    const userFullName = `${user.first_name || ""} ${user.last_name || ""}`;

    return (
      userEmail.toLowerCase().includes(searchTerm.toLowerCase()) ||
      userFullName.toLowerCase().includes(searchTerm.toLowerCase())
    );
  });

  // Handle deleting a user
  const handleDeleteUser = async (userId: string) => {
    if (
      confirm(
        "Are you sure you want to delete this user? This action cannot be undone.",
      )
    ) {
      try {
        const { success, error } = await deleteUserAction(userId);

        if (error) {
          toast.error("Failed to delete user", {
            description: error.message,
          });
          return;
        }

        if (success) {
          toast.success("User deleted successfully");
          // Refresh the page to show updated user list
          window.location.reload();
        }
      } catch (error) {
        toast.error("An error occurred");
        console.error("Error deleting user:", error);
      }
    }
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

  // Format date safely
  const formatDate = (dateStr: string | null | undefined) => {
    if (!dateStr) return "Never";
    try {
      return format(new Date(dateStr), "MMM d, yyyy");
    } catch (e) {
      return "Invalid date";
    }
  };

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle>User Accounts</CardTitle>
            <CardDescription>Manage user accounts and access</CardDescription>
          </div>
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
      </CardHeader>
      <CardContent>
        {filteredUsers.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-lg font-medium">No users found</p>
            <p className="text-sm text-muted-foreground mt-1">
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
                  <TableHead>Name</TableHead>
                  <TableHead>Email</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead>Last Sign In</TableHead>
                  <TableHead className="text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredUsers.map((user) => (
                  <TableRow key={user.user_id}>
                    <TableCell>
                      <div className="font-medium">
                        {user.first_name
                          ? `${user.first_name} ${user.last_name}`
                          : "Unnamed User"}
                      </div>
                    </TableCell>
                    <TableCell>{user.email || "No email"}</TableCell>
                    <TableCell>
                      {user.is_active ? (
                        <div className="flex items-center">
                          <Check className="h-4 w-4 mr-1 text-green-600" />
                          <span>Active</span>
                        </div>
                      ) : (
                        <div className="flex items-center">
                          <X className="h-4 w-4 mr-1 text-red-600" />
                          <span>Inactive</span>
                        </div>
                      )}
                    </TableCell>
                    <TableCell>{formatDate(user.last_sign_in)}</TableCell>
                    <TableCell className="text-right">
                      <div className="flex justify-end">
                        <Button variant="ghost" size="icon" asChild>
                          <Link href={`/users/${user.user_id}`}>
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
                              <Link href={`/users/${user.user_id}`}>
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
                            <DropdownMenuSeparator />
                            <DropdownMenuItem
                              onClick={() => handleDeleteUser(user.user_id)}
                              className="text-red-600"
                            >
                              <Trash className="h-4 w-4 mr-2" />
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
    </Card>
  );
}
