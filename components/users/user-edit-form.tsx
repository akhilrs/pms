"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { toast } from "sonner";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Switch } from "@/components/ui/switch";
import { updateUserAction } from "@/app/users/actions";
import { UserWithAuthDetails } from "@/lib/supabase/users";
import { Loader2 } from "lucide-react";

// Form schema with validation
const formSchema = z.object({
  firstName: z.string().optional(),
  lastName: z.string().optional(),
  isActive: z.boolean().default(true),
  avatarUrl: z.string().optional(),
});

type UserEditFormValues = z.infer<typeof formSchema>;

interface UserEditFormProps {
  userId: string;
  user?: UserWithAuthDetails;
  onSuccess?: () => void;
  onCancel?: () => void;
}

export function UserEditForm({ userId, user, onSuccess, onCancel }: UserEditFormProps) {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isLoading, setIsLoading] = useState(!user);
  const [userData, setUserData] = useState<UserWithAuthDetails | null>(user || null);
  const router = useRouter();

  // Initialize form
  const form = useForm<UserEditFormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      firstName: user?.first_name || "",
      lastName: user?.last_name || "",
      isActive: user?.auth_user?.is_active ?? true,
      avatarUrl: user?.avatar_url || "",
    },
  });

  // Load user data if not provided
  useEffect(() => {
    const fetchUser = async () => {
      if (user) return; // Skip if user is already provided
      
      try {
        setIsLoading(true);
        const response = await fetch(`/api/users/${userId}`);

        if (!response.ok) {
          throw new Error("Failed to load user");
        }

        const { data } = await response.json();
        setUserData(data);

        // Set form values
        form.reset({
          firstName: data.first_name || "",
          lastName: data.last_name || "",
          isActive: data.auth_user?.is_active ?? true,
          avatarUrl: data.avatar_url || "",
        });
      } catch (error) {
        console.error("Error loading user:", error);
        toast.error("Failed to load user");
      } finally {
        setIsLoading(false);
      }
    };

    fetchUser();
  }, [userId, form, user]);

  // Submit handler
  const onSubmit = async (values: UserEditFormValues) => {
    setIsSubmitting(true);
    try {
      const { data, error } = await updateUserAction(userId, {
        firstName: values.firstName,
        lastName: values.lastName,
        isActive: values.isActive,
        avatarUrl: values.avatarUrl || null,
      });

      if (error) {
        if (error.message?.includes("Could not update user status") && 
            (values.firstName || values.lastName || values.avatarUrl)) {
          // Profile fields were updated successfully, but couldn't update user status
          toast.success("User profile updated successfully", {
            description: "Note: Could not update user status. You may not have admin permissions."
          });
          
          // Navigate or call success callback
          if (onSuccess) {
            onSuccess();
          } else {
            router.push(`/users/${userId}`);
          }
          return;
        }
        
        // For all other errors
        throw new Error(error.message);
      }

      toast.success("User updated successfully");

      // Either use callback or navigate back to user details
      if (onSuccess) {
        onSuccess();
      } else {
        router.push(`/users/${userId}`);
      }
    } catch (error) {
      console.error("Error updating user:", error);
      toast.error("Failed to update user", {
        description:
          error instanceof Error ? error.message : "An unknown error occurred",
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  if (isLoading) {
    return (
      <div className="flex justify-center items-center py-8">
        <Loader2 className="h-8 w-8 animate-spin text-gray-400" />
      </div>
    );
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        <div className="grid grid-cols-2 gap-4">
          <FormField
            control={form.control}
            name="firstName"
            render={({ field }) => (
              <FormItem>
                <FormLabel>First Name</FormLabel>
                <FormControl>
                  <Input placeholder="John" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="lastName"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Last Name</FormLabel>
                <FormControl>
                  <Input placeholder="Doe" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
        </div>

        <FormField
          control={form.control}
          name="avatarUrl"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Avatar URL</FormLabel>
              <FormControl>
                <Input
                  placeholder="https://example.com/avatar.jpg"
                  {...field}
                />
              </FormControl>
              <FormDescription>
                URL to the user's profile picture
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="isActive"
          render={({ field }) => (
            <FormItem className="flex flex-row items-center justify-between rounded-lg border p-3 shadow-sm">
              <div className="space-y-0.5">
                <FormLabel>Active Status</FormLabel>
                <FormDescription>
                  Allow this user to sign in to the application
                </FormDescription>
              </div>
              <FormControl>
                <Switch
                  checked={field.value}
                  onCheckedChange={field.onChange}
                />
              </FormControl>
            </FormItem>
          )}
        />

        <div className="flex justify-end gap-3">
          <Button 
            type="button" 
            variant="outline" 
            onClick={onCancel || (() => router.push(`/users/${userId}`))}
          >
            Cancel
          </Button>
          <Button type="submit" disabled={isSubmitting}>
            {isSubmitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
            Save Changes
          </Button>
        </div>
      </form>
    </Form>
  );
}
