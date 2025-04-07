"use client";

import { useState, useEffect } from "react";
import { useProjectMessages } from "@/lib/supabase/messages-adapter";
import { useUser } from "@/lib/supabase/auth";
import { MessageList } from "./message-list";
import { MessageForm } from "./message-form";

interface ProjectMessagesWrapperProps {
  projectId: string;
}

export function ProjectMessagesWrapper({ projectId }: ProjectMessagesWrapperProps) {
  const [messages, setMessages] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const { getProjectMessages, subscribeToMessages } = useProjectMessages();
  const { user } = useUser();

  const loadMessages = async () => {
    setIsLoading(true);
    const messages = await getProjectMessages(projectId);
    setMessages(messages);
    setIsLoading(false);
  };

  useEffect(() => {
    loadMessages();

    // Set up real-time subscription for new messages
    const unsubscribe = subscribeToMessages(projectId, (newMessage) => {
      setMessages((prevMessages) => [newMessage, ...prevMessages]);
    });

    return () => {
      unsubscribe();
    };
  }, [projectId]);

  const handleMessageSent = () => {
    loadMessages();
  };

  const handleMessageDeleted = () => {
    loadMessages();
  };

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-md shadow-sm border">
        <div className="p-4">
          <MessageForm 
            projectId={projectId} 
            onMessageSent={handleMessageSent} 
          />
        </div>
      </div>

      <div className="bg-white rounded-md shadow-sm border">
        <div className="p-2">
          <MessageList
            messages={messages}
            currentUserId={user?.id || ""}
            isLoading={isLoading}
            onMessageDeleted={handleMessageDeleted}
          />
        </div>
      </div>
    </div>
  );
}