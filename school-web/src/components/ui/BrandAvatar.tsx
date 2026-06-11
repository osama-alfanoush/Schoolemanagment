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
};

const roleRingMap: Record<string, string> = {
  student: "ring-brand-purple",
  parent: "ring-brand-pink",
  teacher: "ring-brand-mint",
  admin: "ring-brand-sky",
  finance: "ring-brand-amber",
  hr: "ring-brand-lavender",
  accounting: "ring-brand-emerald",
  warehouse: "ring-brand-orange",
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
  size?: "sm" | "md" | "lg" | "xl";
  className?: string;
}

export default function BrandAvatar({
  src,
  name,
  role,
  size = "md",
  className,
}: BrandAvatarProps) {
  const initials = getInitials(name);
  const gradientClass = role ? roleGradientMap[role] ?? "" : "";
  const ringClass = role ? roleRingMap[role] ?? "" : "";

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
        "flex items-center justify-center rounded-full font-semibold text-white",
        sizeMap[size],
        gradientClass || "bg-brand-purple",
        className
      )}
    >
      {initials}
    </div>
  );
}
