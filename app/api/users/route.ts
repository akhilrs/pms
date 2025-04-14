// app/api/users/route.ts
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { getAllUsers, createUser } from "@/lib/supabase/users";
import { requireAuth } from "@/lib/supabase/auth-helpers";

// Schema for creating a user
const createUserSchema = z.object({
  email: z.string().email("Invalid email address"),
  password: z.string().min(8, "Password must be at least 8 characters"),
  firstName: z.string().optional(),
  lastName: z.string().optional(),
  isActive: z.boolean().optional(),
});

// GET /api/users - Get all users
export async function GET(req: NextRequest) {
  try {
    // Check if user is authenticated and has admin access
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented
    // For now, we're allowing any authenticated user to access this endpoint

    const { data, error } = await getAllUsers();

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ data });
  } catch (error) {
    console.error("Error in users GET route:", error);
    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}

// POST /api/users - Create a new user
export async function POST(req: NextRequest) {
  try {
    // Check if user is authenticated and has admin access
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    // Parse and validate request body
    const body = await req.json();
    const validation = createUserSchema.safeParse(body);

    if (!validation.success) {
      return NextResponse.json(
        { error: validation.error.errors },
        { status: 400 },
      );
    }

    // Create the user
    const { email, password, firstName, lastName, isActive } = validation.data;

    const { data, error } = await createUser({
      email,
      password,
      firstName,
      lastName,
      isActive,
    });

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ data }, { status: 201 });
  } catch (error) {
    console.error("Error in users POST route:", error);
    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}
