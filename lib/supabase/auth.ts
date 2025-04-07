"use client";

import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { Database } from "@/types/supabase";
import { User } from "@supabase/supabase-js";
import { useState, useEffect } from "react";

// Create a client component Supabase client
const supabase = createClientComponentClient<Database>();

// Type definitions for backward compatibility
export type AuthUser = User;

// Hook to get and listen for user auth state changes
export function useUser() {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Get the current user
    const getInitialUser = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      
      if (user) {
        // Ensure user profile exists
        await ensureUserProfile(user.id);
      }
      
      setUser(user);
      setIsLoading(false);
    };

    getInitialUser();

    // Set up auth state listener
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, session) => {
        const currentUser = session?.user ?? null;
        
        if (currentUser && (event === 'SIGNED_IN' || event === 'TOKEN_REFRESHED')) {
          // Ensure user profile exists
          await ensureUserProfile(currentUser.id);
        }
        
        setUser(currentUser);
        setIsLoading(false);
      }
    );

    // Clean up subscription on unmount
    return () => {
      subscription.unsubscribe();
    };
  }, []);

  return { user, isLoading };
}

export interface UserProfile {
  id: string;
  user_id: string;
  first_name: string | null;
  last_name: string | null;
  avatar_url: string | null;
  created_at: string;
  updated_at: string;
}

/**
 * Update user profile with name information
 */
export async function updateUserProfile({
  firstName,
  lastName,
  avatarUrl,
}: {
  firstName: string;
  lastName: string;
  avatarUrl?: string;
}): Promise<boolean> {
  try {
    const { data: userData, error: userError } = await supabase.auth.getUser();
    
    if (userError || !userData.user) {
      console.error("Error getting current user:", userError);
      return false;
    }
    
    const updateData: any = {
      first_name: firstName,
      last_name: lastName,
      updated_at: new Date().toISOString(),
    };
    
    // Only include avatar_url if it's provided
    if (avatarUrl !== undefined) {
      updateData.avatar_url = avatarUrl;
    }
    
    const { error: updateError } = await supabase
      .from("profiles")
      .update(updateData)
      .eq("user_id", userData.user.id);
    
    if (updateError) {
      console.error("Error updating profile:", updateError);
      return false;
    }
    
    return true;
  } catch (err) {
    console.error("Error in updateUserProfile:", err);
    return false;
  }
}

/**
 * Sign in with email and password
 */
/**
 * Create a profile for a user if it doesn't exist
 */
export async function ensureUserProfile(userId: string) {
  try {
    // Check if profile already exists
    const { data: existingProfile } = await supabase
      .from("profiles")
      .select("id")
      .eq("user_id", userId)
      .single();
    
    if (existingProfile) {
      return true; // Profile already exists
    }
    
    // Create profile if it doesn't exist
    const { error } = await supabase
      .from("profiles")
      .insert({
        id: userId,
        user_id: userId,
        first_name: "",
        last_name: "",
        avatar_url: "",
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      });
    
    if (error) {
      console.error("Error creating user profile:", error);
      return false;
    }
    
    return true;
  } catch (err) {
    console.error("Error in ensureUserProfile:", err);
    return false;
  }
}

export async function signIn({
  email,
  password,
}: {
  email: string;
  password: string;
}) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password,
  });

  if (error) {
    console.error("Supabase auth error:", error.message);
    throw error;
  }

  // Create profile for user if needed
  if (data.user) {
    await ensureUserProfile(data.user.id);
  }

  return data;
}

/**
 * Sign up with email and password
 */
export async function signUp({
  email,
  password,
}: {
  email: string;
  password: string;
}) {
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      emailRedirectTo: `${window.location.origin}/auth/callback`,
    },
  });

  if (error) {
    console.error("Supabase signup error:", error.message);
    throw error;
  }

  // Create profile for user if needed
  if (data.user) {
    await ensureUserProfile(data.user.id);
  }

  return data;
}

/**
 * Sign out the current user
 */
export async function signOut() {
  const { error } = await supabase.auth.signOut();

  if (error) {
    console.error("Supabase signout error:", error.message);
    throw error;
  }

  return true;
}

/**
 * Check if there's a current session
 */
export async function getSession() {
  const { data, error } = await supabase.auth.getSession();

  if (error) {
    console.error("Error getting session:", error.message);
    return null;
  }

  return data.session;
}

/**
 * Get the current user (for client components)
 * @deprecated Use getCurrentUser instead which matches your existing API
 */
export async function getUser() {
  const {
    data: { user },
    error,
  } = await supabase.auth.getUser();

  if (error) {
    console.error("Error getting user:", error.message);
    return null;
  }

  return user;
}

/**
 * Get the current user (for backward compatibility)
 */
export async function getCurrentUser(): Promise<AuthUser | null> {
  const {
    data: { user },
    error,
  } = await supabase.auth.getUser();

  if (error) {
    console.error("Error getting current user:", error.message);
    return null;
  }

  return user;
}

/**
 * Get user profile data
 */
export async function getUserProfile(
  userId: string,
): Promise<UserProfile | null> {
  if (!userId) {
    return null;
  }

  const { data, error } = await supabase
    .from("profiles")
    .select("*")
    .eq("user_id", userId)
    .single();

  if (error) {
    console.error("Error fetching user profile:", error);
    return null;
  }

  return data as UserProfile;
}

