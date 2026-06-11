import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Accounting, ChartOfAccount } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import { renderCurrency, renderStatus } from "@/lib/tableHelpers";
import { PencilIcon } from "@/lib/icons";
import { toArray } from "@/lib/response";

export default function ChartOfAccounts() {
  const [search, setSearch] = useState("");
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data, isLoading } = useQuery({
    queryKey: ["chart-of-accounts", search, activeFilters],
    queryFn: () => Accounting.chartOfAccounts({ search, ...activeFilters }),
  }) as any;

  const accounts = toArray<ChartOfAccount>(data);

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Chart of Accounts" subtitle="Account structure and classifications" />

      <DataTable
        title="Accounts"
        columns={[
          { key: "account_code", label: "Code", sortable: true, render: (v) => <span className="font-mono text-sm font-semibold text-foreground">{v}</span> },
          { key: "account_name", label: "Account Name", sortable: true, render: (v, row) => (
            <div style={{ paddingLeft: `${(row.level ?? 0) * 16}px` }}>
              <span className="text-sm font-medium text-foreground">{v}</span>
            </div>
          )},
          { key: "account_type", label: "Type", sortable: true, render: (v) => <span className="px-2.5 py-1 rounded-full text-xs font-medium bg-muted/50 text-muted-foreground capitalize">{v}</span> },
          { key: "normal_balance", label: "Normal Balance", render: (v) => <span className={`text-xs font-semibold ${v === "debit" ? "text-blue-600" : "text-green-600"}`}>{v?.toUpperCase()}</span> },
          { key: "balance", label: "Balance", render: (v) => renderCurrency(v ?? 0), align: "right" as const, sortable: true },
          { key: "is_active", label: "Status", render: (v) => renderStatus(v ? "active" : "inactive") },
        ]}
        data={accounts}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder="Search accounts by name or code..."
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "type", label: "Type", options: [
                { value: "asset", label: "Asset" }, { value: "liability", label: "Liability" },
                { value: "equity", label: "Equity" }, { value: "revenue", label: "Revenue" }, { value: "expense", label: "Expense" },
              ]},
            ]}
          />
        }
        rowActions={[{ label: "Edit", icon: <PencilIcon />, onClick: () => {} }]}
        emptyMessage="No accounts found."
      />
    </div>
  );
}
