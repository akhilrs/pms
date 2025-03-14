'use client';

import React, { useState } from 'react';
import Link from 'next/link';

export default function AuthTestPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [status, setStatus] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [response, setResponse] = useState<any | null>(null);

  const handleSignUp = async () => {
    try {
      setStatus('Signing up...');
      setError(null);
      setResponse(null);

      const res = await fetch('/api/auth/signup', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email,
          password,
          first_name: firstName,
          last_name: lastName,
        }),
      });

      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.error || 'Failed to sign up');
      }

      setStatus('Signup successful!');
      setResponse(data);
    } catch (err: any) {
      setError(err.message || 'An error occurred during signup');
      setStatus('Signup failed');
    }
  };

  const handleSignIn = async () => {
    try {
      setStatus('Signing in...');
      setError(null);
      setResponse(null);

      const res = await fetch('/api/auth/signin', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email,
          password,
        }),
      });

      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.error || 'Failed to sign in');
      }

      setStatus('Signin successful!');
      setResponse(data);
    } catch (err: any) {
      setError(err.message || 'An error occurred during signin');
      setStatus('Signin failed');
    }
  };

  const handleSignOut = async () => {
    try {
      setStatus('Signing out...');
      setError(null);
      setResponse(null);

      const res = await fetch('/api/auth/signout', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const data = await res.json();
      
      if (!res.ok) {
        throw new Error(data.error || 'Failed to sign out');
      }

      setStatus('Signout successful!');
      setResponse(data);
    } catch (err: any) {
      setError(err.message || 'An error occurred during signout');
      setStatus('Signout failed');
    }
  };

  const checkSession = async () => {
    try {
      setStatus('Checking session...');
      setError(null);
      setResponse(null);

      const res = await fetch('/api/auth/session', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const data = await res.json();
      setStatus('Session check complete');
      setResponse(data);
    } catch (err: any) {
      setError(err.message || 'An error occurred checking session');
      setStatus('Session check failed');
    }
  };

  const checkUsers = async () => {
    try {
      setStatus('Checking users in database...');
      setError(null);
      setResponse(null);

      const res = await fetch('/api/auth/users');
      const data = await res.json();
      
      setStatus(`Found ${data.count} users in database`);
      setResponse(data);
    } catch (err: any) {
      setError(err.message || 'An error occurred checking users');
      setStatus('Users check failed');
    }
  };

  const testUrls = async () => {
    try {
      setStatus('Testing URLs...');
      setError(null);
      setResponse(null);

      const res = await fetch('/api/auth/test-urls');
      const data = await res.json();
      
      setStatus('URL testing complete');
      setResponse(data);
    } catch (err: any) {
      setError(err.message || 'An error occurred during URL testing');
      setStatus('URL testing failed');
    }
  };

  return (
    <div className="container mx-auto p-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Authentication Test</h1>
        <Link href="/auth/login" className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
          Go to Login Page
        </Link>
      </div>
      
      <div className="bg-white rounded-lg shadow-md p-6 mb-8">
        <h2 className="text-xl font-semibold mb-4">User Credentials</h2>
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          <div>
            <label className="block text-sm font-medium mb-1" htmlFor="email">
              Email
            </label>
            <input
              id="email"
              type="email"
              className="w-full p-2 border rounded"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1" htmlFor="password">
              Password
            </label>
            <input
              id="password"
              type="password"
              className="w-full p-2 border rounded"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1" htmlFor="firstName">
              First Name
            </label>
            <input
              id="firstName"
              type="text"
              className="w-full p-2 border rounded"
              value={firstName}
              onChange={(e) => setFirstName(e.target.value)}
            />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1" htmlFor="lastName">
              Last Name
            </label>
            <input
              id="lastName"
              type="text"
              className="w-full p-2 border rounded"
              value={lastName}
              onChange={(e) => setLastName(e.target.value)}
            />
          </div>
        </div>
      </div>

      <div className="flex flex-wrap gap-4 mb-8">
        <button
          onClick={handleSignUp}
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
        >
          Sign Up
        </button>
        <button
          onClick={handleSignIn}
          className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700"
        >
          Sign In
        </button>
        <button
          onClick={handleSignOut}
          className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700"
        >
          Sign Out
        </button>
        <button
          onClick={checkSession}
          className="px-4 py-2 bg-purple-600 text-white rounded hover:bg-purple-700"
        >
          Check Session
        </button>
        <button
          onClick={checkUsers}
          className="px-4 py-2 bg-yellow-600 text-white rounded hover:bg-yellow-700"
        >
          Check Users
        </button>
        <button
          onClick={testUrls}
          className="px-4 py-2 bg-gray-600 text-white rounded hover:bg-gray-700"
        >
          Test URLs
        </button>
      </div>

      {status && (
        <div className="mb-6">
          <h2 className="text-xl font-semibold mb-2">Status</h2>
          <div className="bg-gray-100 p-4 rounded">{status}</div>
        </div>
      )}

      {error && (
        <div className="mb-6">
          <h2 className="text-xl font-semibold mb-2 text-red-600">Error</h2>
          <div className="bg-red-100 text-red-800 p-4 rounded">{error}</div>
        </div>
      )}

      {response && (
        <div className="mb-6">
          <h2 className="text-xl font-semibold mb-2">Response</h2>
          <pre className="bg-gray-100 p-4 rounded overflow-auto max-h-96">
            {JSON.stringify(response, null, 2)}
          </pre>
        </div>
      )}

      <div className="bg-yellow-50 p-4 rounded border border-yellow-200 mt-8">
        <h2 className="text-lg font-semibold mb-2">Instructions</h2>
        <ul className="list-disc list-inside space-y-1">
          <li>Fill in the email and password fields.</li>
          <li>For sign up, also provide a first and last name.</li>
          <li>Click "Sign Up" to create a new account.</li>
          <li>Use the same credentials and click "Sign In" to login.</li>
          <li>Click "Sign Out" to log out of your account.</li>
          <li>Click "Check Session" to verify if you are logged in.</li>
          <li>Click "Check Users" to see all users in the database.</li>
          <li>Click "Test URLs" to test various authentication endpoints.</li>
        </ul>
      </div>
    </div>
  );
} 