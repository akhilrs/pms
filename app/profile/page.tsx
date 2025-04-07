import { Metadata } from "next";
import { DashboardLayout } from "@/components/common/layout";
import { UpdateProfileForm } from "@/components/auth/update-profile-form";
import { FixProfiles } from "@/components/auth/fix-profiles";

export const metadata: Metadata = {
  title: "Profile | Basecamp Clone",
  description: "Manage your profile",
};

export default function ProfilePage() {
  return (
    <DashboardLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold">Your Profile</h1>
          <p className="text-gray-600">
            Update your profile information and settings
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="md:col-span-2">
            <UpdateProfileForm />
          </div>
          
          <div className="space-y-6">
            <div className="bg-blue-50 rounded-lg p-4 border border-blue-100">
              <h3 className="font-medium text-blue-800 mb-2">Why update your profile?</h3>
              <p className="text-sm text-blue-700">
                Setting your name helps team members identify you in projects and messages,
                preventing the "Unknown User" display throughout the application.
              </p>
            </div>
            
            <FixProfiles />
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
}