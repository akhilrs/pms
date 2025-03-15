import { supabase } from './client';
import { User } from '@supabase/supabase-js';

export type AuthUser = User;

export interface UserProfile {
  id: string;
  first_name: string | null;
  last_name: string | null;
  avatar_url: string | null;
  created_at: string;
  updated_at: string;
}

export interface SignUpCredentials {
  email: string;
  password: string;
  first_name?: string;
  last_name?: string;
}

export interface SignInCredentials {
  email: string;
  password: string;
}

export async function signUp({ email, password, first_name, last_name }: SignUpCredentials) {
  try {
    console.log('Starting signup process with Supabase...', { email });
    
    // Use Supabase auth directly
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          first_name,
          last_name
        }
      }
    });
    
    if (error) {
      console.error('Supabase auth.signUp error:', error);
      throw error;
    }

    console.log('Signup successful', data);
    
    // Create profile in database if signup was successful
    if (data.user) {
      try {
        const profile = await createUserProfile(data.user.id, first_name, last_name);
        console.log('Profile created:', profile);
      } catch (profileError) {
        // Don't fail the signup if profile creation fails
        console.error('Failed to create profile:', profileError);
      }
    }

    return data;
  } catch (error) {
    console.error('Exception during signup process:', error);
    throw error;
  }
}

export async function signIn({ email, password }: SignInCredentials) {
  try {
    console.log('Starting signin process with Supabase...', { email });
    
    // Use Supabase auth directly
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    });
    
    if (error) {
      console.error('Supabase auth.signIn error:', error);
      throw error;
    }

    console.log('Signin successful', data);
    return data;
  } catch (error) {
    console.error('Exception during signin process:', error);
    throw error;
  }
}

export async function signOut() {
  try {
    const { error } = await supabase.auth.signOut();
    if (error) {
      console.error('Supabase auth.signOut error:', error);
      throw error;
    }
    console.log('Signout successful');
  } catch (error) {
    console.error('Exception during signout process:', error);
    throw error;
  }
}

export async function getCurrentUser() {
  try {
    const { data: { user }, error } = await supabase.auth.getUser();
    
    if (error) {
      console.warn('Error getting user:', error);
      return null;
    }
    
    return user;
  } catch (error) {
    console.error('Error checking session:', error);
    return null;
  }
}

// Helper function to create a user profile
async function createUserProfile(userId: string, first_name?: string, last_name?: string) {
  const { data, error } = await supabase
    .from('profiles')
    .insert([
      {
        id: userId,
        first_name: first_name || null,
        last_name: last_name || null,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      }
    ])
    .select()
    .single();

  if (error) {
    throw error;
  }

  return data;
}

export async function getUserProfile(userId: string) {
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .single();

  if (error) {
    throw error;
  }

  return data as UserProfile;
}

export async function updateUserProfile(userId: string, updates: Partial<UserProfile>) {
  const { data, error } = await supabase
    .from('profiles')
    .update(updates)
    .eq('id', userId)
    .select()
    .single();

  if (error) {
    throw error;
  }

  return data as UserProfile;
}

export async function uploadAvatar(userId: string, file: File) {
  const fileExt = file.name.split('.').pop();
  const fileName = `${userId}-${Math.random().toString(36).substring(2)}.${fileExt}`;
  const filePath = `avatars/${fileName}`;

  const { error: uploadError } = await supabase.storage
    .from('avatars')
    .upload(filePath, file);

  if (uploadError) {
    throw uploadError;
  }

  const { data } = supabase.storage.from('avatars').getPublicUrl(filePath);

  const { error: updateError } = await supabase
    .from('profiles')
    .update({
      avatar_url: data.publicUrl,
    })
    .eq('id', userId);

  if (updateError) {
    throw updateError;
  }

  return data.publicUrl;
} 