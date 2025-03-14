# Project Management App - Complete Plan

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Technology Stack](#technology-stack)
3. [Database Schema](#database-schema)
4. [API Endpoints](#api-endpoints)
5. [Project Folder Structure](#project-folder-structure)
6. [Authentication Flow](#authentication-flow)
7. [Common Supabase Queries](#common-supabase-queries)
8. [Implementation Plan](#implementation-plan)
9. [Deployment Strategy](#deployment-strategy)
10. [Future Enhancements](#future-enhancements)

## Architecture Overview

This project follows a modern web application architecture using Next.js for both frontend and backend (API routes), with Supabase as the backend service providing database, authentication, storage, and real-time capabilities.

The system is divided into logical layers:
- **Client Layer**: React components (with shadcn-ui) rendered through Next.js pages
- **API Layer**: Next.js API routes that interact with Supabase
- **Backend Services**: Supabase providing PostgreSQL database, authentication, storage
- **Deployment**: Vercel for hosting the Next.js application

## Technology Stack

### Frontend
- **Framework**: Next.js 14+ (App Router)
- **UI Library**: shadcn-ui (based on Radix UI primitives)
- **Styling**: Tailwind CSS
- **State Management**: React Context API + React Query
- **Form Handling**: React Hook Form + Zod validation
- **Date Handling**: date-fns
- **Icons**: Lucide React

### Backend
- **API Routes**: Next.js API routes
- **Database**: PostgreSQL (via Supabase)
- **Authentication**: Supabase Auth (JWT-based)
- **File Storage**: Supabase Storage
- **Real-time**: Supabase Realtime

### Development Tools
- **Language**: TypeScript
- **Linting**: ESLint
- **Formatting**: Prettier
- **Version Control**: Git
- **IDE**: VS Code with Cursor AI

### Deployment
- **Platform**: Vercel
- **Database Hosting**: Supabase Cloud

## Database Schema

### Tables

#### 1. profiles
```sql
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### 2. projects
```sql
CREATE TABLE public.projects (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'Planning' CHECK (status IN ('Planning', 'In Progress', 'On Hold', 'Completed', 'Canceled')),
  start_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP WITH TIME ZONE,
  owner_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### 3. project_members
```sql
CREATE TABLE public.project_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('owner', 'admin', 'member')),
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(project_id, user_id)
);
```

#### 4. tasks
```sql
CREATE TABLE public.tasks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'To Do' CHECK (status IN ('To Do', 'In Progress', 'Completed')),
  priority TEXT NOT NULL DEFAULT 'Medium' CHECK (priority IN ('Low', 'Medium', 'High')),
  due_date TIMESTAMP WITH TIME ZONE,
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  assignee_id UUID REFERENCES auth.users(id),
  creator_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### 5. comments
```sql
CREATE TABLE public.comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  content TEXT NOT NULL,
  task_id UUID REFERENCES public.tasks(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### 6. files
```sql
CREATE TABLE public.files (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  size INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  storage_path TEXT NOT NULL,
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  uploaded_by UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### 7. messages
```sql
CREATE TABLE public.messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  content TEXT NOT NULL,
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### 8. activities
```sql
CREATE TABLE public.activities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  entity_type TEXT NOT NULL, -- 'project', 'task', 'comment', etc.
  entity_id UUID NOT NULL,
  action TEXT NOT NULL, -- 'created', 'updated', 'deleted', etc.
  details JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Database Functions

#### Project Stats
```sql
CREATE OR REPLACE FUNCTION get_project_stats(project_uuid UUID)
RETURNS TABLE (
  total_tasks BIGINT,
  completed_tasks BIGINT,
  pending_tasks BIGINT,
  overdue_tasks BIGINT,
  progress NUMERIC
) LANGUAGE plpgsql AS $$
BEGIN
  RETURN QUERY
  WITH stats AS (
    SELECT
      COUNT(*) AS total,
      COUNT(*) FILTER (WHERE status = 'Completed') AS completed,
      COUNT(*) FILTER (WHERE status != 'Completed') AS pending,
      COUNT(*) FILTER (WHERE status != 'Completed' AND due_date < NOW()) AS overdue
    FROM public.tasks
    WHERE project_id = project_uuid
  )
  SELECT 
    total,
    completed,
    pending,
    overdue,
    CASE WHEN total > 0 THEN ROUND((completed::NUMERIC / total) * 100, 2) ELSE 0 END
  FROM stats;
END;
$$;
```

#### Activity Logging
```sql
CREATE OR REPLACE FUNCTION log_activity(
  project_uuid UUID,
  user_uuid UUID,
  entity_type_val TEXT,
  entity_id_val UUID,
  action_val TEXT,
  details_val JSONB DEFAULT NULL
) RETURNS UUID LANGUAGE plpgsql AS $$
DECLARE
  activity_id UUID;
BEGIN
  INSERT INTO public.activities (
    project_id, user_id, entity_type, entity_id, action, details
  ) VALUES (
    project_uuid, user_uuid, entity_type_val, entity_id_val, action_val, details_val
  )
  RETURNING id INTO activity_id;
  
  RETURN activity_id;
END;
$$;
```

#### Create Project with Owner as Member
```sql
CREATE OR REPLACE FUNCTION create_project_with_member(
  p_name TEXT,
  p_description TEXT,
  p_status TEXT,
  p_start_date TIMESTAMP WITH TIME ZONE,
  p_end_date TIMESTAMP WITH TIME ZONE,
  p_owner_id UUID
) RETURNS JSONB LANGUAGE plpgsql AS $$
DECLARE
  new_project_id UUID;
  new_member_id UUID;
BEGIN
  -- Insert the project
  INSERT INTO public.projects (
    name, description, status, start_date, end_date, owner_id
  ) VALUES (
    p_name, p_description, p_status, p_start_date, p_end_date, p_owner_id
  ) RETURNING id INTO new_project_id;
  
  -- Add the owner as a member with 'owner' role
  INSERT INTO public.project_members (
    project_id, user_id, role
  ) VALUES (
    new_project_id, p_owner_id, 'owner'
  ) RETURNING id INTO new_member_id;
  
  RETURN jsonb_build_object(
    'project_id', new_project_id,
    'member_id', new_member_id
  );
END;
$$;
```

### Row Level Security Policies

Key RLS policies to set up:

```sql
-- Projects: Users can view projects they own or are members of
CREATE POLICY "Users can view their projects" 
  ON public.projects FOR SELECT USING (
    owner_id = auth.uid() OR 
    EXISTS (
      SELECT 1 FROM public.project_members 
      WHERE project_id = id AND user_id = auth.uid()
    )
  );

-- Tasks: Users can view and manage tasks in their projects
CREATE POLICY "Users can view tasks in their projects" 
  ON public.tasks FOR SELECT USING (
    creator_id = auth.uid() OR 
    assignee_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.project_members 
      WHERE project_id = project_id AND user_id = auth.uid()
    )
  );
```

## API Endpoints

### Authentication

- `POST /api/auth/login` - User login with email/password
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/logout` - User logout
- `GET /api/auth/user` - Get current user information
- `PUT /api/auth/user` - Update user profile

### Projects

- `GET /api/projects` - List projects for current user
- `POST /api/projects` - Create new project
- `GET /api/projects/:id` - Get project details
- `PUT /api/projects/:id` - Update project
- `DELETE /api/projects/:id` - Delete project
- `GET /api/projects/:id/members` - List project members
- `POST /api/projects/:id/members` - Add member to project
- `DELETE /api/projects/:id/members/:userId` - Remove project member

### Tasks

- `GET /api/projects/:id/tasks` - List tasks for project
- `POST /api/projects/:id/tasks` - Create new task
- `GET /api/tasks/:id` - Get task details
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task
- `POST /api/tasks/:id/comments` - Add comment to task
- `GET /api/tasks/:id/comments` - Get task comments

### Files

- `GET /api/projects/:id/files` - List files for project
- `POST /api/projects/:id/files` - Upload file
- `GET /api/files/:id` - Get file details
- `DELETE /api/files/:id` - Delete file

### Messages

- `GET /api/projects/:id/messages` - List messages for project
- `POST /api/projects/:id/messages` - Create new message
- `PUT /api/messages/:id` - Update message
- `DELETE /api/messages/:id` - Delete message

### Reports

- `GET /api/projects/:id/reports/overview` - Get project overview statistics
- `GET /api/projects/:id/reports/tasks` - Get task statistics
- `GET /api/projects/:id/reports/activities` - Get recent activities

## Project Folder Structure

```
project-management-app/
├── components/
│   ├── auth/
│   │   ├── login-form.tsx
│   │   ├── register-form.tsx
│   │   └── auth-guard.tsx
│   ├── common/
│   │   ├── layout.tsx
│   │   ├── header.tsx
│   │   ├── sidebar.tsx
│   │   └── loading.tsx
│   ├── projects/
│   │   ├── project-card.tsx
│   │   ├── project-list.tsx
│   │   ├── project-form.tsx
│   │   ├── project-detail.tsx
│   │   └── project-members.tsx
│   ├── tasks/
│   │   ├── task-list.tsx
│   │   ├── task-card.tsx
│   │   ├── task-form.tsx
│   │   └── task-detail.tsx
│   ├── files/
│   │   ├── file-list.tsx
│   │   ├── file-upload.tsx
│   │   └── file-item.tsx
│   ├── messages/
│   │   ├── message-list.tsx
│   │   ├── message-form.tsx
│   │   └── message-item.tsx
│   └── reports/
│       ├── project-overview.tsx
│       ├── task-stats.tsx
│       └── activity-feed.tsx
├── lib/
│   ├── supabase/
│   │   ├── client.ts
│   │   ├── auth.ts
│   │   ├── projects.ts
│   │   ├── tasks.ts
│   │   ├── files.ts
│   │   └── messages.ts
│   ├── utils/
│   │   ├── date-utils.ts
│   │   ├── format-utils.ts
│   │   └── validation.ts
│   └── constants.ts
├── pages/
│   ├── _app.tsx
│   ├── index.tsx
│   ├── auth/
│   │   ├── login.tsx
│   │   └── register.tsx
│   ├── dashboard.tsx
│   ├── projects/
│   │   ├── index.tsx
│   │   ├── new.tsx
│   │   └── [id]/
│   │       ├── index.tsx
│   │       ├── edit.tsx
│   │       ├── tasks/
│   │       │   ├── index.tsx
│   │       │   └── [taskId].tsx
│   │       ├── files.tsx
│   │       ├── messages.tsx
│   │       └── reports.tsx
│   ├── profile.tsx
│   └── settings.tsx
├── api/
│   ├── auth/
│   │   ├── login.ts
│   │   ├── register.ts
│   │   ├── logout.ts
│   │   └── user.ts
│   ├── projects/
│   │   ├── index.ts
│   │   ├── [id].ts
│   │   └── [id]/
│   │       ├── members.ts
│   │       ├── tasks.ts
│   │       ├── files.ts
│   │       ├── messages.ts
│   │       └── reports.ts
│   ├── tasks/
│   │   ├── [id].ts
│   │   └── [id]/comments.ts
│   └── files/
│       └── [id].ts
├── styles/
│   ├── globals.css
│   └── variables.css
├── types/
│   ├── supabase.ts
│   ├── auth.ts
│   ├── projects.ts
│   ├── tasks.ts
│   ├── files.ts
│   └── messages.ts
├── public/
│   ├── favicon.ico
│   └── images/
├── prisma/
│   └── schema.prisma
├── .env.local
├── .env.example
├── next.config.js
├── package.json
├── tsconfig.json
├── tailwind.config.js
└── README.md
```

## Authentication Flow

1. **User Registration**:
   - User submits registration form with email, password, name
   - Client calls Supabase auth.signUp() API
   - On success, automatically create a profile record
   - Redirect to dashboard or confirmation page

2. **User Login**:
   - User submits login form with email and password
   - Client calls Supabase auth.signInWithPassword() API
   - On success, store session in browser and redirect to dashboard

3. **Session Management**:
   - Supabase handles session storage and token refreshing
   - App checks for active session on initial load
   - AuthGuard component protects private routes

4. **Logout**:
   - User clicks logout button
   - Client calls Supabase auth.signOut() API
   - Clear local session and redirect to login page

## Common Supabase Queries

### Authentication Queries

```typescript
// Login
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'password123'
})

// Register
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'password123',
  options: {
    data: {
      first_name: 'John',
      last_name: 'Doe'
    }
  }
})

// Get current user
const { data: { session }, error } = await supabase.auth.getSession()
const user = session?.user
```

### Project Queries

```typescript
// Get projects for current user
const { data: projects, error } = await supabase
  .from('projects')
  .select(`
    *,
    owner:owner_id(*),
    members:project_members(id, role, user:user_id(*))
  `)
  .or(`owner_id.eq.${userId},id.in.(${memberProjectIds.join(',')})`)
  .order('created_at', { ascending: false })

// Create project
const { data, error } = await supabase
  .from('projects')
  .insert({
    name: 'New Project',
    description: 'Project description',
    owner_id: userId
  })
  .select()
  .single()

// Get project with details
const { data: project, error } = await supabase
  .from('projects')
  .select(`
    *,
    owner:owner_id(*),
    members:project_members(id, role, user:user_id(*))
  `)
  .eq('id', projectId)
  .single()
```

### Task Queries

```typescript
// Get tasks for a project
const { data: tasks, error } = await supabase
  .from('tasks')
  .select(`
    *,
    creator:creator_id(*),
    assignee:assignee_id(*)
  `)
  .eq('project_id', projectId)
  .order('created_at', { ascending: false })

// Create task
const { data: task, error } = await supabase
  .from('tasks')
  .insert({
    title: 'New Task',
    description: 'Task description',
    status: 'To Do',
    priority: 'Medium',
    project_id: projectId,
    creator_id: userId
  })
  .select()
  .single()

// Update task status
const { data, error } = await supabase
  .from('tasks')
  .update({ status: 'Completed' })
  .eq('id', taskId)
  .select()
  .single()
```

### File Queries

```typescript
// Upload file to storage
const { data, error } = await supabase.storage
  .from('project-files')
  .upload(`${projectId}/${fileName}`, fileData, {
    contentType: 'application/pdf'
  })

// Create file record
const { data: file, error } = await supabase
  .from('files')
  .insert({
    name: 'document.pdf',
    size: 12345,
    mime_type: 'application/pdf',
    storage_path: `${projectId}/${fileName}`,
    project_id: projectId,
    uploaded_by: userId
  })
  .select()
  .single()

// Get file public URL
const { data } = supabase.storage.from('project-files').getPublicUrl(filePath)
const fileUrl = data.publicUrl
```

### Realtime Subscriptions

```typescript
// Subscribe to new tasks
const subscription = supabase
  .channel('tasks')
  .on(
    'postgres_changes',
    {
      event: 'INSERT',
      schema: 'public',
      table: 'tasks',
      filter: `project_id=eq.${projectId}`
    },
    (payload) => {
      // Handle new task
      console.log('New task:', payload.new)
      // Update UI
    }
  )
  .subscribe()

// Clean up subscription when component unmounts
return () => {
  supabase.removeChannel(subscription)
}
```

## Implementation Plan

### Week 1: Foundation & Core Features

#### Day 1-2: Setup & Authentication
- Set up Next.js project with TypeScript, Tailwind CSS
- Install shadcn-ui components
- Create Supabase project and set up database schema
- Implement authentication (login, register, profile)

#### Day 3-4: Projects & Dashboard
- Create dashboard layout with header and sidebar
- Implement project listing and creation
- Build project detail page
- Add project member management

#### Day 5-7: Task Management
- Implement task list and task creation
- Build task detail view with comments
- Add task filtering and sorting
- Implement task status updates

### Week 2: Additional Features & Polish

#### Day 8-9: File Management & Messages
- Add file upload functionality
- Implement file listing and previews
- Build team messaging system
- Add real-time updates for messages

#### Day 10-11: Reporting & Activity Tracking
- Implement project statistics dashboard
- Create activity feed
- Build task reports and charts
- Add user productivity tracking

#### Day 12-14: Testing, Fixing & Deployment
- Perform end-to-end testing
- Fix bugs and optimize performance
- Deploy to production on Vercel
- Set up continuous deployment

## Deployment Strategy

### Supabase Setup

1. **Database Configuration**:
   - Create a new Supabase project
   - Run the schema SQL scripts to create tables
   - Set up RLS policies for security
   - Create storage buckets for files

2. **Authentication Setup**:
   - Configure email authentication
   - Set up password reset flow
   - Define user profile handling

3. **Storage Configuration**:
   - Create `project-files` bucket with public access
   - Configure CORS settings
   - Set up RLS policies for storage

### Vercel Deployment

1. **Environment Setup**:
   - Set up environment variables:
     - `NEXT_PUBLIC_SUPABASE_URL`
     - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
     - `SUPABASE_SERVICE_ROLE_KEY` (for admin operations)

2. **Deployment Process**:
   - Connect GitHub repository to Vercel
   - Configure build settings
   - Set up automatic deployments for main branch
   - Configure preview deployments for PRs

3. **Post-Deployment**:
   - Set up custom domain (if needed)
   - Configure SSL
   - Set up monitoring

## Future Enhancements

1. **Advanced Features**:
   - Email notifications
   - Calendar integration
   - Gantt chart view for projects
   - Time tracking
   - Document collaboration
   - Custom project templates

2. **Performance Improvements**:
   - Implement client-side caching
   - Optimize database queries
   - Add pagination for large lists

3. **User Experience Upgrades**:
   - Dark mode support
   - Advanced filtering and search
   - Keyboard shortcuts
   - Drag-and-drop interfaces
   - Mobile app (React Native)

4. **Integration Possibilities**:
   - Slack/Teams integration
   - GitHub/GitLab integration
   - Google Drive/OneDrive integration
   - Zapier/Make automation
