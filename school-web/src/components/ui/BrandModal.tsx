import { useEffect, useState, type ReactNode } from "react";
import { cn } from "@/lib/utils";
import { X } from "lucide-react";

/* ─── Types ─── */
interface BrandModalProps {
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: ReactNode;
  size?: "sm" | "md" | "lg" | "xl";
  footer?: ReactNode;
  icon?: string;
}

const sizeMap: Record<string, string> = {
  sm: "max-w-md",
  md: "max-w-lg",
  lg: "max-w-2xl",
  xl: "max-w-4xl",
};

/* ─── Main Component ─── */
export default function BrandModal({
  isOpen,
  onClose,
  title,
  children,
  size = "md",
  footer,
  icon,
}: BrandModalProps) {
  const [visible, setVisible] = useState(false);
  const [animIn, setAnimIn] = useState(false);

  useEffect(() => {
    let timer: ReturnType<typeof setTimeout> | undefined;
    if (isOpen) {
      setVisible(true);
      requestAnimationFrame(() => setAnimIn(true));
    } else {
      setAnimIn(false);
      timer = setTimeout(() => setVisible(false), 200);
    }
    return () => { if (timer) clearTimeout(timer); };
  }, [isOpen]);

  // Close on Escape
  useEffect(() => {
    if (!isOpen) return;
    const handler = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", handler);
    return () => document.removeEventListener("keydown", handler);
  }, [isOpen, onClose]);

  if (!visible) return null;

  return (
    <div
      className="fixed inset-0 z-50 bg-black/40 backdrop-blur-sm flex items-center justify-center p-4"
      onClick={onClose}
      role="presentation"
    >
      <div
        className={cn(
          "bg-card flex flex-col max-h-[90vh] transition-all duration-200 ease-out shadow-[var(--shadow-hover)] w-full",
          sizeMap[size],
          animIn ? "scale-100 opacity-100" : "scale-95 opacity-0"
        )}
        style={{ borderRadius: "var(--radius-base, 1.5rem)" }}
        onClick={(e) => e.stopPropagation()}
        role="presentation"
      >
        {/* Header */}
        <div className="flex items-center justify-between p-6 border-b border-border">
          <div className="flex items-center gap-3">
            {icon && (
              <div
                className="w-10 h-10 bg-[var(--color-primary)] text-[var(--color-primary-fg)] flex items-center justify-center text-xl"
                style={{ borderRadius: "var(--radius-base, 0.75rem)" }}
              >
                {icon}
              </div>
            )}
            <h2 className="font-display font-bold text-foreground text-lg">{title}</h2>
          </div>
          <button
            onClick={onClose}
            className="w-8 h-8 rounded-full hover:bg-muted/60 transition-colors flex items-center justify-center"
          >
            <X className="h-4 w-4 text-muted-foreground" />
          </button>
        </div>

        {/* Body */}
        <div className="flex-1 overflow-y-auto p-6">{children}</div>

        {/* Footer */}
        {footer && (
          <div className="p-6 border-t border-border flex items-center justify-end gap-3">
            {footer}
          </div>
        )}
      </div>
    </div>
  );
}
