import BrandBadge from "@/components/ui/BrandBadge";

export { hasPermission } from "@/lib/permissions";

export const money = (value: number | string | null | undefined) =>
  new Intl.NumberFormat(undefined, { style: "currency", currency: "USD" }).format(Number(value ?? 0));

export const dateText = (value?: string | null) =>
  value ? new Intl.DateTimeFormat(undefined, { dateStyle: "medium" }).format(new Date(value)) : "—";

export function StatusBadge({ status }: { status: string }) {
  const variant = ["paid", "received", "approved", "posted", "completed", "active"].includes(status)
    ? "success"
    : ["cancelled", "overdue", "defaulted"].includes(status)
      ? "danger"
      : ["pending_approval", "partial", "partially_received", "processed"].includes(status)
        ? "warning"
        : "default";
  return <BrandBadge variant={variant}>{status.replaceAll("_", " ")}</BrandBadge>;
}

export const fieldClass = "space-y-1.5";
