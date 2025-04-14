// app/users/[id]/page.tsx
import { Metadata } from "next";
import { APP_NAME } from "@/lib/constants";
import { notFound } from "next/navigation";
import { getUserById } from "@/lib/supabase/users";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import { ArrowLeft, Edit } from "lucide-react";
import { UserDetails } from "@/components/users/user-details";
import { getUser } from "@/lib/supabase/auth-helpers";
import { redirect } from "next/navigation";
import { DashboardLayout } from "@/components/common";

interface UserPageProps {
  params: Promise<{
    id: string;
  }>;
}

export async function generateMetadata({ params }: UserPageProps): Promise<Metadata> {
  // Safely access params
  const { id } = await params;

  try {
    const { data: user } = await getUserById(id);
    return {
      title: user
        ? `${user.first_name || ""} ${user.last_name || ""} | ${APP_NAME}`
        : `User Details | ${APP_NAME}`,
      description: "View and manage user details",
    };
  } catch (error) {
    console.error("Error generating metadata:", error);
    return {
      title: `User Details | ${APP_NAME}`,
      description: "View and manage user details",
    };
  }
}

export default async function UserPage({ params }: UserPageProps) {
  // Safely access params
  const { id: userId } = await params;

  // Check authentication
  const currentUser = await getUser();
  if (!currentUser) {
    redirect("/auth/login?redirectTo=/users");
  }

  // Get user directly from the service, not via action
  const { data: user, error } = await getUserById(userId);

  if (error || !user) {
    notFound();
  }

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
          <div>
            <h1 className="text-3xl font-bold">
              {user.first_name || ""} {user.last_name || ""}
            </h1>
            <p className="text-gray-600 mt-1">
              {user.email || "No email available"}
            </p>
          </div>
          <div className="flex gap-2">
            <Button variant="outline" asChild>
              <Link href="/users">
                <ArrowLeft className="mr-2 h-4 w-4" />
                Back
              </Link>
            </Button>
            <Button variant="outline" asChild>
              <Link href={`/users/edit/${userId}`}>
                <Edit className="h-4 w-4 mr-2" />
                Edit
              </Link>
            </Button>
          </div>
        </div>

        <UserDetails user={user} />
      </div>
    </DashboardLayout>
  );
}
