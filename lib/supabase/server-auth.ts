import { getSession, requireAuth } from "./auth-helpers";
import { cookies } from "next/headers";
import { supabase } from "./client";

/**
 * Gets the current user session in a server component
 * Maintains backward compatibility with your existing code
 */
export async function getServerSession() {
  try {
    // First try the new method using auth-helpers
    const session = await getSession();

    if (session) {
      console.log(
        "Server auth - Got session via auth-helpers:",
        session.user.id,
      );
      return session;
    }

    // Try using standard method with supabase client as fallback
    try {
      const {
        data: { session: stdSession },
      } = await supabase.auth.getSession();

      if (stdSession) {
        console.log(
          "Server auth - Got session via standard method:",
          stdSession.user.id,
        );
        return stdSession;
      }
    } catch (stdError) {
      console.warn("Server auth - Error with standard method:", stdError);
    }

    // Try with cookies directly as last resort
    try {
      const cookieStore = await cookies();
      const accessToken = cookieStore.get("sb-localhost-auth-token")?.value;

      if (accessToken) {
        console.log("Server auth - Found auth token in cookies");

        const { data, error } = await supabase.auth.getUser(accessToken);

        if (data.user) {
          console.log(
            "Server auth - Validated user from cookie:",
            data.user.id,
          );
          return { user: data.user };
        }

        if (error) {
          console.warn("Server auth - Cookie validation error:", error);
        }
      }
    } catch (cookieError) {
      console.error("Server auth - Error accessing cookies:", cookieError);
    }

    console.log("Server auth - No session found after trying all methods");
    return null;
  } catch (error) {
    console.error("Server auth - Unexpected error:", error);
    return null;
  }
}

/**
 * Gets the authenticated user, or null if not authenticated
 */
export async function getAuthenticatedUser() {
  const session = await getServerSession();
  return session?.user || null;
}

/**
 * Requires authentication, throws if not authenticated
 */
export { requireAuth };
