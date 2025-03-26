import { Metadata } from 'next';
import { DashboardLayout } from '@/components/common/layout';
import { getServerSession } from '@/lib/supabase/server-auth';
import { redirect } from 'next/navigation';
import { NewProjectForm } from '@/components/projects/new-project-form';

export const metadata: Metadata = {
  title: 'Create New Project | Basecamp Clone',
  description: 'Create a new project in your Basecamp Clone',
};

export default async function NewProjectPage() {
  // Check authentication with server-side method
  const session = await getServerSession();
  const userId = session?.user?.id;
  
  // If not authenticated, redirect to login
  if (!userId) {
    console.log('New project page - No user session found, redirecting to login');
    redirect('/auth/login?returnTo=/projects/new');
  }
  
  console.log('New project page - User authenticated:', userId);
  
  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6">
            <h1 className="text-2xl font-bold">Create New Project</h1>
            <p className="text-gray-600 mb-6">Fill out the form below to create a new project.</p>
            
            {/* Pass userId to the client component */}
            <NewProjectForm userId={userId} />
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
} 