'use client';

import React, { useState, useEffect } from 'react';
import { signUp, signIn, signOut, getCurrentUser, UserProfile, getUserProfile } from '@/lib/supabase/auth';
import { supabase } from '@/lib/supabase/client';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';

export default function SupabaseAuthTestPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [status, setStatus] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [response, setResponse] = useState<any | null>(null);
  const [currentUser, setCurrentUser] = useState<any | null>(null);
  const [profile, setProfile] = useState<UserProfile | null>(null);

  // Check if user is already logged in on page load
  useEffect(() => {
    const checkUser = async () => {
      try {
        const user = await getCurrentUser();
        setCurrentUser(user);
        
        if (user) {
          try {
            const userProfile = await getUserProfile(user.id);
            setProfile(userProfile);
          } catch (err) {
            console.error('Error fetching profile:', err);
          }
        }
      } catch (err) {
        console.error('Error checking user:', err);
      }
    };
    
    checkUser();
  }, []);

  const handleSignUp = async () => {
    try {
      setStatus('Signing up...');
      setError(null);
      setResponse(null);

      const result = await signUp({
        email,
        password,
        first_name: firstName,
        last_name: lastName,
      });

      setStatus('Signup successful!');
      setResponse(result);
      
      // Refresh user
      const user = await getCurrentUser();
      setCurrentUser(user);
      
      if (user) {
        try {
          const userProfile = await getUserProfile(user.id);
          setProfile(userProfile);
        } catch (err) {
          console.error('Error fetching profile:', err);
        }
      }
    } catch (err: any) {
      setStatus('Signup failed');
      setError(err.message || 'Unknown error');
      console.error('Signup error:', err);
    }
  };

  const handleSignIn = async () => {
    try {
      setStatus('Signing in...');
      setError(null);
      setResponse(null);

      const result = await signIn({
        email,
        password,
      });

      setStatus('Signin successful!');
      setResponse(result);
      
      // Refresh user
      const user = await getCurrentUser();
      setCurrentUser(user);
      
      if (user) {
        try {
          const userProfile = await getUserProfile(user.id);
          setProfile(userProfile);
        } catch (err) {
          console.error('Error fetching profile:', err);
        }
      }
    } catch (err: any) {
      setStatus('Signin failed');
      setError(err.message || 'Unknown error');
      console.error('Signin error:', err);
    }
  };

  const handleSignOut = async () => {
    try {
      setStatus('Signing out...');
      setError(null);
      setResponse(null);

      await signOut();

      setStatus('Signout successful!');
      setResponse(null);
      setCurrentUser(null);
      setProfile(null);
    } catch (err: any) {
      setStatus('Signout failed');
      setError(err.message || 'Unknown error');
      console.error('Signout error:', err);
    }
  };

  const checkSession = async () => {
    try {
      setStatus('Checking session...');
      setError(null);
      setResponse(null);

      const user = await getCurrentUser();
      
      setCurrentUser(user);
      setStatus(user ? 'User is logged in' : 'No active session');
      setResponse(user);
      
      if (user) {
        try {
          const userProfile = await getUserProfile(user.id);
          setProfile(userProfile);
        } catch (err) {
          console.error('Error fetching profile:', err);
        }
      }
    } catch (err: any) {
      setStatus('Session check failed');
      setError(err.message || 'Unknown error');
      console.error('Session check error:', err);
    }
  };

  return (
    <div className="container mx-auto p-8">
      <h1 className="text-3xl font-bold mb-6">Supabase Auth Test</h1>
      
      <div className="grid md:grid-cols-2 gap-8">
        <Card className="mb-8">
          <CardHeader>
            <CardTitle>Authentication Actions</CardTitle>
            <CardDescription>Test Supabase authentication functionality</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="email">Email</Label>
              <Input
                id="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="user@example.com"
              />
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="password">Password</Label>
              <Input
                id="password"
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
              />
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="firstName">First Name</Label>
              <Input
                id="firstName"
                value={firstName}
                onChange={(e) => setFirstName(e.target.value)}
                placeholder="First Name"
              />
            </div>
            
            <div className="space-y-2">
              <Label htmlFor="lastName">Last Name</Label>
              <Input
                id="lastName"
                value={lastName}
                onChange={(e) => setLastName(e.target.value)}
                placeholder="Last Name"
              />
            </div>
          </CardContent>
          <CardFooter className="flex flex-wrap gap-2">
            <Button onClick={handleSignUp}>Sign Up</Button>
            <Button onClick={handleSignIn}>Sign In</Button>
            <Button onClick={handleSignOut} variant="outline">Sign Out</Button>
            <Button onClick={checkSession} variant="secondary">Check Session</Button>
          </CardFooter>
        </Card>
        
        <Card>
          <CardHeader>
            <CardTitle>Status & Response</CardTitle>
            <CardDescription>Results from authentication operations</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {status && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold">Status:</h2>
                <p className="p-2 bg-gray-100 rounded">{status}</p>
              </div>
            )}
            
            {error && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold text-red-500">Error:</h2>
                <p className="p-2 bg-red-50 text-red-500 rounded">{error}</p>
              </div>
            )}
            
            {currentUser && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold">Current User:</h2>
                <pre className="p-2 bg-gray-100 rounded overflow-x-auto text-sm">
                  {JSON.stringify({
                    id: currentUser.id,
                    email: currentUser.email,
                    role: currentUser.role,
                    aud: currentUser.aud,
                    created_at: currentUser.created_at
                  }, null, 2)}
                </pre>
              </div>
            )}
            
            {profile && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold">User Profile:</h2>
                <pre className="p-2 bg-gray-100 rounded overflow-x-auto text-sm">
                  {JSON.stringify(profile, null, 2)}
                </pre>
              </div>
            )}
            
            {response && !currentUser && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold">Response:</h2>
                <pre className="p-2 bg-gray-100 rounded overflow-x-auto text-sm">
                  {JSON.stringify(response, null, 2)}
                </pre>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
      
      <div className="mt-8">
        <h2 className="text-xl font-semibold mb-4">Supabase Configuration</h2>
        <pre className="p-4 bg-gray-100 rounded overflow-x-auto text-sm">
          {`URL: ${process.env.NEXT_PUBLIC_SUPABASE_URL || 'Not set'}
Anon Key: ${(process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'Not set').substring(0, 10)}...`}
        </pre>
      </div>
    </div>
  );
} 