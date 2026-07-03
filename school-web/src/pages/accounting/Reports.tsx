import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Accounting, TrialBalanceData } from "@/lib/api";
import { downloadBlob } from "@/lib/utils";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import DataTable from "@/components/ui/DataTable";
import { renderCurrency } from "@/lib/tableHelpers";
import { DownloadIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function AccountingReports() {
  const { toast } = useToast();
  const today = new Date();
  const [month, setMonth] = useState(today.getMonth() + 1);
  const [year, setYear] = useState(today.getFullYear());

  const reportParams = { month, year };
  const balanceSheetParams = { as_of_date: new Date(year, month, 0).toISOString().slice(0, 10) };

  const { data: trialData } = useQuery({
    queryKey: ["trial-balance", month, year],
    queryFn: () => Accounting.trialBalance(reportParams),
  }) as any;

  const trialRows = toArray<TrialBalanceData>(trialData);

  const handleDownload = (apiCall: Promise<unknown>, filename: string) => {
    void downloadBlob(apiCall, filename, (e: unknown) => {
      toast({ variant: "destructive", title: "Download failed", description: (e as Error)?.message });
    });
  };

  const setCurrentPeriod = () => {
    setMonth(today.getMonth() + 1);
    setYear(today.getFullYear());
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="AR" title="Financial Reports" subtitle="Trial balance, income statement, balance sheet" />

      <div className="flex items-center gap-3 mb-6 flex-wrap">
        <label htmlFor="accounting-report-month" className="text-sm text-muted-foreground">Month:</label>
        <select id="accounting-report-month" value={month} onChange={(e) => setMonth(Number(e.target.value))} className="px-3 py-1.5 rounded-lg border border-border text-sm">
          {Array.from({ length: 12 }, (_, i) => i + 1).map((m) => (
            <option key={m} value={m}>{m}</option>
          ))}
        </select>
        <label htmlFor="accounting-report-year" className="text-sm text-muted-foreground">Year:</label>
        <input id="accounting-report-year" type="number" value={year} onChange={(e) => setYear(Number(e.target.value))} className="w-24 px-3 py-1.5 rounded-lg border border-border text-sm" />
        <BrandButton variant="secondary" size="sm" onClick={setCurrentPeriod}>Current Period</BrandButton>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-purple to-brand-pink flex items-center justify-center text-lg font-semibold text-white">TB</div>
            <h3 className="font-display text-base font-bold text-ink-dark">Trial Balance</h3>
            <p className="text-sm text-muted-foreground">Verify that total debits equal total credits.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Accounting.trialBalancePdf(reportParams), "trial-balance.pdf")}>
              <DownloadIcon /> Generate
            </BrandButton>
          </div>
        </BrandCard>

        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-mint to-brand-teal flex items-center justify-center text-lg font-semibold text-white">IS</div>
            <h3 className="font-display text-base font-bold text-ink-dark">Income Statement</h3>
            <p className="text-sm text-muted-foreground">Revenue, expenses, and net income for the period.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Accounting.incomeStatementPdf(reportParams), "income-statement.pdf")}>
              <DownloadIcon /> Generate
            </BrandButton>
          </div>
        </BrandCard>

        <BrandCard className="hover:shadow-hover cursor-pointer">
          <div className="flex flex-col items-center text-center gap-3 py-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-sky to-brand-blue flex items-center justify-center text-lg font-semibold text-white">BS</div>
            <h3 className="font-display text-base font-bold text-ink-dark">Balance Sheet</h3>
            <p className="text-sm text-muted-foreground">Assets, liabilities, and equity at month end.</p>
            <BrandButton variant="primary" onClick={() => handleDownload(Accounting.balanceSheet(balanceSheetParams), "balance-sheet.pdf")}>
              <DownloadIcon /> Generate
            </BrandButton>
          </div>
        </BrandCard>
      </div>

      <DataTable
        title="Trial Balance Preview"
        compact
        columns={[
          { key: "account_code", label: "Code", render: (v) => <span className="font-mono text-xs">{v}</span> },
          { key: "account_name", label: "Account", sortable: true },
          { key: "total_debit", label: "Debit", render: (v) => v ? renderCurrency(v) : <span className="text-muted-foreground/50">-</span>, align: "right" as const },
          { key: "total_credit", label: "Credit", render: (v) => v ? renderCurrency(v) : <span className="text-muted-foreground/50">-</span>, align: "right" as const },
          { key: "balance", label: "Balance", render: (v) => renderCurrency(v ?? 0), align: "right" as const },
        ]}
        data={trialRows}
        emptyMessage="No trial balance data for the selected period."
      />
    </div>
  );
}
