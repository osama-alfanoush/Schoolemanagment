import { useCallback, useEffect, useRef, useState } from "react"
import type { ChangeEvent, ReactNode, RefObject } from "react"
import {
  Check,
  Palette,
  RotateCcw,
  Save,
  School,
  Sparkles,
  UploadCloud,
  X,
} from "lucide-react"
import { useTheme } from "@/lib/ThemeContext"
import { useTheme as useColorScheme } from "next-themes"
import { DEFAULT_THEME, buildTheme } from "@/lib/theme"
import { Admin, ApiError, mediaUrl } from "@/lib/api"
import { toast } from "@/hooks/use-toast"
import { cn } from "@/lib/utils"
import PageHeader from "@/components/ui/PageHeader"
import BrandCard from "@/components/ui/BrandCard"
import BrandButton from "@/components/ui/BrandButton"


const PRIMARY_PRESETS = [
  "#6C63FF", "#3B82F6", "#10B981", "#F59E0B",
  "#EF4444", "#8B5CF6", "#EC4899", "#0EA5E9",
]


const ACCENT_PRESETS = [
  "#FF6584", "#F97316", "#14B8A6", "#EAB308",
  "#F43F5E", "#A855F7", "#06B6D4", "#84CC16",
]


const FONT_FAMILIES: Record<FontStyle, string> = {
  modern: "'Plus Jakarta Sans', sans-serif",
  classic: "'Merriweather', serif",
  friendly: "'Nunito', sans-serif",
}


const SIDEBAR_PREVIEW: Record<SidebarStyle, string> = {
  gradient: "bg-[var(--gradient-main)]",
  white: "bg-white border-r border-gray-200",
  dark: "bg-gray-900",
}


const HEX_RE = /^#[0-9A-Fa-f]{6}$/
const DEFAULT_ACADEMIC_YEAR = "2025-2026"
const SIDEBAR_STYLES = ["white", "gradient", "dark"] as const
const BORDER_RADII = ["sharp", "medium", "rounded"] as const
const FONT_STYLES = ["modern", "classic", "friendly"] as const


type SidebarStyle = (typeof SIDEBAR_STYLES)[number]
type BorderRadius = (typeof BORDER_RADII)[number]
type FontStyle = (typeof FONT_STYLES)[number]


interface SchoolSettingsResponse {
  school_name?: string | null
  school_motto?: string | null
  academic_year?: string | null
  address?: string | null
  school_logo?: string | null
  logo_url?: string | null
  primary_color?: string | null
  accent_color?: string | null
  sidebar_style?: string | null
  border_radius?: string | null
  font_style?: string | null
  data?: SchoolSettingsResponse
}


