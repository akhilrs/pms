// lib/supabase/messages-adapter.ts
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { Database } from "@/types/supabase";
import { toast } from "sonner";

type Message = Database["public"]["Tables"]["messages"]["Row"] & {
  user?: {
    id: string;
    first_name: string | null;
    last_name: string | null;
    avatar_url: string | null;
  } | null;
};

export function useProjectMessages() {
  const supabase = createClientComponentClient<Database>();

  // Fetch project messages
  const getProjectMessages = async (projectId: string): Promise<Message[]> => {
    if (!projectId) {
      console.error("No project ID provided for message fetching");
      return [];
    }

    try {
      // First, fetch the messages
      const { data: messagesData, error: messagesError } = await supabase
        .from("messages")
        .select("*")
        .eq("project_id", projectId)
        .order("created_at", { ascending: false });

      if (messagesError) {
        console.error("Error fetching project messages:", messagesError);
        toast.error("Failed to load messages");
        return [];
      }

      if (!messagesData || messagesData.length === 0) {
        return [];
      }

      // Then, fetch user profiles for these messages in a separate query
      const userIds = [...new Set(messagesData.map(message => message.user_id))];
      
      const { data: profilesData, error: profilesError } = await supabase
        .from("profiles")
        .select("*")
        .in("id", userIds);

      if (profilesError) {
        console.error("Error fetching user profiles:", profilesError);
      }

      // Map profiles to messages
      const messagesWithUsers = messagesData.map(message => {
        const userProfile = profilesData?.find(profile => profile.id === message.user_id) || null;
        return {
          ...message,
          user: userProfile ? {
            id: userProfile.id,
            first_name: userProfile.first_name,
            last_name: userProfile.last_name,
            avatar_url: userProfile.avatar_url
          } : null
        };
      });

      return messagesWithUsers;
    } catch (err) {
      console.error("Error in getProjectMessages:", err);
      toast.error("Failed to load messages");
      return [];
    }
  };

  // Create a new message
  const createMessage = async (
    projectId: string,
    content: string
  ): Promise<Message | null> => {
    if (!projectId || !content.trim()) {
      toast.error("Message content cannot be empty");
      return null;
    }

    try {
      const { data: userData, error: userError } = await supabase.auth.getUser();
      
      if (userError || !userData.user) {
        console.error("Error getting current user:", userError);
        toast.error("You must be logged in to post a message");
        return null;
      }

      // Insert the message first
      const { data: newMessage, error: insertError } = await supabase
        .from("messages")
        .insert({
          project_id: projectId,
          user_id: userData.user.id,
          content: content.trim(),
        })
        .select()
        .single();
        
      if (insertError) {
        console.error("Error creating message:", insertError);
        toast.error("Failed to post message");
        return null;
      }
      
      // Then fetch the user profile in a separate query
      const { data: userProfile, error: profileError } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", userData.user.id)
        .single();
        
      if (profileError) {
        console.error("Error fetching user profile:", profileError);
      }
      
      // Combine the message with the user profile
      const data = {
        ...newMessage,
        user: userProfile || null
      };

      // This block is no longer needed as we're handling errors above

      toast.success("Message posted successfully");
      return data;
    } catch (err) {
      console.error("Error in createMessage:", err);
      toast.error("Failed to post message");
      return null;
    }
  };

  // Delete a message
  const deleteMessage = async (messageId: string): Promise<boolean> => {
    if (!messageId) {
      toast.error("Invalid message");
      return false;
    }

    try {
      const { error } = await supabase
        .from("messages")
        .delete()
        .eq("id", messageId);

      if (error) {
        console.error("Error deleting message:", error);
        toast.error("Failed to delete message");
        return false;
      }

      toast.success("Message deleted");
      return true;
    } catch (err) {
      console.error("Error in deleteMessage:", err);
      toast.error("Failed to delete message");
      return false;
    }
  };

  // Setup realtime subscription for new messages
  const subscribeToMessages = (
    projectId: string,
    callback: (message: Message) => void
  ) => {
    const channel = supabase
      .channel(`messages:${projectId}`)
      .on(
        "postgres_changes",
        {
          event: "INSERT",
          schema: "public",
          table: "messages",
          filter: `project_id=eq.${projectId}`,
        },
        async (payload) => {
          // Fetch the message
          const { data: messageData } = await supabase
            .from("messages")
            .select("*")
            .eq("id", payload.new.id)
            .single();

          if (messageData) {
            // Fetch the user profile separately
            const { data: userData } = await supabase
              .from("profiles")
              .select("*")
              .eq("id", messageData.user_id)
              .single();

            // Combine the message with user data
            const enrichedMessage = {
              ...messageData,
              user: userData || null
            };

            callback(enrichedMessage);
          }
        }
      )
      .subscribe();

    // Return unsubscribe function
    return () => {
      supabase.removeChannel(channel);
    };
  };

  return {
    getProjectMessages,
    createMessage,
    deleteMessage,
    subscribeToMessages,
  };
}