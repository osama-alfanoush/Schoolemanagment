import { cn } from "@/lib/utils"
import type { ReactNode } from "react"

const roleStyles: Record<string, string> = {
  admin:   "bg-[var(--color-primary-light)] text-[var(--color-primary)] border border-[var(--color-primary)]/20",
  teacher: "bg-amber-500/10 text-amber-700 dark:text-amber-400 border border-amber-500/20",
  student: "bg-emerald-500/10 text-emerald-700 dark:text-emerald-400 border border-emerald-500/20",
  parent:  "bg-sky-500/10 text-sky-700 dark:text-sky-400 border border-sky-500/20",
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
        "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold",
        roleStyles[variant] || roleStyles.default,
        className
      )}
    >
      {label || children}
    </span>
  )
}
