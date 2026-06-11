import { ReactNode, useEffect } from "react";
import { useLocation } from "wouter";
import { useAuth } from "@/lib/auth";
import { Role } from "@/lib/api";

interface RoleGuardProps {
  roles: Role[];
  children: ReactNode;
}

export function RoleGuard({ roles, children }: RoleGuardProps) {
  const { user, loading } = useAuth();
  const [, setLocation] = useLocation();

  const ok = !!user && roles.includes(user.role);
  const redirectTo = !user ? "/login" : !ok ? `/${user.role}` : null;

  useEffect(() => {
    if (loading) return;
    if (redirectTo) setLocation(redirectTo);
  }, [loading, redirectTo, setLocation]);

  if (loading) {
    return (
      <div className="min-h-screen w-full flex items-center justify-center bg-background">
        <div className="flex flex-col items-center gap-3">
          <div className="h-6 w-6 animate-spin rounded-full border-2 border-primary border-t-transparent" />
          <div className="text-sm text-muted-foreground animate-pulse">Loading…</div>
        </div>
      </div>
    );
  }

  if (!ok) return null;

  return <>{children}</>;
}
