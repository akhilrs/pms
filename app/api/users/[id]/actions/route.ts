// app/api/users/[id]/actions/route.ts
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import {
  sendPasswordResetLink,
  generateInviteLink,
} from "@/lib/supabase/users";
import { requireAuth } from "@/lib/supabase/auth-helpers";

// Schema for action request
const actionSchema = z.object({
  action: z.enum(["reset-password", "generate-invite"]),
  email: z.string().email("Invalid email address").optional(),
});

// POST /api/users/[id]/actions - Perform actions on a user
export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    // Check if user is authenticated and has admin access
    const authUser = await requireAuth();

    // TODO: Add admin role check here once roles are implemented

    // Parse and validate request body
    const body = await req.json();
    const validation = actionSchema.safeParse(body);

    if (!validation.success) {
      return NextResponse.json(
        { error: validation.error.errors },
        { status: 400 },
      );
    }

    const { action, email } = validation.data;

    if (action === "reset-password") {
      if (!email) {
        return NextResponse.json(
          { error: "Email is required for password reset" },
          { status: 400 },
        );
      }

      const { success, error } = await sendPasswordResetLink(email);

      if (error) {
        return NextResponse.json({ error: error.message }, { status: 500 });
      }

      return NextResponse.json({ success });
    } else if (action === "generate-invite") {
      const { data, error } = await generateInviteLink(params.id);

      if (error) {
        return NextResponse.json({ error: error.message }, { status: 500 });
      }

      return NextResponse.json({ data });
    }

    return NextResponse.json(
      { error: "Invalid action specified" },
      { status: 400 },
    );
  } catch (error) {
    console.error("Error in user actions route:", error);
    return NextResponse.json(
      { error: "Unauthorized or server error" },
      { status: 401 },
    );
  }
}
