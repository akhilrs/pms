"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { UserWithAuthDetails } from "@/lib/supabase/users";
import { toast } from "sonner";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { format } from "date-fns";
import { Check, X, Mail, Trash, Edit } from "lucide-react";

interface UserDetailsProps {
  user: UserWithAuthDetails;
}

export function UserDetails({ user }: UserDetailsProps) {
  const [isUpdating, setIsUpdating] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);
  const router = useRouter();

  // Toggle user active status
  const toggleStatus = async () => {
    setIsUpdating(true);
    try {
      // Send PATCH request to API
      const response = await fetch(`/api/users/${user.user_id}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          isActive: !user.is_active,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to update user status");
      }

      toast.success(
        user.is_active
          ? "User has been deactivated"
          : "User has been activated",
      );

      // Refresh the page to see updated user info
      router.refresh();
    } catch (error) {
      console.error("Error updating user status:", error);
      toast.error("Failed to update user status", {
        description:
          error instanceof Error ? error.message : "An unknown error occurred",
      });
    } finally {
      setIsUpdating(false);
    }
  };

  // Delete user
  const handleDeleteUser = async () => {
    if (
      !confirm(
        `Are you sure you want to delete user ${user.email}? This action cannot be undone.`,
      )
    ) {
      return;
    }

    setIsDeleting(true);
    try {
      // Send DELETE request to API
      const response = await fetch(`/api/users/${user.user_id}`, {
        method: "DELETE",
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to delete user");
      }

      toast.success("User deleted successfully");
      router.push("/users");
    } catch (error) {
      console.error("Error deleting user:", error);
      toast.error("Failed to delete user", {
        description:
          error instanceof Error ? error.message : "An unknown error occurred",
      });
    } finally {
      setIsDeleting(false);
    }
  };

  // Handle generating invite link
  const handleInviteUser = async () => {
    try {
      // Send POST request to API
      const response = await fetch(`/api/users/${user.user_id}/actions`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ action: "generate-invite" }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to generate invite link");
      }

      const data = await response.json();

      if (data?.data?.inviteLink) {
        // Copy link to clipboard
        await navigator.clipboard.writeText(data.data.inviteLink);
        toast.success("Invite link copied to clipboard");
      }
    } catch (error) {
      toast.error("An error occurred");
      console.error("Error generating invite link:", error);
    }
  };

  // Format date for display
  const formatDate = (date: string | null | undefined) => {
    if (!date) return "Never";
    try {
      return format(new Date(date), "MMM d, yyyy");
    } catch (e) {
      return "Invalid date";
    }
  };

  return (
    <div className="space-y-6">
      <Tabs defaultValue="overview">
        <TabsList>
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="security">Security</TabsTrigger>
          <TabsTrigger value="projects">Projects</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-6">
          <Card>
            <CardHeader>
              <CardTitle>User Information</CardTitle>
              <CardDescription>
                Personal details and preferences
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    Email
                  </h3>
                  <p className="mt-1">{user.email || "No email available"}</p>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    Status
                  </h3>
                  <div className="mt-1">
                    {user.is_active ? (
                      <Badge className="bg-green-100 text-green-800 hover:bg-green-100">
                        <Check className="h-3.5 w-3.5 mr-1" />
                        Active
                      </Badge>
                    ) : (
                      <Badge className="bg-red-100 text-red-800 hover:bg-red-100">
                        <X className="h-3.5 w-3.5 mr-1" />
                        Inactive
                      </Badge>
                    )}
                  </div>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    First Name
                  </h3>
                  <p className="mt-1">{user.first_name || "-"}</p>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    Last Name
                  </h3>
                  <p className="mt-1">{user.last_name || "-"}</p>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    User ID
                  </h3>
                  <p className="mt-1 text-xs font-mono">{user.user_id}</p>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    Created At
                  </h3>
                  <p className="mt-1">{formatDate(user.created_at)}</p>
                </div>

                <div>
                  <h3 className="text-sm font-medium text-muted-foreground">
                    Last Login
                  </h3>
                  <p className="mt-1">{formatDate(user.last_sign_in)}</p>
                </div>
              </div>
            </CardContent>
            <CardFooter className="border-t pt-6 flex justify-between">
              <Button
                variant="outline"
                type="button"
                disabled={isUpdating}
                onClick={toggleStatus}
              >
                {user.is_active ? "Deactivate User" : "Activate User"}
              </Button>

              <Button asChild>
                <a href={`/users/edit/${user.user_id}`}>
                  <Edit className="h-4 w-4 mr-2" />
                  Edit User
                </a>
              </Button>
            </CardFooter>
          </Card>
        </TabsContent>

        <TabsContent value="security">
          <Card>
            <CardHeader>
              <CardTitle>Security Settings</CardTitle>
              <CardDescription>
                Manage user access and credentials
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="space-y-2">
                <h3 className="text-sm font-medium">Account Actions</h3>
                <p className="text-sm text-muted-foreground">
                  Manage the user's access to the system
                </p>
              </div>
            </CardContent>
            <CardFooter className="border-t pt-6 flex flex-col gap-3">
              <div className="grid grid-cols-2 gap-3 w-full">
                <Button
                  variant="outline"
                  className="w-full"
                  onClick={handleInviteUser}
                >
                  <Mail className="h-4 w-4 mr-2" />
                  Send Invite Link
                </Button>

                <Button variant="outline" className="w-full">
                  Reset Password
                </Button>
              </div>

              <Button
                variant="destructive"
                onClick={handleDeleteUser}
                disabled={isDeleting}
                className="w-full"
              >
                <Trash className="h-4 w-4 mr-2" />
                Delete User Account
              </Button>
            </CardFooter>
          </Card>
        </TabsContent>

        <TabsContent value="projects">
          <Card>
            <CardHeader>
              <CardTitle>Project Assignments</CardTitle>
              <CardDescription>
                Projects the user is assigned to
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="py-8 text-center text-muted-foreground">
                <p>Project assignments will be displayed here</p>
                <p className="text-sm mt-2">
                  This feature is under development
                </p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
