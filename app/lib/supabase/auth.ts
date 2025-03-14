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
  first_name: string;
  last_name: string;
}

export interface SignInCredentials {
  email: string;
  password: string;
}

export async function signUp({ email, password, first_name, last_name }: SignUpCredentials) {
  try {
    console.log('Starting signup process with custom API...', { email });
    
    // Ensure all data is properly formatted to avoid JSON issues
    const userData = {
      email: String(email).trim(),
      password: String(password),
      first_name: first_name ? String(first_name).trim() : '',
      last_name: last_name ? String(last_name).trim() : ''
    };
    
    console.log('Sending signup data:', {
      ...userData,
      password: '[REDACTED]'
    });
    
    // Use our custom API endpoint instead of Supabase auth directly
    const response = await fetch('/api/auth/signup', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userData)
    });
    
    const responseData = await response.json();
    console.log('Signup API response status:', response.status);
    
    if (!response.ok) {
      const errorMessage = responseData.details || responseData.error || 'Failed to sign up';
      const error = new Error(errorMessage);
      console.error('Custom auth.signUp error:', error);
      throw error;
    }

    const { user, session } = responseData;
    console.log('Signup successful, user data:', user);

    // Profile is now created in the backend, no need to create it here
    return { user, session };
  } catch (error) {
    console.error('Exception during signup process:', error);
    throw error;
  }
}

export async function signIn({ email, password }: SignInCredentials) {
  try {
    console.log('Starting signin process with custom API...', { email });
    
    // Ensure all data is properly formatted to avoid JSON issues
    const userData = {
      email: String(email).trim(),
      password: String(password)
    };
    
    console.log('Sending signin data:', {
      ...userData,
      password: '[REDACTED]'
    });
    
    // Use our custom API endpoint instead of Supabase auth directly
    const response = await fetch('/api/auth/signin', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userData)
    });
    
    const responseData = await response.json();
    console.log('Signin API response status:', response.status);
    
    if (!response.ok) {
      const errorMessage = responseData.details || responseData.error || 'Failed to sign in';
      const error = new Error(errorMessage);
      console.error('Custom auth.signIn error:', error);
      throw error;
    }

    return responseData;
  } catch (error) {
    console.error('Exception during signin process:', error);
    throw error;
  }
}

export async function signOut() {
  const { error } = await supabase.auth.signOut();
  if (error) {
    throw error;
  }
}

export async function getCurrentUser() {
  try {
    // Use our custom session endpoint instead of Supabase
    const response = await fetch('/api/auth/session', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    });
    
    const data = await response.json();
    
    // If we have a user in the response, return it
    if (data.user) {
      return data.user;
    }
    
    // Fallback to Supabase check if our custom session endpoint didn't find a user
    try {
      const { data: { session }, error } = await supabase.auth.getSession();
      
      if (error) {
        console.warn('Error getting Supabase session:', error);
        return null;
      }
      
      return session?.user || null;
    } catch (supabaseError) {
      console.error('Error checking Supabase session:', supabaseError);
      return null;
    }
  } catch (error) {
    console.error('Error checking session:', error);
    return null;
  }
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