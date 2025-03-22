'use client';

import { useState, useCallback } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { format } from 'date-fns';
import { CalendarIcon, Loader2 } from 'lucide-react';
import { useRouter } from 'next/navigation';
import { toast } from 'sonner';
import { createClientBrowser } from '@/lib/supabase/client';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover';
import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';

// Define form schema with Zod
const formSchema = z.object({
  name: z
    .string()
    .min(3, { message: 'Project name must be at least 3 characters' })
    .max(100, { message: 'Project name must be less than 100 characters' }),
  description: z
    .string()
    .max(500, { message: 'Description must be less than 500 characters' })
    .optional(),
  status: z.enum(['Planning', 'In Progress', 'On Hold', 'Completed', 'Canceled']),
  start_date: z.date(),
  end_date: z.date().optional(),
});

export type ProjectFormValues = z.infer<typeof formSchema>;

export function ProjectForm() {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const supabase = createClientBrowser();
  
  const form = useForm<ProjectFormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      name: '',
      description: '',
      status: 'Planning',
      start_date: new Date(),
    },
  });

  const onSubmit = useCallback(
    async (data: ProjectFormValues) => {
      setIsSubmitting(true);
      setError(null);
      
      try {
        // Get the user's session for the access token
        const { data: { session }, error: sessionError } = await supabase.auth.getSession();
        
        if (sessionError || !session) {
          setError("You must be logged in to create a project");
          toast.error("Authentication error. Please sign in again.");
          return;
        }
        
        // Send the form data to the API
        const response = await fetch("/api/projects", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${session.access_token}`
          },
          body: JSON.stringify(data),
        });

        const result = await response.json();

        if (!response.ok) {
          throw new Error(result.error || "Failed to create project");
        }

        toast.success("Project created successfully!");
        router.push(`/projects/${result.project.id}`);
      } catch (err: any) {
        console.error("Error creating project:", err);
        setError(err.message || "Failed to create project");
        toast.error(err.message || "Failed to create project");
      } finally {
        setIsSubmitting(false);
      }
    },
    [router, supabase]
  );

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        {error && (
          <div className="p-3 bg-red-50 border border-red-200 rounded-md text-red-800 mb-4">
            {error}
          </div>
        )}
        
        <FormField
          control={form.control}
          name="name"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Project Name *</FormLabel>
              <FormControl>
                <Input placeholder="Enter project name" {...field} />
              </FormControl>
              <FormDescription>
                Give your project a clear, descriptive name.
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
                  placeholder="Enter a brief description of your project"
                  className="min-h-32"
                  {...field}
                  value={field.value || ''}
                />
              </FormControl>
              <FormDescription>
                Provide details about the project's purpose and goals.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <FormField
            control={form.control}
            name="status"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Status *</FormLabel>
                <Select onValueChange={field.onChange} defaultValue={field.value}>
                  <FormControl>
                    <SelectTrigger>
                      <SelectValue placeholder="Select project status" />
                    </SelectTrigger>
                  </FormControl>
                  <SelectContent>
                    <SelectItem value="Planning">Planning</SelectItem>
                    <SelectItem value="In Progress">In Progress</SelectItem>
                    <SelectItem value="On Hold">On Hold</SelectItem>
                    <SelectItem value="Completed">Completed</SelectItem>
                    <SelectItem value="Canceled">Canceled</SelectItem>
                  </SelectContent>
                </Select>
                <FormDescription>
                  The current status of your project.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="start_date"
            render={({ field }) => (
              <FormItem className="flex flex-col">
                <FormLabel>Start Date *</FormLabel>
                <Popover>
                  <PopoverTrigger asChild>
                    <FormControl>
                      <Button
                        variant="outline"
                        className="w-full pl-3 text-left font-normal"
                      >
                        {field.value ? (
                          format(field.value, 'PPP')
                        ) : (
                          <span>Pick a date</span>
                        )}
                        <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                      </Button>
                    </FormControl>
                  </PopoverTrigger>
                  <PopoverContent className="w-auto p-0" align="start">
                    <Calendar
                      mode="single"
                      selected={field.value}
                      onSelect={field.onChange}
                      initialFocus
                    />
                  </PopoverContent>
                </Popover>
                <FormDescription>
                  When will the project start?
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="end_date"
            render={({ field }) => (
              <FormItem className="flex flex-col">
                <FormLabel>End Date</FormLabel>
                <Popover>
                  <PopoverTrigger asChild>
                    <FormControl>
                      <Button
                        variant="outline"
                        className="w-full pl-3 text-left font-normal"
                      >
                        {field.value ? (
                          format(field.value, 'PPP')
                        ) : (
                          <span>Pick a date</span>
                        )}
                        <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                      </Button>
                    </FormControl>
                  </PopoverTrigger>
                  <PopoverContent className="w-auto p-0" align="start">
                    <Calendar
                      mode="single"
                      selected={field.value || undefined}
                      onSelect={field.onChange}
                      initialFocus
                      disabled={(date) => {
                        // Disable dates before start date
                        const startDate = form.getValues('start_date');
                        return startDate && date < startDate;
                      }}
                    />
                  </PopoverContent>
                </Popover>
                <FormDescription>
                  When do you expect the project to be completed? (Optional)
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />
        </div>

        <div className="flex justify-end">
          <Button type="submit" disabled={isSubmitting}>
            {isSubmitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
            {form.defaultValues?.name ? 'Update Project' : 'Create Project'}
          </Button>
        </div>
      </form>
    </Form>
  );
} 