function formatFileSize(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`
}


function validationMessage(error: unknown): string {
  if (error instanceof ApiError) {
    const data = error.data as { errors?: Record<string, string[]>; message?: string } | undefined
    const first = data?.errors ? Object.values(data.errors).flat()[0] : undefined
    return first || data?.message || error.message
  }
  return "Something went wrong. Please try again."
}


function isSidebarStyle(value: unknown): value is SidebarStyle {
  return SIDEBAR_STYLES.includes(value as SidebarStyle)
}


function isBorderRadius(value: unknown): value is BorderRadius {
  return BORDER_RADII.includes(value as BorderRadius)
}


function isFontStyle(value: unknown): value is FontStyle {
  return FONT_STYLES.includes(value as FontStyle)
}


function unwrapSettings(data: SchoolSettingsResponse): SchoolSettingsResponse {
  return data.data ?? data
}


export default function SchoolSettings() {
  const { theme, setTheme, updatePrimaryColor, updateAccentColor, applyThemeToCss, resetToDefault } = useTheme()


  const [schoolName, setSchoolName] = useState(DEFAULT_THEME.school_name)
  const [motto, setMotto] = useState("")
  const [academicYear, setAcademicYear] = useState(DEFAULT_ACADEMIC_YEAR)
  const [address, setAddress] = useState("")
  const [logoFile, setLogoFile] = useState<File | null>(null)
  const [logoPreview, setLogoPreview] = useState("")
  const [existingLogoUrl, setExistingLogoUrl] = useState("")
  const [logoWasRemoved, setLogoWasRemoved] = useState(false)
  const [primaryColor, setPrimaryColor] = useState(DEFAULT_THEME.primary)
  const [accentColor, setAccentColor] = useState(DEFAULT_THEME.accent)
  const [sidebarStyle, setSidebarStyle] = useState<SidebarStyle>(DEFAULT_THEME.sidebar_style)
  const [borderRadius, setBorderRadius] = useState<BorderRadius>(DEFAULT_THEME.border_radius)
  const [fontStyle, setFontStyle] = useState<FontStyle>(DEFAULT_THEME.font_style)
  const [isSaving, setIsSaving] = useState(false)
  const [isLoading, setIsLoading] = useState(true)
  const [loadError, setLoadError] = useState("")
  // Light/dark is owned by next-themes (the single source of truth, shared with
  // the top-bar toggle). We just read/drive it here — no manual class/localStorage.
  const { theme: colorScheme, setTheme: setColorScheme } = useColorScheme()
  const uiMode: "light" | "dark" = colorScheme === "dark" ? "dark" : "light"


  const primaryInputRef = useRef<HTMLInputElement>(null)
  const accentInputRef = useRef<HTMLInputElement>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)
  const logoObjectUrlRef = useRef("")


  const revokeLogoObjectUrl = useCallback(() => {
    if (logoObjectUrlRef.current) {
      URL.revokeObjectURL(logoObjectUrlRef.current)
      logoObjectUrlRef.current = ""
    }
  }, [])


  const loadSettings = useCallback(async () => {
    setIsLoading(true)
    setLoadError("")
    try {
      const settings = unwrapSettings((await Admin.schoolSettings()) as SchoolSettingsResponse)


      const loadedPrimary = settings.primary_color && HEX_RE.test(settings.primary_color)
        ? settings.primary_color
        : DEFAULT_THEME.primary
      const loadedAccent = settings.accent_color && HEX_RE.test(settings.accent_color)
        ? settings.accent_color
        : DEFAULT_THEME.accent
      const logoUrl = mediaUrl(settings.school_logo || settings.logo_url)


      setSchoolName(settings.school_name || DEFAULT_THEME.school_name)
      setMotto(settings.school_motto || "")
      setAcademicYear(settings.academic_year || DEFAULT_ACADEMIC_YEAR)
      setAddress(settings.address || "")
      setExistingLogoUrl(logoUrl)
      setLogoPreview(logoUrl)
      setLogoFile(null)
      setLogoWasRemoved(false)
      setPrimaryColor(loadedPrimary)
      setAccentColor(loadedAccent)
      if (isSidebarStyle(settings.sidebar_style)) setSidebarStyle(settings.sidebar_style)
      if (isBorderRadius(settings.border_radius)) setBorderRadius(settings.border_radius)
      if (isFontStyle(settings.font_style)) setFontStyle(settings.font_style)
      updatePrimaryColor(loadedPrimary)
      updateAccentColor(loadedAccent)
    } catch (error) {
      setLoadError(validationMessage(error))
    } finally {
      setIsLoading(false)
    }
  }, [updateAccentColor, updatePrimaryColor])


  useEffect(() => {
    void loadSettings()
  }, [loadSettings])


  useEffect(() => {
    return () => revokeLogoObjectUrl()
  }, [revokeLogoObjectUrl])


  useEffect(() => {
    const fonts: Record<FontStyle, string> = {
      modern: "https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap",
      classic: "https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&display=swap",
      friendly: "https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap",
    }
    const href = fonts[fontStyle]
    if (!document.querySelector(`link[href="${href}"]`)) {
      const link = document.createElement("link")
      link.rel = "stylesheet"
      link.href = href
      document.head.appendChild(link)
    }
    applyThemeToCss({ ...theme, font_style: fontStyle })
  }, [applyThemeToCss, fontStyle, theme])


  const handlePrimaryChange = useCallback((hex: string) => {
    if (!HEX_RE.test(hex)) return
    setPrimaryColor(hex)
    updatePrimaryColor(hex)
  }, [updatePrimaryColor])


  const handleAccentChange = useCallback((hex: string) => {
    if (!HEX_RE.test(hex)) return
    setAccentColor(hex)
    updateAccentColor(hex)
  }, [updateAccentColor])


  const handleUiModeChange = (mode: "light" | "dark") => {
    // next-themes persists this (storageKey "ui-mode") and applies the .dark
    // class app-wide and across refreshes.
    setColorScheme(mode)
  }


  const handleLogoFile = (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return
    if (!["image/jpeg", "image/png", "image/webp"].includes(file.type)) {
      toast({ title: "Unsupported file", description: "Use a PNG, JPG, or WebP logo.", variant: "destructive" })
      e.target.value = ""
      return
    }
    if (file.size > 2 * 1024 * 1024) {
      toast({ title: "Logo too large", description: "Logo must be under 2MB.", variant: "destructive" })
      e.target.value = ""
      return
    }


    revokeLogoObjectUrl()
    const previewUrl = URL.createObjectURL(file)
    logoObjectUrlRef.current = previewUrl
    setLogoFile(file)
    setLogoPreview(previewUrl)
    setLogoWasRemoved(false)
  }


  const handleRemoveLogo = () => {
    revokeLogoObjectUrl()
    setLogoFile(null)
    setLogoPreview("")
    setLogoWasRemoved(Boolean(existingLogoUrl))
    if (fileInputRef.current) fileInputRef.current.value = ""
  }


  const handleReset = () => {
    revokeLogoObjectUrl()
    resetToDefault()
    setSchoolName(DEFAULT_THEME.school_name)
    setMotto("")
    setAcademicYear(DEFAULT_ACADEMIC_YEAR)
    setAddress("")
    setLogoFile(null)
    setLogoPreview("")
    setLogoWasRemoved(Boolean(existingLogoUrl))
    setPrimaryColor(DEFAULT_THEME.primary)
    setAccentColor(DEFAULT_THEME.accent)
    setSidebarStyle(DEFAULT_THEME.sidebar_style)
    setBorderRadius(DEFAULT_THEME.border_radius)
    setFontStyle(DEFAULT_THEME.font_style)
    toast({ title: "Reset to default theme" })
  }


  const canSave = schoolName.trim().length > 0 && HEX_RE.test(primaryColor) && HEX_RE.test(accentColor)


  const handleSave = async () => {
    if (!canSave) {
      toast({
        title: "Check settings",
        description: "School name and both brand colors are required.",
        variant: "destructive",
      })
      return
    }


    setIsSaving(true)
    try {
      const fd = new FormData()
      fd.append("school_name", schoolName.trim())
      fd.append("school_motto", motto.trim())
      fd.append("academic_year", (academicYear.trim() || DEFAULT_ACADEMIC_YEAR))
      fd.append("address", address.trim())
      fd.append("primary_color", primaryColor)
      fd.append("accent_color", accentColor)
      fd.append("sidebar_style", sidebarStyle)
      fd.append("border_radius", borderRadius)
      fd.append("font_style", fontStyle)
      if (logoFile) {
        fd.append("school_logo", logoFile)
      } else if (logoWasRemoved) {
        fd.append("remove_school_logo", "1")
      }


      const settings = unwrapSettings((await Admin.updateSchoolSettings(fd)) as SchoolSettingsResponse)
      const nextLogo = mediaUrl(settings.school_logo || (logoWasRemoved ? "" : existingLogoUrl))
      const nextTheme = buildTheme(primaryColor, accentColor, {
        school_name: settings.school_name || schoolName.trim(),
        school_logo: nextLogo,
        school_motto: settings.school_motto || motto.trim(),
        sidebar_style: isSidebarStyle(settings.sidebar_style) ? settings.sidebar_style : sidebarStyle,
        border_radius: isBorderRadius(settings.border_radius) ? settings.border_radius : borderRadius,
        font_style: isFontStyle(settings.font_style) ? settings.font_style : fontStyle,
      })


      setTheme(nextTheme)
      setSchoolName(nextTheme.school_name)
      setMotto(settings.school_motto || "")
      setAcademicYear(settings.academic_year || academicYear.trim() || DEFAULT_ACADEMIC_YEAR)
      setAddress(settings.address || "")
      setExistingLogoUrl(nextLogo)
      setLogoPreview(nextLogo)
      setLogoFile(null)
      setLogoWasRemoved(false)
      revokeLogoObjectUrl()
      if (fileInputRef.current) fileInputRef.current.value = ""


      toast({ title: "School settings saved" })
    } catch (error) {
      toast({ title: "Failed to save settings", description: validationMessage(error), variant: "destructive" })
    } finally {
      setIsSaving(false)
    }
  }


  if (isLoading) {
    return (
      <div className="min-h-[400px] flex items-center justify-center">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-[var(--color-primary)] border-t-transparent" />
      </div>
    )
  }


  if (loadError) {
    return (
      <div>
        <PageHeader
          icon="S"
          title="School Settings"
          subtitle="Customize your school's identity and brand theme"
        />
        <BrandCard>
          <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
            <div>
              <h2 className="font-semibold text-foreground">Settings could not load</h2>
              <p className="mt-1 text-sm text-muted-foreground">{loadError}</p>
            </div>
                <BrandButton
                  variant="outline"
                  onClick={() => {
                    void loadSettings()
                  }}
                >
              Try Again
            </BrandButton>
          </div>
        </BrandCard>
      </div>
    )
  }


  return (
    <div>
      <PageHeader
        icon="S"
        title="School Settings"
        subtitle="Customize your school's identity and brand theme"
      />


      <div className="flex flex-col gap-6 xl:flex-row xl:items-start">
        <div className="flex min-w-0 flex-1 flex-col gap-6">
          <BrandCard>
            <SectionTitle icon={<School className="h-5 w-5" />} title="School Identity" />


            <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
              <Field label="School Name" required error={!schoolName.trim() ? "School name is required." : ""}>
                <input
                  value={schoolName}
                  onChange={(e) => setSchoolName(e.target.value)}
                  className={inputClass(!schoolName.trim())}
                />
              </Field>


              <Field label="Academic Year">
                <input
                  value={academicYear}
                  onChange={(e) => setAcademicYear(e.target.value)}
                  placeholder="e.g. 2025-2026"
                  className={inputClass()}
                />
              </Field>


              <Field label="School Motto" className="md:col-span-2">
                <input
                  value={motto}
                  onChange={(e) => setMotto(e.target.value)}
                  placeholder="e.g. Excellence in Education"
                  className={inputClass()}
                />
              </Field>


              <Field label="School Address" className="md:col-span-2">
                <textarea
                  value={address}
                  onChange={(e) => setAddress(e.target.value)}
                  rows={3}
                  className={cn(inputClass(), "resize-none")}
                />
              </Field>


              <div className="md:col-span-2">
                <label htmlFor="school-logo-file" className="block text-sm font-medium text-foreground mb-1.5">School Logo</label>
                <div
                  onClick={() => fileInputRef.current?.click()}
                  onKeyDown={(event) => {
                    if (event.key !== "Enter" && event.key !== " ") return
                    event.preventDefault()
                    fileInputRef.current?.click()
                  }}
                  role="button"
                  tabIndex={0}
                  className={cn(
                    "rounded-2xl p-6 text-center cursor-pointer transition-all duration-200 border-2",
                    logoPreview
                      ? "border-[var(--color-primary)] bg-[var(--color-primary)]/5"
                      : "border-dashed border-border hover:border-[var(--color-primary)] hover:bg-[var(--color-primary)]/5",
                  )}
                >
                  {logoPreview ? (
                    <div className="flex items-center gap-4">
                      <img
                        src={logoPreview}
                        alt="Logo preview"
                        className="h-16 w-16 rounded-xl border border-gray-100 bg-white object-contain shadow-sm"
                      />
                      <div className="min-w-0 flex-1 text-left">
                        <p className="truncate text-sm font-medium text-foreground">
                          {logoFile ? logoFile.name : "Saved logo"}
                        </p>
                        <p className="mt-0.5 text-xs text-muted-foreground">
                          {logoFile ? formatFileSize(logoFile.size) : "Uploaded image"}
                        </p>
                      </div>
                      <button
                        type="button"
                        onClick={(e) => {
                          e.stopPropagation()
                          handleRemoveLogo()
                        }}
                        className="rounded-full p-1 text-muted-foreground transition-colors hover:bg-red-50 hover:text-red-500 dark:hover:bg-red-950/50"
                        aria-label="Remove logo"
                      >
                        <X className="h-4 w-4" />
                      </button>
                    </div>
                  ) : (
                    <div className="flex flex-col items-center">
                      <UploadCloud className="mb-2 h-8 w-8 text-muted-foreground/60" />
                      <p className="text-sm text-muted-foreground">Drop your logo here or click to upload</p>
                      <p className="mt-1 text-xs text-muted-foreground/60">PNG, JPG, WebP - max 2MB</p>
                    </div>
                  )}
                </div>
                <input
                  id="school-logo-file"
                  ref={fileInputRef}
                  type="file"
                  accept="image/jpeg,image/png,image/webp"
                  onChange={handleLogoFile}
                  className="hidden"
                />
              </div>
            </div>
          </BrandCard>


          <BrandCard>
            <SectionTitle icon={<Palette className="h-5 w-5" />} title="Brand Colors" />
            <ColorEditor
              label="Primary Color"
              description="Buttons, active nav, links, and gradients"
              value={primaryColor}
              presets={PRIMARY_PRESETS}
              inputRef={primaryInputRef}
              onChange={handlePrimaryChange}
              onDraft={setPrimaryColor}
            />
            <div className="my-5 border-t border-border" />
            <ColorEditor
              label="Accent Color"
              description="Hero banners, highlights, secondary elements"
              value={accentColor}
              presets={ACCENT_PRESETS}
              inputRef={accentInputRef}
              onChange={handleAccentChange}
              onDraft={setAccentColor}
            />


            <div className="mt-5 grid grid-cols-3 gap-3">
              {[
                { label: "Main Gradient", bg: "var(--gradient-main)" },
                { label: "Hero Gradient", bg: "var(--gradient-hero)" },
                { label: "Combined", bg: `linear-gradient(135deg, ${primaryColor}, ${accentColor})` },
              ].map((item) => (
                <div key={item.label}>
                  <div className="h-10 rounded-xl" style={{ background: item.bg }} />
                  <p className="mt-1 text-center text-xs text-muted-foreground">{item.label}</p>
                </div>
              ))}
            </div>
          </BrandCard>


          <BrandCard>
            <SectionTitle icon={<Sparkles className="h-5 w-5" />} title="UI Style Preferences" />


            <OptionGrid<BorderRadius>
              title="Corner Style"
              options={BORDER_RADII}
              value={borderRadius}
              onChange={setBorderRadius}
              renderPreview={(opt) => (
                <div
                  className={cn(
                    "mx-auto mb-2 h-12 w-12 bg-gray-100",
                    opt === "sharp" && "rounded-none",
                    opt === "medium" && "rounded-lg",
                    opt === "rounded" && "rounded-2xl",
                  )}
                />
              )}
            />


            <OptionGrid<SidebarStyle>
              title="Sidebar Style"
              options={SIDEBAR_STYLES}
              value={sidebarStyle}
              onChange={setSidebarStyle}
              className="mt-5"
              renderPreview={(opt) => (
                <div className="flex h-16 overflow-hidden rounded-lg">
                  <div className={cn("flex h-full w-1/3 flex-col items-center justify-center gap-1", SIDEBAR_PREVIEW[opt])}>
                    <div className={cn("h-0.5 w-3 rounded", opt === "white" ? "bg-gray-200" : "bg-white/60")} />
                    <div className={cn("h-0.5 w-2 rounded", opt === "white" ? "bg-gray-200" : "bg-white/40")} />
                    <div className={cn("h-0.5 w-3 rounded", opt === "white" ? "bg-gray-200" : "bg-white/60")} />
                  </div>
                  <div className="flex h-full w-2/3 flex-col items-center justify-center gap-1.5 bg-gray-50">
                    <div className="h-0.5 w-8 rounded bg-gray-200" />
                    <div className="h-0.5 w-5 rounded bg-gray-200" />
                  </div>
                </div>
              )}
            />


            <OptionGrid<FontStyle>
              title="Typography"
              options={FONT_STYLES}
              value={fontStyle}
              onChange={setFontStyle}
              className="mt-5"
              renderPreview={(opt) => (
                <p className="text-2xl font-bold text-gray-700" style={{ fontFamily: FONT_FAMILIES[opt] }}>
                  Aa
                </p>
              )}
            />


            <div className="mt-5">
              <p className="mb-3 text-sm font-semibold text-foreground">Interface Mode</p>
              <div className="grid grid-cols-2 gap-3">
                {(["light", "dark"] as const).map((mode) => (
                  <button
                    key={mode}
                    type="button"
                    onClick={() => handleUiModeChange(mode)}
                    className={cn(
                      "rounded-xl border-2 p-4 text-center transition-all duration-200",
                      uiMode === mode
                        ? "border-[var(--color-primary)] bg-[var(--color-primary)]/8"
                        : "border-border/50 hover:border-border"
                    )}
                  >
                    <div className={cn(
                      "mx-auto mb-2 h-12 w-full rounded-lg flex items-center justify-center gap-2 text-xs font-medium",
                      mode === "light"
                        ? "bg-[#F8F7FF] border border-gray-200 text-gray-700"
                        : "bg-[#0D1B2E] border border-gray-700 text-gray-200"
                    )}>
                      <span>{mode === "light" ? "☀️" : "🌙"}</span>
                      <span>{mode === "light" ? "Light" : "Dark"}</span>
                    </div>
                    <p className="mt-2 text-xs font-medium capitalize text-muted-foreground">{mode}</p>
                    {uiMode === mode && (
                      <span className="mt-1 inline-flex items-center text-xs text-[var(--color-primary)] font-semibold">
                        ✓ Active
                      </span>
                    )}
                  </button>
                ))}
              </div>
            </div>
          </BrandCard>


          <BrandCard className="!p-4">
            <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
              <div className="flex items-center gap-1.5">
                <span className="flex h-4 w-4 items-center justify-center rounded-full bg-green-500 text-white">
                  <Check className="h-3 w-3" />
                </span>
                <span className="text-xs text-muted-foreground">Changes are previewed live as you edit.</span>
              </div>
              <div className="flex flex-wrap gap-3">
                <BrandButton variant="ghost" onClick={handleReset} leftIcon={<RotateCcw className="h-4 w-4" />}>
                  Reset
                </BrandButton>
                <BrandButton
                  variant="primary"
              onClick={() => {
                void handleSave()
              }}
                  isLoading={isSaving}
                  disabled={!canSave}
                  leftIcon={<Save className="h-4 w-4" />}
                >
                  Save Settings
                </BrandButton>
              </div>
            </div>
          </BrandCard>
        </div>


        <aside className="w-full xl:sticky xl:top-6 xl:w-80">
          <div className="mb-2 flex items-center justify-between">
            <p className="text-sm font-semibold text-foreground">Live Preview</p>
            <p className="text-xs text-muted-foreground">Updates instantly</p>
          </div>


          <div className="relative h-[520px] overflow-hidden border border-border bg-muted/30" style={{ borderRadius: "var(--radius-base, 1rem)" }}>
            <div style={{ transform: "scale(0.6)", transformOrigin: "top left", width: "166.67%", height: "166.67%" }}>
              <PreviewApp
                schoolName={schoolName}
                primaryColor={primaryColor}
                accentColor={accentColor}
                sidebarStyle={sidebarStyle}
                fontStyle={fontStyle}
              />
            </div>
          </div>


          <div className="mt-3 border border-border bg-card p-3" style={{ borderRadius: "var(--radius-base, 0.75rem)" }}>
            <ColorSummary label="Primary" value={primaryColor} />
            <ColorSummary label="Accent" value={accentColor} className="mt-2" />
          </div>
        </aside>
      </div>
    </div>
  )
}


function SectionTitle({ icon, title }: { icon: ReactNode; title: string }) {
  return (
    <div className="mb-5 flex items-center gap-2 text-foreground">
      <span className="text-[var(--color-primary)]">{icon}</span>
      <h2 className="font-semibold">{title}</h2>
    </div>
  )
}


function Field({
  children,
  className,
  error,
  label,
  required,
}: {
  children: ReactNode
  className?: string
  error?: string
  label: string
  required?: boolean
}) {
  return (
    <div className={className}>
      <label className="mb-1.5 block text-sm font-medium text-foreground">
        {label}
        {required && <span className="text-red-500"> *</span>}
      </label>
      {children}
      {error && <p className="mt-1 text-xs text-red-500">{error}</p>}
    </div>
  )
}


function inputClass(hasError = false) {
  return cn(
    "w-full rounded-xl border px-4 py-2.5 text-sm outline-none transition-all duration-200 focus:border-[var(--color-primary)] focus:ring-2 focus:ring-[var(--color-primary)]/20",
    hasError ? "border-red-200 dark:border-red-800 bg-red-50/50 dark:bg-red-950/30" : "border-border",
  )
}


function ColorEditor({
  description,
  inputRef,
  label,
  onChange,
  onDraft,
  presets,
  value,
}: {
  description: string
  inputRef: RefObject<HTMLInputElement | null>
  label: string
  onChange: (hex: string) => void
  onDraft: (hex: string) => void
  presets: string[]
  value: string
}) {
  const hasError = !HEX_RE.test(value)


  return (
    <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
      <div>
        <p className="text-sm font-semibold text-foreground">{label}</p>
        <p className="mt-0.5 text-xs text-muted-foreground">{description}</p>
      </div>
      <div className="flex flex-col gap-3 sm:items-end">
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => inputRef.current?.click()}
            className="h-10 w-10 rounded-xl border-2 border-white shadow-[0_2px_8px_rgba(0,0,0,0.15)] transition-transform hover:scale-110"
            style={{ backgroundColor: HEX_RE.test(value) ? value : "#ffffff" }}
            aria-label={`Pick ${label.toLowerCase()}`}
          />
          <input
            ref={inputRef}
            type="color"
            value={HEX_RE.test(value) ? value : "#000000"}
            onChange={(e) => onChange(e.target.value)}
            className="hidden"
          />
          <input
            value={value}
            onChange={(e) => {
              const next = e.target.value.toUpperCase()
              onDraft(next)
              if (HEX_RE.test(next)) onChange(next)
            }}
            maxLength={7}
            className={cn(
              "w-24 rounded-xl border px-3 py-2 font-mono text-sm uppercase text-foreground outline-none",
              hasError ? "border-red-200 dark:border-red-800 bg-red-50/50 dark:bg-red-950/30" : "border-border",
            )}
          />
        </div>
        <div className="flex flex-wrap gap-2 sm:justify-end">
          {presets.map((hex) => (
            <button
              key={hex}
              type="button"
              onClick={() => onChange(hex)}
              className={cn(
                "h-7 w-7 rounded-full border-2 transition-transform duration-150 hover:scale-110",
                hex.toLowerCase() === value.toLowerCase()
                  ? "scale-110 border-gray-400 shadow-[0_0_0_2px_white_inset]"
                  : "border-transparent",
              )}
              style={{ backgroundColor: hex }}
              aria-label={`Use ${hex}`}
            />
          ))}
        </div>
        {hasError && <p className="text-xs text-red-500">Use a valid hex color like #6C63FF.</p>}
      </div>
    </div>
  )
}


function OptionGrid<T extends string>({
  className,
  onChange,
  options,
  renderPreview,
  title,
  value,
}: {
  className?: string
  onChange: (value: T) => void
  options: readonly T[]
  renderPreview: (value: T) => ReactNode
  title: string
  value: T
}) {
  return (
    <div className={className}>
      <p className="mb-3 text-sm font-semibold text-foreground">{title}</p>
      <div className="grid grid-cols-3 gap-3">
        {options.map((opt) => (
          <button
            key={opt}
            type="button"
            onClick={() => onChange(opt)}
            className={cn(
              "rounded-xl border-2 p-4 text-center transition-all duration-200",
              value === opt
                ? "border-[var(--color-primary)] bg-[var(--color-primary)]/5"
                : "border-border hover:border-muted-foreground/40",
            )}
          >
            {renderPreview(opt)}
            <p className="mt-2 text-xs font-medium capitalize text-muted-foreground">{opt}</p>
          </button>
        ))}
      </div>
    </div>
  )
}


function ColorSummary({ className, label, value }: { className?: string; label: string; value: string }) {
  return (
    <div className={cn("flex items-center justify-between", className)}>
      <span className="text-xs text-muted-foreground">{label}</span>
      <div className="flex items-center gap-2">
        <div className="h-4 w-4 rounded-full" style={{ backgroundColor: HEX_RE.test(value) ? value : "#ffffff" }} />
        <span className="font-mono text-xs text-muted-foreground">{value}</span>
      </div>
    </div>
  )
}


function PreviewApp({
  accentColor,
  fontStyle,
  primaryColor,
  schoolName,
  sidebarStyle,
}: {
  accentColor: string
  fontStyle: FontStyle
  primaryColor: string
  schoolName: string
  sidebarStyle: SidebarStyle
}) {
  return (
    <div className="flex h-full w-full bg-[var(--surface-bg,#F8F7FF)]" style={{ fontFamily: FONT_FAMILIES[fontStyle] }}>
      <div
        className={cn(
          "flex h-full w-56 flex-col",
          sidebarStyle === "gradient" && "bg-[var(--gradient-main)]",
          sidebarStyle === "white" && "bg-white border-r border-gray-100",
          sidebarStyle === "dark" && "bg-gray-900",
        )}
      >
        <div className="flex items-center gap-2 p-4">
          <div
            className={cn(
              "flex h-8 w-8 items-center justify-center rounded-xl text-sm font-bold",
              sidebarStyle === "gradient" ? "bg-white/20 text-white" : "bg-[var(--gradient-main)] text-white",
            )}
          >
            S
          </div>
          <span
            className={cn(
              "truncate text-sm font-bold",
              sidebarStyle === "gradient" || sidebarStyle === "dark" ? "text-white" : "text-gray-800",
            )}
          >
            {schoolName || "School Name"}
          </span>
        </div>


        <div className="flex flex-col gap-1 p-3">
          {["Dashboard", "Students", "Classes", "Grades", "Finance", "Settings"].map((label, i) => {
            const isActive = i === 0
            return (
              <div
                key={label}
                className={cn(
                  "flex items-center gap-2 rounded-xl px-3 py-2 text-xs",
                  isActive
                    ? sidebarStyle === "white"
                      ? "bg-[var(--color-primary-light)] font-semibold text-[var(--color-primary)]"
                      : "bg-white/10 font-semibold text-white"
                    : sidebarStyle === "gradient" || sidebarStyle === "dark"
                      ? "text-white/60"
                      : "text-gray-500",
                )}
              >
                <span className="h-2 w-2 rounded-full bg-current opacity-70" />
                <span>{label}</span>
              </div>
            )
          })}
        </div>
      </div>


      <div className="flex flex-1 flex-col">
        <div className="flex h-10 items-center justify-between border-b border-gray-100 bg-white px-4">
          <span className="text-xs font-semibold text-gray-700">Dashboard</span>
          <div className="flex gap-1.5">
            {[1, 2, 3].map((n) => (
              <div key={n} className="h-5 w-5 rounded-full bg-gray-100" />
            ))}
          </div>
        </div>


        <div className="flex-1 overflow-hidden bg-gray-50 p-4">
          <p className="mb-3 text-sm font-bold text-gray-800">{schoolName || "Welcome to School Suite"}</p>


          <div className="mb-3 grid grid-cols-2 gap-2">
            {[
              "var(--gradient-main)",
              "var(--gradient-hero)",
              primaryColor,
              accentColor,
            ].map((bg, i) => (
              <div key={i} className="rounded-xl p-3" style={{ background: bg }}>
                <div className="mb-2 h-1.5 w-8 rounded bg-white/30" />
                <div className="h-3 w-12 rounded bg-white/80" />
              </div>
            ))}
          </div>


          <div className="overflow-hidden rounded-xl bg-white">
            <div className="flex bg-gray-50 px-3 py-2">
              {[1, 2, 3].map((n) => (
                <div key={n} className="mx-1 h-2 flex-1 animate-pulse rounded bg-gray-200" />
              ))}
            </div>
            {[true, false, false].map((hovered, i) => (
              <div
                key={i}
                className="flex items-center gap-2 border-t border-gray-50 px-3 py-2"
                style={hovered ? { backgroundColor: "var(--color-primary-light)" } : undefined}
              >
                <div className="h-6 w-6 shrink-0 rounded-full bg-gray-200" />
                <div className="h-2 w-16 rounded bg-gray-200" />
                <div className="ml-2 h-2 w-10 rounded bg-gray-100" />
                <div className={cn("ml-auto h-4 w-12 rounded-full", i === 0 ? "bg-green-200" : i === 1 ? "bg-amber-200" : "bg-red-200")} />
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
