import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Accounting, BudgetPlan } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { renderCurrency, renderProgress } from "@/lib/tableHelpers";
import { PencilIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function Budget() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());

  const { data, isLoading } = useQuery({
    queryKey: ["budgets", selectedYear],
    queryFn: () => Accounting.budgets({ year: selectedYear }),
  }) as any;

  const syncMutation = useMutation({
    mutationFn: () => Accounting.syncBudgetActuals({ fiscal_year: selectedYear }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["budgets", selectedYear] });
      toast({ title: "Budget actuals synced successfully" });
    },
    onError: (e: unknown) => toast({ variant: "destructive", title: "Sync failed", description: (e as Error)?.message }),
  });

  const budgets = toArray<BudgetPlan>(data);

  return (
    <div className="space-y-6">
      <PageHeader
        icon="UI"
        title="Budget Management"
        subtitle="Plan and track departmental budgets"
        actions={
          <div className="flex gap-2">
            <BrandButton variant="secondary" onClick={() => syncMutation.mutate()} disabled={syncMutation.isPending}>
              {syncMutation.isPending ? "Syncing..." : "Sync Actuals"}
            </BrandButton>
            <BrandButton variant="primary">+ New Budget</BrandButton>
          </div>
        }
      />

      <div className="flex items-center gap-2 mb-4">
        <label className="text-sm font-medium text-muted-foreground">Year:</label>
        <select
          value={selectedYear}
          onChange={(e) => setSelectedYear(Number(e.target.value))}
          className="px-3 py-1.5 rounded-lg border border-border text-sm"
        >
          {[2024, 2025, 2026, 2027].map((y) => (
            <option key={y} value={y}>{y}</option>
          ))}
        </select>
      </div>

      <DataTable
        title="Budget Lines"
        columns={[
          { key: "category", label: "Category", sortable: true },
          {
            key: "account_name", label: "Account",
            render: (v, row) => (
              <span className="text-sm text-muted-foreground">
                <span className="font-mono text-xs">{row.account_code}</span> {v}
              </span>
            ),
          },
          { key: "budgeted_amount", label: "Budgeted", render: (v) => renderCurrency(v ?? 0), align: "right" as const, sortable: true },
          { key: "actual_amount", label: "Actual", render: (v) => renderCurrency(v ?? 0), align: "right" as const, sortable: true },
          {
            key: "variance", label: "Variance", align: "right" as const,
            render: (v, row) => {
              const diff = (row.budgeted_amount ?? 0) - (row.actual_amount ?? 0);
              return (
                <span className={`text-sm font-semibold ${diff >= 0 ? "text-green-600" : "text-red-600"}`}>
                  {diff >= 0 ? "+" : ""}
                  {new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" }).format(diff)}
                </span>
              );
            },
          },
          {
            key: "utilization", label: "Utilization",
            render: (v, row) => {
              const pct = row.budgeted_amount ? Math.round((row.actual_amount / row.budgeted_amount) * 100) : 0;
              return renderProgress(pct, 100);
            },
          },
        ]}
        data={budgets}
        isLoading={isLoading}
        rowActions={[
          { label: "Edit", icon: <PencilIcon />, onClick: () => {} },
        ]}
        emptyMessage="No budget lines found."
      />
    </div>
  );
}
