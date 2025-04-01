"use client";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import {
  ProjectForm,
  ProjectFormValues,
} from "@/components/projects/project-form";

interface EditProjectFormProps {
  projectId: string;
  initialData: ProjectFormValues;
}

export function EditProjectForm({
  projectId,
  initialData,
}: EditProjectFormProps) {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (formData: ProjectFormValues) => {
    if (isSubmitting) return;

    try {
      setIsSubmitting(true);
      console.log(`Submitting edit form for project ${projectId}`);

      // Updated URL to match your API route structure
      const response = await fetch(`/api/projects/${projectId}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || "Failed to update project");
      }

      toast.success("Project updated successfully");

      // Refresh the page data and redirect
      router.push(`/projects/${projectId}`);
      router.refresh();
    } catch (error) {
      console.error("Form submission error:", error);
      toast.error(
        error instanceof Error ? error.message : "Failed to update project",
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <ProjectForm
      onSubmit={handleSubmit}
      isSubmitting={isSubmitting}
      initialData={initialData}
    />
  );
}

