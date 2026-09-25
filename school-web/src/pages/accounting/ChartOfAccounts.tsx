import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Accounting, ChartOfAccount } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import { renderCurrency, renderStatus } from "@/lib/tableHelpers";
import { PencilIcon } from "@/lib/icons";
import { toArray } from "@/lib/response";

export default function ChartOfAccounts() {
  const { t } = useTranslation();
  const [search, setSearch] = useState("");
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data, isLoading } = useQuery({
    queryKey: ["chart-of-accounts", search, activeFilters],
    queryFn: () => Accounting.chartOfAccounts({ search, ...activeFilters }),
  }) as any;

  const accounts = toArray<ChartOfAccount>(data);

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("accountingPages.coaTitle")} subtitle={t("accountingPages.coaSubtitle")} />

      <DataTable
        title={t("accountingPages.accounts")}
        columns={[
          { key: "account_code", label: t("accountingPages.code"), sortable: true, render: (v) => <span className="font-mono text-sm font-semibold text-foreground">{v}</span> },
          { key: "account_name", label: t("accountingPages.accountName"), sortable: true, render: (v, row) => (
            <div style={{ paddingLeft: `${(row.level ?? 0) * 16}px` }}>
              <span className="text-sm font-medium text-foreground">{v}</span>
            </div>
          )},
          { key: "account_type", label: t("accountingPages.type"), sortable: true, render: (v) => <span className="px-2.5 py-1 rounded-full text-xs font-medium bg-muted/50 text-muted-foreground capitalize">{v}</span> },
          { key: "normal_balance", label: t("accountingPages.normalBalance"), render: (v) => <span className={`text-xs font-semibold ${v === "debit" ? "text-blue-600" : "text-green-600"}`}>{v?.toUpperCase()}</span> },
          { key: "balance", label: t("accountingPages.balance"), render: (v) => renderCurrency(v ?? 0), align: "right" as const, sortable: true },
          { key: "is_active", label: t("common.status"), render: (v) => renderStatus(v ? "active" : "inactive") },
        ]}
        data={accounts}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder={t("accountingPages.searchAccounts")}
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "type", label: t("accountingPages.type"), options: [
                { value: "asset", label: t("accountingPages.asset") }, { value: "liability", label: t("accountingPages.liability") },
                { value: "equity", label: t("accountingPages.equity") }, { value: "revenue", label: t("accountingPages.revenue") }, { value: "expense", label: t("accountingPages.expense") },
              ]},
            ]}
          />
        }
        rowActions={[{ label: t("accountingPages.edit"), icon: <PencilIcon />, onClick: () => {} }]}
        emptyMessage={t("accountingPages.noAccounts")}
      />
    </div>
  );
}
