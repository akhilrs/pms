# Basecamp Project Knowledge Base

## Project Overview

This project is a Basecamp-like project management application built with:
- Next.js for the framework
- Tailwind CSS for styling
- shadcn-ui components
- Supabase for backend (authentication, database, storage)

## Project Structure

The project follows a standard Next.js App Router structure:

```
/basecamp
├── app/                 # Next.js App Router pages and layouts
│   ├── api/             # API routes
│   ├── auth/            # Authentication related routes
│   ├── dashboard/       # Dashboard pages
│   ├── projects/        # Project management pages
│   └── ...              # Root layout, global styles, etc.
├── components/          # UI components
├── lib/                 # Utility functions and libraries
│   ├── supabase/        # Supabase client and helpers
│   └── utils/           # General utility functions
├── types/               # TypeScript type definitions
├── public/              # Static assets
├── middleware.ts        # Authentication middleware
├── next.config.ts       # Next.js configuration
└── ...                  # Config files, etc.
```

## Authentication System

### Authentication Flow

The authentication system uses Supabase Auth with PKCE flow for better security. The flow works as follows:

1. User initiates login through UI
2. Supabase Auth redirects to OAuth provider or shows email/password form
3. After auth, user is redirected to `/auth/callback` route
4. The callback route exchanges the code for a session
5. User is redirected to the projects page
6. Middleware refreshes the session on protected routes

### Key Authentication Files

- `middleware.ts` - Handles session refresh on protected routes
- `lib/supabase/client.ts` - Creates and configures Supabase clients
- `lib/supabase/auth-helpers.ts` - Server-component compatible auth helpers
- `lib/supabase/server-auth.ts` - Backward compatibility with existing code
- `lib/supabase/auth.ts` - Client-side auth functions
- `app/auth/callback/route.ts` - Handles OAuth callback

### Authentication Utilities

#### Server-Side Authentication

For server components and API routes:

```typescript
// Import helpers
import { getUser, requireAuth } from "@/lib/supabase/auth-helpers";

// Get user (returns null if not authenticated)
const user = await getUser();

// Require authentication (throws if not authenticated)
const user = await requireAuth();
```

#### Client-Side Authentication

For client components:

```typescript
import { useAuth } from "@/lib/supabase/auth";

function MyComponent() {
  const { user, signIn, signOut } = useAuth();
  
  // ...
}
```

### Supabase Client Configuration

The application uses multiple Supabase client configurations:

```typescript
// Standard client for general use
export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    flowType: "pkce", // Using PKCE flow for Next.js
  },
});

// Server component client
export async function createServerClient() {
  const cookieStore = await cookies();
  return createServerComponentClient<Database>({ 
    cookies: () => cookieStore 
  });
}

// Service role client for admin operations
export const getServiceSupabase = () => {
  return createClient<Database>(supabaseUrl, supabaseServiceKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });
};

// Browser-only client
export function createClientBrowser() {
  return createClient<Database>(supabaseUrl, supabaseAnonKey, {
    auth: {
      persistSession: true,
      storageKey: "supabase.auth.token",
      autoRefreshToken: true,
      detectSessionInUrl: true,
      flowType: "pkce",
    },
  });
}
```

### Middleware Configuration

The middleware is configured to run on protected routes to refresh the authentication session:

```typescript
// middleware.ts
export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  
  try {
    // Create a Supabase client for the middleware
    const supabase = createMiddlewareClient({ req, res });
    
    // Refresh session
    await supabase.auth.getSession();
  } catch (error) {
    console.error('Middleware error:', error);
  }
  
  return res;
}

// Match specific routes that need authentication
export const config = {
  matcher: [
    '/dashboard/:path*',
    '/projects/:path*',
    '/dashboard',
    '/projects',
    '/auth/callback',
  ],
};
```

## API Authentication

When working with API routes in Next.js 15, authentication can be tricky because cookies are not automatically available in the same way they are in server components. To ensure API routes can authenticate users properly:

### Best Practice for API Authentication

1. **Use `getServerSession()`** from `lib/supabase/server-auth.ts` as your primary authentication method:

