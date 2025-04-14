"use client";

import { useState } from "react";
import { UserWithAuthDetails } from "@/lib/supabase/users";
import { toast } from "sonner";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import * as z from "zod";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Loader2 } from "lucide-react";
import {
  sendPasswordResetAction,
  updateUserAction,
} from "@/app/admin/users/actions";

const formSchema = z.object({
  resetType: z.enum(["send_link", "set_password"]),
  newPassword: z.string().optional().refine(
    (val) => {
      // Only require the password if the reset type is set_password
      if (val === "" && val === undefined) {
        return true;
      }
      return val && val.length >= 8;
    },
    {
      message: "Password must be at least 8 characters when provided",
    }
  ),
});

type PasswordResetValues = z.infer<typeof formSchema>;

interface UserResetPasswordDialogProps {
  user: UserWithAuthDetails | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export function UserResetPasswordDialog({
  user,
  open,
  onOpenChange,
}: UserResetPasswordDialogProps) {
  const [isSubmitting, setIsSubmitting] = useState(false);

  const form = useForm<PasswordResetValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      resetType: "send_link",
      newPassword: "",
    },
  });

  const resetType = form.watch("resetType");

  // Reset form when dialog opens/closes
  if (!open && form.formState.isDirty) {
    form.reset();
  }

  const onSubmit = async (values: PasswordResetValues) => {
    if (!user) return;

    setIsSubmitting(true);
    try {
      if (values.resetType === "send_link") {
        // Send password reset email
        const { success, error } = await sendPasswordResetAction(
          user.auth_user.email
        );

        if (error) {
          throw new Error(error.message);
        }

        if (success) {
          toast.success("Password reset email sent", {
            description: `An email was sent to ${user.auth_user.email}`,
          });
          onOpenChange(false);
        }
      } else if (values.resetType === "set_password" && values.newPassword) {
        // Set new password directly
        const { data, error } = await updateUserAction(user.user_id, {
          password: values.newPassword,
        });

        if (error) {
          throw new Error(error.message);
        }

        toast.success("Password updated successfully");
        onOpenChange(false);
      }
    } catch (error) {
      console.error("Error resetting password:", error);
      toast.error("Failed to reset password", {
        description: error instanceof Error ? error.message : "An unknown error occurred",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  if (!user) return null;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>Reset Password</DialogTitle>
          <DialogDescription>
            Reset password for user: {user.auth_user.email}
          </DialogDescription>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            <FormField
              control={form.control}
              name="resetType"
              render={({ field }) => (
                <FormItem className="space-y-3">
                  <FormLabel>Password Reset Method</FormLabel>
                  <FormControl>
                    <RadioGroup
                      onValueChange={field.onChange}
                      defaultValue={field.value}
                      className="flex flex-col space-y-1"
                    >
                      <FormItem className="flex items-center space-x-3 space-y-0">
                        <FormControl>
                          <RadioGroupItem value="send_link" />
                        </FormControl>
                        <FormLabel className="font-normal">
                          Send password reset link
                        </FormLabel>
                      </FormItem>
                      <FormItem className="flex items-center space-x-3 space-y-0">
                        <FormControl>
                          <RadioGroupItem value="set_password" />
                        </FormControl>
                        <FormLabel className="font-normal">
                          Set new password directly
                        </FormLabel>
                      </FormItem>
                    </RadioGroup>
                  </FormControl>
                </FormItem>
              )}
            />

            {resetType === "set_password" && (
              <FormField
                control={form.control}
                name="newPassword"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>New Password</FormLabel>
                    <FormControl>
                      <Input
                        type="password"
                        placeholder="New password"
                        autoComplete="new-password"
                        {...field}
                      />
                    </FormControl>
                    <FormDescription>
                      Must be at least 8 characters long
                    </FormDescription>
                    <FormMessage />
                  </FormItem>
                )}
              />
            )}

            <DialogFooter>
              <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
                Cancel
              </Button>
              <Button type="submit" disabled={isSubmitting}>
                {isSubmitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                {resetType === "send_link" ? "Send Reset Link" : "Set Password"}
              </Button>
            </DialogFooter>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
