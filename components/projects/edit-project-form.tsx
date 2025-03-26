'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { toast } from 'sonner';
import { ProjectForm, ProjectFormValues } from '@/components/projects/project-form';
import { updateProjectAction } from '@/app/projects/actions';

interface EditProjectFormProps {
  projectId: string;
  initialData: ProjectFormValues;
}

export function EditProjectForm({ projectId, initialData }: EditProjectFormProps) {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (formData: ProjectFormValues) => {
    if (isSubmitting) return;
    
    try {
      setIsSubmitting(true);
      console.log(`Submitting edit form for project ${projectId}`);
      
      // Try the API route first
      try {
        const response = await fetch(`/api/projects/${projectId}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(formData),
          credentials: 'include' // Important for cookies
        });

        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.error || 'Failed to update project using API route');
        }

        toast.success('Project updated successfully');
        router.push(`/projects/${projectId}`);
        router.refresh();
        return; // Success - exit the function early
      } catch (apiError) {
        console.error('API update failed, trying server action:', apiError);
        
        // Fall back to server action if API route fails
        try {
          await updateProjectAction(projectId, formData);
          toast.success('Project updated successfully');
          router.push(`/projects/${projectId}`);
          router.refresh();
          return; // Server action will handle redirection
        } catch (actionError) {
          console.error('Server action also failed:', actionError);
          throw new Error('Both API and server action methods failed to update project');
        }
      }
    } catch (error) {
      console.error('Form submission error:', error);
      toast.error(error instanceof Error ? error.message : 'Failed to update project');
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