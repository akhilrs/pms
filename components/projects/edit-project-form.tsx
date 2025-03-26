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
      
      // Use server action directly
      await updateProjectAction(projectId, formData);
      
      toast.success('Project updated successfully');
      
      // Refresh the page data and redirect
      router.push(`/projects/${projectId}`);
      router.refresh();
      
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