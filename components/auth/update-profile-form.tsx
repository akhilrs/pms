"use client";

import { useState, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { toast } from "sonner";
import { Loader2, User } from "lucide-react";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { AvatarUpload } from "./avatar-upload";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useUser, updateUserProfile, getUserProfile } from "@/lib/supabase/auth";

const formSchema = z.object({
  firstName: z.string().min(1, { message: "First name is required" }),
  lastName: z.string().min(1, { message: "Last name is required" }),
  avatarUrl: z.string().url({ message: "Please enter a valid URL" }).optional().or(z.literal('')),
});

type ProfileFormValues = z.infer<typeof formSchema>;

export function UpdateProfileForm() {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const { user } = useUser();

  const form = useForm<ProfileFormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      firstName: "",
      lastName: "",
      avatarUrl: "",
    },
  });

  useEffect(() => {
    const loadProfileData = async () => {
      if (user?.id) {
        setIsLoading(true);
        const profile = await getUserProfile(user.id);
        if (profile) {
          form.setValue("firstName", profile.first_name || "");
          form.setValue("lastName", profile.last_name || "");
          form.setValue("avatarUrl", profile.avatar_url || "");
        }
        setIsLoading(false);
      }
    };

    loadProfileData();
  }, [user?.id, form]);

  const onSubmit = async (data: ProfileFormValues) => {
    if (isSubmitting) return;

    try {
      setIsSubmitting(true);
      const success = await updateUserProfile({
        firstName: data.firstName,
        lastName: data.lastName,
        avatarUrl: data.avatarUrl,
      });

      if (success) {
        toast.success("Profile updated successfully");
      } else {
        toast.error("Failed to update profile");
      }
    } catch (error) {
      console.error("Error updating profile:", error);
      toast.error("An error occurred while updating your profile");
    } finally {
      setIsSubmitting(false);
    }
  };

  if (isLoading) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Your Profile</CardTitle>
          <CardDescription>Update your name information</CardDescription>
        </CardHeader>
        <CardContent className="flex justify-center py-6">
          <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader className="flex flex-row items-start justify-between">
        <div>
          <CardTitle>Your Profile</CardTitle>
          <CardDescription>Update your name information</CardDescription>
          {user?.email && (
            <div className="mt-2 text-sm text-gray-500">
              {user.email}
            </div>
          )}
        </div>
        <Avatar className="h-16 w-16">
          <AvatarImage src={form.watch("avatarUrl") || undefined} />
          <AvatarFallback className="text-lg">
            {form.watch("firstName") && form.watch("lastName")
              ? `${form.watch("firstName")[0]}${form.watch("lastName")[0]}`
              : <User className="h-6 w-6" />
            }
          </AvatarFallback>
        </Avatar>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <FormField
              control={form.control}
              name="firstName"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>First Name</FormLabel>
                  <FormControl>
                    <Input placeholder="Enter your first name" {...field} />
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
                    <Input placeholder="Enter your last name" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            
            <FormField
              control={form.control}
              name="avatarUrl"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Avatar</FormLabel>
                  <FormControl>
                    <AvatarUpload 
                      currentAvatarUrl={field.value}
                      onUploadComplete={(url) => field.onChange(url)}
                    />
                  </FormControl>
                  <FormDescription>
                    Upload an image for your profile avatar
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              Update Profile
            </Button>
          </form>
        </Form>
      </CardContent>
    </Card>
  );
}