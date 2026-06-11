import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

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
  className?: string;
}

export default function StatCard({ title, value, subtitle, icon, trend, className }: StatCardProps) {
  return (
    <div className={cn("bg-card border border-border border-l-4 border-l-[var(--color-primary)]/30 p-6 rounded-2xl shadow-sm transition-all duration-200", className)}>
      <div className="flex items-start justify-between">
        <div>
          <p className="text-sm text-muted-foreground">{title}</p>
          <p className="mt-2 text-2xl font-bold text-foreground">{value}</p>
          {subtitle && <p className="mt-1 text-xs text-muted-foreground">{subtitle}</p>}
        </div>
        <div className="rounded-lg p-2.5 bg-[var(--color-primary-light)] text-[var(--color-primary)] flex items-center justify-center">
          {icon}
        </div>
      </div>
      {trend && (
        <div className="mt-4 flex items-center gap-2">
          <div className={cn(
            "rounded-full px-2 py-0.5 text-xs font-semibold",
            trend.up 
              ? "text-emerald-600 dark:text-emerald-400 bg-emerald-500/10" 
              : "text-destructive bg-destructive/10"
          )}>
            <span>{trend.up ? "↑" : "↓"}</span>
            <span>{trend.value}%</span>
          </div>
          <span className="text-sm text-muted-foreground">{trend.label}</span>
        </div>
      )}
    </div>
  );
}
