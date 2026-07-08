import AsyncStorage from "@react-native-async-storage/async-storage";
import React, {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";

import { SchoolSettings, SchoolSettingsApi } from "./api";
import { useAuth } from "./auth";

/**
 * ThemeProvider — dynamic theming driven by the school's admin settings.
 *
 * On launch we hydrate the last-known settings from AsyncStorage so the app
 * is themed correctly offline, then (once authenticated) refresh from
 * `GET /api/school-settings` and re-persist. All color tokens are derived
 * from `primary_color` / `accent_color`; radius and font style map from
 * their respective admin settings.
 */

const STORAGE_KEY = "sm_school_settings";

export const DEFAULT_SETTINGS: SchoolSettings = {
  school_name: "School Portal",
  school_motto: null,
  primary_color: "#1d4ed8",
  accent_color: "#7c3aed",
  border_radius: "medium",
  font_style: "modern",
  school_logo: null,
};

// ---------------------------------------------------------------------------
// Color math helpers
// ---------------------------------------------------------------------------

function hexToRgb(hex: string): [number, number, number] | null {
  const m = /^#?([0-9a-f]{6})$/i.exec(hex.trim());
  if (!m) return null;
  const n = parseInt(m[1], 16);
  return [(n >> 16) & 255, (n >> 8) & 255, n & 255];
}

function rgbToHex(r: number, g: number, b: number): string {
  const c = (v: number) =>
    Math.max(0, Math.min(255, Math.round(v)))
      .toString(16)
      .padStart(2, "0");
  return `#${c(r)}${c(g)}${c(b)}`;
}

/** Mix a color with white by `amount` (0 = unchanged, 1 = white). */
export function lighten(hex: string, amount: number): string {
  const rgb = hexToRgb(hex);
  if (!rgb) return hex;
  const [r, g, b] = rgb;
  return rgbToHex(
    r + (255 - r) * amount,
    g + (255 - g) * amount,
    b + (255 - b) * amount,
  );
}

/** Mix a color with black by `amount` (0 = unchanged, 1 = black). */
export function darken(hex: string, amount: number): string {
  const rgb = hexToRgb(hex);
  if (!rgb) return hex;
  const [r, g, b] = rgb;
  return rgbToHex(r * (1 - amount), g * (1 - amount), b * (1 - amount));
}

/** WCAG-ish relative luminance — used to pick readable foreground text. */
function luminance(hex: string): number {
  const rgb = hexToRgb(hex);
  if (!rgb) return 0;
  const [r, g, b] = rgb.map((v) => {
    const s = v / 255;
    return s <= 0.03928 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4);
  });
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

export function contrastForeground(hex: string): string {
  return luminance(hex) > 0.45 ? "#0a0a0a" : "#ffffff";
}

// ---------------------------------------------------------------------------
// Theme computation
// ---------------------------------------------------------------------------

export interface Theme {
  primary: string;
  primaryForeground: string;
  accent: string;
  accentForeground: string;
  background: string;
  foreground: string;
  card: string;
  cardForeground: string;
  muted: string;
  mutedForeground: string;
  border: string;
  input: string;
  destructive: string;
  destructiveForeground: string;
  secondary: string;
  secondaryForeground: string;
  tint: string;
  text: string;
  radius: number;
  fontStyle: "modern" | "classic" | "friendly";
  schoolName: string;
  schoolLogo: string | null;
  schoolMotto: string | null;
}

export function computeTheme(raw: SchoolSettings | null | undefined): Theme {
  const s = { ...DEFAULT_SETTINGS, ...(raw ?? {}) };
  const primary = s.primary_color || DEFAULT_SETTINGS.primary_color!;
  const accent = s.accent_color || DEFAULT_SETTINGS.accent_color!;
  const radius =
    s.border_radius === "sharp" ? 4 : s.border_radius === "rounded" ? 20 : 12;
  return {
    primary,
    primaryForeground: contrastForeground(primary),
    accent,
    accentForeground: contrastForeground(accent),
    background: "#ffffff",
    foreground: "#0a0a0a",
    card: "#f8fafc",
    cardForeground: "#0a0a0a",
    muted: "#f1f5f9",
    mutedForeground: "#64748b",
    border: "#e2e8f0",
    input: "#e2e8f0",
    destructive: "#dc2626",
    destructiveForeground: "#ffffff",
    secondary: lighten(primary, 0.9),
    secondaryForeground: darken(primary, 0.25),
    tint: primary,
    text: "#0a0a0a",
    radius,
    fontStyle: (s.font_style as Theme["fontStyle"]) || "modern",
    schoolName: s.school_name || "School Portal",
    schoolLogo: s.school_logo || null,
    schoolMotto: s.school_motto || null,
  };
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

interface ThemeCtx {
  theme: Theme;
  settings: SchoolSettings;
  refresh: () => Promise<void>;
}

const Ctx = createContext<ThemeCtx | undefined>(undefined);

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const { user } = useAuth();
  const [settings, setSettings] = useState<SchoolSettings>(DEFAULT_SETTINGS);

  // Hydrate last-known settings so the app is themed while offline.
  useEffect(() => {
    let active = true;
    AsyncStorage.getItem(STORAGE_KEY)
      .then((raw) => {
        if (active && raw) {
          setSettings({ ...DEFAULT_SETTINGS, ...JSON.parse(raw) });
        }
      })
      .catch(() => {});
    return () => {
      active = false;
    };
  }, []);

  const refresh = useCallback(async () => {
    try {
      const fresh = await SchoolSettingsApi.get();
      if (fresh && typeof fresh === "object") {
        const merged = { ...DEFAULT_SETTINGS, ...fresh };
        setSettings(merged);
        AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(fresh)).catch(
          () => {},
        );
      }
    } catch {
      // Endpoint requires auth / network may be down — keep cached theme.
    }
  }, []);

  // Refetch whenever a user session becomes available (login or app resume).
  useEffect(() => {
    if (user) refresh();
  }, [user, refresh]);

  const value = useMemo(
    () => ({ theme: computeTheme(settings), settings, refresh }),
    [settings, refresh],
  );

  return <Ctx.Provider value={value}>{children}</Ctx.Provider>;
}

export function useTheme(): ThemeCtx {
  const ctx = useContext(Ctx);
  if (!ctx) throw new Error("useTheme must be used inside <ThemeProvider>");
  return ctx;
}

/** Safe variant — returns defaults when rendered outside the provider. */
export function useThemeSafe(): Theme {
  const ctx = useContext(Ctx);
  return ctx?.theme ?? computeTheme(null);
}
