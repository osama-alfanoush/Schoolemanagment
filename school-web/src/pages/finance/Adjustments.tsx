import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { FinanceWorkspace, type StudentFinancialAdjustment, type User } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandModal from "@/components/ui/BrandModal";
import BrandEmptyState from "@/components/ui/BrandEmptyState";
import { renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { useToast } from "@/hooks/use-toast";

export default function FinanceAdjustments() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [showModal, setShowModal] = useState(false);
  const [studentTerm, setStudentTerm] = useState("");
  const [student, setStudent] = useState<User | null>(null);
  const [form, setForm] = useState<{
    invoice_id: string;
    type: "discount" | "adjustment" | "refund";
    direction: "debit" | "credit";
    calculation_type: "amount" | "percentage";
    value: number;
    reason: string;
  }>({ invoice_id: "", type: "discount", direction: "credit", calculation_type: "amount", value: 0, reason: "" });
  const list = useQuery({ queryKey: ["finance-adjustments"], queryFn: () => FinanceWorkspace.adjustments({ per_page: 50 }) });
  const search = useQuery({ queryKey: ["adjustment-students", studentTerm], queryFn: () => FinanceWorkspace.searchStudents(studentTerm), enabled: showModal && Boolean(studentTerm) && !student });
  const profile = useQuery({ queryKey: ["adjustment-profile", student?.id], queryFn: () => FinanceWorkspace.studentProfile(student!.id), enabled: Boolean(student) });
  const create = useMutation({
    mutationFn: () => FinanceWorkspace.createAdjustment({ student_user_id: student!.id, invoice_id: form.invoice_id ? Number(form.invoice_id) : undefined, type: form.type, direction: form.direction, calculation_type: form.calculation_type, value: form.value, reason: form.reason }),
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["finance-adjustments"] }); setShowModal(false); reset(); toast({ title: "تم إنشاء التسوية كمسودة" }); },
    onError: (error: Error) => toast({ variant: "destructive", title: "تعذر الحفظ", description: error.message }),
  });
  const workflow = useMutation({
    mutationFn: async ({ row, action }: { row: StudentFinancialAdjustment; action: "approve" | "post" | "reverse" }) => {
      if (action === "approve") return FinanceWorkspace.approveAdjustment(row.id);
      if (action === "post") return FinanceWorkspace.postAdjustment(row.id);
      const reason = window.prompt("سبب عكس التسوية")?.trim();
      if (!reason) throw new Error("سبب العكس مطلوب");
      return FinanceWorkspace.reverseAdjustment(row.id, reason);
    },
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["finance-adjustments"] }); void qc.invalidateQueries({ queryKey: ["student-finance-profile"] }); toast({ title: "تم تحديث التسوية" }); },
    onError: (error: Error) => toast({ variant: "destructive", title: "تعذر تنفيذ العملية", description: error.message }),
  });
  const rows = list.data?.data ?? [];

  function reset() {
    setStudent(null); setStudentTerm("");
    setForm({ invoice_id: "", type: "discount", direction: "credit", calculation_type: "amount", value: 0, reason: "" });
  }

  return <div className="space-y-6" dir="rtl">
    <PageHeader title="الخصومات والتسويات" subtitle="دورة موثقة للإنشاء والاعتماد والترحيل والعكس" icon="🏷️" actions={<BrandButton onClick={() => setShowModal(true)}>تسوية جديدة</BrandButton>} />
    {rows.length === 0 && !list.isLoading ? <BrandEmptyState icon="🏷️" title="لا توجد خصومات أو تسويات" subtitle="أنشئ مسودة واربطها بالطالب والفاتورة المتأثرة." /> : <BrandCard className="overflow-x-auto p-0"><table className="w-full min-w-[800px] text-sm"><thead className="bg-muted/40"><tr><th className="p-3 text-start">المرجع</th><th className="p-3 text-start">الطالب</th><th className="p-3">النوع</th><th className="p-3">المبلغ</th><th className="p-3">السبب</th><th className="p-3">الحالة</th><th className="p-3">الإجراء</th></tr></thead><tbody>{rows.map((row) => <tr key={row.id} className="border-t"><td className="p-3 font-mono text-xs">{row.adjustment_no}<span className="block text-muted-foreground">{renderDate(row.created_at)}</span></td><td className="p-3">{row.student?.name}</td><td className="p-3 text-center">{row.type === "discount" ? "خصم" : row.type === "refund" ? "مرتجع" : "تسوية"}</td><td className="p-3 text-center font-bold">{renderCurrency(row.amount)}</td><td className="p-3">{row.reason}</td><td className="p-3 text-center">{renderStatus(row.status)}</td><td className="p-3 text-center">{row.status === "draft" ? <button className="text-[var(--color-primary)]" onClick={() => workflow.mutate({ row, action: "approve" })}>اعتماد</button> : row.status === "approved" ? <button className="text-[var(--color-primary)]" onClick={() => workflow.mutate({ row, action: "post" })}>ترحيل</button> : row.status === "posted" ? <button className="text-red-600" onClick={() => workflow.mutate({ row, action: "reverse" })}>عكس</button> : "—"}</td></tr>)}</tbody></table></BrandCard>}

    <BrandModal isOpen={showModal} onClose={() => { setShowModal(false); reset(); }} title="خصم أو تسوية جديدة" size="lg" footer={<><BrandButton variant="ghost" onClick={() => setShowModal(false)}>إلغاء</BrandButton><BrandButton isLoading={create.isPending} disabled={!student || !form.reason || form.value <= 0} onClick={() => create.mutate()}>حفظ كمسودة</BrandButton></>}>
      <div className="space-y-4" dir="rtl">
        <label className="block text-sm"><span className="mb-1 block font-medium">الطالب</span><input value={studentTerm} onChange={(e) => { setStudentTerm(e.target.value); setStudent(null); }} className="w-full rounded-lg border p-2.5" placeholder="الاسم أو رقم الطالب" /></label>
        {!student && studentTerm && <div className="max-h-36 overflow-y-auto rounded-lg border">{(search.data?.data ?? []).map((item) => <button type="button" key={item.id} onClick={() => { setStudent(item); setStudentTerm(item.name); }} className="flex w-full justify-between border-b p-2 text-sm hover:bg-muted"><span>{item.name}</span><span>{item.student_profile?.admission_no}</span></button>)}</div>}
        <div className="grid gap-3 sm:grid-cols-2">
          <label className="text-sm"><span className="mb-1 block font-medium">الفاتورة المتأثرة</span><select value={form.invoice_id} onChange={(e) => setForm({ ...form, invoice_id: e.target.value })} className="w-full rounded-lg border p-2.5"><option value="">بدون فاتورة محددة</option>{profile.data?.invoices.map((invoice) => <option key={invoice.id} value={invoice.id}>{invoice.invoice_no} — {renderCurrency(invoice.amount)}</option>)}</select></label>
          <label className="text-sm"><span className="mb-1 block font-medium">النوع</span><select value={form.type} onChange={(e) => { const type = e.target.value as typeof form.type; setForm({ ...form, type, direction: type === "adjustment" ? "debit" : "credit" }); }} className="w-full rounded-lg border p-2.5"><option value="discount">خصم</option><option value="adjustment">تسوية مدينة</option><option value="refund">مرتجع</option></select></label>
          <label className="text-sm"><span className="mb-1 block font-medium">طريقة الحساب</span><select value={form.calculation_type} onChange={(e) => setForm({ ...form, calculation_type: e.target.value as typeof form.calculation_type })} className="w-full rounded-lg border p-2.5"><option value="amount">مبلغ</option><option value="percentage">نسبة مئوية</option></select></label>
          <label className="text-sm"><span className="mb-1 block font-medium">القيمة</span><input type="number" min="0.01" step="0.01" value={form.value || ""} onChange={(e) => setForm({ ...form, value: Number(e.target.value) })} className="w-full rounded-lg border p-2.5" /></label>
        </div>
        <label className="block text-sm"><span className="mb-1 block font-medium">السبب</span><textarea rows={3} value={form.reason} onChange={(e) => setForm({ ...form, reason: e.target.value })} className="w-full rounded-lg border p-2.5" /></label>
      </div>
    </BrandModal>
  </div>;
}
