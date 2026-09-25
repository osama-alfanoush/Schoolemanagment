import type { AuthUser } from "@/lib/api";

/**
 * Mirrors the API's `perm:` middleware: admins and holders of the wildcard
 * grant pass everything, anyone else needs the exact key. Keep UI affordances
 * behind the same key the server enforces, so a portal never offers an action
 * whose request comes back 403.
 */
export function hasPermission(user: AuthUser | null, key: string) {
  return user?.role === "admin" || user?.permissions?.includes("*") || user?.permissions?.includes(key) || false;
}
