export interface SchoolTheme {
  school_name: string
  school_logo?: string
  school_motto?: string

  primary: string
  accent: string

  primary_light: string
  primary_dark: string
  accent_light: string
  gradient_main: string
  gradient_hero: string

  sidebar_style: 'gradient' | 'white' | 'dark'
  border_radius: 'sharp' | 'medium' | 'rounded'
  font_style: 'modern' | 'classic' | 'friendly'
}

// ─── Academic Prestige defaults: Deep Academic Navy + Heritage Gold ───
export const DEFAULT_THEME: SchoolTheme = {
  school_name: 'School Management Suite',
  primary: '#163964',
  accent: '#C79A2E',
  primary_light: 'rgba(22,57,100,0.10)',
  primary_dark: '#102C4E',
  accent_light: 'rgba(199,154,46,0.14)',
  gradient_main: 'linear-gradient(135deg, #163964 0%, #2A5C91 100%)',
  gradient_hero: 'linear-gradient(135deg, #163964 0%, #C79A2E 135%)',
  sidebar_style: 'white',
  border_radius: 'rounded',
  font_style: 'modern',
}

export function hexToRgb(hex: string): { r: number; g: number; b: number } {
  const clean = hex.replace('#', '')
  const full = clean.length === 3
    ? clean[0] + clean[0] + clean[1] + clean[1] + clean[2] + clean[2]
    : clean
  const num = parseInt(full, 16)
  return {
    r: (num >> 16) & 255,
    g: (num >> 8) & 255,
    b: num & 255,
  }
}

/** Convert hex to HSL string "H S% L%" (no commas, Tailwind-compatible) */
export function hexToHSL(hex: string): { h: number; s: number; l: number } {
  const { r, g, b } = hexToRgb(hex)
  const rn = r / 255, gn = g / 255, bn = b / 255
  const max = Math.max(rn, gn, bn), min = Math.min(rn, gn, bn)
  let h = 0, s = 0
  const l = (max + min) / 2

  if (max !== min) {
    const d = max - min
    s = l > 0.5 ? d / (2 - max - min) : d / (max + min)
    if (max === rn) h = ((gn - bn) / d + (gn < bn ? 6 : 0)) / 6
    else if (max === gn) h = ((bn - rn) / d + 2) / 6
    else h = ((rn - gn) / d + 4) / 6
  }

  return {
    h: Math.round(h * 360),
    s: Math.round(s * 100),
    l: Math.round(l * 100),
  }
}

/** Relative luminance (WCAG formula) */
export function getLuminance(hex: string): number {
  const { r, g, b } = hexToRgb(hex)
  const toLinear = (c: number) => {
    const s = c / 255
    return s <= 0.03928 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4)
  }
  return 0.2126 * toLinear(r) + 0.7152 * toLinear(g) + 0.0722 * toLinear(b)
}

/** Returns white or dark text color for readable contrast on `bgHex` */
export function contrastForeground(bgHex: string): string {
  return getLuminance(bgHex) > 0.35 ? '#1E1B4B' : '#FFFFFF'
}

export function darken(hex: string, amount: number): string {
  const { r, g, b } = hexToRgb(hex)
  const factor = 1 - amount
  const toHex = (n: number) => Math.round(n * factor).toString(16).padStart(2, '0')
  return `#${toHex(r)}${toHex(g)}${toHex(b)}`
}

export function lighten(hex: string, amount: number): string {
  const { r, g, b } = hexToRgb(hex)
  const toHex = (n: number) => Math.round(n + (255 - n) * amount).toString(16).padStart(2, '0')
  return `#${toHex(r)}${toHex(g)}${toHex(b)}`
}

export function hexToRgba(hex: string, alpha: number): string {
  const { r, g, b } = hexToRgb(hex)
  return `rgba(${r},${g},${b},${alpha})`
}

export function buildTheme(
  primary: string,
  accent: string,
  overrides: Partial<SchoolTheme> = {},
): SchoolTheme {
  const primary_light = hexToRgba(primary, 0.12)
  const primary_dark = darken(primary, 0.2)
  const accent_light = hexToRgba(accent, 0.12)
  const lighter_primary = lighten(primary, 0.32)
  const gradient_main = `linear-gradient(135deg, ${primary} 0%, ${lighter_primary} 100%)`
  const gradient_hero = `linear-gradient(135deg, ${accent} 0%, ${primary} 100%)`

  return {
    ...DEFAULT_THEME,
    primary,
    accent,
    primary_light,
    primary_dark,
    accent_light,
    gradient_main,
    gradient_hero,
    ...overrides,
  }
}
