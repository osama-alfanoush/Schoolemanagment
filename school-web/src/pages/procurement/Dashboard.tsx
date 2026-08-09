import { useQuery } from "@tanstack/react-query";
import { Link } from "wouter";
import { Building2, ClipboardList, Clock3, PackageCheck, Receipt, Wallet } from "lucide-react";
import { Procurement } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import StatCard from "@/components/ui/StatCard";
import BrandButton from "@/components/ui/BrandButton";
import { money, StatusBadge } from "./shared";

export default function ProcurementDashboard() {
  const { data, isLoading, error } = useQuery({ queryKey: ["procurement-dashboard"], queryFn: Procurement.dashboard });
  const statuses = Object.entries(data?.orders_by_status ?? {});

  return <div className="space-y-6">
    <PageHeader icon="PR" title="Procurement" subtitle="Purchase orders, deliveries, suppliers, and accounts payable"
      actions={<Link href="/procurement/purchase-orders"><BrandButton>Manage purchase orders</BrandButton></Link>} />
    {error && <div className="rounded-xl border border-destructive/30 bg-destructive/10 p-4 text-sm text-destructive">{error.message}</div>}
    <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
      <StatCard title="Active suppliers" value={isLoading ? "—" : data?.suppliers_active ?? 0} icon={<Building2 className="h-5 w-5" />} gradient="purple" />
      <StatCard title="Pending approval" value={isLoading ? "—" : data?.pending_approval ?? 0} icon={<Clock3 className="h-5 w-5" />} gradient="amber" />
      <StatCard title="Awaiting delivery" value={isLoading ? "—" : data?.awaiting_delivery ?? 0} icon={<ClipboardList className="h-5 w-5" />} gradient="sky" />
      <StatCard title="Received this month" value={isLoading ? "—" : money(data?.month_received_total)} icon={<PackageCheck className="h-5 w-5" />} gradient="mint" />
      <StatCard title="Total payable" value={isLoading ? "—" : money(data?.total_payable)} icon={<Wallet className="h-5 w-5" />} gradient="pink" />
      <StatCard title="Purchase orders" value={statuses.reduce((sum, [, count]) => sum + Number(count), 0)} icon={<Receipt className="h-5 w-5" />} gradient="primary" />
    </div>
    <section className="rounded-xl border border-border bg-card p-5 shadow-sm">
      <h2 className="font-display text-lg font-bold">Order pipeline</h2>
      <div className="mt-4 flex flex-wrap gap-3">
        {statuses.length ? statuses.map(([status, count]) => <div key={status} className="flex items-center gap-3 rounded-lg border border-border px-4 py-3"><StatusBadge status={status} /><strong className="tabular-nums">{count}</strong></div>) : <p className="text-sm text-muted-foreground">No purchase orders yet.</p>}
      </div>
    </section>
  </div>;
}
