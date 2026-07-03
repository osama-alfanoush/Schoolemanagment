import * as React from "react"
import { Slot } from "@radix-ui/react-slot"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all duration-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[var(--color-primary)]/40 focus-visible:ring-offset-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0",
  {
    variants: {
      variant: {
        default:
          "bg-[var(--color-primary)] text-[var(--color-primary-fg)] shadow-card hover:shadow-hover hover:-translate-y-[1px] hover:brightness-110 active:scale-[0.98]",
        destructive:
          "bg-destructive text-destructive-foreground shadow-card border-destructive-border hover:shadow-hover hover:-translate-y-[1px]",
        outline:
          "border border-border bg-card text-foreground hover:bg-[var(--color-primary-subtle)] hover:text-[var(--color-primary)] hover:border-[var(--color-primary)]/30 shadow-sm",
        secondary:
          "bg-[var(--color-primary-light)] text-[var(--color-primary)] hover:bg-[var(--color-primary-medium)]",
        accent:
          "bg-[var(--color-accent)] text-[var(--color-accent-fg)] border border-[var(--color-accent-dark)]/20 hover:brightness-110",
        ghost: "text-muted-foreground hover:bg-[var(--color-primary-subtle)] hover:text-[var(--color-primary)]",
        link: "text-[var(--color-primary)] underline-offset-4 hover:underline",
      },
      size: {
        default: "min-h-9 px-4 py-2",
        sm: "min-h-8 rounded-md px-3 text-xs",
        lg: "min-h-10 rounded-md px-8",
        icon: "h-9 w-9",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
  VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button"
    return (
      <Comp
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    )
  }
)
Button.displayName = "Button"

export { Button, buttonVariants }
