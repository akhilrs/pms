import { createMiddlewareClient } from "@supabase/auth-helpers-nextjs";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  const supabase = createMiddlewareClient({ req, res });

  try {
    const {
      data: { session },
    } = await supabase.auth.getSession();

    // If there's no session and the user is trying to access a protected route
    if (!session && isProtectedRoute(req.nextUrl.pathname)) {
      const redirectUrl = new URL("/login", req.url);
      redirectUrl.searchParams.set("redirectedFrom", req.nextUrl.pathname);
      return NextResponse.redirect(redirectUrl);
    }
  } catch (error) {
    console.error("Middleware error:", error);
    // On error, redirect to login for protected routes
    if (isProtectedRoute(req.nextUrl.pathname)) {
      return NextResponse.redirect(new URL("/login", req.url));
    }
  }

  return res;
}

function isProtectedRoute(pathname: string): boolean {
  return (
    pathname.startsWith("/dashboard") ||
    pathname.startsWith("/projects") ||
    pathname === "/dashboard" ||
    pathname === "/projects"
  );
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
