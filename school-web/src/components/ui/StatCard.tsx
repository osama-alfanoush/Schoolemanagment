import type { ReactNode } from "react";
import { cn } from "@/lib/utils";
import { ArrowUpRight, ArrowDownRight } from "lucide-react";

interface Trend {
  value: number;
  label: string;
  up: boolean;
}

interface StatCardProps {
  title: string;
  value: string | number;
  subtitle?: string;
  icon: ReactNode;
  trend?: Trend;
  /** Optional accent name (e.g. "purple", "mint", "sky", "pink") for the icon badge. */
  gradient?: string;
  className?: string;
}

const GRADIENTS: Record<string, string> = {
  purple: "bg-[var(--color-primary-light)] text-[var(--color-primary)]",
  mint: "bg-emerald-500/10 text-emerald-600 dark:text-emerald-400",
  sky: "bg-sky-500/10 text-sky-600 dark:text-sky-400",
  pink: "bg-[var(--color-accent-light)] text-[var(--color-accent-dark)]",
  amber: "bg-amber-500/10 text-amber-600 dark:text-amber-400",
  primary: "bg-[var(--color-primary-light)] text-[var(--color-primary)]",
  accent: "bg-[var(--color-accent-light)] text-[var(--color-accent-dark)]",
};

const ACCENT_COLORS: Record<string, string> = {
  purple: "var(--color-primary)",
  primary: "var(--color-primary)",
  mint: "rgb(16 185 129)",
  sky: "rgb(2 132 199)",
  pink: "var(--color-accent)",
  amber: "var(--color-accent)",
  accent: "var(--color-accent)",
};

export default function StatCard({ title, value, subtitle, icon, trend, gradient, className }: StatCardProps) {
  const accentColor = (gradient && ACCENT_COLORS[gradient]) || "var(--color-primary)";

  return (
    <div
      className={cn(
        "relative overflow-hidden bg-card border border-border p-5 shadow-sm transition-all duration-200 hover:shadow-[var(--shadow-hover)] hover:-translate-y-0.5 group",
        className
      )}
      style={{ borderRadius: "var(--radius-base, 1rem)" }}
    >
      {/* Accent stripe */}
      <span
        aria-hidden
        className="absolute inset-y-0 start-0 w-1"
        style={{ backgroundColor: accentColor }}
      />

      <div className="flex items-start justify-between gap-3">
        <div className="min-w-0">
          <p className="text-xs font-semibold uppercase tracking-wider text-muted-foreground truncate">{title}</p>
          <p className="mt-2 text-3xl font-bold text-foreground tabular-nums tracking-tight leading-none">{value}</p>
          {subtitle && <p className="mt-1.5 text-xs text-muted-foreground truncate">{subtitle}</p>}
        </div>
        <div
          className={cn(
            "rounded-xl p-3 flex items-center justify-center shrink-0 transition-transform duration-200 group-hover:scale-110",
            (gradient && GRADIENTS[gradient]) ||
              "bg-[var(--color-primary-light)] text-[var(--color-primary)]",
          )}
        >
          {icon}
        </div>
      </div>
      {trend && (
        <div className="mt-4 flex items-center gap-2">
          <div className={cn(
            "inline-flex items-center gap-0.5 rounded-full px-2 py-0.5 text-xs font-semibold tabular-nums",
            trend.up
              ? "text-emerald-700 dark:text-emerald-400 bg-emerald-500/10"
              : "text-destructive bg-destructive/10"
          )}>
            {trend.up ? <ArrowUpRight className="h-3.5 w-3.5" /> : <ArrowDownRight className="h-3.5 w-3.5" />}
            <span>{trend.value}%</span>
          </div>
          <span className="text-xs text-muted-foreground truncate">{trend.label}</span>
        </div>
      )}
    </div>
  );
}
