import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Hr } from "@/lib/api";
import { toArray } from "@/lib/response";

export default function HrReports() {
  const { t } = useTranslation();
  const now = new Date();
  const [year, setYear] = useState(now.getFullYear());
  const [month, setMonth] = useState(now.getMonth() + 1);

  const { data, isLoading } = useQuery({
    queryKey: ["hr-monthly-report", year, month],
    queryFn: () => Hr.staffMonthlyReport(year, month),
  });

  const report = (data as any)?.data ?? (data as any) ?? {};
  const details = toArray(report.details);
  const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.reports")}</h1>

      {/* Filters */}
      <div className="flex items-center gap-4 flex-wrap">
        <div className="flex items-center gap-2">
          <label htmlFor="hr-report-year" className="text-sm font-medium">Year</label>
          <select id="hr-report-year" className="rounded-md border bg-background px-3 py-2 text-sm" value={year} onChange={(e) => setYear(Number(e.target.value))}>
            {[now.getFullYear() - 1, now.getFullYear(), now.getFullYear() + 1].map((y) => (
              <option key={y} value={y}>{y}</option>
            ))}
          </select>
        </div>
        <div className="flex items-center gap-2">
          <label htmlFor="hr-report-month" className="text-sm font-medium">Month</label>
          <select id="hr-report-month" className="rounded-md border bg-background px-3 py-2 text-sm" value={month} onChange={(e) => setMonth(Number(e.target.value))}>
            {months.map((m, i) => (
              <option key={i} value={i + 1}>{m}</option>
            ))}
          </select>
        </div>
      </div>

      {isLoading ? (
        <div className="p-8 text-center text-muted-foreground">Loading report…</div>
      ) : (
        <div className="space-y-4">
          {/* Summary Cards */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            <div className="rounded-lg border bg-card p-4">
              <div className="text-sm text-muted-foreground">Total Staff</div>
              <div className="text-2xl font-bold mt-1">{report.total_staff ?? report.data?.total_staff ?? "—"}</div>
            </div>
            <div className="rounded-lg border bg-card p-4">
              <div className="text-sm text-muted-foreground">Avg Attendance Rate</div>
              <div className="text-2xl font-bold mt-1 text-green-600">{report.attendance_rate ?? report.data?.attendance_rate ?? "—"}%</div>
            </div>
            <div className="rounded-lg border bg-card p-4">
              <div className="text-sm text-muted-foreground">Total Leave Days</div>
              <div className="text-2xl font-bold mt-1 text-yellow-600">{report.total_leave_days ?? report.data?.total_leave_days ?? "—"}</div>
            </div>
            <div className="rounded-lg border bg-card p-4">
              <div className="text-sm text-muted-foreground">Working Days</div>
              <div className="text-2xl font-bold mt-1">{report.working_days ?? report.data?.working_days ?? "—"}</div>
            </div>
          </div>

          {/* Detail Table */}
          {details.length > 0 && (
            <div className="rounded-lg border bg-card overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b bg-muted/50">
                    <th className="text-left p-3">Staff Member</th>
                    <th className="text-center p-3">Present</th>
                    <th className="text-center p-3">Absent</th>
                    <th className="text-center p-3">Late</th>
                    <th className="text-center p-3">Rate</th>
                  </tr>
                </thead>
                <tbody>
                  {details.map((d: any, i: number) => (
                    <tr key={i} className="border-b hover:bg-muted/30">
                      <td className="p-3 font-medium">{d.name ?? d.staff_name}</td>
                      <td className="p-3 text-center text-green-600">{d.present ?? 0}</td>
                      <td className="p-3 text-center text-red-600">{d.absent ?? 0}</td>
                      <td className="p-3 text-center text-yellow-600">{d.late ?? 0}</td>
                      <td className="p-3 text-center font-medium">{d.rate ?? "—"}%</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}

          {/* Fallback if no detail data */}
          {details.length === 0 && !isLoading && (
            <div className="p-8 text-center border rounded-md text-muted-foreground">
              No detailed report data available for {months[month - 1]} {year}. Staff attendance records will appear here once attendance is tracked.
            </div>
          )}
        </div>
      )}
    </div>
  );
}
