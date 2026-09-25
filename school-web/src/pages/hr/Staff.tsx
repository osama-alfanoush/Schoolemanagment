import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Eye, Pencil } from "lucide-react";
import { Hr, mediaUrl } from "@/lib/api";
import DataTable from "@/components/ui/DataTable";
import PageHeader from "@/components/ui/PageHeader";
import BrandButton from "@/components/ui/BrandButton";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

const tabs = ["البيانات الأساسية", "الوظيفة والعقد", "الراتب والمكونات", "الضمان الاجتماعي", "الحضور والإجازات", "السلف", "الإنذارات", "المستندات", "سجل التغييرات"];
const contractLabels: Record<string, string> = { active: "ساري", expiring_soon: "ينتهي قريباً", expired: "منتهي", indefinite: "غير محدد المدة" };

export default function HrStaff() {
  const { toast } = useToast(); const qc = useQueryClient();
  const [search, setSearch] = useState(""); const [contractDays, setContractDays] = useState<number | undefined>();
  const [editing, setEditing] = useState<any>(null); const [form, setForm] = useState<any>({});
  const [viewingId, setViewingId] = useState<number | null>(null); const [activeTab, setActiveTab] = useState(tabs[0]);
  const staffQuery = useQuery({ queryKey: ["hr", "staff", search, contractDays], queryFn: () => Hr.staff({ q: search || undefined, contract_expires_within: contractDays }) });
  const detailQuery = useQuery({ queryKey: ["hr", "staff-detail", viewingId], queryFn: () => Hr.staffDetail(viewingId!), enabled: viewingId !== null });
  const staff = toArray<any>(staffQuery.data);

  const openEdit = (employee: any) => {
    const sp = employee.staffProfile ?? employee.staff_profile ?? {};
    setEditing(employee); setForm({
      employee_no: sp.employee_no ?? "", department: sp.department ?? "", position: sp.position ?? "",
      employment_type: sp.employment_type ?? "full-time", employment_status: sp.employment_status ?? "active",
      hire_date: sp.hire_date?.slice?.(0, 10) ?? "", supervisor_user_id: sp.supervisor_user_id ?? "",
      base_salary: sp.base_salary ?? "", payment_method: sp.payment_method ?? "", bank_name: sp.bank_name ?? "", bank_account: sp.bank_account ?? "",
      social_insurance_registered: !!sp.social_insurance_registered, social_insurance_number: sp.social_insurance_number ?? "",
      social_insurance_scheme_code: sp.social_insurance_scheme_code ?? "", social_insurance_start: sp.social_insurance_start?.slice?.(0, 10) ?? "", reason: "تحديث ملف الموظف",
    });
  };
  const save = useMutation({ mutationFn: () => Hr.updateStaff(editing.id, {
    ...form, supervisor_user_id: form.supervisor_user_id ? Number(form.supervisor_user_id) : null,
    base_salary: form.base_salary === "" ? undefined : Number(form.base_salary),
  }), onSuccess: () => { void qc.invalidateQueries({ queryKey: ["hr", "staff"] }); setEditing(null); toast({ title: "تم تحديث ملف الموظف" }); }, onError: (e: any) => toast({ variant: "destructive", title: "تعذر التحديث", description: e?.data?.message ?? e.message }) });

  return <div className="space-y-6" dir="rtl">
    <PageHeader title="الموظفون" subtitle="ملف موحّد للعقد والراتب والضمان والسلف والإنذارات" icon="👥" />
    <div className="flex flex-wrap gap-2"><Input className="max-w-xs" placeholder="بحث بالاسم" value={search} onChange={e => setSearch(e.target.value)} />{[undefined, 7, 30, 60, 90].map(days => <BrandButton key={days ?? "all"} size="sm" variant={contractDays === days ? "primary" : "outline"} onClick={() => setContractDays(days)}>{days ? `ينتهي خلال ${days} يوماً` : "كل العقود"}</BrandButton>)}</div>
    <DataTable<any> data={staff} isLoading={staffQuery.isLoading} error={(staffQuery.error as Error)?.message}
      columns={[
        { key: "name", label: "الموظف", sortable: true, render: (_, employee) => <div className="flex items-center gap-3"><Avatar className="h-8 w-8"><AvatarImage src={mediaUrl(employee.photo_path)} /><AvatarFallback>{employee.name?.slice(0, 2)}</AvatarFallback></Avatar><div><div className="font-medium">{employee.name}</div><div className="text-xs text-muted-foreground">{profileOf(employee).employee_no ?? "بلا رقم وظيفي"}</div></div></div> },
        { key: "department", label: "القسم", render: (_, row) => profileOf(row).department ?? "—" },
        { key: "position", label: "المسمى", render: (_, row) => profileOf(row).position ?? "—" },
        { key: "contract_type", label: "نوع العقد", render: (_, row) => currentContract(row)?.contract_type === "indefinite" ? "غير محدد" : currentContract(row)?.contract_type === "fixed_term" ? "محدد" : "—" },
        { key: "contract_end", label: "نهاية العقد", render: (_, row) => currentContract(row)?.end_date ?? "—" },
        { key: "days_remaining", label: "المتبقي", align: "right", render: (_, row) => currentContract(row)?.days_remaining == null ? "—" : `${currentContract(row).days_remaining} يوم` },
        { key: "contract_status", label: "حالة العقد", render: (_, row) => { const status = currentContract(row)?.display_status; return status ? <Badge variant="outline">{contractLabels[status] ?? status}</Badge> : <span>—</span>; } },
        { key: "insurance", label: "الضمان", render: (_, row) => <Badge className={profileOf(row).social_insurance_registered ? "bg-emerald-100 text-emerald-800" : "bg-rose-100 text-rose-800"}>{profileOf(row).social_insurance_registered ? "مسجل" : "غير مسجل"}</Badge> },
      ]}
      rowActions={[
        { label: "عرض الملف", icon: <Eye className="h-4 w-4" />, onClick: row => { setViewingId(row.id); setActiveTab(tabs[0]); } },
        { label: "تعديل", icon: <Pencil className="h-4 w-4" />, onClick: openEdit },
      ]} emptyMessage="لا يوجد موظفون" />

    <Dialog open={!!editing} onOpenChange={value => !value && setEditing(null)}><DialogContent className="max-w-3xl" dir="rtl"><DialogHeader><DialogTitle>تعديل ملف {editing?.name}</DialogTitle><DialogDescription>تعديل العقد نفسه يتم من شاشة العقود حتى لا يُفقد التاريخ.</DialogDescription></DialogHeader><div className="grid max-h-[65vh] gap-3 overflow-y-auto p-1 sm:grid-cols-2">
      <Field label="الرقم الوظيفي" value={form.employee_no} onChange={value => setForm({ ...form, employee_no: value })} /><Field label="القسم" value={form.department} onChange={value => setForm({ ...form, department: value })} /><Field label="المسمى الوظيفي" value={form.position} onChange={value => setForm({ ...form, position: value })} /><Field label="نوع التوظيف" value={form.employment_type} onChange={value => setForm({ ...form, employment_type: value })} />
      <SelectField label="حالة الموظف" value={form.employment_status} onChange={value => setForm({ ...form, employment_status: value })} options={[["active", "فعال"], ["suspended", "موقوف"], ["on_leave", "في إجازة"], ["terminated", "منتهي الخدمة"]]} /><Field label="تاريخ التعيين" type="date" value={form.hire_date} onChange={value => setForm({ ...form, hire_date: value })} /><Field label="الراتب الأساسي" type="number" value={form.base_salary} onChange={value => setForm({ ...form, base_salary: value })} /><Field label="طريقة الدفع" value={form.payment_method} onChange={value => setForm({ ...form, payment_method: value })} /><Field label="البنك" value={form.bank_name} onChange={value => setForm({ ...form, bank_name: value })} /><Field label="الحساب البنكي" value={form.bank_account} onChange={value => setForm({ ...form, bank_account: value })} />
      <label className="flex items-center gap-2 text-sm"><input type="checkbox" checked={form.social_insurance_registered} onChange={e => setForm({ ...form, social_insurance_registered: e.target.checked })} /> مسجل في الضمان</label><Field label="رقم الضمان" value={form.social_insurance_number} onChange={value => setForm({ ...form, social_insurance_number: value })} /><Field label="رمز نظام الضمان" value={form.social_insurance_scheme_code} onChange={value => setForm({ ...form, social_insurance_scheme_code: value })} /><Field label="بداية الاشتراك" type="date" value={form.social_insurance_start} onChange={value => setForm({ ...form, social_insurance_start: value })} /><div className="sm:col-span-2"><Field label="سبب التغيير" value={form.reason} onChange={value => setForm({ ...form, reason: value })} /></div>
    </div><DialogFooter><BrandButton variant="ghost" onClick={() => setEditing(null)}>إلغاء</BrandButton><BrandButton isLoading={save.isPending} onClick={() => save.mutate()}>حفظ</BrandButton></DialogFooter></DialogContent></Dialog>

    <Dialog open={viewingId !== null} onOpenChange={value => !value && setViewingId(null)}><DialogContent className="max-w-5xl" dir="rtl"><DialogHeader><DialogTitle>ملف {(detailQuery.data as any)?.name}</DialogTitle><DialogDescription>البيانات الحساسة تظهر حسب صلاحيات المستخدم.</DialogDescription></DialogHeader>
      <div className="flex gap-1 overflow-x-auto border-b pb-2">{tabs.map(tab => <BrandButton key={tab} size="sm" variant={activeTab === tab ? "primary" : "ghost"} onClick={() => setActiveTab(tab)}>{tab}</BrandButton>)}</div>
      <div className="min-h-56 max-h-[55vh] overflow-y-auto p-2">{detailQuery.isLoading ? "جارٍ التحميل…" : <EmployeeTab tab={activeTab} employee={detailQuery.data} />}</div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setViewingId(null)}>إغلاق</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}

