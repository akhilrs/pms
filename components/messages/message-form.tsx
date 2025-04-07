"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { Loader2, Send } from "lucide-react";
import { useProjectMessages } from "@/lib/supabase/messages-adapter";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormMessage,
} from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";

// Define form schema with Zod
const formSchema = z.object({
  content: z
    .string()
    .min(1, { message: "Message cannot be empty" })
    .max(2000, { message: "Message must be less than 2000 characters" }),
});

type MessageFormValues = z.infer<typeof formSchema>;

interface MessageFormProps {
  projectId: string;
  onMessageSent: () => void;
}

export function MessageForm({ projectId, onMessageSent }: MessageFormProps) {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { createMessage } = useProjectMessages();

  const form = useForm<MessageFormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      content: "",
    },
  });

  const handleSubmit = async (data: MessageFormValues) => {
    if (isSubmitting) return;

    try {
      setIsSubmitting(true);
      const message = await createMessage(projectId, data.content);
      
      if (message) {
        form.reset(); // Clear the form on success
        onMessageSent(); // Notify parent of successful message
      }
    } catch (error) {
      console.error("Error sending message:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(handleSubmit)} className="relative">
        <FormField
          control={form.control}
          name="content"
          render={({ field }) => (
            <FormItem>
              <FormControl>
                <Textarea
                  placeholder="Type your message here..."
                  className="min-h-[100px] resize-none pr-12"
                  {...field}
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button
          type="submit"
          size="sm"
          className="absolute bottom-3 right-3"
          disabled={isSubmitting}
        >
          {isSubmitting ? (
            <Loader2 className="h-4 w-4 animate-spin" />
          ) : (
            <>
              <Send className="h-4 w-4 mr-1" />
              Send
            </>
          )}
        </Button>
      </form>
    </Form>
  );
}