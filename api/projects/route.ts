import { NextRequest, NextResponse } from 'next/server';
import { supabase, getServiceSupabase } from '@/lib/supabase/client';
import { formatDateForSupabase } from '@/lib/utils';

export async function POST(request: NextRequest) {
  try {
    // Parse the request body
    const formData = await request.json();
    
    // Log the request headers for debugging
    console.log('Request headers:', Object.fromEntries([...request.headers]));
    
    // Try multiple methods to get the session
    console.log('Attempting to get session using regular client...');
    const { data: { session }, error: sessionError } = await supabase.auth.getSession();
    
    console.log('Session attempt result:', { 
      hasSession: !!session, 
      userId: session?.user?.id, 
      error: sessionError 
    });
    
    // If no session, try to get the auth token from Authorization header
    let userId = session?.user?.id;
    if (!userId) {
      console.log('No session found, checking for token in headers...');
      const authHeader = request.headers.get('authorization');
      if (authHeader && authHeader.startsWith('Bearer ')) {
        const token = authHeader.substring(7);
        console.log('Found token in header, attempting to get user...');
        
        const { data: { user }, error: userError } = await supabase.auth.getUser(token);
        if (user) {
          userId = user.id;
          console.log('Retrieved user from token:', userId);
        } else if (userError) {
          console.error('Error getting user from token:', userError);
        }
      } else {
        console.log('No authorization header found');
      }
    }
    
    // Last check - logging in is required
    if (!userId) {
      console.error('No authenticated user could be found');
      return NextResponse.json(
        { error: 'Authentication required. Please log in again.' },
        { status: 401 }
      );
    }
    
    // Create project
    console.log('Creating project with owner ID:', userId);
    try {
      // Format dates properly as ISO strings for Supabase
      const start_date = formData.start_date ? formatDateForSupabase(new Date(formData.start_date)) : null;
      const end_date = formData.end_date ? formatDateForSupabase(new Date(formData.end_date)) : null;
      
      const projectData = {
        name: formData.name,
        description: formData.description || null,
        status: formData.status,
        start_date, // Now properly formatted ISO string
        end_date,   // Now properly formatted ISO string
        owner_id: userId,
      };
      
      console.log('Project data to be created:', JSON.stringify(projectData, null, 2));
      
      // Use the service role client which bypasses RLS
      console.log('Creating project with service role client (bypassing RLS)');
      const adminClient = getServiceSupabase();
      
      // Create project directly with admin client
      const { data: project, error: projectError } = await adminClient
        .from('projects')
        .insert(projectData)
        .select()
        .single();
      
      if (projectError) {
        console.error('Project creation error details:', projectError);
        return NextResponse.json(
          { error: `Failed to create project: ${projectError.message || JSON.stringify(projectError)}` },
          { status: 500 }
        );
      }
      
      if (!project) {
        console.error('Project creation returned no data');
        return NextResponse.json(
          { error: 'Failed to create project: No project data returned' },
          { status: 500 }
        );
      }
      
      // Add the creator as an owner of the project
      console.log('Adding user as project owner');
      const { error: memberError } = await adminClient
        .from('project_members')
        .insert({
          project_id: project.id,
          user_id: userId,
          role: 'owner',
          joined_at: new Date().toISOString(),
        });
      
      if (memberError) {
        console.error('Error adding project owner:', memberError);
        // We don't fail the whole operation if this fails
      }
      
      // Return success response with the created project
      console.log('Project created successfully:', project.id);
      return NextResponse.json({
        success: true,
        project,
        redirectTo: `/projects/${project.id}`,
      });
    } catch (projectError) {
      console.error('Project creation caught error:', projectError);
      return NextResponse.json(
        { error: `Failed to create project: ${projectError instanceof Error ? projectError.message : 'Unknown error'}` },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Project creation API error:', error);
    return NextResponse.json(
      { error: 'Failed to create project' },
      { status: 500 }
    );
  }
} 