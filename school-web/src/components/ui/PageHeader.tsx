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
                {i > 0 && <span className="text-ink-light text-xs">›</span>}
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
      <div className="flex items-center justify-between pb-5 border-b border-border">
        <div className="flex items-center gap-4">
          {icon && (
            <div className="w-12 h-12 bg-[var(--color-primary-light)] text-[var(--color-primary)] rounded-xl flex items-center justify-center text-2xl shadow-sm">
              {icon}
            </div>
          )}
          <div>
            <h1 className="font-display text-2xl font-bold text-foreground leading-tight">{title}</h1>
            {subtitle && <p className="text-muted-foreground text-sm mt-0.5">{subtitle}</p>}
          </div>
        </div>
        {actions && <div className="flex items-center gap-3">{actions}</div>}
      </div>
    </div>
  );
}
