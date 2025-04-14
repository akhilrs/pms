import { Metadata } from "next";
import { APP_NAME } from "@/lib/constants";
import { DashboardLayout } from "@/components/common";
import { getUser } from "@/lib/supabase/auth-helpers";
import { redirect } from "next/navigation";
import { getUserById } from "@/lib/supabase/users";
import { notFound } from "next/navigation";
import { UserEditForm } from "@/components/users/user-edit-form";

type Props = {
  params: Promise<{
    id: string;
  }>;
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  // Safely access params
  const { id } = await params;

  try {
    const { data: user } = await getUserById(id);
    return {
      title: user
        ? `Edit ${user.first_name || ""} ${user.last_name || ""} | ${APP_NAME}`
        : `Edit User | ${APP_NAME}`,
      description: "Edit user details",
    };
  } catch (error) {
    console.error("Error generating metadata:", error);
    return {
      title: `Edit User | ${APP_NAME}`,
      description: "Edit user details",
    };
  }
}

export default async function EditUserPage({ params }: Props) {
  // Safely access params
  const { id: userId } = await params;

  // Check authentication
  const currentUser = await getUser();
  if (!currentUser) {
    redirect("/auth/login?redirectTo=/users/edit/" + userId);
  }

  // Get user to verify it exists
  const { data: user, error } = await getUserById(userId);

  if (error || !user) {
    notFound();
  }
  
  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6">
            <h1 className="text-3xl font-bold">Edit User</h1>
            <p className="text-gray-600 mb-6">Update user account details</p>
            
            <UserEditForm userId={userId} />
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
}
