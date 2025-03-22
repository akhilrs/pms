# Basecamp Clone Project

A comprehensive project management application built with Next.js, Supabase, and shadcn/ui.

## Current Progress

As of [current date], we've implemented the following core functionality:

### Completed Features

1. **Project Setup**
   - Next.js 15 with App Router
   - Tailwind CSS with shadcn/ui components
   - TypeScript for type safety
   - Supabase for backend services (auth, database, storage)
   - Docker/Podman setup for local development

2. **Project Management**
   - Project listing with filtering and sorting
   - Project creation with form validation
   - Project details view with timeline, team, and progress information
   - Project editing functionality
   - Project deletion with confirmation dialog
   - Dashboard with project statistics and recent projects

3. **UI Components**
   - DashboardLayout with sidebar navigation
   - Project card component for displaying project information
   - Project form for adding/editing projects
   - Delete confirmation dialog

### Project Structure

```
app/
├── app/                    # Next.js App Router
│   ├── dashboard/          # Dashboard page
│   ├── projects/           # Project management pages
│   │   ├── page.tsx        # Projects list page
│   │   ├── new/            # Create new project
│   │   ├── [id]/           # Project details
│   │   │   ├── page.tsx    # Project details page
│   │   │   ├── edit/       # Edit project
│   │   ├── actions.ts      # Server actions for projects
├── components/             # React components
│   ├── common/             # Common components like layout
│   ├── projects/           # Project-related components
│   │   ├── project-card.tsx
│   │   ├── project-form.tsx
│   │   ├── project-list.tsx
│   │   ├── project-delete-button.tsx
│   ├── ui/                 # UI components from shadcn/ui
├── lib/                    # Utility functions and services
│   ├── supabase/           # Supabase client and APIs
│   │   ├── client.ts       # Supabase client setup
│   │   ├── projects.ts     # Project-related database operations
│   │   ├── auth.ts         # Authentication functions
├── types/                  # TypeScript type definitions
│   ├── supabase.ts         # Supabase database types
├── supabase/               # Local Supabase setup
│   ├── docker-compose.yml  # Docker configuration for Supabase
```

## Setup Instructions

### Prerequisites

- Node.js 18 or higher
- Docker/Podman for local Supabase development

### Getting Started

1. **Clone the repository**

```bash
git clone [your-repository-url]
cd basecamp-clone
```

2. **Install dependencies**

```bash
cd app
npm install
```

3. **Set up environment variables**

Create a `.env.local` file in the `app` directory with the following:

```
NEXT_PUBLIC_SUPABASE_URL=http://localhost:8000
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

4. **Start Supabase locally**

```bash
cd supabase
podman-compose up -d
```

If you're using Podman instead of Docker, make sure to update the docker-compose.yml file to use specific image versions and proper port configurations.

5. **Run the development server**

```bash
cd app
npm run dev
```

The application should now be running at [http://localhost:3000](http://localhost:3000).

## Database Schema

Our core database tables:

1. **profiles** - User profiles with personal information
2. **projects** - Project information and metadata
3. **project_members** - Relationship between projects and users

## Next Steps

The following features are planned for future development:

1. **Task Management**
   - Create and manage tasks within projects
   - Assign tasks to team members
   - Track task status and completion

2. **Team Management**
   - Invite users to projects
   - Manage user roles and permissions
   - Team member profiles

3. **File Management**
   - Upload and store files
   - File previews and downloads
   - File organization within projects

4. **Messaging**
   - Project-level messaging
   - Real-time updates with Supabase Realtime
   - Notification system

5. **Activity Tracking**
   - Track user activity within projects
   - Create activity feeds
   - Generate reports

## Troubleshooting

### Supabase Connection Issues

If you encounter issues with Supabase connection:

1. Ensure Supabase containers are running: `podman ps`
2. Check if the ports are correctly mapped
3. Verify your environment variables are correct

### Port Conflicts

If you encounter port conflicts when starting Supabase services, you can modify the port mappings in the `docker-compose.yml` file.

## Contributing

[Your contribution guidelines here]

## License

[Your license information here]
