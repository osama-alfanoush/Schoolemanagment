import { createContext, useContext, useEffect, useState, useCallback, type ReactNode } from "react"
import { SchoolTheme, DEFAULT_THEME, buildTheme, hexToHSL, lighten, darken, hexToRgba, contrastForeground } from "./theme"
import { apiFetch, mediaUrl, tokenStore } from "./api"

const STORAGE_KEY = "school_theme"
const FONTS: Record<string, string> = {
  modern: "'Plus Jakarta Sans', sans-serif",
  classic: "'Merriweather', serif",
  friendly: "'Nunito', sans-serif",
}
const RADII: Record<string, string> = {
  sharp: "4px",
  medium: "8px",
  rounded: "16px",
}

interface ThemeContextValue {
  theme: SchoolTheme
  setTheme: (theme: SchoolTheme) => void
  updatePrimaryColor: (hex: string) => void
  updateAccentColor: (hex: string) => void
  resetToDefault: () => void
  applyThemeToCss: (theme: SchoolTheme) => void
}

const ThemeContext = createContext<ThemeContextValue | undefined>(undefined)

function loadSavedTheme(): SchoolTheme | null {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return JSON.parse(raw) as SchoolTheme
  } catch {
    // Ignore invalid or inaccessible localStorage.
  }
  return null
}

function saveTheme(theme: SchoolTheme) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(theme))
  } catch {
    // Ignore localStorage write failures.
  }
}

export function applyThemeToCss(theme: SchoolTheme) {
  const root = document.documentElement
  const p = theme.primary
  const a = theme.accent

  // ── Core colors ──
  root.style.setProperty("--color-primary", p)
  root.style.setProperty("--color-accent", a)
  root.style.setProperty("--color-primary-light", theme.primary_light)
  root.style.setProperty("--color-primary-dark", theme.primary_dark)
  root.style.setProperty("--color-accent-light", theme.accent_light)

  // ── Gradients ──
  root.style.setProperty("--gradient-main", theme.gradient_main)
  root.style.setProperty("--gradient-hero", theme.gradient_hero)

  // ── Typography & Shape ──
  root.style.setProperty("--font-primary", FONTS[theme.font_style])
  root.style.setProperty("--radius-base", RADII[theme.border_radius])

  // ── HSL versions for Tailwind token overrides ──
  const pHSL = hexToHSL(p)
  const aHSL = hexToHSL(a)
  root.style.setProperty("--dyn-primary-h", String(pHSL.h))
  root.style.setProperty("--dyn-primary-s", pHSL.s + "%")
  root.style.setProperty("--dyn-primary-l", pHSL.l + "%")
  root.style.setProperty("--dyn-accent-h", String(aHSL.h))
  root.style.setProperty("--dyn-accent-s", aHSL.s + "%")
  root.style.setProperty("--dyn-accent-l", aHSL.l + "%")

  // ── Derived shades ──
  root.style.setProperty("--color-primary-subtle", hexToRgba(p, 0.06))
  root.style.setProperty("--color-primary-medium", hexToRgba(p, 0.18))
  root.style.setProperty("--color-primary-hover", lighten(p, 0.12))
  root.style.setProperty("--color-primary-pressed", darken(p, 0.12))
  root.style.setProperty("--color-accent-medium", hexToRgba(a, 0.18))
  root.style.setProperty("--color-accent-hover", lighten(a, 0.12))
  root.style.setProperty("--color-accent-dark", darken(a, 0.2))

  // ── Contrast-safe foregrounds ──
  root.style.setProperty("--color-primary-fg", contrastForeground(p))
  root.style.setProperty("--color-accent-fg", contrastForeground(a))

  // ── Brand aliases (keep backwards-compat) ──
  root.style.setProperty("--color-brand-purple", p)
  root.style.setProperty("--color-brand-pink", a)

  // ── Shadows tinted by primary ──
  root.style.setProperty("--shadow-card", `0 4px 24px ${hexToRgba(p, 0.08)}`)
  root.style.setProperty("--shadow-hover", `0 8px 32px ${hexToRgba(p, 0.16)}`)
  root.style.setProperty("--shadow-glow", `0 0 24px ${hexToRgba(p, 0.30)}`)
}

export function ThemeProvider({ children }: { children: ReactNode }) {
  const saved = loadSavedTheme()
  const [theme, setThemeState] = useState<SchoolTheme>(saved ?? DEFAULT_THEME)

  const applyTheme = useCallback((t: SchoolTheme) => {
    applyThemeToCss(t)
    saveTheme(t)
  }, [])

  const setTheme = useCallback((next: SchoolTheme) => {
    const computed = buildTheme(next.primary, next.accent, next)
    setThemeState(computed)
    applyTheme(computed)
  }, [applyTheme])

  const updatePrimaryColor = useCallback((hex: string) => {
    setThemeState((prev) => {
      const computed = buildTheme(hex, prev.accent, { ...prev, primary: hex })
      applyTheme(computed)
      return computed
    })
  }, [applyTheme])

  const updateAccentColor = useCallback((hex: string) => {
    setThemeState((prev) => {
      const computed = buildTheme(prev.primary, hex, { ...prev, accent: hex })
      applyTheme(computed)
      return computed
    })
  }, [applyTheme])

  const resetToDefault = useCallback(() => {
    setThemeState(DEFAULT_THEME)
    applyTheme(DEFAULT_THEME)
  }, [applyTheme])

  // Apply the initial theme once on mount; later changes flow through setTheme/applyTheme.
  useEffect(() => {
    applyTheme(theme)
    // eslint-disable-next-line react-hooks/exhaustive-deps -- intentional mount-only init
  }, [])

  useEffect(() => {
    const refreshSchoolTheme = () => {
      if (!tokenStore.getAccess()) return
      apiFetch<any>("/school-settings")
        .then((payload) => {
          const data = payload?.data ?? payload
          if (!data || typeof data !== "object") return

          setThemeState((prev) => {
            const primary = data.primary_color || prev.primary
            const accent = data.accent_color || prev.accent
            const logoUrl = mediaUrl(data.school_logo || data.logo_url)
            const overrides: Partial<SchoolTheme> = {}
            if (data.school_name) overrides.school_name = data.school_name
            overrides.school_logo = logoUrl
            if (data.school_motto) overrides.school_motto = data.school_motto
            if (data.sidebar_style) overrides.sidebar_style = data.sidebar_style
            if (data.border_radius) overrides.border_radius = data.border_radius
            if (data.font_style) overrides.font_style = data.font_style
            const computed = buildTheme(primary, accent, { ...prev, ...overrides })
            applyTheme(computed)
            return computed
          })
        })
        .catch(() => {})
    }

    refreshSchoolTheme()
    const intervalId = window.setInterval(refreshSchoolTheme, 60_000)
    window.addEventListener("focus", refreshSchoolTheme)
    window.addEventListener("school-auth-changed", refreshSchoolTheme)

    return () => {
      window.clearInterval(intervalId)
      window.removeEventListener("focus", refreshSchoolTheme)
      window.removeEventListener("school-auth-changed", refreshSchoolTheme)
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps -- mount-only: installs polling + listeners once
  }, [])

  return (
    <ThemeContext.Provider
      value={{ theme, setTheme, updatePrimaryColor, updateAccentColor, resetToDefault, applyThemeToCss: applyTheme }}
    >
      {children}
    </ThemeContext.Provider>
  )
}

export function useTheme(): ThemeContextValue {
  const ctx = useContext(ThemeContext)
  if (!ctx) throw new Error("useTheme must be inside <ThemeProvider>")
  return ctx
}
