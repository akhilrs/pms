"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import {
  ProjectForm,
  ProjectFormValues,
} from "@/components/projects/project-form";

interface NewProjectFormProps {
  userId: string;
}

export function NewProjectForm({ userId }: NewProjectFormProps) {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (formData: ProjectFormValues) => {
    if (isSubmitting) return;

    try {
      setIsSubmitting(true);
      console.log(`Submitting new project form for user ${userId}`);

      // Include the owner_id in the form data
      const projectData = {
        ...formData,
        owner_id: userId,
      };

      try {
        // Use the fetch API to call our project creation API route
        const response = await fetch("/api/projects", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(projectData),
          credentials: "include", // Important for cookies
        });

        const data = await response.json();

        if (!response.ok) {
          throw new Error(
            data.error || "Failed to create project using API route",
          );
        }

        toast.success("Project created successfully");

        // Redirect to the project page
        if (data.redirectTo) {
          router.push(data.redirectTo);
        } else {
          router.push("/projects");
        }

        return; // Success - exit the function early
      } catch (apiError) {
        console.error("API creation failed: ", apiError);
      }
    } catch (error) {
      console.error("Error creating project:", error);
      toast.error(
        error instanceof Error ? error.message : "Failed to create project",
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div>
      <ProjectForm onSubmit={handleSubmit} isSubmitting={isSubmitting} />
    </div>
  );
}

