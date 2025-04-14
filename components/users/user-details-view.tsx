"use client";

import { useState } from "react";
import { UserWithAuthDetails } from "@/lib/supabase/users";
import { toast } from "sonner";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Switch } from "@/components/ui/switch";
import { format } from "date-fns";
import {
  Check,
  X,
  Mail,
  Lock,
  Trash,
  MoreHorizontal,
  Edit,
} from "lucide-react";
import { UserEditForm } from "./user-edit-form";
import {
  generateInviteLinkAction,
  updateUserAction,
} from "@/app/admin/users/actions";
import { UserDeleteDialog } from "./user-delete-dialog";
import { UserResetPasswordDialog } from "./user-reset-password-dialog";

interface UserDetailsViewProps {
  user: UserWithAuthDetails;
}

export function UserDetailsView({ user }: UserDetailsViewProps) {
  const [isUpdating, setIsUpdating] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [showResetPasswordDialog, setShowResetPasswordDialog] = useState(false);

  // Generate user initials for avatar
  const getInitials = (firstName?: string | null, lastName?: string | null) => {
    if (!firstName && !lastName) return "?";

    const firstInitial = firstName ? firstName.charAt(0) : "";
    const lastInitial = lastName ? lastName.charAt(0) : "";

    return `${firstInitial}${lastInitial}`.toUpperCase();
  };

  // Toggle user active status
  const toggleStatus = async () => {
    setIsUpdating(true);
    try {
      const { data, error } = await updateUserAction(user.user_id, {
        isActive: !user.auth_user.is_active,
      });

      if (error) {
        throw new Error(error.message);
      }

      toast.success(
        data?.auth_user.is_active
          ? "User has been activated"
          : "User has been deactivated",
      );
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

  // Handle generating invite link
  const handleInviteUser = async () => {
    try {
      const { data, error } = await generateInviteLinkAction(user.user_id);

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
    <div className="space-y-6">
      <Tabs defaultValue="overview">
        <TabsList>
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="projects">Projects</TabsTrigger>
          <TabsTrigger value="activity">Activity</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-6">
          {isEditing ? (
            <Card>
              <CardHeader>
                <CardTitle>Edit User</CardTitle>
                <CardDescription>
                  Update user profile information
                </CardDescription>
              </CardHeader>
              <CardContent>
                <UserEditForm
                  user={user}
                  onSuccess={() => setIsEditing(false)}
                  onCancel={() => setIsEditing(false)}
                />
              </CardContent>
            </Card>
          ) : (
            <>
              <Card>
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <div>
                    <CardTitle>Profile Information</CardTitle>
                    <CardDescription>
                      User account details and preferences
                    </CardDescription>
                  </div>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" size="icon">
                        <MoreHorizontal className="h-4 w-4" />
                        <span className="sr-only">Actions</span>
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem onClick={() => setIsEditing(true)}>
                        <Edit className="h-4 w-4 mr-2" />
                        Edit User
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={handleInviteUser}>
                        <Mail className="h-4 w-4 mr-2" />
                        Send Invite Link
                      </DropdownMenuItem>
                      <DropdownMenuItem
                        onClick={() => setShowResetPasswordDialog(true)}
                      >
                        <Lock className="h-4 w-4 mr-2" />
                        Reset Password
                      </DropdownMenuItem>
                      <DropdownMenuItem
                        onClick={() => setShowDeleteDialog(true)}
                        className="text-red-600"
                      >
                        <Trash className="h-4 w-4 mr-2" />
                        Delete User
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </CardHeader>
                <CardContent className="pt-6">
                  <div className="flex flex-col gap-8 sm:flex-row">
                    <div className="flex flex-col items-center gap-2">
                      <Avatar className="h-24 w-24">
                        <AvatarImage src={user.avatar_url || undefined} />
                        <AvatarFallback className="text-2xl">
                          {getInitials(user.first_name, user.last_name)}
                        </AvatarFallback>
                      </Avatar>
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
                    </div>
                    <div className="flex-1 space-y-4">
                      <div>
                        <h3 className="text-lg font-medium">
                          {user.first_name
                            ? `${user.first_name} ${user.last_name}`
                            : "Unnamed User"}
                        </h3>
                        <p className="text-sm text-muted-foreground">
                          {user.auth_user.email}
                        </p>
                      </div>

                      <div className="space-y-3">
                        <div className="flex justify-between text-sm">
                          <span className="text-muted-foreground">User ID</span>
                          <span className="font-mono">{user.user_id}</span>
                        </div>
                        <div className="flex justify-between text-sm">
                          <span className="text-muted-foreground">Created</span>
                          <span>
                            {user.auth_user.created_at
                              ? format(
                                  new Date(user.auth_user.created_at),
                                  "MMM d, yyyy 'at' h:mm a",
                                )
                              : "Unknown"}
                          </span>
                        </div>
                        <div className="flex justify-between text-sm">
                          <span className="text-muted-foreground">
                            Last Sign In
                          </span>
                          <span>
                            {user.auth_user.last_sign_in_at
                              ? format(
                                  new Date(user.auth_user.last_sign_in_at),
                                  "MMM d, yyyy 'at' h:mm a",
                                )
                              : "Never"}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </CardContent>
                <CardFooter className="flex justify-between border-t pt-6">
                  <div className="flex items-center gap-2">
                    <div className="text-sm font-medium">Account Status</div>
                    <Switch
                      checked={user.auth_user.is_active}
                      onCheckedChange={toggleStatus}
                      disabled={isUpdating}
                    />
                  </div>
                  <Button variant="outline" onClick={() => setIsEditing(true)}>
                    <Edit className="mr-2 h-4 w-4" />
                    Edit Profile
                  </Button>
                </CardFooter>
              </Card>
            </>
          )}
        </TabsContent>

        <TabsContent value="projects">
          <Card>
            <CardHeader>
              <CardTitle>Projects</CardTitle>
              <CardDescription>
                Projects the user is assigned to
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <p>Project assignments will be displayed here</p>
                <p className="text-sm mt-2">
                  This feature is under development
                </p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="activity">
          <Card>
            <CardHeader>
              <CardTitle>Activity Log</CardTitle>
              <CardDescription>Recent user activity</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <p>User activity will be displayed here</p>
                <p className="text-sm mt-2">
                  This feature is under development
                </p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      {/* Delete confirmation dialog */}
      <UserDeleteDialog
        user={showDeleteDialog ? user : null}
        open={showDeleteDialog}
        onOpenChange={setShowDeleteDialog}
      />

      {/* Reset password dialog */}
      <UserResetPasswordDialog
        user={showResetPasswordDialog ? user : null}
        open={showResetPasswordDialog}
        onOpenChange={setShowResetPasswordDialog}
      />
    </div>
  );
}
