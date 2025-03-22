# Database Migrations

This directory contains SQL migrations for setting up the database schema in Supabase.

## Migration Order

The migrations should be executed in the following order:

1. `00000000000001_create_projects_table.sql`: Creates the projects table
2. `00000000000002_create_project_members_table.sql`: Creates the project_members table
3. `00000000000003_create_tasks_table.sql`: Creates the tasks table
4. `00000000000004_create_comments_table.sql`: Creates the comments table
5. `00000000000005_create_files_table.sql`: Creates the files table
6. `00000000000006_create_messages_table.sql`: Creates the messages table
7. `00000000000007_create_activities_table.sql`: Creates the activities table

## Executing Migrations

Migrations can be executed in the Supabase Dashboard under the SQL Editor, or via the Supabase CLI with:

```
supabase db reset
```

or

```
supabase migration up
```

## Schema Overview

- **projects**: Main project information
- **project_members**: Linking users to projects with roles
- **tasks**: Project tasks with status, priority, and assignments
- **comments**: Comments on tasks
- **files**: Uploaded files for projects
- **messages**: Project discussion messages
- **activities**: Audit trail of all actions in the system

Each table has appropriate Row Level Security policies to ensure data access is properly controlled. 