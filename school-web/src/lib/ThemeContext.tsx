import { createContext, useContext, useEffect, useState, useCallback, type ReactNode } from "react"
import { SchoolTheme, DEFAULT_THEME, buildTheme } from "./theme"
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
  } catch {}
  return null
}

function saveTheme(theme: SchoolTheme) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(theme))
  } catch {}
}

export function applyThemeToCss(theme: SchoolTheme) {
  const root = document.documentElement
  root.style.setProperty("--color-primary", theme.primary)
  root.style.setProperty("--color-accent", theme.accent)
  root.style.setProperty("--color-primary-light", theme.primary_light)
  root.style.setProperty("--color-primary-dark", theme.primary_dark)
  root.style.setProperty("--color-accent-light", theme.accent_light)
  root.style.setProperty("--gradient-main", theme.gradient_main)
  root.style.setProperty("--gradient-hero", theme.gradient_hero)
  root.style.setProperty("--font-primary", FONTS[theme.font_style])
  root.style.setProperty("--radius-base", RADII[theme.border_radius])
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

  useEffect(() => {
    applyTheme(theme)
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
