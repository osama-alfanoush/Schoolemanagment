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

export const DEFAULT_THEME: SchoolTheme = {
  school_name: 'School Management Suite',
  primary: '#6C63FF',
  accent: '#FF6584',
  primary_light: 'rgba(108,99,255,0.12)',
  primary_dark: '#4B44CC',
  accent_light: 'rgba(255,101,132,0.12)',
  gradient_main: 'linear-gradient(135deg, #6C63FF 0%, #A78BFA 100%)',
  gradient_hero: 'linear-gradient(135deg, #FF6584 0%, #6C63FF 100%)',
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
