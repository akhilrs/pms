import { cookies } from "next/headers";
import { createServerComponentClient } from "@supabase/auth-helpers-nextjs";
import { createServerActionClient } from "@supabase/auth-helpers-nextjs";
import { Database } from "@/types/supabase";

/**
 * Creates a Supabase client for use in server components
 * This is the recommended way to access Supabase in server components
 */
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

/**
 * Creates a Supabase client for use in server actions
 */
export function createActionClient() {
  return createServerActionClient<Database>({ cookies });
}

/**
 * Gets the current session in a server component
 */
export async function getSession() {
  try {
    const supabase = await createServerClient();
    const {
      data: { session },
    } = await supabase.auth.getSession();
    return session;
  } catch (error) {
    console.error("Error getting session in server component:", error);
    return null;
  }
}

/**
 * Gets the current user in a server component
 */
export async function getUser() {
  try {
    const session = await getSession();
    return session?.user || null;
  } catch (error) {
    console.error("Error getting user in server component:", error);
    return null;
  }
}

/**
 * Requires authentication, throws if not authenticated
 */
export async function requireAuth() {
  const user = await getUser();

  if (!user) {
    throw new Error("Authentication required");
  }

  return user;
}
