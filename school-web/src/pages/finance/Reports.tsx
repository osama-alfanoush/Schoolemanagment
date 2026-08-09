import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { FinanceWorkspace } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";
import { Download, RefreshCw } from "lucide-react";

const reportTypes = [
  ["student-balances", "أرصدة الطلاب"],
  ["due-installments", "الأقساط المستحقة والمتأخرة"],
  ["receipts", "المقبوضات"],
  ["discounts", "الخصومات"],
  ["general-journal", "اليومية العامة"],
  ["reversed", "الحركات المعكوسة"],
  ["reconciliation", "مطابقة السندات والقيود"],
] as const;

export default function FinanceReports() {
  const [type, setType] = useState<(typeof reportTypes)[number][0]>("student-balances");
  const [dateFrom, setDateFrom] = useState("");
  const [dateTo, setDateTo] = useState("");
  const [page, setPage] = useState(1);
  const report = useQuery({
    queryKey: ["financial-report-center", type, dateFrom, dateTo, page],
    queryFn: () => FinanceWorkspace.report<Record<string, unknown>>(type, { date_from: dateFrom || undefined, date_to: dateTo || undefined, page, per_page: 25 }),
  });
  const rows = report.data?.data ?? [];
  const directPagination = report.data as unknown as { last_page?: number } | undefined;
  const lastPage = report.data?.meta?.last_page ?? directPagination?.last_page ?? 1;
  const columns = rows.length ? Object.keys(rows[0]).filter((key) => !["created_at", "updated_at", "deleted_at"].includes(key)) : [];

  function downloadCsv() {
    if (!rows.length) return;
    const csv = [columns.join(","), ...rows.map((row) => columns.map((key) => `"${cellText(row[key]).replace(/"/g, '""')}"`).join(","))].join("\n");
    const url = URL.createObjectURL(new Blob(["\ufeff", csv], { type: "text/csv;charset=utf-8" }));
    const anchor = document.createElement("a"); anchor.href = url; anchor.download = `${type}.csv`; anchor.click(); URL.revokeObjectURL(url);
  }

  return <div className="space-y-6" dir="rtl">
    <PageHeader title="مركز التقارير المالية" subtitle="تقارير مفلترة من نفس حركات السندات والقيود" icon="📊" actions={<BrandButton variant="outline" disabled={!rows.length} onClick={downloadCsv}><Download className="h-4 w-4" /> Excel CSV</BrandButton>} />
    <BrandCard className="p-4"><div className="grid gap-3 md:grid-cols-4">
      <label className="text-sm"><span className="mb-1 block font-medium">التقرير</span><select value={type} onChange={(e) => { setType(e.target.value as typeof type); setPage(1); }} className="w-full rounded-lg border p-2.5">{reportTypes.map(([value, label]) => <option key={value} value={value}>{label}</option>)}</select></label>
      <label className="text-sm"><span className="mb-1 block font-medium">من تاريخ</span><input type="date" value={dateFrom} onChange={(e) => setDateFrom(e.target.value)} className="w-full rounded-lg border p-2.5" /></label>
      <label className="text-sm"><span className="mb-1 block font-medium">إلى تاريخ</span><input type="date" value={dateTo} onChange={(e) => setDateTo(e.target.value)} className="w-full rounded-lg border p-2.5" /></label>
      <div className="flex items-end"><BrandButton fullWidth variant="secondary" onClick={() => { void report.refetch(); }} isLoading={report.isFetching}><RefreshCw className="h-4 w-4" /> تحديث</BrandButton></div>
    </div></BrandCard>
    {!rows.length && !report.isLoading ? <BrandEmptyState icon="📊" title="لا توجد بيانات للفلاتر المحددة" subtitle="غيّر الفترة أو نوع التقرير ثم أعد المحاولة." /> : <BrandCard className="overflow-x-auto p-0"><table className="w-full min-w-[760px] text-sm"><thead className="bg-muted/40"><tr>{columns.map((column) => <th key={column} className="p-3 text-start">{column.replace(/_/g, " ")}</th>)}</tr></thead><tbody>{rows.map((row, index) => <tr key={typeof row.id === "string" || typeof row.id === "number" ? row.id : index} className="border-t">{columns.map((column) => <td key={column} className="max-w-72 p-3"><span className="line-clamp-2">{cellText(row[column])}</span></td>)}</tr>)}</tbody></table></BrandCard>}
    <div className="flex justify-center gap-2"><button className="rounded border px-3 py-1 disabled:opacity-40" disabled={page <= 1} onClick={() => setPage((p) => p - 1)}>السابق</button><span className="px-3 py-1">{page} / {lastPage}</span><button className="rounded border px-3 py-1 disabled:opacity-40" disabled={page >= lastPage} onClick={() => setPage((p) => p + 1)}>التالي</button></div>
  </div>;
}

function cellText(value: unknown): string {
  if (value === null || value === undefined) return "—";
  if (typeof value === "string" || typeof value === "number" || typeof value === "boolean") return String(value);
  try { return JSON.stringify(value); } catch { return "—"; }
}
