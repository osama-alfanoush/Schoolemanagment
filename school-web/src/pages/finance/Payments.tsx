import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { FinanceWorkspace, type PaymentReceipt, type User } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandModal from "@/components/ui/BrandModal";
import BrandEmptyState from "@/components/ui/BrandEmptyState";
import { renderCurrency, renderDate, renderStatus } from "@/lib/tableHelpers";
import { useToast } from "@/hooks/use-toast";
import { CheckCircle2, Download, FileCheck2, RotateCcw, Search } from "lucide-react";

const today = new Date().toISOString().slice(0, 10);

export default function FinancePayments() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [page, setPage] = useState(1);
  const [showCreate, setShowCreate] = useState(false);
  const [studentTerm, setStudentTerm] = useState("");
  const [selectedStudent, setSelectedStudent] = useState<User | null>(null);
  const [allocations, setAllocations] = useState<Record<number, number>>({});
  const [form, setForm] = useState({ amount: 0, method: "cash" as const, receipt_date: today, reference: "", cash_account: "الصندوق الرئيسي", note: "" });

  const list = useQuery({
    queryKey: ["finance-receipts", page],
    queryFn: () => FinanceWorkspace.receipts({ page, per_page: 25 }),
  });
  const studentSearch = useQuery({
    queryKey: ["receipt-student-search", studentTerm],
    queryFn: () => FinanceWorkspace.searchStudents(studentTerm),
    enabled: showCreate && studentTerm.trim().length > 0 && !selectedStudent,
  });
  const profile = useQuery({
    queryKey: ["receipt-student-profile", selectedStudent?.id],
    queryFn: () => FinanceWorkspace.studentProfile(selectedStudent!.id),
    enabled: Boolean(selectedStudent),
  });

  const invalidate = () => {
    void queryClient.invalidateQueries({ queryKey: ["finance-receipts"] });
    void queryClient.invalidateQueries({ queryKey: ["student-finance-profile"] });
  };
  const createReceipt = useMutation({
    mutationFn: () => FinanceWorkspace.createReceipt({
      student_user_id: selectedStudent!.id,
      ...form,
      allocations: Object.entries(allocations).filter(([, amount]) => amount > 0)
        .map(([invoiceId, amount]) => ({ invoice_id: Number(invoiceId), amount })),
    }),
    onSuccess: () => {
      invalidate();
      setShowCreate(false);
      resetForm();
      toast({ title: "تم إنشاء سند القبض كمسودة" });
    },
    onError: (error: Error) => toast({ variant: "destructive", title: "تعذر إنشاء السند", description: error.message }),
  });
  const workflow = useMutation({
    mutationFn: async ({ receipt, action }: { receipt: PaymentReceipt; action: "approve" | "post" | "reverse" }) => {
      if (action === "approve") return FinanceWorkspace.approveReceipt(receipt.id);
      if (action === "post") return FinanceWorkspace.postReceipt(receipt.id);
      const reason = window.prompt("سبب عكس السند")?.trim();
      if (!reason) throw new Error("سبب العكس مطلوب");
      return FinanceWorkspace.reverseReceipt(receipt.id, reason);
    },
    onSuccess: () => { invalidate(); toast({ title: "تم تحديث حالة السند" }); },
    onError: (error: Error) => toast({ variant: "destructive", title: "تعذر تنفيذ العملية", description: error.message }),
  });

  const allocationTotal = useMemo(() => Object.values(allocations).reduce((sum, value) => sum + Number(value || 0), 0), [allocations]);
  const receipts = list.data?.data ?? [];
  const lastPage = (list.data as any)?.last_page ?? list.data?.meta?.last_page ?? 1;

  function resetForm() {
    setSelectedStudent(null);
    setStudentTerm("");
    setAllocations({});
    setForm({ amount: 0, method: "cash", receipt_date: today, reference: "", cash_account: "الصندوق الرئيسي", note: "" });
  }

  function autoAllocate() {
    let remaining = Math.round(Number(form.amount) * 100) / 100;
    const next: Record<number, number> = {};
    const invoices = [...(profile.data?.invoices ?? [])].sort((a, b) => a.due_date.localeCompare(b.due_date));
    for (const invoice of invoices) {
      const outstanding = Math.max(0, Number(invoice.amount) - Number(invoice.paid_amount));
      const amount = Math.min(remaining, outstanding);
      if (amount > 0) next[invoice.id] = Math.round(amount * 100) / 100;
      remaining = Math.round((remaining - amount) * 100) / 100;
      if (remaining <= 0) break;
    }
    setAllocations(next);
  }

  return (
    <div className="space-y-6" dir="rtl">
      <PageHeader title="القبض وسندات الدفع" subtitle="إنشاء، اعتماد، ترحيل وعكس السندات مع قيد محاسبي تلقائي" icon="🧾"
        actions={<BrandButton onClick={() => setShowCreate(true)}>سند قبض جديد</BrandButton>} />

      {receipts.length === 0 && !list.isLoading ? <BrandEmptyState icon="🧾" title="لا توجد سندات قبض" subtitle="ابدأ بإنشاء سند جديد واختيار الطالب." /> : (
        <BrandCard className="overflow-x-auto p-0">
          <table className="w-full min-w-[850px] text-sm">
            <thead className="bg-muted/40"><tr><th className="p-3 text-start">السند</th><th className="p-3 text-start">الطالب</th><th className="p-3">التاريخ</th><th className="p-3">الطريقة</th><th className="p-3">المبلغ</th><th className="p-3">الحالة</th><th className="p-3">الإجراءات</th></tr></thead>
            <tbody>{receipts.map((receipt) => <tr key={receipt.id} className="border-t border-border">
              <td className="p-3 font-mono text-xs">{receipt.receipt_no}</td><td className="p-3 font-medium">{receipt.student?.name}</td>
              <td className="p-3 text-center">{renderDate(receipt.receipt_date)}</td><td className="p-3 text-center">{receipt.method}</td>
              <td className="p-3 text-center font-bold tabular-nums">{renderCurrency(receipt.amount)}</td><td className="p-3 text-center">{renderStatus(receipt.status)}</td>
              <td className="p-3"><div className="flex justify-center gap-1">
                {receipt.status === "draft" && <Action title="اعتماد" onClick={() => workflow.mutate({ receipt, action: "approve" })}><CheckCircle2 /></Action>}
                {receipt.status === "approved" && <Action title="ترحيل" onClick={() => workflow.mutate({ receipt, action: "post" })}><FileCheck2 /></Action>}
                {receipt.status === "posted" && <Action title="عكس" onClick={() => workflow.mutate({ receipt, action: "reverse" })}><RotateCcw /></Action>}
                {(receipt.status === "posted" || receipt.status === "reversed") && <Action title="طباعة" onClick={() => { void FinanceWorkspace.receiptPdf(receipt.id, receipt.receipt_no); }}><Download /></Action>}
              </div></td>
            </tr>)}</tbody>
          </table>
        </BrandCard>
      )}
      <div className="flex justify-center gap-2"><button className="rounded border px-3 py-1 disabled:opacity-40" disabled={page <= 1} onClick={() => setPage((p) => p - 1)}>السابق</button><span className="px-3 py-1">{page} / {lastPage}</span><button className="rounded border px-3 py-1 disabled:opacity-40" disabled={page >= lastPage} onClick={() => setPage((p) => p + 1)}>التالي</button></div>

      <BrandModal isOpen={showCreate} onClose={() => { setShowCreate(false); resetForm(); }} title="سند قبض جديد" size="xl" footer={<>
        <BrandButton variant="ghost" onClick={() => setShowCreate(false)}>إلغاء</BrandButton>
        <BrandButton isLoading={createReceipt.isPending} disabled={!selectedStudent || form.amount <= 0 || (allocationTotal > 0 && Math.abs(allocationTotal - form.amount) > 0.005)} onClick={() => createReceipt.mutate()}>حفظ كمسودة</BrandButton>
      </>}>
        <div className="space-y-5" dir="rtl">
          <div><label className="mb-1 block text-sm font-medium" htmlFor="receipt-student">الطالب</label><div className="relative"><Search className="absolute end-3 top-3 h-4 w-4 text-muted-foreground" /><input id="receipt-student" value={studentTerm} onChange={(e) => { setStudentTerm(e.target.value); setSelectedStudent(null); }} placeholder="الاسم أو رقم الطالب أو الهاتف" className="w-full rounded-lg border p-2.5 pe-9" /></div>
            {!selectedStudent && studentTerm && <div className="mt-1 max-h-40 overflow-y-auto rounded-lg border bg-card">{(studentSearch.data?.data ?? []).map((student) => <button type="button" key={student.id} onClick={() => { setSelectedStudent(student); setStudentTerm(student.name); setAllocations({}); }} className="flex w-full justify-between border-b p-2 text-sm hover:bg-muted/50"><span>{student.name}</span><span className="text-muted-foreground">{student.student_profile?.admission_no}</span></button>)}</div>}
          </div>
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <Field label="المبلغ"><input type="number" min="0.01" step="0.01" value={form.amount || ""} onChange={(e) => { setForm({ ...form, amount: Number(e.target.value) }); setAllocations({}); }} className="w-full rounded-lg border p-2.5" /></Field>
            <Field label="التاريخ"><input type="date" value={form.receipt_date} onChange={(e) => setForm({ ...form, receipt_date: e.target.value })} className="w-full rounded-lg border p-2.5" /></Field>
            <Field label="طريقة الدفع"><select value={form.method} onChange={(e) => setForm({ ...form, method: e.target.value as typeof form.method })} className="w-full rounded-lg border p-2.5"><option value="cash">نقدي</option><option value="bank_transfer">تحويل مصرفي</option><option value="card">بطاقة</option><option value="online">إلكتروني</option></select></Field>
            <Field label="الصندوق/الحساب"><input value={form.cash_account} onChange={(e) => setForm({ ...form, cash_account: e.target.value })} className="w-full rounded-lg border p-2.5" /></Field>
          </div>
          <div className="grid gap-3 sm:grid-cols-2"><Field label="المرجع"><input value={form.reference} onChange={(e) => setForm({ ...form, reference: e.target.value })} className="w-full rounded-lg border p-2.5" /></Field><Field label="ملاحظة"><input value={form.note} onChange={(e) => setForm({ ...form, note: e.target.value })} className="w-full rounded-lg border p-2.5" /></Field></div>

          {selectedStudent && <div>
            <div className="mb-2 flex items-center justify-between"><div><h3 className="font-semibold">توزيع الدفعة</h3><p className="text-xs text-muted-foreground">يمكن تعديل التوزيع قبل حفظ السند.</p></div><BrandButton type="button" size="sm" variant="secondary" onClick={autoAllocate}>توزيع تلقائي</BrandButton></div>
            <div className="max-h-64 overflow-y-auto rounded-xl border"><table className="w-full text-sm"><thead className="sticky top-0 bg-muted"><tr><th className="p-2 text-start">الفاتورة</th><th className="p-2">المستحق</th><th className="p-2">المتبقي</th><th className="p-2">التخصيص</th></tr></thead><tbody>{(profile.data?.invoices ?? []).filter((invoice) => invoice.status !== "paid" && invoice.status !== "cancelled").map((invoice) => <tr key={invoice.id} className="border-t"><td className="p-2">{invoice.invoice_no}<span className="block text-xs text-muted-foreground">{invoice.description}</span></td><td className="p-2 text-center">{renderCurrency(invoice.amount)}</td><td className="p-2 text-center">{renderCurrency(invoice.amount - invoice.paid_amount)}</td><td className="p-2"><input aria-label={`تخصيص ${invoice.invoice_no}`} type="number" min="0" max={invoice.amount - invoice.paid_amount} step="0.01" value={allocations[invoice.id] ?? ""} onChange={(e) => setAllocations((current) => ({ ...current, [invoice.id]: Number(e.target.value) }))} className="w-28 rounded border p-2" /></td></tr>)}</tbody></table></div>
            <div className={`mt-2 text-sm font-semibold ${allocationTotal > form.amount ? "text-red-600" : "text-foreground"}`}>الموزع: {renderCurrency(allocationTotal)} من {renderCurrency(form.amount)}</div>
          </div>}
        </div>
      </BrandModal>
    </div>
  );
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <label className="block text-sm"><span className="mb-1 block font-medium">{label}</span>{children}</label>; }
function Action({ title, onClick, children }: { title: string; onClick: () => void; children: React.ReactElement<{ className?: string }> }) { return <button type="button" title={title} aria-label={title} onClick={onClick} className="rounded-lg p-2 text-muted-foreground hover:bg-muted hover:text-[var(--color-primary)]">{children}</button>; }
