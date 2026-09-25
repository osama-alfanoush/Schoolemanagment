import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useLocation } from "wouter";
import { useQuery } from "@tanstack/react-query";
import { Parent } from "@/lib/api";
import { renderUser, renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { EyeIcon, DownloadIcon } from "@/lib/icons";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function ParentInvoices() {
  const { t } = useTranslation();
  const [, setLocation] = useLocation();
  const [selectedChild, setSelectedChild] = useState<number | "all">("all");
  const [search, setSearch] = useState("");
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data: childrenData } = useQuery({
    queryKey: ["parent-children"],
    queryFn: () => Parent.children(),
  }) as any;
  const children = Array.isArray(childrenData) ? childrenData : childrenData?.data ?? [];

  const { data: invoicesData, isLoading } = useQuery({
    queryKey: ["parent-invoices", selectedChild],
    queryFn: () => {
      const id = selectedChild === "all" ? children[0]?.id : selectedChild;
      if (!id) return Promise.resolve({ invoices: [], outstanding_total: 0 });
      return Parent.childInvoices(id);
    },
    enabled: children.length > 0,
  }) as any;
// The API returns { invoices, outstanding_total }; tolerate legacy array/{data} shapes too.
const invoices = Array.isArray(invoicesData)
  ? invoicesData
  : invoicesData?.invoices ?? invoicesData?.data ?? [];

  const totalPaid = invoices
    .filter((i: any) => i.status === "paid")
    .reduce((s: number, i: any) => s + (i.amount ?? i.total ?? 0), 0);

  const totalOutstanding = invoices
    .filter((i: any) => ["pending", "partial", "overdue"].includes(i.status))
    .reduce((s: number, i: any) => s + ((i.amount ?? i.total ?? 0) - (i.paid_amount ?? 0)), 0);

  const nextDue = invoices
    .filter((i: any) => i.status !== "paid")
    .sort((a: any, b: any) => new Date(a.due_date ?? a.issue_date).getTime() - new Date(b.due_date ?? b.issue_date).getTime())[0];

  const showStudentColumn = children.length > 1 && selectedChild === "all";
  const activeChildId = selectedChild === "all" ? children[0]?.id : selectedChild;

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("parentPages.invoicesTitle")} subtitle={t("parentPages.invoicesSubtitle")} />

      {children.length > 1 && (
        <div className="flex gap-2 flex-wrap">
          <button
            onClick={() => setSelectedChild("all")}
            className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
              selectedChild === "all" ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
            }`}
            style={selectedChild === "all" ? { background: "var(--gradient-main)" } : undefined}
          >
            All Children
          </button>
          {children.map((c: any) => (
            <button
              key={c.id}
              onClick={() => setSelectedChild(c.id)}
              className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
                selectedChild === c.id ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
              }`}
              style={selectedChild === c.id ? { background: "var(--gradient-main)" } : undefined}
            >
              {c.name}
            </button>
          ))}
        </div>
      )}

      {invoices.length > 0 && (
        <div className="grid grid-cols-3 gap-4 mb-6">
          <BrandCard className="p-4">
            <p className="text-xs text-muted-foreground">{t("parentPages.totalPaid")}</p>
            <p className="text-xl font-bold mt-1" style={{ color: "var(--color-primary)" }}>{renderCurrency(totalPaid)}</p>
          </BrandCard>
          <BrandCard className="p-4">
            <p className="text-xs text-muted-foreground">{t("parentPages.outstanding")}</p>
            <p className="text-xl font-bold mt-1" style={{ color: "var(--color-primary)" }}>{renderCurrency(totalOutstanding)}</p>
          </BrandCard>
          <BrandCard className="p-4">
            <p className="text-xs text-muted-foreground">{t("parentPages.nextDueDate")}</p>
            <p className="text-xl font-bold mt-1" style={{ color: "var(--color-primary)" }}>
              {nextDue ? renderDate(nextDue.due_date ?? nextDue.issue_date) : "-"}
            </p>
          </BrandCard>
        </div>
      )}

      {invoices.length === 0 && !isLoading ? (
        <BrandEmptyState icon="UI" title={t("parentPages.noInvoices")} subtitle={t("parentPages.noInvoicesHint")} />
      ) : (
        <DataTable
          data={invoices}
          isLoading={isLoading}
          columns={[
            { key: "invoice_no", label: "Invoice #", render: (v: any) => <span className="font-mono text-xs">#{v}</span> },
            ...(showStudentColumn
              ? [{ key: "student", label: t("parentPages.student"), render: (_: any, row: any) => renderUser(row.student_name ?? "-", "") }]
              : []
            ),
            { key: "amount", label: t("parentPages.amount"), align: "right" as const, sortable: true, render: (v: any, row: any) => renderCurrency(v ?? row.total ?? 0) },
            { key: "due_date", label: t("parentPages.dueDate"), sortable: true, render: (v: any, row: any) => renderDate(v ?? row.issue_date) },
            { key: "status", label: t("common.status"), render: (v: any) => renderStatus(v) },
          ]}
          rowActions={[
            {
              icon: <EyeIcon />,
              label: t("parentPages.viewChild"),
              onClick: () => { if (activeChildId) setLocation(`/parent/children/${activeChildId}`); },
            },
            {
              icon: <DownloadIcon />,
              label: t("parentPages.downloadReceipt"),
              show: (row: any) => row.status === "paid",
              onClick: (row: any) => {
                if (activeChildId) void Parent.childInvoiceReceipt(activeChildId, row.id, row.invoice_no);
              },
            },
          ]}
          toolbar={
            <SearchAndFilter
              placeholder={t("parentPages.searchInvoices")}
              value={search}
              onChange={setSearch}
              filters={[
                { key: "status", label: t("common.status"), options: [
                  { value: "paid", label: t("status.paid") },
                  { value: "unpaid", label: t("status.unpaid") },
                  { value: "partial", label: t("status.partial") },
                  { value: "overdue", label: t("status.overdue") },
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