```typescript
import { getServerSession } from '@/lib/supabase/server-auth';

export async function POST(request: NextRequest) {
  // Get user session using the same method as server components
  const session = await getServerSession();
  const userId = session?.user?.id;
  
  if (!userId) {
    // Handle unauthenticated users
    return NextResponse.json({ error: 'Authentication required' }, { status: 401 });
  }
  
  // Continue with authenticated operations
  // ...
}
```

2. **Multiple Fallback Methods**: If the primary method fails, try alternative approaches:

```typescript
// If getServerSession fails
if (!userId) {
  // Try client method
  const { data: { session: clientSession } } = await supabase.auth.getSession();
  userId = clientSession?.user?.id;
  
  // Try auth headers
  if (!userId) {
    const authHeader = request.headers.get('authorization');
    if (authHeader?.startsWith('Bearer ')) {
      const token = authHeader.substring(7);
      const { data } = await supabase.auth.getUser(token);
      userId = data.user?.id;
    }
  }
}
```

3. **Client-Side Fallbacks**: For form submissions, consider implementing a fallback strategy:

```typescript
// Try API route first
try {
  const response = await fetch('/api/resource', {
    method: 'POST',
    credentials: 'include', // Important for cookies
    // ...
  });
  
  if (!response.ok) throw new Error();
  
  // Handle success
} catch (error) {
  // Fall back to server actions
  await serverAction(data);
}
```

### Understanding the Authentication Chain

The authentication flow relies on these components working together:

1. Server-side authentication with `getServerSession()` that tries multiple methods
2. Cookie parsing and token extraction 
3. Verifying the token with Supabase
4. Service role client for bypassing RLS when needed

If you encounter authentication issues:
- Check the logs for authentication attempts
- Verify cookie names and values
- Ensure cookies are being sent with `credentials: 'include'`
- Consider implementing server actions as a more reliable alternative

## Next.js 15 Cookie Handling

In Next.js 15, the `cookies()` function became awaitable. This is a breaking change that affects how cookie access should be handled in server components and API routes.

### Key Issues

The codebase has several instances where `cookies()` is used without awaiting it, causing warnings:
- Warning: "Route '/projects' used `cookies().getAll()`. `cookies()` should be awaited before using its value"
- Warning: "Route '/projects' used `cookies().get('supabase.auth.token')`. `cookies()` should be awaited before using its value"

### Correct Pattern

The recommended way to access cookies in Next.js 15 is:

```typescript
// Old approach (causes warnings)
const cookieStore = cookies();
const value = cookieStore.get('key')?.value;

// New approach for Next.js 15
const cookieStore = await cookies();
const value = cookieStore.get('key')?.value;
```

### Files Needing Updates

These files need to be updated to fix the cookie warnings:

1. `lib/supabase/auth-helpers.ts`:
```typescript
// Current implementation
export function createServerClient() {
  try {
    const cookieStore = cookies();
    return createServerComponentClient<Database>({
      cookies: () => cookieStore,
    });
  } catch (error) {
    console.error("Error creating server client:", error);
    throw error;
  }
}

// Fixed implementation (to be applied)
export async function createServerClient() {
  try {
    const cookieStore = await cookies();
    return createServerComponentClient<Database>({
      cookies: () => cookieStore,
    });
  } catch (error) {
    console.error("Error creating server client:", error);
    throw error;
  }
}
```

2. `lib/supabase/server-auth.ts`:
```typescript
// In getServerSession() function, update:
const cookieStore = cookies();
// to:
const cookieStore = await cookies();
```

3. API routes that use cookies directly also need to be updated.

## Async Supabase Client Usage

When using the `createServerClient()` function that is now async, we need to ensure we properly await it throughout the codebase.

### Issues

After updating `createServerClient()` to properly await cookies(), we encountered these errors:
- TypeError: supabase.from is not a function
- Error occurs because the client was not fully initialized before attempting to use it

### Correct Pattern

```typescript
// Old approach (causes errors)
const supabase = createServerClient();
const { data } = await supabase.from('table').select('*');

// New approach (properly awaited)
const supabase = await createServerClient();
const { data } = await supabase.from('table').select('*');
```

