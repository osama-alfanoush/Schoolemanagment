import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { FileClock, Plus, RefreshCw } from "lucide-react";
import { Hr } from "@/lib/api";
import { HrEmployeesApi } from "@/lib/hrPayrollApi";
import { paginationMeta, toArray } from "@/lib/response";
import type { EmployeeContract } from "@/types/hrPayroll.types";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";

const statusText = { active: "ساري", expiring_soon: "ينتهي قريباً", expired: "منتهي", indefinite: "غير محدد المدة" } as const;
const statusClass = { active: "bg-emerald-100 text-emerald-800", expiring_soon: "bg-amber-100 text-amber-800", expired: "bg-rose-100 text-rose-800", indefinite: "bg-sky-100 text-sky-800" } as const;
const emptyForm = { user_id: "", contract_no: "", contract_type: "fixed_term", start_date: "", end_date: "", base_salary: "", probation_days: "" };

export default function HrContracts() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [page, setPage] = useState(1);
  const [days, setDays] = useState<number | undefined>();
  const [dialog, setDialog] = useState(false);
  const [renewing, setRenewing] = useState<EmployeeContract | null>(null);
  const [form, setForm] = useState(emptyForm);
  const contracts = useQuery({ queryKey: ["hr-contracts", page, days], queryFn: () => HrEmployeesApi.contracts({ page, per_page: 20, expiring_within: days }) });
  const staffQuery = useQuery({ queryKey: ["hr", "staff", "contract-picker"], queryFn: () => Hr.staff() });
  const staff = useMemo(() => toArray<any>(staffQuery.data).filter(row => row.staff_profile ?? row.staffProfile), [staffQuery.data]);

  const save = useMutation({
    mutationFn: () => {
      const payload = { contract_no: form.contract_no, contract_type: form.contract_type as "fixed_term" | "indefinite", start_date: form.start_date, end_date: form.contract_type === "indefinite" ? null : form.end_date, base_salary: Number(form.base_salary), probation_days: form.probation_days ? Number(form.probation_days) : null };
      return renewing ? HrEmployeesApi.renewContract(renewing.id, payload as any) : HrEmployeesApi.createContract(Number(form.user_id), payload as any);
    },
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["hr-contracts"] }); setDialog(false); setRenewing(null); setForm(emptyForm); toast({ title: "تم حفظ العقد مع الاحتفاظ بالتاريخ" }); },
    onError: (error: any) => toast({ variant: "destructive", title: "تعذر حفظ العقد", description: error?.data?.message ?? error.message }),
  });
  const openRenew = (contract: EmployeeContract) => {
    setRenewing(contract); setForm({ ...emptyForm, user_id: String(contract.staff_profile?.user?.id ?? ""), contract_type: contract.contract_type, base_salary: String(contract.base_salary) }); setDialog(true);
  };

  return <div className="space-y-6" dir="rtl">
    <PageHeader title="العقود" subtitle="تاريخ العقود والتجديدات والتنبيهات المؤرّخة" icon="📄" actions={<BrandButton onClick={() => { setRenewing(null); setForm(emptyForm); setDialog(true); }}><Plus className="h-4 w-4" /> عقد جديد</BrandButton>} />
    <div className="flex flex-wrap gap-2" aria-label="فلاتر انتهاء العقود">
      {[undefined, 7, 30, 60, 90].map(value => <BrandButton key={value ?? "all"} size="sm" variant={days === value ? "primary" : "outline"} onClick={() => { setDays(value); setPage(1); }}>{value ? `خلال ${value} يوماً` : "الكل"}</BrandButton>)}
    </div>
    <DataTable<EmployeeContract> data={toArray(contracts.data)} isLoading={contracts.isLoading} error={(contracts.error as Error)?.message}
      columns={[
        { key: "contract_no", label: "رقم العقد", render: value => <span className="font-semibold">{value}</span> },
        { key: "employee", label: "الموظف", render: (_, row) => row.staff_profile?.user?.name ?? "—" },
        { key: "contract_type", label: "النوع", render: value => value === "indefinite" ? "غير محدد المدة" : "محدد المدة" },
        { key: "start_date", label: "البداية" }, { key: "end_date", label: "النهاية", render: value => value ?? "—" },
        { key: "days_remaining", label: "الأيام المتبقية", align: "right", render: value => value == null ? "—" : value },
        { key: "display_status", label: "الحالة", render: value => <Badge className={statusClass[value as keyof typeof statusClass]}>{statusText[value as keyof typeof statusText] ?? value}</Badge> },
      ]}
      rowActions={[{ label: "تجديد", icon: <RefreshCw className="h-4 w-4" />, show: row => row.is_current, onClick: openRenew }]}
      pagination={{ currentPage: page, lastPage: paginationMeta(contracts.data).last_page ?? 1, total: paginationMeta(contracts.data).total ?? 0, perPage: 20, onPageChange: setPage }} emptyMessage="لا توجد عقود مطابقة" />

    <Dialog open={dialog} onOpenChange={setDialog}><DialogContent dir="rtl"><DialogHeader><DialogTitle>{renewing ? `تجديد ${renewing.contract_no}` : "إضافة عقد"}</DialogTitle><DialogDescription>التجديد ينشئ نسخة جديدة ولا يكتب فوق العقد السابق.</DialogDescription></DialogHeader>
      <div className="grid gap-3 sm:grid-cols-2">
        {!renewing && <div className="space-y-1.5 sm:col-span-2"><Label>الموظف</Label><select className="h-10 w-full rounded-md border bg-background px-3" value={form.user_id} onChange={e => setForm({ ...form, user_id: e.target.value })}><option value="">اختر الموظف</option>{staff.map(row => <option key={row.id} value={row.id}>{row.name}</option>)}</select></div>}
        <div className="space-y-1.5"><Label>رقم العقد</Label><Input value={form.contract_no} onChange={e => setForm({ ...form, contract_no: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>نوع العقد</Label><select className="h-10 w-full rounded-md border bg-background px-3" value={form.contract_type} onChange={e => setForm({ ...form, contract_type: e.target.value })}><option value="fixed_term">محدد المدة</option><option value="indefinite">غير محدد المدة</option></select></div>
        <div className="space-y-1.5"><Label>تاريخ البداية</Label><Input type="date" value={form.start_date} onChange={e => setForm({ ...form, start_date: e.target.value })} /></div>
        {form.contract_type === "fixed_term" && <div className="space-y-1.5"><Label>تاريخ النهاية</Label><Input type="date" value={form.end_date} onChange={e => setForm({ ...form, end_date: e.target.value })} /></div>}
        <div className="space-y-1.5"><Label>الراتب الأساسي</Label><Input type="number" step="0.01" value={form.base_salary} onChange={e => setForm({ ...form, base_salary: e.target.value })} /></div>
        <div className="space-y-1.5"><Label>فترة التجربة (يوم)</Label><Input type="number" value={form.probation_days} onChange={e => setForm({ ...form, probation_days: e.target.value })} /></div>
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setDialog(false)}>إلغاء</BrandButton><BrandButton leftIcon={<FileClock className="h-4 w-4" />} isLoading={save.isPending} onClick={() => save.mutate()}>حفظ</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}
