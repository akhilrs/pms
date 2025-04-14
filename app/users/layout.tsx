import { Metadata } from "next";
import { APP_NAME } from "@/lib/constants";

export const metadata: Metadata = {
  title: `Users | ${APP_NAME}`,
  description: "Manage users in your application",
};

export default async function UsersLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}
