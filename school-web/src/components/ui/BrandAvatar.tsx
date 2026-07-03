import { cn } from "@/lib/utils";

const sizeMap: Record<string, string> = {
  sm: "h-8 w-8 text-xs",
  md: "h-10 w-10 text-sm",
  lg: "h-12 w-12 text-base",
  xl: "h-16 w-16 text-lg",
};

const roleGradientMap: Record<string, string> = {
  student: "gradient-purple",
  parent: "gradient-pink",
  teacher: "gradient-mint",
  admin: "gradient-ocean",
  finance: "gradient-sunset",
  hr: "gradient-purple",
  warehouse: "gradient-pink",
};

const roleRingMap: Record<string, string> = {
  student: "ring-[var(--color-primary)]",
  parent: "ring-[var(--color-accent)]",
  teacher: "ring-emerald-400",
  admin: "ring-sky-400",
  finance: "ring-amber-400",
  hr: "ring-violet-400",
  warehouse: "ring-orange-400",
};

function getInitials(name: string): string {
  const parts = name.trim().split(/\s+/);
  if (parts.length >= 2) return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  return parts[0].slice(0, 2).toUpperCase();
}

interface BrandAvatarProps {
  src?: string;
  name: string;
  role?: string;
  variant?: string;
  size?: "sm" | "md" | "lg" | "xl";
  className?: string;
}

export default function BrandAvatar({
  src,
  name,
  role,
  variant,
  size = "md",
  className,
}: BrandAvatarProps) {
  const initials = getInitials(name);
  const visualRole = variant ?? role;
  const gradientClass = visualRole ? roleGradientMap[visualRole] ?? "" : "";
  const ringClass = visualRole ? roleRingMap[visualRole] ?? "" : "";

  if (src) {
    return (
      <img
        src={src}
        alt={name}
        className={cn(
          "rounded-full object-cover ring-2 ring-offset-2",
          sizeMap[size],
          ringClass,
          className
        )}
      />
    );
  }

  return (
    <div
      className={cn(
        "flex items-center justify-center rounded-full font-semibold text-[var(--color-primary-fg)]",
        sizeMap[size],
        gradientClass || "bg-[var(--color-primary)]",
        className
      )}
    >
      {initials}
    </div>
  );
}
