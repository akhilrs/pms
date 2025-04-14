"use client";

import NewUserPage from "./page";
import { DashboardLayout } from "@/components/layouts/dashboard-layout";

export function NewUserPageWrapper() {
  return (
    <DashboardLayout>
      <NewUserPage />
    </DashboardLayout>
  );
}
