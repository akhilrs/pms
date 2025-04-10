# Supabase Database Setup

This directory contains SQL migrations for setting up the Basecamp Clone database in Supabase.

## Database Recreation

The `recreate_database.sql` script provides a clean slate setup that:

1. Drops all existing tables (project_members, projects, profiles)
2. Creates tables with proper structure and relationships
3. Sets up Row Level Security (RLS) policies
4. Creates triggers for automatic profile creation

## How to Apply the Migrations

### Using Supabase Studio

1. Log in to your Supabase dashboard at [app.supabase.com](https://app.supabase.com)
2. Select your project
3. Navigate to the SQL Editor
4. Click "New Query"
5. Paste the contents of `recreate_database.sql` into the editor
6. Run the script by clicking the "Run" button

**WARNING**: Running this script will delete all existing data in the specified tables.

### Optional - Creating Sample Data

The script includes commented-out sample data insertion at the end. If you want to create sample data:

1. Uncomment the INSERT statements at the end of the script
2. Replace `'your-user-id-here'` with your actual Supabase user ID
3. Run the script

## Database Structure

The database consists of three main tables:

### Profiles

A table for user profile information linked to Supabase auth users:

- `id`: Primary key, references auth.users
- `user_id`: Also references auth.users (for flexibility)
- `first_name`, `last_name`: User names
- `avatar_url`: Profile picture URL
- `created_at`, `updated_at`: Timestamps

### Projects

Main project table:

- `id`: Primary key
- `name`, `description`: Project details
- `owner_id`: References auth.users
- `status`: Project status (e.g., "Planning", "In Progress")
- `visibility`: Public/private setting
- `created_at`, `updated_at`: Timestamps

### Project Members

Junction table for project memberships:

- `id`: Primary key
- `project_id`: References projects
- `user_id`: References auth.users
- `role`: Role in project (e.g., "owner", "member")
- `joined_at`: Timestamp

## RLS Policies

The script sets up these RLS policies:

### For Profiles
- Users can view any profile
- Users can only update their own profile

### For Projects
- Project owners have full access to their projects
- Members can view projects they're part of
- Anyone can view public projects

### For Project Members
- Users can see their own memberships
- Project owners can manage all memberships for their projects
- Members can view other members of their projects
- Users can add themselves to public projects

## Troubleshooting

If you encounter the "infinite recursion detected in policy" error after applying these changes, try:

1. Verifying all policies were created correctly
2. Checking the Policies tab in Supabase Studio
3. If issues persist, consider manually verifying each policy from the Supabase dashboard 