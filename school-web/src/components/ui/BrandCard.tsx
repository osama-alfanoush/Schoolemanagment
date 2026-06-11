import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

interface BrandCardProps {
  children: ReactNode;
  className?: string;
  hover?: boolean;
  glass?: boolean;
  onClick?: () => void;
}

export default function BrandCard({
  children,
  className,
  hover = false,
  glass = false,
  onClick,
}: BrandCardProps) {
  return (
    <div
      onClick={onClick}
      className={cn(
        "rounded-xl border border-border bg-card shadow-sm transition-all duration-200",
        hover && "hover:shadow-md hover:-translate-y-0.5 cursor-pointer",
        glass && "backdrop-blur-md bg-card/70 border border-white/10 dark:bg-card/40 dark:border-white/5",
        className
      )}
    >
      {children}
    </div>
  );
}