function profileOf(employee: any) { return employee?.staffProfile ?? employee?.staff_profile ?? {}; }
function currentContract(employee: any) { const profile = profileOf(employee); return profile.currentContract ?? profile.current_contract ?? null; }
function Field({ label, value, onChange, type = "text" }: { label: string; value: any; onChange: (value: string) => void; type?: string }) { return <div className="space-y-1.5"><Label>{label}</Label><Input type={type} value={value ?? ""} onChange={e => onChange(e.target.value)} /></div>; }
function SelectField({ label, value, onChange, options }: { label: string; value: string; onChange: (value: string) => void; options: string[][] }) { return <div className="space-y-1.5"><Label>{label}</Label><select className="h-10 w-full rounded-md border bg-background px-3" value={value} onChange={e => onChange(e.target.value)}>{options.map(([key, text]) => <option key={key} value={key}>{text}</option>)}</select></div>; }
function EmployeeTab({ tab, employee }: { tab: string; employee: any }) {
  const sp = profileOf(employee); const contract = currentContract(employee); const effective = employee?.effective_social_insurance;
  if (tab === "البيانات الأساسية") return <Info rows={[["الرقم الوظيفي", sp.employee_no], ["الاسم", employee?.name], ["البريد", employee?.email], ["الحالة", sp.employment_status]]} />;
  if (tab === "الوظيفة والعقد") return <><Info rows={[["القسم", sp.department], ["المسمى", sp.position], ["المدير المباشر", sp.supervisor?.name], ["تاريخ التعيين", sp.hire_date], ["العقد الحالي", contract?.contract_no], ["المدة بالأيام", contract?.duration_days], ["النهاية", contract?.end_date], ["المتبقي", contract?.days_remaining]]} /><h3 className="mt-5 font-semibold">الخط الزمني</h3><div className="mt-2 space-y-2">{sp.contracts?.map((row: any) => <div key={row.id} className="rounded-lg border p-3">{row.start_date} ← {row.end_date ?? "غير محدد"} · {row.contract_no} · {contractLabels[row.display_status] ?? row.status}</div>)}</div></>;
  if (tab === "الراتب والمكونات") return <><Info rows={[["الراتب الأساسي", sp.base_salary], ["طريقة الدفع", sp.payment_method], ["البنك", sp.bank_name]]} /><div className="mt-3 space-y-2">{sp.payroll_components?.map((row: any) => <div key={row.id} className="rounded-lg border p-3">{row.component?.name_ar} · {row.amount_override ?? row.rate_override ?? "حسب الإعداد"}</div>)}</div></>;
  if (tab === "الضمان الاجتماعي") return <Info rows={[["الحالة", sp.social_insurance_registered ? "مسجل" : "غير مسجل"], ["رقم الاشتراك", sp.social_insurance_number], ["النظام", sp.social_insurance_scheme_code], ["نسبة الموظف", effective?.employee_rate ? `${effective.employee_rate}%` : null], ["نسبة صاحب العمل", effective?.employer_rate ? `${effective.employer_rate}%` : null], ["الأجر المتوقع الخاضع", effective?.estimated_insurable_wage], ["اقتطاع الموظف المتوقع", effective?.estimated_employee_amount], ["مساهمة صاحب العمل المتوقعة", effective?.estimated_employer_amount]]} />;
  if (tab === "الحضور والإجازات") return <Info rows={[["رصيد السنوية", sp.annual_leave_balance], ["رصيد المرضية", sp.sick_leave_balance]]} />;
  if (tab === "السلف") return <div className="space-y-2">{sp.advances?.map((row: any) => <div key={row.id} className="rounded-lg border p-3">{row.advance_no} · الأصل {row.original_amount} · الرصيد {row.remaining_balance} · {row.status}</div>)}</div>;
  if (tab === "الإنذارات") return <div className="space-y-2">{sp.warnings?.map((row: any) => <div key={row.id} className="rounded-lg border p-3">{row.warning_no} · {row.offence} · {row.status}</div>)}</div>;
  if (tab === "المستندات") return <pre className="whitespace-pre-wrap text-sm">{JSON.stringify(sp.documents ?? [], null, 2)}</pre>;
  return <p className="text-sm text-muted-foreground">تظهر التغييرات المالية والوظيفية في سجل التدقيق المركزي مع القيم القديمة والجديدة والسبب.</p>;
}
function Info({ rows }: { rows: any[][] }) { return <div className="grid gap-3 sm:grid-cols-2">{rows.map(([label, value]) => <div key={label} className="rounded-lg border p-3"><div className="text-xs text-muted-foreground">{label}</div><div className="mt-1 font-medium">{value ?? "—"}</div></div>)}</div>; }
