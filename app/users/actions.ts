"use server";

import { revalidatePath } from "next/cache";
import {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
  sendPasswordResetLink,
  generateInviteLink,
} from "@/lib/supabase/users";
import { requireAuth } from "@/lib/supabase/auth-helpers";

/**
 * Get all users
 */
export async function getUsersAction() {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    return await getAllUsers();
  } catch (error) {
    console.error("Error in getUsersAction:", error);
    return { data: null, error: { message: "Unauthorized or server error" } };
  }
}

/**
 * Get a user by ID
 */
export async function getUserAction(userId: string) {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    return await getUserById(userId);
  } catch (error) {
    console.error("Error in getUserAction:", error);
    return { data: null, error: { message: "Unauthorized or server error" } };
  }
}

/**
 * Create a new user
 */
export async function createUserAction(userData: {
  email: string;
  password: string;
  firstName?: string;
  lastName?: string;
  isActive?: boolean;
}) {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    const result = await createUser(userData);

    if (result.data) {
      revalidatePath("/users");
    }

    return result;
  } catch (error) {
    console.error("Error in createUserAction:", error);
    return { data: null, error: { message: "Unauthorized or server error" } };
  }
}

/**
 * Update a user
 */
export async function updateUserAction(
  userId: string,
  updates: {
    firstName?: string;
    lastName?: string;
    avatarUrl?: string;
    isActive?: boolean;
    password?: string;
  },
) {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    const result = await updateUser(userId, updates);

    if (result.data) {
      revalidatePath("/users");
      revalidatePath(`/users/${userId}`);
    }

    return result;
  } catch (error) {
    console.error("Error in updateUserAction:", error);
    return { data: null, error: { message: "Unauthorized or server error" } };
  }
}

/**
 * Delete a user
 */
export async function deleteUserAction(userId: string) {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    const result = await deleteUser(userId);

    if (result.success) {
      revalidatePath("/users");
    }

    return result;
  } catch (error) {
    console.error("Error in deleteUserAction:", error);
    return {
      success: false,
      error: { message: "Unauthorized or server error" },
    };
  }
}

/**
 * Send password reset link
 */
export async function sendPasswordResetAction(email: string) {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    return await sendPasswordResetLink(email);
  } catch (error) {
    console.error("Error in sendPasswordResetAction:", error);
    return {
      success: false,
      error: { message: "Unauthorized or server error" },
    };
  }
}

/**
 * Generate invite link for a user
 */
export async function generateInviteLinkAction(userId: string) {
  try {
    // Check if user is authenticated
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    return await generateInviteLink(userId);
  } catch (error) {
    console.error("Error in generateInviteLinkAction:", error);
    return { data: null, error: { message: "Unauthorized or server error" } };
  }
}
