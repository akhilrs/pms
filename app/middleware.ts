import { createMiddlewareClient } from "@supabase/auth-helpers-nextjs";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();

  try {
    // Create a Supabase client configured for the middleware
    const supabase = createMiddlewareClient({ req, res });

    // Refresh session if it exists
    await supabase.auth.getSession();
  } catch (error) {
    console.error("Middleware error:", error);
  }

  return res;
}

// Specify routes that need authentication session refresh
export const config = {
  matcher: [
    // Protected routes
    "/dashboard/:path*",
    "/projects/:path*",
    "/dashboard",
    "/projects",

    // Auth callback route
    "/auth/callback",
  ],
};
