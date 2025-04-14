import { Metadata } from "next";
import { DashboardLayout } from "@/components/layouts/dashboard-layout";
import { NewUserPageWrapper } from "./page-wrapper";
import { getUser } from "@/lib/supabase/auth-helpers";
import { redirect } from "next/navigation";

export const metadata: Metadata = {
  title: "Create User",
  description: "Add a new user to the system",
};

export default async function NewUserPageServer() {
  // Check authentication
  const user = await getUser();
  if (!user) {
    redirect("/login?redirectTo=/users/new");
  }

  return (
    <DashboardLayout>
      <NewUserPageWrapper />
    </DashboardLayout>
  );
}
