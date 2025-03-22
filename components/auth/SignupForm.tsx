import React, { useState } from 'react';
import { useRouter } from 'next/router';

const SignupForm: React.FC = () => {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);

    try {
      // Use our custom API endpoint instead of Supabase auth
      const response = await fetch('/api/auth/signup', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email,
          password,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Failed to sign up');
      }

      // If signup was successful, redirect to the dashboard
      router.push('/dashboard');
    } catch (error) {
      console.error('Signup error:', error);
      setError((error as Error).message);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div>
      {/* Render your form here */}
    </div>
  );
};

export default SignupForm; 