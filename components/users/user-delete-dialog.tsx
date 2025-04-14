"use client";

import { useState } from "react";
import { UserWithAuthDetails } from "@/lib/supabase/users";
import { toast } from "sonner";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import { deleteUserAction } from "@/app/admin/users/actions";
import { Loader2 } from "lucide-react";

interface UserDeleteDialogProps {
  user: UserWithAuthDetails | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export function UserDeleteDialog({
  user,
  open,
  onOpenChange,
}: UserDeleteDialogProps) {
  const [isDeleting, setIsDeleting] = useState(false);

  const handleDelete = async () => {
    if (!user) return;

    setIsDeleting(true);
    try {
      const { success, error } = await deleteUserAction(user.user_id);

      if (error) {
        throw new Error(error.message);
      }

      if (success) {
        toast.success("User deleted successfully");
        onOpenChange(false);
      } else {
        throw new Error("Failed to delete user");
      }
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

  if (!user) return null;

  const userName = user.first_name
    ? `${user.first_name} ${user.last_name}`
    : user.auth_user.email;

  return (
    <AlertDialog open={open} onOpenChange={onOpenChange}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
          <AlertDialogDescription>
            This will permanently delete the user account for{" "}
            <strong>{userName}</strong> including all of their profile data.
            This action cannot be undone.
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel>Cancel</AlertDialogCancel>
          <Button
            variant="destructive"
            onClick={handleDelete}
            disabled={isDeleting}
          >
            {isDeleting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
            Delete User
          </Button>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  );
}
