# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Development: `npm run dev` (uses turbopack)
- Production build: `npm run build`
- Start production server: `npm run start`
- Linting: `npm run lint` 
- Linting specific file: `npm run lint --file path/to/file.tsx`

## Code Style Guidelines
- **TypeScript**: Strong typing with Zod for validation
- **Imports**: Group by type (React, libs, components, utils)
- **Components**: React 19 with Client Components ("use client")
- **Naming**: camelCase for variables/functions, PascalCase for components/types
- **Error Handling**: try/catch blocks with toast notifications
- **UI Components**: Use shadcn/ui components from `/components/ui`
- **Forms**: Use react-hook-form with Zod validation schemas
- **API Routes**: Follow Next.js App Router API patterns
- **Authentication**: Supabase Auth with PKCE flow
- **Data Access**: Supabase client with typed Database interface

## Project Structure
- `/app`: Next.js App Router pages and API routes
- `/components`: Reusable React components
- `/lib`: Utilities and service clients (Supabase)
- `/public`: Static assets

## Architecture Patterns
- **Server/Client Boundary**: Follow React Server Components pattern - server components fetch data, client components handle interactivity
- **Server Actions**: Use server actions in `app/*/actions.ts` files for data mutations
- **Service Role**: Use `getServiceSupabase()` when you need to bypass RLS policies (use sparingly)
- **Component Pattern**: For interactive sections that use server actions:
  1. Create a client component (`'use client'`) that handles the UI and interactivity
  2. Create local handler functions that invoke server actions
  3. Use this client component from server components to maintain proper boundaries

## Common Issues & Solutions
- **Event Handler Error**: "Event handlers cannot be passed to Client Component props" means you're trying to pass server actions directly to client components. Create a client wrapper component that invokes the server actions instead.
- **RLS Policies**: When adding records that need permission to add themselves (like team members), use the service role client to bypass RLS temporarily.
- **TeamForm vs ProjectForm**: TeamForm doesn't use a Card wrapper, while ProjectForm is styled without Card. The parent component should provide any Card wrappers.