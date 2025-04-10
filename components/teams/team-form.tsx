'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { z } from 'zod';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { toast } from 'sonner';
import { 
  Form, 
  FormControl, 
  FormDescription, 
  FormField, 
  FormItem, 
  FormLabel, 
  FormMessage 
} from '@/components/ui/form';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Button } from '@/components/ui/button';
import type { Team } from '@/lib/supabase/teams';

// Define schema for team form
const teamFormSchema = z.object({
  name: z
    .string()
    .min(2, { message: 'Team name must be at least 2 characters' })
    .max(50, { message: 'Team name must be less than 50 characters' }),
  description: z
    .string()
    .max(500, { message: 'Description must be less than 500 characters' })
    .optional(),
  avatar_url: z.string().optional(),
});

type TeamFormValues = z.infer<typeof teamFormSchema>;

interface TeamFormProps {
  team?: Team;
  userId?: string; // Made optional since we're not using it
  onSubmit: (values: TeamFormValues) => Promise<{ success: boolean; error?: string }>;
  submitLabel: string;
  title: string;
  description?: string;
}

export function TeamForm({ 
  team, 
  onSubmit,
  submitLabel,
  title,
  description
}: TeamFormProps) {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);

  // Default values for the form
  const defaultValues: Partial<TeamFormValues> = {
    name: team?.name || '',
    description: team?.description || '',
    avatar_url: team?.avatar_url || '',
  };

  // Initialize form with react-hook-form
  const form = useForm<TeamFormValues>({
    resolver: zodResolver(teamFormSchema),
    defaultValues,
  });

  // Form submission handler
  const handleSubmit = async (values: TeamFormValues) => {
    setIsSubmitting(true);

    try {
      const result = await onSubmit(values);
      
      if (result.success) {
        toast.success('Team saved successfully');
        router.push('/teams');
        router.refresh();
      } else {
        toast.error(result.error || 'Failed to save team');
      }
    } catch (error) {
      console.error('Error submitting team form:', error);
      toast.error('Something went wrong. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div>
      {title && <h2 className="text-xl font-semibold mb-2">{title}</h2>}
      {description && <p className="text-gray-600 mb-6">{description}</p>}
      
      <Form {...form}>
        <form onSubmit={form.handleSubmit(handleSubmit)} className="space-y-6">
          <FormField
            control={form.control}
            name="name"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Team Name</FormLabel>
                <FormControl>
                  <Input placeholder="Engineering Team" {...field} />
                </FormControl>
                <FormDescription>
                  The name of your team as it will appear across the platform.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="description"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Description</FormLabel>
                <FormControl>
                  <Textarea 
                    placeholder="This team focuses on..." 
                    className="resize-none min-h-[100px]"
                    {...field} 
                    value={field.value || ''} 
                  />
                </FormControl>
                <FormDescription>
                  Briefly describe the team&apos;s purpose and responsibilities.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="avatar_url"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Team Avatar URL</FormLabel>
                <FormControl>
                  <Input placeholder="https://example.com/avatar.png" {...field} value={field.value || ''} />
                </FormControl>
                <FormDescription>
                  URL to an image to represent your team (optional).
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <div className="flex justify-end space-x-2 pt-4">
            <Button 
              variant="outline" 
              type="button" 
              onClick={() => router.back()}
              disabled={isSubmitting}
            >
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting}>
              {isSubmitting ? 'Saving...' : submitLabel}
            </Button>
          </div>
        </form>
      </Form>
    </div>
  );
}