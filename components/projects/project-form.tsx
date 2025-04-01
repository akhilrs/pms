"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { format } from "date-fns";
import { CalendarIcon, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { toast } from "sonner";

import { Button } from "@/components/ui/button";
import { Calendar } from "@/components/ui/calendar";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";

// Define form schema with Zod
const formSchema = z.object({
  name: z
    .string()
    .min(3, { message: "Project name must be at least 3 characters" })
    .max(100, { message: "Project name must be less than 100 characters" }),
  description: z
    .string()
    .max(500, { message: "Description must be less than 500 characters" })
    .optional(),
  status: z.enum([
    "Planning",
    "In Progress",
    "On Hold",
    "Completed",
    "Canceled",
  ]),
  start_date: z.date(),
  end_date: z.date().optional(),
});

export type ProjectFormValues = z.infer<typeof formSchema>;

interface ProjectFormProps {
  onSubmit: (data: ProjectFormValues) => Promise<void>;
  isSubmitting?: boolean;
  initialData?: Partial<ProjectFormValues>;
}

export function ProjectForm({
  onSubmit,
  isSubmitting: externalIsSubmitting,
  initialData,
}: ProjectFormProps) {
  const [isSubmitting, setIsSubmitting] = useState(false);

  const form = useForm<ProjectFormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      name: initialData?.name || "",
      description: initialData?.description || "",
      status: initialData?.status || "Planning",
      start_date: initialData?.start_date || new Date(),
      end_date: initialData?.end_date,
    },
  });

  const handleSubmit = async (data: ProjectFormValues) => {
    if (isSubmitting || externalIsSubmitting) return;

    try {
      setIsSubmitting(true);
      await onSubmit(data);
      // toast.success('Project saved successfully');
    } catch (error) {
      console.error("Form submission error:", error);
      toast.error(
        error instanceof Error ? error.message : "Failed to save project",
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(handleSubmit)} className="space-y-8">
        <FormField
          control={form.control}
          name="name"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Project Name</FormLabel>
              <FormControl>
                <Input placeholder="Enter project name" {...field} />
              </FormControl>
              <FormDescription>
                Give your project a clear and descriptive name
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
                  placeholder="Enter project description"
                  className="resize-none"
                  {...field}
                />
              </FormControl>
              <FormDescription>
                Provide a brief description of your project
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="status"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Status</FormLabel>
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
                Set the current status of your project
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <FormField
            control={form.control}
            name="start_date"
            render={({ field }) => (
              <FormItem className="flex flex-col">
                <FormLabel>Start Date</FormLabel>
                <Popover>
                  <PopoverTrigger asChild>
                    <FormControl>
                      <Button
                        variant="outline"
                        className={cn(
                          "w-full pl-3 text-left font-normal",
                          !field.value && "text-muted-foreground",
                        )}
                      >
                        {field.value ? (
                          format(field.value, "PPP")
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
                      disabled={(date) =>
                        date < new Date(new Date().setHours(0, 0, 0, 0))
                      }
                      initialFocus
                    />
                  </PopoverContent>
                </Popover>
                <FormDescription>When does the project start?</FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="end_date"
            render={({ field }) => (
              <FormItem className="flex flex-col">
                <FormLabel>End Date (Optional)</FormLabel>
                <Popover>
                  <PopoverTrigger asChild>
                    <FormControl>
                      <Button
                        variant="outline"
                        className={cn(
                          "w-full pl-3 text-left font-normal",
                          !field.value && "text-muted-foreground",
                        )}
                      >
                        {field.value ? (
                          format(field.value, "PPP")
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
                      disabled={(date) => date < form.getValues("start_date")}
                      initialFocus
                    />
                  </PopoverContent>
                </Popover>
                <FormDescription>When is the project due?</FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />
        </div>

        <Button type="submit" disabled={isSubmitting || externalIsSubmitting}>
          {(isSubmitting || externalIsSubmitting) && (
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
          )}
          {initialData ? "Update Project" : "Create Project"}
        </Button>
      </form>
    </Form>
  );
}

