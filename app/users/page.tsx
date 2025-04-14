// app/users/page.tsx
import { APP_NAME } from "@/lib/constants";
import { getAllUsers } from "@/lib/supabase/users";
import { UserListSimple } from "@/components/users/user-list-simple";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import { PlusCircle } from "lucide-react";
import { getUser } from "@/lib/supabase/auth-helpers";
import { redirect } from "next/navigation";
import { DashboardLayout } from "@/components/common";

export default async function UsersPage() {
  // Check authentication
  const user = await getUser();
  if (!user) {
    redirect("/auth/login?redirectTo=/users");
  }

  // Get users directly from the service
  const { data: users, error } = await getAllUsers();

  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">Users</h1>
            <p className="text-gray-600">
              Manage users and their access to the application
            </p>
          </div>
          <Button asChild>
            <Link href="/users/new">
              <PlusCircle className="h-4 w-4 mr-2" />
              New User
            </Link>
          </Button>
        </div>

        {!user ? (
          <div className="bg-yellow-100 p-4 rounded-md mb-4">
            <p className="font-semibold">Authentication Required</p>
            <p className="text-sm text-gray-700 mt-1">
              Please sign in to view users
            </p>
            <Button className="mt-3" asChild>
              <Link href="/auth/login">Sign In</Link>
            </Button>
          </div>
        ) : null}

        {error && (
          <div className="bg-red-100 p-4 rounded-md mb-4">
            <p className="text-red-600 font-semibold">Error Loading Users</p>
            <p className="text-sm text-red-700 mt-1">{error.message}</p>
          </div>
        )}

        {!error && user && <UserListSimple users={users || []} />}
      </div>
    </DashboardLayout>
  );
}
