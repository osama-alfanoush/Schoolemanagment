import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { BadgeCheck, Banknote, Eye, HandCoins, Plus, Send } from "lucide-react";
import { Hr } from "@/lib/api";
import { HrAdvancesApi } from "@/lib/hrPayrollApi";
import { paginationMeta, toArray } from "@/lib/response";
import type { EmployeeAdvance } from "@/types/hrPayroll.types";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";

const blank = { staff_profile_id: "", original_amount: "", reason: "", requested_at: new Date().toISOString().slice(0, 10), installment_count: "3", first_deduction_month: new Date().toISOString().slice(0, 7) + "-01" };
const money = (value: unknown) => new Intl.NumberFormat("ar", { minimumFractionDigits: 2, maximumFractionDigits: 2 }).format(Number(value ?? 0));

export default function HrAdvances() {
  const { toast } = useToast(); const qc = useQueryClient();
  const [page, setPage] = useState(1); const [open, setOpen] = useState(false); const [selected, setSelected] = useState<EmployeeAdvance | null>(null); const [form, setForm] = useState(blank);
  const query = useQuery({ queryKey: ["hr-advances", page], queryFn: () => HrAdvancesApi.list({ page, per_page: 20 }) });
  const staffQuery = useQuery({ queryKey: ["hr", "staff", "advance-picker"], queryFn: () => Hr.staff() });
  const staff = useMemo(() => toArray<any>(staffQuery.data).filter(row => row.staffProfile || row.staff_profile), [staffQuery.data]);
  const refresh = () => void qc.invalidateQueries({ queryKey: ["hr-advances"] });
  const create = useMutation({ mutationFn: () => HrAdvancesApi.create({ ...form, staff_profile_id: Number(form.staff_profile_id), original_amount: Number(form.original_amount), installment_count: Number(form.installment_count) }), onSuccess: advance => { refresh(); setOpen(false); setForm(blank); toast({ title: `تم إنشاء ${advance.advance_no} كمسودة` }); }, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر إنشاء السلفة", description: e.message }) });
  const action = useMutation({ mutationFn: ({ advance, kind }: { advance: EmployeeAdvance; kind: "submit" | "approve" | "disburse" | "settle" }) => kind === "submit" ? HrAdvancesApi.submit(advance.id) : kind === "approve" ? HrAdvancesApi.approve(advance.id) : kind === "disburse" ? HrAdvancesApi.disburse(advance.id, "bank_transfer") : HrAdvancesApi.settle(advance.id, "cash"), onSuccess: async advance => { refresh(); if (selected) setSelected(await HrAdvancesApi.show(advance.id)); toast({ title: `حالة السلفة: ${advance.status}` }); }, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر تنفيذ العملية", description: e.message }) });
  const meta = paginationMeta(query.data);
  const openDetail = async (id: number) => { try { setSelected(await HrAdvancesApi.show(id)); } catch (e) { toast({ variant: "destructive", title: "تعذر تحميل جدول الأقساط", description: (e as Error).message }); } };

  return <div className="space-y-6" dir="rtl">
    <PageHeader title="سلف الموظفين" subtitle="من الطلب والاعتماد والصرف إلى التحصيل والتسوية" icon="💳" actions={<BrandButton onClick={() => setOpen(true)}><Plus className="h-4 w-4" /> طلب سلفة</BrandButton>} />
    <DataTable<EmployeeAdvance> data={toArray(query.data)} isLoading={query.isLoading} error={(query.error as Error)?.message}
      columns={[
        { key: "advance_no", label: "رقم السلفة", render: value => <span className="font-semibold">{value}</span> },
        { key: "employee", label: "الموظف", render: (_, row) => row.staff_profile?.user?.name ?? "—" },
        { key: "original_amount", label: "الأصل", align: "right", render: money },
        { key: "remaining_balance", label: "الرصيد", align: "right", render: money },
        { key: "installment_amount", label: "القسط", align: "right", render: money },
        { key: "status", label: "الحالة", render: value => <Badge variant="outline">{value}</Badge> },
      ]}
      rowActions={[
        { label: "الأقساط", icon: <Eye className="h-4 w-4" />, onClick: row => void openDetail(row.id) },
        { label: "إرسال", icon: <Send className="h-4 w-4" />, show: row => row.status === "draft", onClick: row => action.mutate({ advance: row, kind: "submit" }) },
        { label: "اعتماد", icon: <BadgeCheck className="h-4 w-4" />, show: row => row.status === "requested", onClick: row => action.mutate({ advance: row, kind: "approve" }) },
        { label: "صرف", icon: <Banknote className="h-4 w-4" />, show: row => row.status === "approved", onClick: row => action.mutate({ advance: row, kind: "disburse" }) },
        { label: "سداد مبكر", icon: <HandCoins className="h-4 w-4" />, show: row => ["disbursed", "active"].includes(row.status), onClick: row => action.mutate({ advance: row, kind: "settle" }) },
      ]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }} emptyMessage="لا توجد سلف" />

    <Dialog open={open} onOpenChange={setOpen}><DialogContent dir="rtl"><DialogHeader><DialogTitle>طلب سلفة</DialogTitle><DialogDescription>سيُحسب القسط الأخير تلقائياً لمعالجة فروق التقريب.</DialogDescription></DialogHeader>
      <div className="grid gap-3 sm:grid-cols-2">
        <div className="space-y-1.5 sm:col-span-2"><Label>الموظف</Label><select className="h-10 w-full rounded-md border bg-background px-3" value={form.staff_profile_id} onChange={e => setForm({ ...form, staff_profile_id: e.target.value })}><option value="">اختر الموظف</option>{staff.map(row => { const profile = row.staffProfile ?? row.staff_profile; return <option key={row.id} value={profile.id}>{row.name}</option>; })}</select></div>
        <div className="space-y-1.5"><Label>المبلغ</Label><Input type="number" min="0.01" step="0.01" value={form.original_amount} onChange={e => setForm({ ...form, original_amount: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>عدد الأقساط</Label><Input type="number" min="1" value={form.installment_count} onChange={e => setForm({ ...form, installment_count: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>تاريخ الطلب</Label><Input type="date" value={form.requested_at} onChange={e => setForm({ ...form, requested_at: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>أول شهر اقتطاع</Label><Input type="date" value={form.first_deduction_month} onChange={e => setForm({ ...form, first_deduction_month: e.target.value })} /></div>
        <div className="space-y-1.5 sm:col-span-2"><Label>السبب</Label><textarea className="min-h-20 w-full rounded-md border bg-background p-3" value={form.reason} onChange={e => setForm({ ...form, reason: e.target.value })} /></div>
      </div><DialogFooter><BrandButton variant="ghost" onClick={() => setOpen(false)}>إلغاء</BrandButton><BrandButton isLoading={create.isPending} onClick={() => create.mutate()}>حفظ المسودة</BrandButton></DialogFooter>
    </DialogContent></Dialog>

    <Dialog open={!!selected} onOpenChange={value => !value && setSelected(null)}><DialogContent dir="rtl"><DialogHeader><DialogTitle>جدول أقساط {selected?.advance_no}</DialogTitle><DialogDescription>الأصل {money(selected?.original_amount)} — الرصيد {money(selected?.remaining_balance)}</DialogDescription></DialogHeader>
      <div className="space-y-2">{selected?.installments?.map(item => <div key={item.id} className="grid grid-cols-4 rounded-lg border p-3 text-sm"><span>#{item.installment_no}</span><span>{item.due_date}</span><span>{money(item.amount)}</span><Badge variant="outline">{item.status}</Badge></div>)}</div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setSelected(null)}>إغلاق</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}
