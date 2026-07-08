import { Redirect } from "expo-router";
import React from "react";

import { LoadingView } from "@/components/ui";
import { useAuth } from "@/lib/auth";

export default function Index() {
  const { user, loading } = useAuth();
  if (loading) return <LoadingView />;
  if (!user) return <Redirect href="/login" />;
  if (user.role === "student") return <Redirect href="/(student)" />;
  if (user.role === "parent") return <Redirect href="/(parent)" />;
  if (user.role === "teacher") return <Redirect href="/(teacher)" />;
  // Other roles must use the web portal — redirect them back to login with a message.
  return <Redirect href="/login?reason=web-only" />;
}
