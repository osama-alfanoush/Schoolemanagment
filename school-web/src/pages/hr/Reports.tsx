import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Download } from "lucide-react";
import { HrPayrollReportsApi } from "@/lib/hrPayrollApi";
import { paginationMeta, toArray } from "@/lib/response";
import PageHeader from "@/components/ui/PageHeader";
import BrandButton from "@/components/ui/BrandButton";
import BrandCard from "@/components/ui/BrandCard";
import { CardContent } from "@/components/ui/card";

const reports = [
  ["payroll", "كشف الرواتب وتكلفة الموظفين"], ["payroll-reconciliation", "مطابقة الرواتب مع القيود المحاسبية"],
  ["payroll-detail", "تفاصيل الرواتب"], ["social-insurance", "تقرير الضمان الاجتماعي"],
  ["components", "مكونات الراتب"], ["employee-cost", "تكلفة الموظف"],
  ["contracts", "العقود المنتهية والقريبة"], ["advances", "السلف والأرصدة والأقساط"],
  ["warnings", "الإنذارات"], ["uninsured", "الموظفون غير المسجلين في الضمان"],
];

export default function HrReports() {
  const [type, setType] = useState("payroll"); const [page, setPage] = useState(1);
  const query = useQuery({ queryKey: ["hr-payroll-report", type, page], queryFn: () => HrPayrollReportsApi.report<Record<string, any>>(type, { page, per_page: 25 }) });
  const rows = toArray<Record<string, any>>(query.data); const meta = paginationMeta(query.data);
  const downloadCsv = () => {
    if (!rows.length) return; const keys = Object.keys(rows[0]).filter(key => typeof rows[0][key] !== "object");
    const csv = [keys.join(","), ...rows.map(row => keys.map(key => `"${String(row[key] ?? "").replaceAll('"', '""')}"`).join(","))].join("\n");
    const url = URL.createObjectURL(new Blob(["\ufeff" + csv], { type: "text/csv;charset=utf-8" })); const anchor = document.createElement("a"); anchor.href = url; anchor.download = `${type}.csv`; anchor.click(); URL.revokeObjectURL(url);
  };
  return <div className="space-y-6" dir="rtl"><PageHeader title="تقارير HR والرواتب" subtitle="فلترة وصفحات من الخادم ومن نفس snapshots والقيود" icon="📊" actions={<BrandButton variant="outline" disabled={!rows.length} onClick={downloadCsv}><Download className="h-4 w-4" /> CSV</BrandButton>} />
    <div className="flex flex-wrap gap-2">{reports.map(([key, label]) => <BrandButton key={key} size="sm" variant={type === key ? "primary" : "outline"} onClick={() => { setType(key); setPage(1); }}>{label}</BrandButton>)}</div>
    <BrandCard><CardContent className="p-0"><div className="overflow-x-auto"><table className="w-full text-sm"><thead className="bg-muted"><tr>{rows[0] && Object.keys(rows[0]).filter(key => typeof rows[0][key] !== "object").map(key => <th key={key} className="p-3 text-right">{key}</th>)}</tr></thead><tbody>{rows.map((row, index) => <tr key={row.id ?? index} className="border-t">{Object.keys(row).filter(key => typeof row[key] !== "object").map(key => <td key={key} className="whitespace-nowrap p-3">{String(row[key] ?? "—")}</td>)}</tr>)}</tbody></table></div>{query.isLoading && <div className="p-8 text-center">جارٍ تحميل التقرير…</div>}{!query.isLoading && !rows.length && <div className="p-8 text-center text-muted-foreground">لا توجد بيانات</div>}</CardContent></BrandCard>
    <div className="flex justify-center gap-2"><BrandButton size="sm" variant="outline" disabled={page <= 1} onClick={() => setPage(page - 1)}>السابق</BrandButton><span className="self-center text-sm">{page} / {meta.last_page ?? 1}</span><BrandButton size="sm" variant="outline" disabled={page >= (meta.last_page ?? 1)} onClick={() => setPage(page + 1)}>التالي</BrandButton></div>
  </div>;
}
