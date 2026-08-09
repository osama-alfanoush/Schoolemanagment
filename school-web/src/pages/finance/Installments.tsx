import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Banknote, BellRing, Eye, Plus, X } from "lucide-react";
import { Finance, Installments, type CreatePaymentPlanRequest, type InstallmentRow, type Invoice, type PayInstallmentRequest, type PaymentPlan } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { paginationMeta, toArray } from "@/lib/response";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { dateText, hasPermission, money, StatusBadge } from "../procurement/shared";

const today = () => new Date().toISOString().slice(0, 10);
const EMPTY_PLAN: CreatePaymentPlanRequest = {
  student_user_id: 0, total_amount: 0, num_installments: 3, frequency: "monthly", start_date: today(),
};
const EMPTY_PAYMENT: PayInstallmentRequest = { amount: 0, method: "cash" };

export default function FinanceInstallments() {
  const { user } = useAuth();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [status, setStatus] = useState("");
  const [page, setPage] = useState(1);
  const [createOpen, setCreateOpen] = useState(false);
  const [selected, setSelected] = useState<PaymentPlan | null>(null);
  const [paying, setPaying] = useState<InstallmentRow | null>(null);
  const [form, setForm] = useState<CreatePaymentPlanRequest>({ ...EMPTY_PLAN });
  const [payment, setPayment] = useState<PayInstallmentRequest>({ ...EMPTY_PAYMENT });
  const canCreate = hasPermission(user, "finance.installments.create");
  const canApprove = hasPermission(user, "finance.installments.approve");
  const canEdit = hasPermission(user, "finance.installments.edit");

  const plansQuery = useQuery({
    queryKey: ["payment-plans", status, page],
    queryFn: () => Installments.plans({ status, page, per_page: 20 }),
  });
  const meta = paginationMeta(plansQuery.data);
  // Open invoices drive plan creation: picking one fills student + amount.
  const invoicesQuery = useQuery({
    queryKey: ["finance-invoices", "open-for-plan"],
    queryFn: () => Finance.invoices({ status: "pending" }),
    enabled: createOpen,
  });
  const invoices = toArray<Invoice>(invoicesQuery.data);

  const refresh = () => {
    void qc.invalidateQueries({ queryKey: ["payment-plans"] });
  };
  const reloadDetail = async (id: number) => {
    try { setSelected(await Installments.plan(id)); } catch { setSelected(null); }
  };

  const create = useMutation({
    mutationFn: () => Installments.createPlan(form),
    onSuccess: () => { refresh(); setCreateOpen(false); setForm({ ...EMPTY_PLAN }); toast({ title: "Payment plan created" }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Could not create plan", description: e.message }),
  });
  const cancelPlan = useMutation({
    mutationFn: (id: number) => Installments.cancelPlan(id),
    onSuccess: () => { refresh(); setSelected(null); toast({ title: "Plan cancelled" }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Could not cancel plan", description: e.message }),
  });
  const waive = useMutation({
    mutationFn: (id: number) => Installments.waive(id),
    onSuccess: async () => { refresh(); if (selected) await reloadDetail(selected.id); toast({ title: "Installment waived" }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Could not waive", description: e.message }),
  });
  const pay = useMutation({
    mutationFn: () => Installments.pay(paying!.id, payment),
    onSuccess: async () => {
      refresh();
      setPaying(null);
      setPayment({ ...EMPTY_PAYMENT });
      if (selected) await reloadDetail(selected.id);
      toast({ title: "Installment payment recorded" });
    },
    onError: (e: Error) => toast({ variant: "destructive", title: "Payment failed", description: e.message }),
  });
  const remind = useMutation({
    mutationFn: () => Installments.sendReminders(),
    onSuccess: (res) => toast({ title: "Reminders sent", description: `${res.reminders_sent} notification(s) queued.` }),
    onError: (e: Error) => toast({ variant: "destructive", title: "Could not send reminders", description: e.message }),
  });

  const pickInvoice = (id: number) => {
    const invoice = invoices.find(i => i.id === id);
    if (!invoice) { setForm({ ...form, invoice_id: undefined, student_user_id: 0 }); return; }
    setForm({
      ...form,
      invoice_id: invoice.id,
      student_user_id: invoice.student_user_id,
      total_amount: Number(invoice.amount) - Number(invoice.paid_amount),
    });
  };
  const outstanding = (row: InstallmentRow) => Number(row.amount) - Number(row.paid_amount);

  return <div className="space-y-6">
    <PageHeader icon="📅" title="Installments" subtitle="Student payment plans, schedules, and reminders"
      actions={<div className="flex gap-2">
        {canEdit && <BrandButton variant="secondary" leftIcon={<BellRing className="h-4 w-4" />} isLoading={remind.isPending} onClick={() => remind.mutate()}>Send reminders</BrandButton>}
        {canCreate && <BrandButton leftIcon={<Plus className="h-4 w-4" />} onClick={() => setCreateOpen(true)}>New plan</BrandButton>}
      </div>} />

    <DataTable<PaymentPlan> title="Payment plans" data={toArray<PaymentPlan>(plansQuery.data)} isLoading={plansQuery.isLoading} error={(plansQuery.error as Error)?.message}
      toolbar={<div className="max-w-xs"><Label htmlFor="plan-status" className="sr-only">Filter by status</Label><select id="plan-status" className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={status} onChange={e => { setStatus(e.target.value); setPage(1); }}><option value="">All statuses</option>{["active", "completed", "defaulted", "cancelled"].map(s => <option key={s} value={s}>{s}</option>)}</select></div>}
      columns={[
        { key: "plan_no", label: "Plan", sortable: true, render: v => <span className="font-semibold">{v}</span> },
        { key: "student.name", label: "Student", sortable: true },
        { key: "invoice.invoice_no", label: "Invoice", render: v => v ?? "—", hide: "md" },
        { key: "total_amount", label: "Total", align: "right", render: money },
        { key: "num_installments", label: "Installments", align: "center", hide: "sm" },
        { key: "start_date", label: "Starts", render: dateText, hide: "md" },
        { key: "status", label: "Status", render: v => <StatusBadge status={v} /> },
      ]}
      rowActions={[
        { label: "View schedule", icon: <Eye className="h-4 w-4" />, onClick: row => void reloadDetail(row.id) },
        { label: "Cancel plan", icon: <X className="h-4 w-4" />, variant: "danger", show: row => canApprove && row.status === "active", onClick: row => cancelPlan.mutate(row.id) },
      ]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }}
      emptyMessage="No payment plans yet." />

    <Dialog open={createOpen} onOpenChange={setCreateOpen}><DialogContent className="max-w-2xl"><DialogHeader><DialogTitle>New payment plan</DialogTitle><DialogDescription>Pick an open invoice — the student and outstanding amount fill in automatically, then choose the schedule.</DialogDescription></DialogHeader>
      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5 sm:col-span-2">
          <Label htmlFor="plan-invoice">Invoice</Label>
          <select id="plan-invoice" className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={form.invoice_id ?? 0} onChange={e => pickInvoice(Number(e.target.value))}>
            <option value={0}>Select an open invoice</option>
            {invoices.map(inv => <option key={inv.id} value={inv.id}>{inv.invoice_no} — {inv.student?.name} ({money(Number(inv.amount) - Number(inv.paid_amount))} outstanding)</option>)}
          </select>
        </div>
        <Field label="Total amount"><Input type="number" min="0.01" step="0.01" value={form.total_amount || ""} onChange={e => setForm({ ...form, total_amount: Number(e.target.value) })} /></Field>
        <Field label="Down payment"><Input type="number" min="0" step="0.01" value={form.down_payment ?? ""} onChange={e => setForm({ ...form, down_payment: e.target.value ? Number(e.target.value) : undefined })} /></Field>
        <Field label="Number of installments"><Input type="number" min="1" max="36" value={form.num_installments} onChange={e => setForm({ ...form, num_installments: Number(e.target.value) })} /></Field>
        <Field label="Frequency"><select className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={form.frequency} onChange={e => setForm({ ...form, frequency: e.target.value as CreatePaymentPlanRequest["frequency"] })}><option value="monthly">Monthly</option><option value="quarterly">Quarterly</option></select></Field>
        <Field label="First due date"><Input type="date" value={form.start_date} onChange={e => setForm({ ...form, start_date: e.target.value })} /></Field>
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setCreateOpen(false)}>Cancel</BrandButton><BrandButton isLoading={create.isPending} disabled={!form.student_user_id || form.total_amount <= 0 || form.num_installments < 1} onClick={() => create.mutate()}>Create plan</BrandButton></DialogFooter>
    </DialogContent></Dialog>

    <Dialog open={!!selected} onOpenChange={open => !open && setSelected(null)}><DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto"><DialogHeader><DialogTitle>{selected?.plan_no} — {selected?.student?.name}</DialogTitle><DialogDescription>{money(selected?.total_amount)} over {selected?.num_installments} {selected?.frequency} installment(s){selected?.invoice ? ` · invoice ${selected.invoice.invoice_no}` : ""}</DialogDescription></DialogHeader>
      <div className="space-y-2">
        {(selected?.installments ?? []).map(inst => <div key={inst.id} className="flex items-center justify-between gap-3 rounded-xl border border-border p-3">
          <div>
            <p className="text-sm font-semibold">#{inst.sequence_no} · due {dateText(inst.due_date)}</p>
            <p className="text-xs text-muted-foreground">{money(inst.paid_amount)} paid of {money(inst.amount)}</p>
          </div>
          <div className="flex items-center gap-2">
            <StatusBadge status={inst.status} />
            {canCreate && !["paid", "waived"].includes(inst.status) && <BrandButton size="sm" variant="secondary" leftIcon={<Banknote className="h-4 w-4" />} onClick={() => { setPaying(inst); setPayment({ ...EMPTY_PAYMENT, amount: outstanding(inst) }); }}>Pay</BrandButton>}
            {canApprove && !["paid", "waived"].includes(inst.status) && <BrandButton size="sm" variant="ghost" onClick={() => waive.mutate(inst.id)}>Waive</BrandButton>}
          </div>
        </div>)}
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setSelected(null)}>Close</BrandButton></DialogFooter>
    </DialogContent></Dialog>

    <Dialog open={!!paying} onOpenChange={open => !open && setPaying(null)}><DialogContent><DialogHeader><DialogTitle>Pay installment #{paying?.sequence_no}</DialogTitle><DialogDescription>Outstanding: {money(paying ? outstanding(paying) : 0)}. Payments post to the linked invoice when one exists.</DialogDescription></DialogHeader>
      <div className="space-y-3">
        <Field label="Amount"><Input type="number" min="0.01" step="0.01" max={paying ? outstanding(paying) : undefined} value={payment.amount || ""} onChange={e => setPayment({ ...payment, amount: Number(e.target.value) })} /></Field>
        <Field label="Method"><select className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={payment.method} onChange={e => setPayment({ ...payment, method: e.target.value as PayInstallmentRequest["method"] })}><option value="cash">Cash</option><option value="bank_transfer">Bank transfer</option><option value="card">Card</option><option value="online">Online</option></select></Field>
        <Field label="Reference"><Input value={payment.reference ?? ""} onChange={e => setPayment({ ...payment, reference: e.target.value || undefined })} /></Field>
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setPaying(null)}>Cancel</BrandButton><BrandButton isLoading={pay.isPending} disabled={payment.amount <= 0} onClick={() => pay.mutate()}>Record payment</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <div className="space-y-1.5"><Label>{label}</Label>{children}</div>; }
