import { NextRequest, NextResponse } from "next/server";
import { getUserById, updateUser, deleteUser } from "@/lib/supabase/users";
import { requireAuth } from "@/lib/supabase/auth-helpers";

// GET /api/users/[id] - Get a user by ID
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    // Store params.id in variable to avoid Next.js warning
    const userId = params.id;

    // Check if user is authenticated
    const authUser = await requireAuth();

    const { data, error } = await getUserById(userId);

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    if (!data) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    return NextResponse.json({ data });
  } catch (error) {
    console.error("Error in user GET route:", error);
    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}

// PATCH /api/users/[id] - Update a user
export async function PATCH(
  req: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    const userId = params.id;

    // Check if user is authenticated
    const authUser = await requireAuth();

    // Parse request body
    const body = await req.json();

    // Update the user
    const { data, error } = await updateUser(userId, {
      firstName: body.firstName,
      lastName: body.lastName,
      avatarUrl: body.avatarUrl,
      isActive: body.isActive,
      password: body.password,
    });

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    if (!data) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    return NextResponse.json({ data });
  } catch (error) {
    console.error("Error in user PATCH route:", error);
    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}

// DELETE /api/users/[id] - Delete a user
export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    const userId = params.id;

    // Check if user is authenticated
    const authUser = await requireAuth();

    const { success, error } = await deleteUser(userId);

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    if (!success) {
      return NextResponse.json(
        { error: "Failed to delete user" },
        { status: 500 },
      );
    }

    return NextResponse.json({ success: true }, { status: 200 });
  } catch (error) {
    console.error("Error in user DELETE route:", error);
    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}
