import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Download, RefreshCw } from "lucide-react";
function toCsv(rows: Record<string, any>[]): string {
  if (rows.length === 0) return "";
  const cols = Object.keys(rows[0]);
  const head = cols.join(",");
  const body = rows.map(r => cols.map(c => {
    const v = r[c];
    if (v == null) return "";
    const s = typeof v === "object" ? JSON.stringify(v) : String(v);
    return `"${s.replace(/"/g, '""')}"`;
  }).join(",")).join("\n");
  return `${head}\n${body}`;
}
function downloadCsv(filename: string, csv: string) {
  const blob = new Blob([csv], {
    type: "text/csv"
  });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}
export default function FinanceReports() {
  const {
    t
  } = useTranslation();
  const now = new Date();
  const [year, setYear] = useState(now.getFullYear());
  const [month, setMonth] = useState(now.getMonth() + 1);
  const {
    data,
    isLoading,
    refetch,
    isFetching
  } = useQuery({
    queryKey: ["finance", "reports", year, month],
    queryFn: () => Finance.reports(year, month)
  }) as any;
  const report: any = data ?? {};
  const rows = Array.isArray(report.rows) ? report.rows : Array.isArray(report.invoices) ? report.invoices : Array.isArray(report) ? report : [];
  const summary = Array.isArray(report) ? null : report;
  return <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.reports")}</h1>
        <div className="flex gap-2">
          <BrandButton variant="outline" onClick={() => downloadCsv(`finance-report-${year}-${String(month).padStart(2, "0")}.csv`, toCsv(rows))} disabled={rows.length === 0}>
            <Download className="h-4 w-4 me-2" />
            CSV
          </BrandButton>
        </div>
      </div>

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle className="text-base">Period</CardTitle>
          <CardDescription>
            Monthly financial summary — collections, outstanding, payroll.
          </CardDescription>
        </CardHeader>
        <CardContent className="grid gap-4 sm:grid-cols-3 max-w-xl">
          <div className="space-y-1.5">
            <Label htmlFor="year">Year</Label>
            <Input id="year" type="number" value={year} onChange={e => setYear(Number(e.target.value) || year)} />
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="month">Month</Label>
            <Input id="month" type="number" min={1} max={12} value={month} onChange={e => setMonth(Number(e.target.value) || month)} />
          </div>
          <div className="flex items-end">
            <BrandButton onClick={() => refetch()} disabled={isFetching} className="w-full">
              <RefreshCw className={`h-4 w-4 me-2 ${isFetching ? "animate-spin" : ""}`} />
              {t("common.refresh")}
            </BrandButton>
          </div>
        </CardContent>
      </BrandCard>

      {isLoading ? <div className="text-center text-muted-foreground py-8">
          {t("common.loading")}
        </div> : summary && Object.keys(summary).length > 0 ? <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {Object.entries(summary).filter(([k]) => !["rows", "invoices"].includes(k)).map(([k, v]) => <BrandCard key={k}>
                <CardHeader className="pb-2">
                  <CardTitle className="text-sm capitalize">
                    {k.replace(/_/g, " ")}
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  {typeof v === "object" && v !== null ? <pre className="text-xs whitespace-pre-wrap text-muted-foreground overflow-auto max-h-48 bg-muted p-2 rounded">
                      {JSON.stringify(v, null, 2)}
                    </pre> : <div className="text-2xl font-semibold font-mono">
                      {String(v)}
                    </div>}
                </CardContent>
              </BrandCard>)}
        </div> : <div className="text-center text-muted-foreground py-8 border rounded-md">
          {t("common.empty")}
        </div>}
    </div>;
}