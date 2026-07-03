import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

interface ActionConfig {
  label: string;
  onClick: () => void;
}

interface BrandEmptyStateProps {
  icon: ReactNode;
  title: string;
  description?: string;
  /** Alias for `description` — many call sites use `subtitle`. */
  subtitle?: string;
  /** A custom node, or a `{ label, onClick }` config rendered as a button. */
  action?: ReactNode | ActionConfig;
  className?: string;
}

function isActionConfig(action: ReactNode | ActionConfig): action is ActionConfig {
  return (
    typeof action === "object" &&
    action !== null &&
    "label" in action &&
    "onClick" in action
  );
}

export default function BrandEmptyState({
  icon,
  title,
  description,
  subtitle,
  action,
  className,
}: BrandEmptyStateProps) {
  description = description ?? subtitle;
  return (
    <div className={cn("flex flex-col items-center justify-center py-16 px-8 text-center", className)}>
      <div
        className="mb-4 bg-[var(--color-primary-light)] p-5 inline-flex"
        style={{ borderRadius: "var(--radius-base, 1rem)" }}
      >
        <span className="h-10 w-10 text-[var(--color-primary)] flex items-center justify-center">
          {icon}
        </span>
      </div>
      <h3 className="text-base font-semibold text-foreground mb-1">{title}</h3>
      {description && <p className="text-sm text-muted-foreground max-w-xs">{description}</p>}
      {action != null && (
        <div className="mt-6">
          {isActionConfig(action) ? (
            <button
              type="button"
              onClick={action.onClick}
              className="inline-flex items-center px-4 py-2 text-sm font-medium text-[var(--color-primary-fg)] shadow-sm transition-all duration-200 hover:brightness-110 hover:shadow-[var(--shadow-hover)] hover:-translate-y-0.5 active:scale-[0.97]"
              style={{
                backgroundColor: "var(--color-primary)",
                borderRadius: "var(--radius-base, 0.5rem)",
              }}
            >
              {action.label}
            </button>
          ) : (
            action
          )}
        </div>
      )}
    </div>
  );
}