### Key Files Updated

The following files needed to be updated to properly await the client:

1. `lib/supabase/projects.ts`: All project-related functions (getUserProjects, getProject, etc.)
2. `app/dashboard/page.tsx`: Added proper error handling around database calls
3. `app/projects/page.tsx`: Already had proper error handling

## Projects System

Projects are managed through the Supabase database with the following structure:

### Data Models

- `projects` - Core project information
- `project_members` - User membership in projects
- `profiles` - User profile information

### Project Functions

The `lib/supabase/projects.ts` file provides these key functions:

- `getUserProjects(userId)` - Get all projects for a user
- `getProject(projectId)` - Get a single project with details
- `createProject(projectData)` - Create a new project
- `updateProject(projectId, updates)` - Update a project
- `deleteProject(projectId)` - Delete a project

### RLS Policy Notes

The project uses Row Level Security (RLS) policies in Supabase to secure data. There were issues with infinite recursion in RLS policies for project members.

Simplified policies were needed to avoid the recursion:

```sql
-- Allow users to see their own memberships
CREATE POLICY "Users can view their own memberships" 
ON project_members FOR SELECT 
USING (auth.uid() = user_id);

-- Allow users to see other members of projects they're in
CREATE POLICY "Users can view memberships of their projects" 
ON project_members FOR SELECT 
USING (
  project_id IN (
    SELECT project_id FROM project_members WHERE user_id = auth.uid()
  )
);
```

## Next.js Configuration

The project uses a customized Next.js configuration to handle authentication and other features:

```typescript
// next.config.ts
/** @type {import('next').NextConfig} */
const nextConfig = {
  // Updated config for Next.js 15+
  experimental: {
    // Empty but keep it for future experimental features
  },
  // Moved from experimental to root level in Next.js 15
  serverExternalPackages: ["@supabase/auth-helpers-nextjs"],
  typescript: {
    // Temporarily ignore type errors in development
    ignoreBuildErrors: process.env.NODE_ENV === "development",
  },
};

module.exports = nextConfig;
```

Key changes in the Next.js configuration:
1. `serverExternalPackages` moved from experimental to root level in Next.js 15
2. TypeScript build errors are temporarily ignored in development to focus on fixing functionality
3. Empty experimental section retained for future use

## Development Fixes and Improvements

### Session Issues Fixed

Recent changes to fix session handling included:

1. Middleware implementation for automatic session refresh
2. Separation of server and client authentication methods
3. Multiple fallback methods for session retrieval
4. Better error handling and logging for authentication

### Project Structure Cleanup

The codebase was reorganized from the nested `basecamp/app/` structure to a cleaner `basecamp/` structure to fix routing and import issues. This resolved:

1. Duplicate app directories (`/app` and `/app/app`)
2. Conflicting route files
3. Inconsistent import paths using `@/lib` vs `@/app/lib`
4. Dynamic route parameter handling errors

### Next.js 15 Compatibility

The codebase has been updated for Next.js 15 compatibility, including:

1. Updated cookie handling to use async/await patterns
2. Moved experimental config options to standard config
3. Fixed server component API compatibility issues
4. Fixed warnings about `cookies()` methods that need to be awaited
5. Fixed Supabase client initialization with proper await handling

## Known Issues and TODOs

1. Cookie handling in Next.js 15 needs more refinement
   - Warning: "Route '/projects' used `cookies().getAll()`. `cookies()` should be awaited before using its value"
   - Warning: "Route '/projects' used `cookies().get('supabase.auth.token')`. `cookies()` should be awaited before using its value"

2. Authentication state persistence
   - Session detection is not working consistently between pages
   - Projects listing page shows "Not logged in" in debug info despite authentication

3. Error handling improvements
   - Better user-facing error messages for authentication issues
   - More graceful fallbacks when authentication fails

4. Supabase RLS policies
   - Need to implement the SQL fixes for RLS policies to resolve infinite recursion issues
   - Create a proper profiles table with the recommended structure 