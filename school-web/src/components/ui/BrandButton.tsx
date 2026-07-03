import { type ReactNode } from "react";
import { cn } from "@/lib/utils";
import { Loader2 } from "lucide-react";

/* ─── Types ─── */
interface BrandButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  children: ReactNode;
  variant?: "primary" | "secondary" | "ghost" | "destructive" | "outline";
  size?: "sm" | "md" | "lg";
  isLoading?: boolean;
  leftIcon?: ReactNode;
  rightIcon?: ReactNode;
  fullWidth?: boolean;
}

const sizeClasses: Record<string, string> = {
  sm: "px-3 py-1.5 text-xs gap-1.5",
  md: "px-4 py-2.5 text-sm gap-2",
  lg: "px-6 py-3 text-base gap-2.5",
};

const variantClasses = {
  primary: cn(
    "bg-[var(--color-primary)] text-[var(--color-primary-fg)] font-semibold",
    "hover:brightness-110 hover:shadow-md hover:shadow-[var(--color-primary)]/30",
    "active:scale-[0.97] active:brightness-95",
    "focus-visible:ring-2 focus-visible:ring-[var(--color-primary)]/50 focus-visible:ring-offset-2",
    "disabled:opacity-50 disabled:pointer-events-none"
  ),
  secondary: cn(
    "bg-[var(--color-primary-light)] text-[var(--color-primary)] font-semibold border border-[var(--color-primary)]/20",
    "hover:bg-[var(--color-primary)]/15 hover:border-[var(--color-primary)]/40",
    "active:scale-[0.97]",
    "disabled:opacity-50 disabled:pointer-events-none"
  ),
  outline: cn(
    "bg-transparent border-2 border-[var(--color-primary)] text-[var(--color-primary)] font-semibold",
    "hover:bg-[var(--color-primary)] hover:text-[var(--color-primary-fg)]",
    "active:scale-[0.97]",
    "disabled:opacity-50 disabled:pointer-events-none"
  ),
  ghost: cn(
    "bg-transparent text-foreground font-medium",
    "hover:bg-muted/60",
    "active:scale-[0.97]",
    "disabled:opacity-50 disabled:pointer-events-none"
  ),
  destructive: cn(
    "bg-destructive text-white font-semibold",
    "hover:bg-destructive/90 hover:shadow-md hover:shadow-destructive/30",
    "active:scale-[0.97]",
    "disabled:opacity-50 disabled:pointer-events-none"
  ),
};

/* ─── Main Component ─── */
export default function BrandButton({
  children,
  variant = "primary",
  size = "md",
  isLoading,
  leftIcon,
  rightIcon,
  disabled,
  className,
  fullWidth,
  ...props
}: BrandButtonProps) {
  const isDisabled = disabled || isLoading;

  const spinnerColor =
    variant === "primary" || variant === "destructive"
      ? "text-[var(--color-primary-fg)]"
      : "text-[var(--color-primary)]";

  return (
    <button
      disabled={isDisabled}
      className={cn(
        "inline-flex items-center justify-center rounded-lg transition-all duration-150 focus-visible:outline-none",
        sizeClasses[size],
        variantClasses[variant],
        fullWidth && "w-full",
        className
      )}
      {...props}
    >
      {isLoading ? (
        <>
          <Loader2 className={cn("h-4 w-4 animate-spin", spinnerColor)} />
          <span>Loading...</span>
        </>
      ) : (
        <>
          {leftIcon}
          {children}
          {rightIcon}
        </>
      )}
    </button>
  );
}
