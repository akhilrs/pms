"use client";

import { useState, useEffect } from "react";
import { MessageItem } from "./message-item";
import { Loader2 } from "lucide-react";

interface MessageListProps {
  messages: Array<{
    id: string;
    content: string;
    user_id: string;
    created_at: string;
    user?: {
      id: string;
      first_name: string | null;
      last_name: string | null;
      avatar_url: string | null;
    } | null;
  }>;
  currentUserId: string;
  isLoading?: boolean;
  onMessageDeleted: () => void;
}

export function MessageList({
  messages,
  currentUserId,
  isLoading = false,
  onMessageDeleted,
}: MessageListProps) {
  if (isLoading) {
    return (
      <div className="flex justify-center items-center py-12">
        <Loader2 className="h-8 w-8 animate-spin text-gray-400" />
      </div>
    );
  }

  if (messages.length === 0) {
    return (
      <div className="text-center py-12 text-gray-500">
        <p>No messages yet</p>
        <p className="text-sm mt-2">Start a conversation with your team</p>
      </div>
    );
  }

  return (
    <div className="space-y-0 divide-y divide-gray-100">
      {messages.map((message) => (
        <MessageItem
          key={message.id}
          message={message}
          currentUserId={currentUserId}
          onMessageDeleted={onMessageDeleted}
        />
      ))}
    </div>
  );
}