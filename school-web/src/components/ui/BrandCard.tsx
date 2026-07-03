import type { KeyboardEvent, ReactNode } from "react"
import { cn } from "@/lib/utils"

interface BrandCardProps {
  children: ReactNode
  className?: string
  hover?: boolean
  glass?: boolean
  onClick?: () => void
  variant?: "default" | "outline" | "elevated" | "ghost"
}

export default function BrandCard({
  children,
  className,
  hover = false,
  glass = false,
  onClick,
  variant = "default",
}: BrandCardProps) {
  const base = "p-5 transition-all duration-200"

  const variants = {
    default: "bg-card border border-border shadow-sm",
    outline: "bg-transparent border-2 border-border",
    elevated: "bg-card border border-border shadow-[var(--shadow-card)]",
    ghost: "bg-muted/30 border border-transparent",
  }

  const hoverClass = hover || onClick
    ? "hover:shadow-[var(--shadow-hover)] hover:-translate-y-0.5 cursor-pointer"
    : ""

  const glassClass = glass
    ? "!bg-white/80 dark:!bg-card/60 backdrop-blur-md border-white/30 dark:border-white/10"
    : ""

  const handleKeyDown = (event: KeyboardEvent<HTMLDivElement>) => {
    if (!onClick || (event.key !== "Enter" && event.key !== " ")) return
    event.preventDefault()
    onClick()
  }

  return (
    <div
      onClick={onClick}
      onKeyDown={handleKeyDown}
      role={onClick ? "button" : undefined}
      tabIndex={onClick ? 0 : undefined}
      className={cn(base, variants[variant], hoverClass, glassClass, className)}
      style={{ borderRadius: "var(--radius-base, 1rem)" }}
    >
      {children}
    </div>
  )
}
