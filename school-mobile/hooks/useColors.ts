import { useThemeSafe } from "@/lib/theme";

/**
 * Returns the design tokens for the app.
 *
 * Tokens are computed by ThemeProvider from the school's admin settings
 * (`GET /api/school-settings`) — primary/accent colors, border radius and
 * font style — with sensible defaults when offline or unauthenticated.
 * Falls back to those defaults automatically outside the provider.
 */
export function useColors() {
  return useThemeSafe();
}
