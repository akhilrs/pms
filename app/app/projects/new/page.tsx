'use client';

import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import { DashboardLayout } from '@/components/common/layout';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { ProjectForm, ProjectFormValues } from '@/components/projects/project-form';
import { toast } from 'sonner';
import { createClientBrowser } from '@/lib/supabase/client';

export default function NewProjectPage() {
  const router = useRouter();
  const [isLoading, setIsLoading] = useState(true);
  const [userToken, setUserToken] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  // Check authentication status on component mount
  useEffect(() => {
    const checkAuth = async () => {
      try {
        setIsLoading(true);
        // Create client-side only Supabase client
        const supabase = createClientBrowser();
        
        // Get the current session
        const { data: { session }, error } = await supabase.auth.getSession();
        
        if (error) {
          console.error('Error checking auth:', error);
          setError('Authentication error. Please log in again.');
          return;
        }
        
        if (!session) {
          console.log('No session found, redirecting to login');
          setError('Please log in to create a project');
          // Optional: redirect to login page
          // router.push('/login');
          return;
        }
        
        // Store access token for API calls
        setUserToken(session.access_token);
        console.log('Auth check successful, token available');
      } catch (err) {
        console.error('Auth check failed:', err);
        setError('Failed to verify authentication');
      } finally {
        setIsLoading(false);
      }
    };
    
    checkAuth();
  }, [router]);

  const handleSubmit = async (formData: ProjectFormValues) => {
    try {
      if (!userToken) {
        throw new Error('Not authenticated. Please log in again.');
      }
      
      // Use the fetch API to call our project creation API route
      const response = await fetch('/api/projects', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${userToken}` // Pass token in Authorization header
        },
        body: JSON.stringify(formData),
        credentials: 'include' // Important for cookies
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Failed to create project');
      }

      toast.success('Project created successfully');
      
      // Redirect to the project page
      if (data.redirectTo) {
        router.push(data.redirectTo);
      } else {
        router.push('/projects');
      }
      
    } catch (error) {
      console.error('Error creating project:', error);
      throw error; // Let the form component handle the error display
    }
  };

  if (isLoading) {
    return (
      <DashboardLayout>
        <div className="max-w-3xl mx-auto">
          <Card>
            <CardContent className="pt-6">
              <div className="flex justify-center items-center py-10">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-gray-900"></div>
              </div>
            </CardContent>
          </Card>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <Card>
          <CardHeader>
            <CardTitle>Create New Project</CardTitle>
            <CardDescription>
              Fill out the form below to create a new project.
            </CardDescription>
          </CardHeader>
          <CardContent>
            {error ? (
              <div className="p-4 bg-red-50 border border-red-200 rounded-md text-red-800 mb-4">
                <p>{error}</p>
                <button 
                  onClick={() => router.push('/auth/login')}
                  className="mt-2 px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700"
                >
                  Go to Login
                </button>
              </div>
            ) : (
              <ProjectForm onSubmit={handleSubmit} />
            )}
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
} 