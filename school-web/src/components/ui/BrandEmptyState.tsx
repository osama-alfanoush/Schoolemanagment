import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

interface BrandEmptyStateProps {
  icon: ReactNode;
  title: string;
  description?: string;
  action?: ReactNode;
  className?: string;
}

export default function BrandEmptyState({
  icon,
  title,
  description,
  action,
  className,
}: BrandEmptyStateProps) {
  return (
    <div className={cn("flex flex-col items-center justify-center py-16 px-8 text-center", className)}>
      <div className="mb-4 rounded-2xl bg-muted/50 p-5 inline-flex">
        <span className="h-10 w-10 text-muted-foreground/60 flex items-center justify-center">
          {icon}
        </span>
      </div>
      <h3 className="text-base font-semibold text-foreground mb-1">{title}</h3>
      {description && <p className="text-sm text-muted-foreground max-w-xs">{description}</p>}
      {action && <div className="mt-6">{action}</div>}
    </div>
  );
}
