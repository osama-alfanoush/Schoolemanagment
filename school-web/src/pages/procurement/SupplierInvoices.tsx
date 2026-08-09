import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Banknote, Plus } from "lucide-react";
import { AccountsPayable, Procurement, type CreateSupplierInvoiceRequest, type RecordSupplierPaymentRequest, type Supplier, type SupplierInvoice } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { paginationMeta, toArray } from "@/lib/response";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { dateText, hasPermission, money, StatusBadge } from "./shared";

const today = () => new Date().toISOString().slice(0, 10);
const initialInvoice: CreateSupplierInvoiceRequest = { supplier_id: 0, invoice_date: today(), due_date: today(), amount: 0 };
const initialPayment: RecordSupplierPaymentRequest = { amount: 0, method: "bank_transfer" };

export default function SupplierInvoices() {
  const { user } = useAuth();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [status, setStatus] = useState("");
  const [page, setPage] = useState(1);
  const [createOpen, setCreateOpen] = useState(false);
  const [paying, setPaying] = useState<SupplierInvoice | null>(null);
  const [form, setForm] = useState<CreateSupplierInvoiceRequest>(initialInvoice);
  const [payment, setPayment] = useState<RecordSupplierPaymentRequest>(initialPayment);
  const canCreate = hasPermission(user, "finance.procurement.create");
  const canPay = hasPermission(user, "finance.procurement.approve");

  const { data, isLoading, error } = useQuery({ queryKey: ["supplier-invoices", status, page], queryFn: () => AccountsPayable.invoices({ status, page, per_page: 20 }) });
  const meta = paginationMeta(data);
  const suppliersQuery = useQuery({ queryKey: ["procurement-suppliers", "options"], queryFn: () => Procurement.suppliers({ is_active: true, per_page: 100 }) });
  const suppliers = toArray<Supplier>(suppliersQuery.data);
  const agingQuery = useQuery({ queryKey: ["ap-aging"], queryFn: () => AccountsPayable.aging() });

  const refresh = () => { void qc.invalidateQueries({ queryKey: ["supplier-invoices"] }); void qc.invalidateQueries({ queryKey: ["procurement-suppliers"] }); void qc.invalidateQueries({ queryKey: ["procurement-dashboard"] }); void qc.invalidateQueries({ queryKey: ["ap-aging"] }); };
  const create = useMutation({
    mutationFn: () => AccountsPayable.createInvoice(form),
    onSuccess: () => { refresh(); setCreateOpen(false); setForm(initialInvoice); toast({ title: "Supplier invoice registered" }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Could not register invoice", description: e.message }),
  });
  const pay = useMutation({
    mutationFn: () => AccountsPayable.recordPayment(paying!.id, payment),
    onSuccess: () => { refresh(); setPaying(null); setPayment(initialPayment); toast({ title: "Payment recorded", description: "Supplier balance and ledger updated." }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Payment failed", description: e.message }),
  });

  const outstanding = (row: SupplierInvoice) => Number(row.amount) - Number(row.paid_amount);
  const openPay = (row: SupplierInvoice) => { setPaying(row); setPayment({ ...initialPayment, amount: outstanding(row) }); };

  return <div className="space-y-6">
    <PageHeader icon="AP" title="Supplier invoices" subtitle="Accounts payable — register supplier invoices and settle payments"
      actions={canCreate ? <BrandButton leftIcon={<Plus className="h-4 w-4" />} onClick={() => setCreateOpen(true)}>Register invoice</BrandButton> : undefined} />
    <DataTable<SupplierInvoice> title="Invoices" data={toArray<SupplierInvoice>(data)} isLoading={isLoading} error={(error as Error)?.message}
      toolbar={<div className="max-w-xs"><Label htmlFor="ap-status" className="sr-only">Filter by status</Label><select id="ap-status" className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={status} onChange={e => { setStatus(e.target.value); setPage(1); }}><option value="">All statuses</option>{["pending", "partial", "paid", "overdue", "cancelled"].map(s => <option key={s} value={s}>{s}</option>)}</select></div>}
      columns={[
        { key: "invoice_no", label: "Invoice", sortable: true, render: (v, row) => <div><p className="font-semibold">{v}</p>{row.supplier_invoice_ref && <p className="text-xs text-muted-foreground">Ref: {row.supplier_invoice_ref}</p>}</div> },
        { key: "supplier.name", label: "Supplier", sortable: true },
        { key: "invoice_date", label: "Invoiced", render: dateText, hide: "md" },
        { key: "due_date", label: "Due", sortable: true, render: dateText },
        { key: "amount", label: "Amount", align: "right", sortable: true, render: money },
        { key: "paid_amount", label: "Paid", align: "right", render: money, hide: "sm" },
        { key: "status", label: "Status", render: v => <StatusBadge status={v} /> },
      ]}
      rowActions={[{ label: "Record payment", icon: <Banknote className="h-4 w-4" />, show: row => canPay && ["pending", "partial", "overdue"].includes(row.status), onClick: openPay }]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }}
      emptyMessage="No supplier invoices found." />

    <DataTable title={`AP aging — total payable ${money(agingQuery.data?.total_payable ?? 0)}`}
      data={agingQuery.data?.data ?? []} isLoading={agingQuery.isLoading} error={(agingQuery.error as Error)?.message}
      columns={[
        { key: "supplier.name", label: "Supplier", sortable: true, render: (v, row: any) => <div><p className="font-semibold">{v}</p><p className="text-xs text-muted-foreground">{row.supplier?.code}</p></div> },
        { key: "buckets.current", label: "Current", align: "right", render: money },
        { key: "buckets.days_30", label: "1–30 days", align: "right", render: money },
        { key: "buckets.days_60", label: "31–60 days", align: "right", render: money, hide: "sm" },
        { key: "buckets.days_90", label: "61–90 days", align: "right", render: money, hide: "md" },
        { key: "buckets.days_90_plus", label: "90+ days", align: "right", render: money },
        { key: "total_outstanding", label: "Total", align: "right", sortable: true, render: v => <span className="font-bold">{money(v)}</span> },
      ]}
      emptyMessage="Nothing outstanding — all supplier invoices are settled." />

    <Dialog open={createOpen} onOpenChange={setCreateOpen}><DialogContent className="max-w-2xl"><DialogHeader><DialogTitle>Register supplier invoice</DialogTitle><DialogDescription>Record an invoice received from a supplier so it can be tracked and paid.</DialogDescription></DialogHeader>
      <div className="grid gap-4 sm:grid-cols-2">
        <Field label="Supplier"><select className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={form.supplier_id} onChange={e => setForm({ ...form, supplier_id: Number(e.target.value) })}><option value={0}>Select supplier</option>{suppliers.map(s => <option key={s.id} value={s.id}>{s.code} — {s.name}</option>)}</select></Field>
        <Field label="Supplier's invoice ref"><Input value={form.supplier_invoice_ref ?? ""} onChange={e => setForm({ ...form, supplier_invoice_ref: e.target.value || undefined })} /></Field>
        <Field label="Invoice date"><Input type="date" value={form.invoice_date} onChange={e => setForm({ ...form, invoice_date: e.target.value })} /></Field>
        <Field label="Due date"><Input type="date" min={form.invoice_date} value={form.due_date} onChange={e => setForm({ ...form, due_date: e.target.value })} /></Field>
        <Field label="Amount"><Input type="number" min="0.01" step="0.01" value={form.amount || ""} onChange={e => setForm({ ...form, amount: Number(e.target.value) })} /></Field>
        <Field label="Notes"><Input value={form.notes ?? ""} onChange={e => setForm({ ...form, notes: e.target.value || undefined })} /></Field>
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setCreateOpen(false)}>Cancel</BrandButton><BrandButton isLoading={create.isPending} disabled={!form.supplier_id || form.amount <= 0 || !form.invoice_date || !form.due_date} onClick={() => create.mutate()}>Register</BrandButton></DialogFooter>
    </DialogContent></Dialog>

    <Dialog open={!!paying} onOpenChange={open => !open && setPaying(null)}><DialogContent><DialogHeader><DialogTitle>Record payment — {paying?.invoice_no}</DialogTitle><DialogDescription>Outstanding balance: {money(paying ? outstanding(paying) : 0)}. Posts to the supplier ledger and journal.</DialogDescription></DialogHeader>
      <div className="space-y-3">
        <Field label="Amount"><Input type="number" min="0.01" step="0.01" max={paying ? outstanding(paying) : undefined} value={payment.amount || ""} onChange={e => setPayment({ ...payment, amount: Number(e.target.value) })} /></Field>
        <Field label="Method"><select className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={payment.method} onChange={e => setPayment({ ...payment, method: e.target.value as RecordSupplierPaymentRequest["method"] })}><option value="bank_transfer">Bank transfer</option><option value="cash">Cash</option><option value="cheque">Cheque</option></select></Field>
        <Field label="Reference"><Input value={payment.reference ?? ""} onChange={e => setPayment({ ...payment, reference: e.target.value || undefined })} /></Field>
        <Field label="Note"><Input value={payment.note ?? ""} onChange={e => setPayment({ ...payment, note: e.target.value || undefined })} /></Field>
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setPaying(null)}>Cancel</BrandButton><BrandButton isLoading={pay.isPending} disabled={payment.amount <= 0} onClick={() => pay.mutate()}>Record payment</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <div className="space-y-1.5"><Label>{label}</Label>{children}</div>; }
