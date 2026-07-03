import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Download, RefreshCw } from "lucide-react";
function downloadJson(filename: string, data: unknown) {
  const blob = new Blob([JSON.stringify(data, null, 2)], {
    type: "application/json"
  });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}
export default function AdminReports() {
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
    queryKey: ["admin", "reports", year, month],
    queryFn: () => Admin.monthlyReports(year, month)
  }) as any;
  const report: any = data ?? {};
  const sections = Object.entries(report).filter(([k]) => !["year", "month"].includes(k));
  return <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.reports")}</h1>
        <BrandButton variant="outline" onClick={() => downloadJson(`admin-report-${year}-${String(month).padStart(2, "0")}.json`, report)} disabled={isLoading}>
          <Download className="h-4 w-4 me-2" />
          {t("common.download")}
        </BrandButton>
      </div>

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle className="text-base">Period</CardTitle>
          <CardDescription>
            Monthly attendance, enrolment, finance and HR snapshot.
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
        </div> : sections.length === 0 ? <div className="text-center text-muted-foreground py-8 border rounded-md">
          {t("common.empty")}
        </div> : <div className="grid gap-4 md:grid-cols-2">
          {sections.map(([key, value]) => <BrandCard key={key}>
              <CardHeader>
                <CardTitle className="capitalize text-base">
                  {key.replace(/_/g, " ")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                {typeof value === "object" && value !== null ? (
                  Object.keys(value).length === 0 ? (
                    <p className="text-sm text-muted-foreground">No data for this period.</p>
                  ) : (
                    <dl className="space-y-2">
                      {Object.entries(value as Record<string, unknown>).map(([k, v]) => (
                        <div key={k} className="flex items-center justify-between gap-4 text-sm border-b border-surface-border/60 pb-1.5 last:border-0">
                          <dt className="text-muted-foreground capitalize">{k.replace(/_/g, " ")}</dt>
                          <dd className="font-semibold tabular-nums">{typeof v === "number" ? v.toLocaleString() : String(v)}</dd>
                        </div>
                      ))}
                    </dl>
                  )
                ) : (
                  <div className="text-2xl font-semibold tabular-nums">{typeof value === "number" ? value.toLocaleString() : String(value)}</div>
                )}
              </CardContent>
            </BrandCard>)}
        </div>}
    </div>;
}