import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { BadgeCheck, Banknote, Download, Eye, Play, Plus, RotateCcw } from "lucide-react";
import { PayrollRuns, type PayrollRunRow } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { paginationMeta, toArray } from "@/lib/response";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { hasPermission, money, StatusBadge } from "../procurement/shared";

const MONTHS = ["يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو", "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"];
type RecordDraft = { allowances: string; deductions: string; reason: string };

export default function FinancePayrollRuns() {
  const { user } = useAuth(); const { toast } = useToast(); const qc = useQueryClient();
  const [page, setPage] = useState(1); const [createOpen, setCreateOpen] = useState(false); const [selected, setSelected] = useState<PayrollRunRow | null>(null);
  const [period, setPeriod] = useState({ year: new Date().getFullYear(), month: new Date().getMonth() + 1 });
  const [drafts, setDrafts] = useState<Record<number, RecordDraft>>({}); const [recordSearch, setRecordSearch] = useState(""); const [expandedRecord, setExpandedRecord] = useState<number | null>(null);
  const [reversingId, setReversingId] = useState<number | null>(null);
  const canCreate = hasPermission(user, "finance.payroll.create"); const canEdit = hasPermission(user, "finance.payroll.edit"); const canApprove = hasPermission(user, "finance.payroll.approve");
  const runsQuery = useQuery({ queryKey: ["payroll-runs", page], queryFn: () => PayrollRuns.runs({ page, per_page: 20 }) });
  const meta = paginationMeta(runsQuery.data); const refresh = () => void qc.invalidateQueries({ queryKey: ["payroll-runs"] });
  const openDetail = async (id: number) => { try { const run = await PayrollRuns.run(id); setSelected(run); setDrafts(Object.fromEntries((run.records ?? []).map(record => [record.id, { allowances: String(record.allowances ?? 0), deductions: String(record.deductions ?? 0), reason: "تعديل يدوي من شاشة دورة الرواتب" }]))); } catch (e) { toast({ variant: "destructive", title: "تعذر تحميل الدورة", description: (e as Error).message }); } };
  const create = useMutation({ mutationFn: () => PayrollRuns.createRun(period), onSuccess: run => { refresh(); setCreateOpen(false); toast({ title: `تم إنشاء ${run.run_no}`, description: `تم توليد ${run.records?.length ?? 0} سجل من قاعدة البيانات.` }); }, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر إنشاء الدورة", description: e.message }) });
  const transition = useMutation({ mutationFn: ({ kind, id }: { kind: "process" | "approve" | "pay"; id: number }) => kind === "process" ? PayrollRuns.processRun(id) : kind === "approve" ? PayrollRuns.approveRun(id) : PayrollRuns.payRun(id), onSuccess: async run => { refresh(); if (selected) await openDetail(selected.id); toast({ title: `حالة الدورة: ${run.status}` }); }, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر تحديث الدورة", description: e.message }) });
  const saveRecord = useMutation({ mutationFn: (recordId: number) => PayrollRuns.updateRecord(recordId, { allowances: Number(drafts[recordId]?.allowances ?? 0), deductions: Number(drafts[recordId]?.deductions ?? 0), reason: drafts[recordId]?.reason || "تعديل يدوي من شاشة دورة الرواتب" }), onSuccess: async () => { refresh(); if (selected) await openDetail(selected.id); toast({ title: "تم تحديث السجل وإعادة الحساب في الخادم" }); }, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر تحديث السجل", description: e.message }) });
  const reverse = async (row: PayrollRunRow) => { if (reversingId !== null || transition.isPending) return; const reason = window.prompt("سبب عكس دورة الرواتب"); if (!reason) return; setReversingId(row.id); try { await PayrollRuns.reverseRun(row.id, reason); refresh(); if (selected?.id === row.id) await openDetail(row.id); toast({ title: "تم عكس الدورة والقيود" }); } catch (e) { toast({ variant: "destructive", title: "تعذر العكس", description: (e as Error).message }); } finally { setReversingId(null); } };
  const isDraft = selected?.status === "draft";
  const visibleRecords = (selected?.records ?? []).filter(record => (record.staff?.name ?? String(record.staff_user_id)).toLowerCase().includes(recordSearch.toLowerCase()));

  return <div className="space-y-6" dir="rtl">
    <PageHeader icon="🧾" title="دورات الرواتب" subtitle="إنشاء، معالجة، اعتماد، دفع وعكس مع فصل المهام" actions={canCreate ? <BrandButton onClick={() => setCreateOpen(true)}><Plus className="h-4 w-4" /> دورة جديدة</BrandButton> : undefined} />
    <DataTable<PayrollRunRow> title="الدورات" data={toArray(runsQuery.data)} isLoading={runsQuery.isLoading} error={(runsQuery.error as Error)?.message}
      columns={[
        { key: "run_no", label: "الدورة", render: value => <span className="font-semibold">{value}</span> },
        { key: "month", label: "الفترة", render: (_, row) => `${MONTHS[row.month - 1]} ${row.year}` },
        { key: "total_gross", label: "الإجمالي", align: "right", render: money }, { key: "total_deductions", label: "الاقتطاعات", align: "right", render: money },
        { key: "total_net", label: "الصافي", align: "right", render: money }, { key: "status", label: "الحالة", render: value => <StatusBadge status={value} /> },
        { key: "journal", label: "القيد", render: (_, row) => row.accrual_journal?.reference_no ?? row.payment_journal?.reference_no ?? "—" },
      ]}
      rowActions={[
        { label: "فتح", icon: <Eye className="h-4 w-4" />, onClick: row => void openDetail(row.id) },
        { label: "معالجة", icon: <Play className="h-4 w-4" />, show: row => canEdit && row.status === "draft", disabled: () => transition.isPending || reversingId !== null, onClick: row => transition.mutate({ kind: "process", id: row.id }) },
        { label: "اعتماد", icon: <BadgeCheck className="h-4 w-4" />, show: row => canApprove && row.status === "processed", disabled: () => transition.isPending || reversingId !== null, onClick: row => transition.mutate({ kind: "approve", id: row.id }) },
        { label: "دفع", icon: <Banknote className="h-4 w-4" />, show: row => canApprove && row.status === "approved", disabled: () => transition.isPending || reversingId !== null, onClick: row => transition.mutate({ kind: "pay", id: row.id }) },
        { label: "عكس", icon: <RotateCcw className="h-4 w-4" />, show: row => hasPermission(user, "payroll.runs.reverse") && ["approved", "paid"].includes(row.status), disabled: row => transition.isPending || reversingId === row.id, onClick: row => void reverse(row) },
      ]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }} emptyMessage="لا توجد دورات رواتب" />

    <Dialog open={createOpen} onOpenChange={setCreateOpen}><DialogContent dir="rtl"><DialogHeader><DialogTitle>إنشاء دورة راتب</DialogTitle><DialogDescription>الحساب الفعلي يتم عند المعالجة في الخادم ويثبت العقد والمكونات والضمان.</DialogDescription></DialogHeader><div className="grid gap-4 sm:grid-cols-2"><div className="space-y-1.5"><Label>السنة</Label><Input type="number" value={period.year} onChange={e => setPeriod({ ...period, year: Number(e.target.value) })} /></div><div className="space-y-1.5"><Label>الشهر</Label><select className="h-10 w-full rounded-md border bg-background px-3" value={period.month} onChange={e => setPeriod({ ...period, month: Number(e.target.value) })}>{MONTHS.map((month, index) => <option key={month} value={index + 1}>{month}</option>)}</select></div></div><DialogFooter><BrandButton variant="ghost" onClick={() => setCreateOpen(false)}>إلغاء</BrandButton><BrandButton isLoading={create.isPending} onClick={() => create.mutate()}>إنشاء مسودة</BrandButton></DialogFooter></DialogContent></Dialog>

    <Dialog open={!!selected} onOpenChange={open => !open && setSelected(null)}><DialogContent className="max-h-[92vh] max-w-6xl overflow-y-auto" dir="rtl"><DialogHeader><DialogTitle>{selected?.run_no}</DialogTitle><DialogDescription>{selected && `${MONTHS[selected.month - 1]} ${selected.year}`} · الصافي {money(selected?.total_net)} · {selected?.status}{selected?.accrual_journal && ` · قيد الاستحقاق ${selected.accrual_journal.reference_no}`}{selected?.payment_journal && ` · قيد الدفع ${selected.payment_journal.reference_no}`}</DialogDescription></DialogHeader>
      <Input placeholder="بحث باسم الموظف" value={recordSearch} onChange={e => setRecordSearch(e.target.value)} />
      <div className="space-y-2">{visibleRecords.map(record => <div key={record.id} className="rounded-xl border p-3">
        <div className="grid min-w-[860px] items-center gap-3 text-sm sm:grid-cols-[1.7fr_repeat(7,1fr)_auto]">
          <div><p className="font-semibold">{record.staff?.name ?? `Staff ${record.staff_user_id}`}</p><Badge variant="outline">{record.status}</Badge></div>
          <Amount label="الأساسي" value={record.base_salary} /><Amount label="الاستحقاقات" value={record.total_earnings ?? record.allowances} /><Amount label="الضمان" value={record.employee_social_insurance} /><Amount label="اقتطاعات أخرى" value={record.other_deductions ?? record.deductions} /><Amount label="قسط السلفة" value={record.advance_deduction} /><Amount label="الإجمالي" value={record.gross_salary ?? Number(record.base_salary) + Number(record.allowances)} /><Amount label="الصافي" value={record.net_pay} strong />
          <BrandButton size="sm" variant="outline" onClick={() => setExpandedRecord(expandedRecord === record.id ? null : record.id)}><Eye className="h-4 w-4" /> التفاصيل</BrandButton>
        </div>
        {isDraft && canEdit && <div className="mt-3 grid gap-2 border-t pt-3 sm:grid-cols-4"><div><Label className="text-xs">بدل يدوي</Label><Input type="number" min="0" step="0.01" value={drafts[record.id]?.allowances ?? ""} onChange={e => setDrafts({ ...drafts, [record.id]: { ...drafts[record.id], allowances: e.target.value } })} /></div><div><Label className="text-xs">اقتطاع يدوي</Label><Input type="number" min="0" step="0.01" value={drafts[record.id]?.deductions ?? ""} onChange={e => setDrafts({ ...drafts, [record.id]: { ...drafts[record.id], deductions: e.target.value } })} /></div><div><Label className="text-xs">السبب</Label><Input value={drafts[record.id]?.reason ?? ""} onChange={e => setDrafts({ ...drafts, [record.id]: { ...drafts[record.id], reason: e.target.value } })} /></div><BrandButton className="self-end" size="sm" variant="secondary" isLoading={saveRecord.isPending && saveRecord.variables === record.id} onClick={() => saveRecord.mutate(record.id)}>حفظ</BrandButton></div>}
        {expandedRecord === record.id && <div className="mt-3 space-y-3 border-t pt-3"><div className="rounded-lg bg-muted p-3 text-sm">الصافي = الأساسي {money(record.base_salary)} + الاستحقاقات {money(record.total_earnings)} − ضمان الموظف {money(record.employee_social_insurance)} − الاقتطاعات {money(record.other_deductions)} − قسط السلفة {money(record.advance_deduction)} = <strong>{money(record.net_pay)}</strong></div><div className="grid gap-2 sm:grid-cols-2">{record.components?.map(component => <div key={component.id} className="flex justify-between rounded-lg border p-2 text-sm"><span>{component.name_ar} <span className="text-xs text-muted-foreground">({component.calculation_type})</span></span><strong>{money(component.amount)}</strong></div>)}</div><BrandButton size="sm" variant="outline" onClick={() => void PayrollRuns.payslip(record.id)}><Download className="h-4 w-4" /> قسيمة PDF</BrandButton></div>}
      </div>)}</div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setSelected(null)}>إغلاق</BrandButton>{selected && canEdit && selected.status === "draft" && <BrandButton isLoading={transition.isPending} onClick={() => transition.mutate({ kind: "process", id: selected.id })}>معالجة</BrandButton>}{selected && canApprove && selected.status === "processed" && <BrandButton isLoading={transition.isPending} onClick={() => transition.mutate({ kind: "approve", id: selected.id })}>اعتماد</BrandButton>}{selected && canApprove && selected.status === "approved" && <BrandButton isLoading={transition.isPending} onClick={() => transition.mutate({ kind: "pay", id: selected.id })}>دفع</BrandButton>}</DialogFooter>
    </DialogContent></Dialog>
  </div>;
}

function Amount({ label, value, strong = false }: { label: string; value: unknown; strong?: boolean }) { return <div><p className="text-[11px] text-muted-foreground">{label}</p><p className={strong ? "font-bold" : "font-medium"}>{money(value == null ? 0 : Number(value))}</p></div>; }
