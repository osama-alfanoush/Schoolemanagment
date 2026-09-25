import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Plus, Search } from "lucide-react";
import { Procurement, type CreateSupplierRequest, type Supplier } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { paginationMeta, toArray } from "@/lib/response";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import BrandBadge from "@/components/ui/BrandBadge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { hasPermission, money } from "./shared";

const initial: CreateSupplierRequest = { name: "", phone: "", contact_person: "", email: "", address: "", payment_terms: "net_30" };

export default function Suppliers() {
  const { t } = useTranslation();
  const { user } = useAuth();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [q, setQ] = useState("");
  const [page, setPage] = useState(1);
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState<CreateSupplierRequest>(initial);
  const canCreate = hasPermission(user, "procurement.create");
  const { data, isLoading, error } = useQuery({ queryKey: ["procurement-suppliers", q, page], queryFn: () => Procurement.suppliers({ q, page, per_page: 20 }) });
  const meta = paginationMeta(data);
  const create = useMutation({
    mutationFn: () => Procurement.createSupplier(form),
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["procurement-suppliers"] }); void qc.invalidateQueries({ queryKey: ["procurement-dashboard"] }); setOpen(false); setForm(initial); toast({ title: t("procurementPages.supplierCreated") }); },
    onError: (e: Error) => toast({ variant: "destructive", title: t("procurementPages.supplierFailed"), description: e.message }),
  });

  return <div className="space-y-6">
    <PageHeader icon="SU" title={t("procurementPages.suppliers")} subtitle={t("procurementPages.suppliersSubtitle")}
      actions={canCreate ? <BrandButton leftIcon={<Plus className="h-4 w-4" />} onClick={() => setOpen(true)}>Add supplier</BrandButton> : undefined} />
    <DataTable<Supplier> title={t("procurementPages.supplierDirectory")} data={toArray<Supplier>(data)} isLoading={isLoading} error={(error as Error)?.message}
      toolbar={<div className="relative max-w-sm"><Search className="absolute start-3 top-2.5 h-4 w-4 text-muted-foreground" /><Input aria-label={t("procurementPages.searchSuppliers")} className="ps-9" value={q} onChange={e => { setQ(e.target.value); setPage(1); }} placeholder={t("procurementPages.searchSuppliersHint")} /></div>}
      columns={[
        { key: "code", label: t("procurementPages.code"), sortable: true },
        { key: "name", label: t("procurementPages.supplier"), sortable: true, render: (v, row) => <div><p className="font-semibold">{v}</p><p className="text-xs text-muted-foreground">{row.contact_person || t("procurementPages.noContactPerson")}</p></div> },
        { key: "phone", label: t("procurementPages.phone") },
        { key: "email", label: t("procurementPages.email"), render: v => v || "—", hide: "sm" },
        { key: "account.payment_terms", label: "Terms", render: v => String(v ?? "—").replace("_", " ") },
        { key: "account.balance", label: t("procurementPages.balance"), align: "right", sortable: true, render: v => money(v) },
        { key: "is_active", label: t("common.status"), render: v => <BrandBadge variant={v ? "success" : "default"}>{v ? t("status.active") : t("status.inactive")}</BrandBadge> },
      ]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }}
      emptyMessage={t("procurementPages.noSuppliers")} />

    <Dialog open={open} onOpenChange={setOpen}><DialogContent className="max-w-2xl"><DialogHeader><DialogTitle>Add supplier</DialogTitle><DialogDescription>Create a supplier and its accounts-payable ledger.</DialogDescription></DialogHeader>
      <div className="grid gap-4 sm:grid-cols-2">
        <Field label={t("procurementPages.supplierName")}><Input required value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} /></Field>
        <Field label={t("procurementPages.phone")}><Input required value={form.phone} onChange={e => setForm({ ...form, phone: e.target.value })} /></Field>
        <Field label={t("procurementPages.contactPerson")}><Input value={form.contact_person} onChange={e => setForm({ ...form, contact_person: e.target.value })} /></Field>
        <Field label={t("procurementPages.email")}><Input type="email" value={form.email} onChange={e => setForm({ ...form, email: e.target.value })} /></Field>
        <Field label={t("procurementPages.paymentTerms")}><select className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={form.payment_terms} onChange={e => setForm({ ...form, payment_terms: e.target.value as CreateSupplierRequest["payment_terms"] })}><option value="cash">Cash</option><option value="net_15">Net 15</option><option value="net_30">Net 30</option><option value="net_60">Net 60</option></select></Field>
        <Field label={t("procurementPages.creditLimit")}><Input type="number" min="0" value={form.credit_limit ?? ""} onChange={e => setForm({ ...form, credit_limit: e.target.value ? Number(e.target.value) : undefined })} /></Field>
        <div className="sm:col-span-2"><Field label={t("procurementPages.address")}><Input value={form.address} onChange={e => setForm({ ...form, address: e.target.value })} /></Field></div>
      </div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setOpen(false)}>Cancel</BrandButton><BrandButton disabled={!form.name.trim() || !form.phone.trim()} isLoading={create.isPending} onClick={() => create.mutate()}>Create supplier</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <div className="space-y-1.5"><Label>{label}</Label>{children}</div>; }
