import { useQuery } from "@tanstack/react-query";
import { useLocation } from "wouter";
import { Accounting, BudgetPlan, FinancialClosing, JournalEntry } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import StatCard from "@/components/ui/StatCard";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { renderDate } from "@/lib/tableHelpers";
import { useTranslation } from "react-i18next";
import { toArray } from "@/lib/response";
import { CircleDollarSign, Landmark, TrendingDown, TrendingUp } from "lucide-react";

function fmt(n: number | undefined | null) {
  if (n == null) return "-";
  return new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" }).format(n);
}

export default function AccountingDashboard() {
  const [, navigate] = useLocation();
  const { t } = useTranslation();
  const now = new Date();
  const reportParams = { month: now.getMonth() + 1, year: now.getFullYear() };

  const { data: trialData, isLoading } = useQuery({
    queryKey: ["accounting-dashboard", reportParams.month, reportParams.year],
    queryFn: () => Accounting.trialBalance(reportParams),
  }) as any;

  const { data: recentEntries } = useQuery({
    queryKey: ["recent-journal-entries"],
    queryFn: () => Accounting.journalEntries({ per_page: 5 }),
  }) as any;

  const { data: budgetData } = useQuery({
    queryKey: ["accounting-budgets"],
    queryFn: () => Accounting.budgets({ per_page: 5 }),
  }) as any;

  const { data: closingsData } = useQuery({
    queryKey: ["accounting-closings"],
    queryFn: () => Accounting.closings(),
  }) as any;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-brand-purple border-t-transparent" />
      </div>
    );
  }

  const trialRows = toArray<any>(trialData);
  const journalEntries = toArray<JournalEntry>(recentEntries);
  const budgets = toArray<BudgetPlan>(budgetData);
  const closings = toArray<FinancialClosing>(closingsData);
  const totalDebit = trialRows.reduce((sum, row) => sum + Number(row.total_debit ?? row.debit ?? 0), 0);
  const totalCredit = trialRows.reduce((sum, row) => sum + Number(row.total_credit ?? row.credit ?? 0), 0);
  const netBalance = totalDebit - totalCredit;

  return (
    <div className="space-y-6">
      <PageHeader icon="AC" title={t("accountingDashboard.title")} subtitle={t("accountingDashboard.subtitle")} />

      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <StatCard title="Total debit" value={fmt(totalDebit)} icon={<TrendingUp className="h-5 w-5" />} />
        <StatCard title="Total credit" value={fmt(totalCredit)} icon={<TrendingDown className="h-5 w-5" />} />
        <StatCard title="Net balance" value={fmt(netBalance)} icon={<CircleDollarSign className="h-5 w-5" />} />
        <StatCard title="Journal entries" value={journalEntries.length} icon={<Landmark className="h-5 w-5" />} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mt-6">
        <BrandCard className="!p-0 overflow-hidden">
          <div className="flex items-center justify-between p-5 pb-3">
            <h3 className="font-display text-base font-bold text-ink-dark">{t("accountingDashboard.recentJournalEntries")}</h3>
            <BrandButton variant="ghost" size="sm" onClick={() => navigate("/accounting/journal-entries")}>{t("accountingDashboard.manage")}</BrandButton>
          </div>
          <div className="px-5 pb-5">
            {journalEntries.length > 0 ? (
              <div className="flex flex-col divide-y divide-gray-50">
                {journalEntries.map((row: JournalEntry) => (
                  <div key={row.id} className="flex items-center justify-between py-3">
                    <div className="min-w-0">
                      <p className="text-sm font-mono text-foreground">{row.reference_no ?? `JE-${row.id}`}</p>
                      <p className="text-xs text-muted-foreground/70">{renderDate(row.entry_date)}</p>
                    </div>
                    <div className="flex-1 px-4">
                      <p className="text-sm text-muted-foreground line-clamp-1 max-w-[200px]">{row.description}</p>
                    </div>
                    <div className="text-right rtl:text-left">
                      <p className="text-sm font-semibold">{fmt(row.amount)}</p>
                      <span className={`inline-block px-2 py-0.5 rounded-full text-xs ${row.type === "credit" ? "bg-green-50 text-green-700" : "bg-blue-50 text-blue-700"}`}>
                        {row.type === "credit" ? t("accountingDashboard.credit") : t("accountingDashboard.debit")}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground/70 text-center py-8">{t("accountingDashboard.noJournalEntries")}</p>
            )}
          </div>
        </BrandCard>

        <BrandCard className="!p-0 overflow-hidden">
          <div className="flex items-center justify-between p-5 pb-3">
            <h3 className="font-display text-base font-bold text-ink-dark">{t("accountingDashboard.budgetVsActuals")}</h3>
            <BrandButton variant="ghost" size="sm" onClick={() => navigate("/accounting/budget")}>{t("accountingDashboard.manage")}</BrandButton>
          </div>
          <div className="px-5 pb-5">
            {budgets.length > 0 ? (
              <div className="flex flex-col gap-3">
                {budgets.map((item: BudgetPlan) => {
                  const pct = item.planned_amount ? Math.min(100, Math.round((item.actual_amount / item.planned_amount) * 100)) : 0;
                  return (
                    <div key={item.id}>
                      <div className="flex justify-between mb-1">
                        <span className="text-sm font-medium text-foreground">{item.category}</span>
                        <span className="text-xs text-muted-foreground/70">{fmt(item.actual_amount)} / {fmt(item.planned_amount)}</span>
                      </div>
                      <div className="h-2 bg-muted/50 rounded-full overflow-hidden">
                        <div className="h-full rounded-full transition-all" style={{ width: `${pct}%`, backgroundColor: pct >= 90 ? "#ef4444" : pct >= 70 ? "#f59e0b" : "#6C63FF" }} />
                      </div>
                      <div className="text-right mt-0.5 rtl:text-left">
                        {pct >= 100 ? <span className="text-xs font-semibold text-red-600">{t("accountingDashboard.overBudget")}</span> : <span className="text-xs text-muted-foreground">{pct}%</span>}
                      </div>
                    </div>
                  );
                })}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground/70 text-center py-8">{t("accountingDashboard.noBudgetData")}</p>
            )}
          </div>
        </BrandCard>
      </div>

      <BrandCard className="!p-0 overflow-hidden">
        <div className="p-5 pb-3">
          <h3 className="font-display text-base font-bold text-ink-dark">{t("accountingDashboard.accountingPeriods")}</h3>
        </div>
        <div className="px-5 pb-5">
          {closings.length > 0 ? (
            <div className="flex gap-3 overflow-x-auto py-2">
              {closings.map((p: FinancialClosing) => {
                const isClosed = p.status === "closed";
                const isOpen = p.status === "open" || p.is_current;
                return (
                  <div key={p.id} className={`min-w-[120px] rounded-xl p-3 text-center ${isClosed ? "bg-green-50 border border-green-100" : isOpen ? "bg-gradient-to-br from-brand-purple to-brand-pink text-white" : "bg-muted/30 border border-border/50"}`}>
                    <p className={`text-xs font-semibold ${isClosed ? "text-green-800" : isOpen ? "text-white" : "text-muted-foreground/70"}`}>{p.name ?? p.period_name ?? `Period ${p.id}`}</p>
                    <p className={`text-xs ${isClosed ? "text-green-500" : isOpen ? "text-white/80" : "text-muted-foreground/50"}`}>{isClosed ? t("accountingDashboard.closed") : isOpen ? t("accountingDashboard.open") : t("accountingDashboard.future")}</p>
                  </div>
                );
              })}
            </div>
          ) : (
            <p className="text-sm text-muted-foreground/70 text-center py-8">{t("accountingDashboard.noAccountingPeriods")}</p>
          )}
        </div>
      </BrandCard>
    </div>
  );
}
