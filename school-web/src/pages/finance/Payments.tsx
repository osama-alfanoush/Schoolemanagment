import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Finance, Invoice } from "@/lib/api";
import { renderUser, renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { EyeIcon, DownloadIcon } from "@/lib/icons";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function FinancePayments() {
  const [search, setSearch] = useState("");
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data: invoicesData, isLoading } = useQuery({
    queryKey: ["finance", "invoices"],
    queryFn: () => Finance.invoices(),
  }) as any;
const invoices = Array.isArray(invoicesData) ? invoicesData : invoicesData?.data ?? [];

  const paidInvoices = invoices.filter((i: any) => i.status === "paid");
  const todayStr = new Date().toISOString().slice(0, 10);
  const todayTotal = paidInvoices
    .filter((i: any) => i.paid_at?.startsWith(todayStr) ?? false)
    .reduce((s: number, i: any) => s + (i.amount ?? 0), 0);
  const monthStr = todayStr.slice(0, 7);
  const monthTotal = paidInvoices
    .filter((i: any) => (i.paid_at ?? i.updated_at)?.startsWith(monthStr))
    .reduce((s: number, i: any) => s + (i.amount ?? 0), 0);
  const pendingTotal = invoices
    .filter((i: any) => i.status === "pending")
    .reduce((s: number, i: any) => s + (i.amount ?? 0), 0);

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Payments" subtitle="Payment transactions and gateway records" />

      <div className="grid grid-cols-3 gap-4 mb-6">
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">Total Collected Today</p>
          <p className="text-xl font-bold text-green-600 mt-1">{renderCurrency(todayTotal)}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">This Month</p>
          <p className="text-xl font-bold mt-1" style={{ color: "var(--color-primary)" }}>{renderCurrency(monthTotal)}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">Pending Confirmation</p>
          <p className="text-xl font-bold text-amber-600 mt-1">{renderCurrency(pendingTotal)}</p>
        </BrandCard>
      </div>

      {invoices.length === 0 && !isLoading ? (
        <BrandEmptyState icon="UI" title="No payment records" subtitle="No payment transactions found." />
      ) : (
        <DataTable
          title="Payment Transactions"
          data={invoices}
          isLoading={isLoading}
          columns={[
            { key: "transaction_id", label: "Transaction ID", render: (v: any, row: any) => (
              <span className="font-mono text-xs text-muted-foreground">{row.invoice_no ?? `#${row.id}`}</span>
            )},
            { key: "student", label: "Student", render: (_: any, row: any) => renderUser(row.student?.name ?? row.student_name ?? "-", row.class_name ?? "") },
            { key: "amount", label: "Amount", align: "right" as const, sortable: true, render: (v: any, row: any) => renderCurrency(v ?? row.total ?? 0) },
            { key: "method", label: "Method", render: (v: any, row: any) => (
              <span className="px-2.5 py-1 rounded-full text-xs font-medium bg-muted/50 text-muted-foreground">
                {row.payment_method ?? v ?? "-"}
              </span>
            )},
            { key: "date", label: "Date", sortable: true, render: (v: any, row: any) => renderDate(v ?? row.paid_at ?? row.created_at) },
            { key: "status", label: "Status", render: (v: any) => renderStatus(v) },
          ]}
          rowActions={[
            { icon: <EyeIcon />, label: "View", onClick: () => {} },
            { icon: <DownloadIcon />, label: "Download Receipt", show: (row: any) => row.status === "paid", onClick: () => {} },
          ]}
          toolbar={
            <SearchAndFilter
              placeholder="Search payments..."
              value={search}
              onChange={setSearch}
              filters={[
                { key: "method", label: "Method", options: [
                  { value: "cash", label: "Cash" },
                  { value: "card", label: "Card" },
                  { value: "bank transfer", label: "Bank Transfer" },
                  { value: "online", label: "Online" },
                ]},
                { key: "status", label: "Status", options: [
                  { value: "paid", label: "Paid" },
                  { value: "pending", label: "Pending" },
                  { value: "failed", label: "Failed" },
                  { value: "refunded", label: "Refunded" },
                ]},
              ]}
              activeFilters={activeFilters}
              onFilterChange={(key, val) => setActiveFilters((p) => ({ ...p, [key]: val }))}
              onClearFilters={() => setActiveFilters({})}
            />
          }
        />
      )}
    </div>
  );
}
