import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { AlertTriangle, CheckCircle2, Plus, Send, XCircle } from "lucide-react";
import { Hr } from "@/lib/api";
import { HrWarningsApi } from "@/lib/hrPayrollApi";
import { paginationMeta, toArray } from "@/lib/response";
import type { DisciplinaryWarning } from "@/types/hrPayroll.types";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";

const blank = { staff_profile_id: "", warning_type: "written", offence: "", incident_description: "", incident_date: "", issued_date: new Date().toISOString().slice(0, 10), level: "first" };

export default function HrWarnings() {
  const { toast } = useToast(); const qc = useQueryClient();
  const [page, setPage] = useState(1); const [status, setStatus] = useState(""); const [open, setOpen] = useState(false); const [form, setForm] = useState(blank);
  const query = useQuery({ queryKey: ["hr-warnings", page, status], queryFn: () => HrWarningsApi.list({ page, per_page: 20, status }) });
  const staffQuery = useQuery({ queryKey: ["hr", "staff", "warning-picker"], queryFn: () => Hr.staff() });
  const staff = useMemo(() => toArray<any>(staffQuery.data).filter(row => row.staffProfile || row.staff_profile), [staffQuery.data]);
  const refresh = () => void qc.invalidateQueries({ queryKey: ["hr-warnings"] });
  const create = useMutation({ mutationFn: () => HrWarningsApi.create({ ...form, staff_profile_id: Number(form.staff_profile_id) } as any), onSuccess: () => { refresh(); setOpen(false); setForm(blank); toast({ title: "تم حفظ مسودة الإنذار دون أي خصم مالي" }); }, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر الحفظ", description: e.message }) });
  const transition = useMutation({ mutationFn: ({ id, action }: { id: number; action: "submit" | "approve" | "cancel" }) => HrWarningsApi.transition(id, action, action === "cancel" ? { reason: "أُلغي من شاشة الموارد البشرية" } : undefined), onSuccess: refresh, onError: (e: Error) => toast({ variant: "destructive", title: "تعذر تحديث الإنذار", description: e.message }) });
  const meta = paginationMeta(query.data);

  return <div className="space-y-6" dir="rtl">
    <PageHeader title="الإنذارات والإجراءات التأديبية" subtitle="بيانات حساسة مستقلة عن أي اقتطاع مالي" icon="⚠️" actions={<BrandButton onClick={() => setOpen(true)}><Plus className="h-4 w-4" /> إنذار جديد</BrandButton>} />
    <div className="rounded-xl border border-amber-200 bg-amber-50 p-3 text-sm text-amber-900"><AlertTriangle className="ml-2 inline h-4 w-4" /> إصدار الإنذار لا ينشئ خصماً. أي اقتطاع يحتاج مكوّناً مالياً معتمداً وسبباً مستقلاً.</div>
    <div className="flex gap-2"><Label className="self-center">الحالة</Label><select className="h-10 rounded-md border bg-background px-3" value={status} onChange={e => { setStatus(e.target.value); setPage(1); }}><option value="">الكل</option><option value="draft">مسودة</option><option value="pending_approval">بانتظار الاعتماد</option><option value="issued">صادر</option><option value="received">مستلم</option><option value="objected">معترض عليه</option><option value="cancelled">ملغى</option></select></div>
    <DataTable<DisciplinaryWarning> data={toArray(query.data)} isLoading={query.isLoading} error={(query.error as Error)?.message}
      columns={[
        { key: "warning_no", label: "رقم الإنذار", render: value => <span className="font-semibold">{value}</span> },
        { key: "employee", label: "الموظف", render: (_, row) => row.staff_profile?.user?.name ?? "—" },
        { key: "offence", label: "المخالفة" }, { key: "issued_date", label: "تاريخ الإصدار" },
        { key: "level", label: "المستوى" }, { key: "status", label: "الحالة", render: value => <Badge variant="outline">{value}</Badge> },
      ]}
      rowActions={[
        { label: "إرسال للاعتماد", icon: <Send className="h-4 w-4" />, show: row => row.status === "draft", onClick: row => transition.mutate({ id: row.id, action: "submit" }) },
        { label: "اعتماد وإصدار", icon: <CheckCircle2 className="h-4 w-4" />, show: row => row.status === "pending_approval", onClick: row => transition.mutate({ id: row.id, action: "approve" }) },
        { label: "إلغاء", icon: <XCircle className="h-4 w-4" />, show: row => !["cancelled"].includes(row.status), onClick: row => transition.mutate({ id: row.id, action: "cancel" }) },
      ]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }} emptyMessage="لا توجد إنذارات" />

    <Dialog open={open} onOpenChange={setOpen}><DialogContent dir="rtl"><DialogHeader><DialogTitle>مسودة إنذار وظيفي</DialogTitle><DialogDescription>سيُسجل الإنشاء والتعديل والاعتماد في سجل التدقيق.</DialogDescription></DialogHeader>
      <div className="grid gap-3 sm:grid-cols-2">
        <div className="space-y-1.5 sm:col-span-2"><Label>الموظف</Label><select className="h-10 w-full rounded-md border bg-background px-3" value={form.staff_profile_id} onChange={e => setForm({ ...form, staff_profile_id: e.target.value })}><option value="">اختر الموظف</option>{staff.map(row => { const profile = row.staffProfile ?? row.staff_profile; return <option key={row.id} value={profile.id}>{row.name}</option>; })}</select></div>
        <div className="space-y-1.5"><Label>نوع الإنذار</Label><Input value={form.warning_type} onChange={e => setForm({ ...form, warning_type: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>المستوى</Label><Input value={form.level} onChange={e => setForm({ ...form, level: e.target.value })} /></div>
        <div className="space-y-1.5 sm:col-span-2"><Label>المخالفة / السبب</Label><Input value={form.offence} onChange={e => setForm({ ...form, offence: e.target.value })} /></div>
        <div className="space-y-1.5 sm:col-span-2"><Label>وصف الواقعة</Label><textarea className="min-h-24 w-full rounded-md border bg-background p-3" value={form.incident_description} onChange={e => setForm({ ...form, incident_description: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>تاريخ الواقعة</Label><Input type="date" value={form.incident_date} onChange={e => setForm({ ...form, incident_date: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>تاريخ الإصدار</Label><Input type="date" value={form.issued_date} onChange={e => setForm({ ...form, issued_date: e.target.value })} /></div>
      </div><DialogFooter><BrandButton variant="ghost" onClick={() => setOpen(false)}>إلغاء</BrandButton><BrandButton isLoading={create.isPending} onClick={() => create.mutate()}>حفظ المسودة</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}
