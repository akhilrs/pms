import { Metadata } from "next";
import { APP_NAME } from "@/lib/constants";
import { DashboardLayout } from "@/components/common";
import { getUser } from "@/lib/supabase/auth-helpers";
import { redirect } from "next/navigation";
import { UserCreateForm } from "@/components/users/user-create-form";

export const metadata: Metadata = {
  title: `New User | ${APP_NAME}`,
  description: `Create a new user account in ${APP_NAME}`,
};

export default async function NewUserPage() {
  // Check authentication
  const user = await getUser();
  if (!user) {
    redirect("/auth/login?redirectTo=/users/new");
  }
  
  return (
    <DashboardLayout>
      <div className="max-w-3xl mx-auto">
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6">
            <h1 className="text-3xl font-bold">Create New User</h1>
            <p className="text-gray-600 mb-6">Fill out the form below to create a new user account.</p>
            
            <UserCreateForm />
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
}
