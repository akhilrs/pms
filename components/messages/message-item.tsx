"use client";

import { useState } from "react";
import { formatDistanceToNow } from "date-fns";
import { MoreHorizontal, Trash } from "lucide-react";
import { useProjectMessages } from "@/lib/supabase/messages-adapter";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";

interface MessageItemProps {
  message: {
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
  };
  currentUserId: string;
  onMessageDeleted: () => void;
}

export function MessageItem({
  message,
  currentUserId,
  onMessageDeleted,
}: MessageItemProps) {
  const [isDeleteDialogOpen, setIsDeleteDialogOpen] = useState(false);
  const { deleteMessage } = useProjectMessages();
  const isCurrentUserMessage = message.user_id === currentUserId;

  // Get user display name or fallback
  const userName = message.user
    ? `${message.user.first_name || ""} ${message.user.last_name || ""}`.trim() ||
      "Unknown User"
    : "Unknown User";

  // Get initials for avatar fallback
  const getInitials = (name: string): string => {
    if (!name || name === "Unknown User") return "?";
    return name
      .split(" ")
      .map((part) => part[0])
      .join("")
      .toUpperCase()
      .substring(0, 2);
  };

  // Format timestamp
  const formattedTime = message.created_at
    ? formatDistanceToNow(new Date(message.created_at), { addSuffix: true })
    : "";

  // Handle message deletion
  const handleDelete = async () => {
    const success = await deleteMessage(message.id);
    if (success) {
      onMessageDeleted();
    }
    setIsDeleteDialogOpen(false);
  };

  return (
    <div className="flex gap-3 p-3 border-b border-gray-100 hover:bg-gray-50">
      <Avatar className="h-8 w-8">
        <AvatarImage
          src={message.user?.avatar_url || undefined}
          alt={userName}
        />
        <AvatarFallback>{getInitials(userName)}</AvatarFallback>
      </Avatar>
      
      <div className="flex-1 min-w-0">
        <div className="flex items-center justify-between">
          <div className="font-medium text-sm">{userName}</div>
          <div className="flex items-center gap-1">
            <div className="text-xs text-gray-500">{formattedTime}</div>
            
            {isCurrentUserMessage && (
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="icon" className="h-7 w-7">
                    <MoreHorizontal className="h-4 w-4" />
                    <span className="sr-only">Message actions</span>
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem 
                    className="text-red-600 focus:text-red-600" 
                    onClick={() => setIsDeleteDialogOpen(true)}
                  >
                    <Trash className="h-4 w-4 mr-2" />
                    Delete
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            )}
          </div>
        </div>
        
        <div className="mt-1 text-sm whitespace-pre-wrap break-words">
          {message.content}
        </div>
      </div>

      <AlertDialog open={isDeleteDialogOpen} onOpenChange={setIsDeleteDialogOpen}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Delete Message</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure you want to delete this message? This action cannot be undone.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction 
              onClick={handleDelete}
              className="bg-red-600 hover:bg-red-700"
            >
              Delete
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}