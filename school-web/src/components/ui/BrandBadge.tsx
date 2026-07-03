import { cn } from "@/lib/utils"
import type { ReactNode } from "react"

const roleStyles: Record<string, string> = {
  admin:   "bg-[var(--color-primary-light)] text-[var(--color-primary)] border border-[var(--color-primary)]/20",
  teacher: "bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20",
  student: "bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20",
  parent:  "bg-sky-500/10 text-sky-700 dark:text-sky-400 border border-sky-500/20",
  finance: "bg-orange-500/10 text-orange-700 dark:text-orange-400 border border-orange-500/20",
  hr:      "bg-violet-500/10 text-violet-700 dark:text-violet-400 border border-violet-500/20",
  warehouse: "bg-rose-500/10 text-rose-700 dark:text-rose-400 border border-rose-500/20",
  // Dynamic theme colors
  primary: "bg-[var(--color-primary-light)] text-[var(--color-primary)] border border-[var(--color-primary)]/20",
  accent:  "bg-[var(--color-accent-light)] text-[var(--color-accent)] border border-[var(--color-accent)]/20",
  success: "bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20",
  warning: "bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20",
  danger:  "bg-red-500/10 text-red-700 dark:text-red-400 border border-red-500/20",
  default: "bg-muted text-muted-foreground border border-border",
}

interface BrandBadgeProps {
  label?: string
  children?: ReactNode
  variant?: keyof typeof roleStyles
  className?: string
}

export default function BrandBadge({ label, children, variant = "default", className }: BrandBadgeProps) {
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold transition-colors",
        roleStyles[variant] || roleStyles.default,
        className
      )}
    >
      {label || children}
    </span>
  )
}
