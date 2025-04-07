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