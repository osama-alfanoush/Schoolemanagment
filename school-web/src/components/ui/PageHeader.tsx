import type { ReactNode } from "react";
import { cn } from "@/lib/utils";
import { Link } from "wouter";

/* ─── Types ─── */
interface Breadcrumb {
  label: string;
  href?: string;
  onClick?: () => void;
}

interface PageHeaderProps {
  title: string;
  subtitle?: string;
  icon?: string;
  actions?: ReactNode;
  breadcrumbs?: Breadcrumb[];
}

/* ─── Main Component ─── */
export default function PageHeader({
  title,
  subtitle,
  icon,
  actions,
  breadcrumbs,
}: PageHeaderProps) {
  return (
    <div className="mb-6">
      {/* Breadcrumbs */}
      {breadcrumbs && breadcrumbs.length > 0 && (
        <div className="flex items-center gap-1.5 mb-3">
          {breadcrumbs.map((crumb, i) => {
            const isLast = i === breadcrumbs.length - 1;
            return (
              <span key={i} className="inline-flex items-center gap-1.5">
                {i > 0 && <span className="text-muted-foreground/40 text-xs">›</span>}
                {crumb.href && !isLast ? (
                  <Link
                    href={crumb.href}
                    className="text-xs text-muted-foreground hover:text-[var(--color-primary)] cursor-pointer transition-colors"
                  >
                    {crumb.label}
                  </Link>
                ) : crumb.onClick && !isLast ? (
                  <button
                    type="button"
                    onClick={crumb.onClick}
                    className="text-xs text-muted-foreground hover:text-[var(--color-primary)] cursor-pointer transition-colors"
                  >
                    {crumb.label}
                  </button>
                ) : (
                  <span className={cn("text-xs", isLast ? "text-foreground font-medium" : "text-muted-foreground")}>
                    {crumb.label}
                  </span>
                )}
              </span>
            );
          })}
        </div>
      )}

      {/* Main row */}
      <div className="flex flex-col gap-4 pb-5 border-b border-border sm:flex-row sm:items-center sm:justify-between">
        <div className="flex items-center gap-4 min-w-0">
          {icon && (
            <div
              className="w-12 h-12 shrink-0 bg-[var(--color-primary-light)] text-[var(--color-primary)] ring-1 ring-[var(--color-primary)]/15 flex items-center justify-center text-2xl shadow-sm transition-transform duration-200 hover:scale-105"
              style={{ borderRadius: "var(--radius-base, 0.75rem)" }}
            >
              {icon}
            </div>
          )}
          <div className="min-w-0">
            <h1 className="font-display text-xl sm:text-2xl font-bold text-foreground leading-tight truncate">{title}</h1>
            {subtitle && <p className="text-muted-foreground text-sm mt-0.5">{subtitle}</p>}
          </div>
        </div>
        {actions && <div className="flex items-center gap-2 sm:gap-3 flex-wrap">{actions}</div>}
      </div>
    </div>
  );
}
