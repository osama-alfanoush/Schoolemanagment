import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Check, PackageCheck, Plus, Send, X } from "lucide-react";
import { Procurement, type PurchaseOrder, type PurchaseOrderItem, type Supplier, type WarehouseItem } from "@/lib/api";
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

type DraftLine = { warehouse_item_id: number; quantity_ordered: number; unit: string; unit_cost: number; warehouse_location?: string };
const today = () => new Date().toISOString().slice(0, 10);

export default function PurchaseOrders() {
  const { user } = useAuth();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [status, setStatus] = useState("");
  const [page, setPage] = useState(1);
  const [createOpen, setCreateOpen] = useState(false);
  const [receiveOpen, setReceiveOpen] = useState(false);
  const [selected, setSelected] = useState<PurchaseOrder | null>(null);
  const [form, setForm] = useState<{ supplier_id: number; order_date: string; expected_date: string; tax: number; notes: string; items: DraftLine[] }>({ supplier_id: 0, order_date: today(), expected_date: "", tax: 0, notes: "", items: [{ warehouse_item_id: 0, quantity_ordered: 1, unit: "unit", unit_cost: 0 }] });
  const [receiveLines, setReceiveLines] = useState<Array<{ purchase_order_item_id: number; quantity_received: number; unit_cost: number; warehouse_location: string }>>([]);

  const ordersQuery = useQuery({ queryKey: ["purchase-orders", status, page], queryFn: () => Procurement.purchaseOrders({ status, page, per_page: 20 }) });
  const ordersMeta = paginationMeta(ordersQuery.data);
  const suppliersQuery = useQuery({ queryKey: ["procurement-suppliers", "options"], queryFn: () => Procurement.suppliers({ is_active: true, per_page: 100 }) });
  const itemsQuery = useQuery({ queryKey: ["procurement-items"], queryFn: () => Procurement.items({ is_active: true, per_page: 100 }) });
  const suppliers = toArray<Supplier>(suppliersQuery.data);
  const items = toArray<WarehouseItem>(itemsQuery.data);
  const canCreate = hasPermission(user, "procurement.create");
  const canEdit = hasPermission(user, "procurement.edit");
  const canApprove = hasPermission(user, "procurement.approve");
  const canReceive = hasPermission(user, "procurement.receive");

  const refresh = () => { void qc.invalidateQueries({ queryKey: ["purchase-orders"] }); void qc.invalidateQueries({ queryKey: ["procurement-dashboard"] }); };
  const action = useMutation({
    mutationFn: async ({ kind, row }: { kind: "submit" | "approve" | "cancel"; row: PurchaseOrder }) => kind === "submit" ? Procurement.submitPurchaseOrder(row.id) : kind === "approve" ? Procurement.approvePurchaseOrder(row.id) : Procurement.cancelPurchaseOrder(row.id),
    onSuccess: () => { refresh(); toast({ title: "Purchase order updated" }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Update failed", description: e.message }),
  });
  const create = useMutation({
    mutationFn: () => Procurement.createPurchaseOrder({ ...form, expected_date: form.expected_date || undefined }),
    onSuccess: () => { refresh(); setCreateOpen(false); toast({ title: "Purchase order created" }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Creation failed", description: e.message }),
  });
  const receive = useMutation({
    mutationFn: () => Procurement.receivePurchaseOrder(selected!.id, { lines: receiveLines.filter(line => line.quantity_received > 0) }),
    onSuccess: () => { refresh(); void qc.invalidateQueries({ queryKey: ["goods-receipts"] }); setReceiveOpen(false); toast({ title: "Goods receipt posted", description: "Inventory quantities and costs were updated." }); },
    onError: (e: Error) => toast({ variant: "destructive", title: "Receiving failed", description: e.message }),
  });

  const total = useMemo(() => form.items.reduce((sum, line) => sum + Number(line.quantity_ordered) * Number(line.unit_cost), 0) + Number(form.tax), [form]);
  const openReceive = async (row: PurchaseOrder) => {
    try {
      const detail = await Procurement.purchaseOrder(row.id);
      setSelected(detail);
      setReceiveLines((detail.items ?? []).map(line => ({ purchase_order_item_id: line.id, quantity_received: Math.max(0, Number(line.quantity_ordered) - Number(line.quantity_received)), unit_cost: Number(line.unit_cost), warehouse_location: line.warehouse_location ?? "" })));
      setReceiveOpen(true);
    } catch (e) { toast({ variant: "destructive", title: "Could not load order", description: (e as Error).message }); }
  };

  return <div className="space-y-6">
    <PageHeader icon="PO" title="Purchase orders" subtitle="Create, approve, and receive supplier orders"
      actions={canCreate ? <BrandButton leftIcon={<Plus className="h-4 w-4" />} onClick={() => setCreateOpen(true)}>New purchase order</BrandButton> : undefined} />
    <DataTable<PurchaseOrder> title="Orders" data={toArray<PurchaseOrder>(ordersQuery.data)} isLoading={ordersQuery.isLoading} error={(ordersQuery.error as Error)?.message}
      toolbar={<div className="max-w-xs"><Label htmlFor="po-status" className="sr-only">Filter by status</Label><select id="po-status" className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={status} onChange={e => { setStatus(e.target.value); setPage(1); }}><option value="">All statuses</option>{["draft", "pending_approval", "approved", "partially_received", "received", "cancelled"].map(s => <option key={s} value={s}>{s.replaceAll("_", " ")}</option>)}</select></div>}
      columns={[
        { key: "po_no", label: "PO number", sortable: true, render: v => <span className="font-semibold">{v}</span> },
        { key: "supplier.name", label: "Supplier", sortable: true },
        { key: "status", label: "Status", render: v => <StatusBadge status={v} /> },
        { key: "order_date", label: "Order date", render: dateText, hide: "sm" },
        { key: "expected_date", label: "Expected", render: dateText, hide: "md" },
        { key: "total", label: "Total", align: "right", sortable: true, render: money },
      ]}
      rowActions={[
        { label: "Submit", icon: <Send className="h-4 w-4" />, show: row => canEdit && row.status === "draft", onClick: row => action.mutate({ kind: "submit", row }) },
        { label: "Approve", icon: <Check className="h-4 w-4" />, show: row => canApprove && row.status === "pending_approval", onClick: row => action.mutate({ kind: "approve", row }) },
        { label: "Receive", icon: <PackageCheck className="h-4 w-4" />, show: row => canReceive && ["approved", "partially_received"].includes(row.status), onClick: row => void openReceive(row) },
        { label: "Cancel", icon: <X className="h-4 w-4" />, variant: "danger", show: row => canApprove && ["draft", "pending_approval", "approved"].includes(row.status), onClick: row => action.mutate({ kind: "cancel", row }) },
      ]}
      pagination={{ currentPage: page, lastPage: ordersMeta.last_page ?? 1, total: ordersMeta.total ?? 0, perPage: 20, onPageChange: setPage }}
      emptyMessage="No purchase orders found." />

    <Dialog open={createOpen} onOpenChange={setCreateOpen}><DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto"><DialogHeader><DialogTitle>New purchase order</DialogTitle><DialogDescription>Add one or more warehouse items. The order begins as a draft.</DialogDescription></DialogHeader>
      <div className="grid gap-4 sm:grid-cols-2">
        <Field label="Supplier"><select className="h-9 w-full rounded-md border border-input bg-card px-3 text-sm" value={form.supplier_id} onChange={e => setForm({ ...form, supplier_id: Number(e.target.value) })}><option value={0}>Select supplier</option>{suppliers.map(s => <option key={s.id} value={s.id}>{s.code} — {s.name}</option>)}</select></Field>
        <Field label="Order date"><Input type="date" value={form.order_date} onChange={e => setForm({ ...form, order_date: e.target.value })} /></Field>
        <Field label="Expected date"><Input type="date" min={form.order_date} value={form.expected_date} onChange={e => setForm({ ...form, expected_date: e.target.value })} /></Field>
        <Field label="Tax"><Input type="number" min="0" step="0.01" value={form.tax} onChange={e => setForm({ ...form, tax: Number(e.target.value) })} /></Field>
      </div>
      <div className="space-y-3"><div className="flex items-center justify-between"><Label>Order lines</Label><BrandButton size="sm" variant="secondary" onClick={() => setForm({ ...form, items: [...form.items, { warehouse_item_id: 0, quantity_ordered: 1, unit: "unit", unit_cost: 0 }] })}>Add line</BrandButton></div>
        {form.items.map((line, index) => <LineEditor key={index} line={line} items={items} onChange={next => setForm({ ...form, items: form.items.map((item, i) => i === index ? next : item) })} onRemove={() => setForm({ ...form, items: form.items.filter((_, i) => i !== index) })} />)}
      </div>
      <div className="flex justify-end text-lg font-bold">Total: {money(total)}</div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setCreateOpen(false)}>Cancel</BrandButton><BrandButton isLoading={create.isPending} disabled={!form.supplier_id || !form.items.length || form.items.some(i => !i.warehouse_item_id || i.quantity_ordered <= 0)} onClick={() => create.mutate()}>Create draft</BrandButton></DialogFooter>
    </DialogContent></Dialog>

    <Dialog open={receiveOpen} onOpenChange={setReceiveOpen}><DialogContent className="max-w-3xl"><DialogHeader><DialogTitle>Receive {selected?.po_no}</DialogTitle><DialogDescription>Enter this delivery's quantities. Posting updates inventory and supplier balances.</DialogDescription></DialogHeader>
      <div className="space-y-3">{selected?.items?.map((line, index) => <ReceiveLine key={line.id} line={line} value={receiveLines[index]} onChange={next => setReceiveLines(receiveLines.map((item, i) => i === index ? next : item))} />)}</div>
      <DialogFooter><BrandButton variant="ghost" onClick={() => setReceiveOpen(false)}>Cancel</BrandButton><BrandButton isLoading={receive.isPending} disabled={!receiveLines.some(line => line.quantity_received > 0)} onClick={() => receive.mutate()}>Post goods receipt</BrandButton></DialogFooter>
    </DialogContent></Dialog>
  </div>;
}

function Field({ label, children }: { label: string; children: React.ReactNode }) { return <div className="space-y-1.5"><Label>{label}</Label>{children}</div>; }
function LineEditor({ line, items, onChange, onRemove }: { line: DraftLine; items: WarehouseItem[]; onChange: (line: DraftLine) => void; onRemove: () => void }) {
  return <div className="grid gap-2 rounded-xl border border-border p-3 md:grid-cols-[2fr_1fr_1fr_1fr_auto]">
    <select aria-label="Warehouse item" className="h-9 rounded-md border border-input bg-card px-3 text-sm" value={line.warehouse_item_id} onChange={e => { const item = items.find(i => i.id === Number(e.target.value)); onChange({ ...line, warehouse_item_id: Number(e.target.value), unit: item?.unit ?? line.unit, unit_cost: Number(item?.last_unit_cost ?? item?.unit_cost ?? line.unit_cost) }); }}><option value={0}>Select item</option>{items.map(item => <option key={item.id} value={item.id}>{item.sku} — {item.name}</option>)}</select>
    <Input aria-label="Quantity" type="number" min="0.01" step="0.01" value={line.quantity_ordered} onChange={e => onChange({ ...line, quantity_ordered: Number(e.target.value) })} />
    <Input aria-label="Unit" value={line.unit} onChange={e => onChange({ ...line, unit: e.target.value })} />
    <Input aria-label="Unit cost" type="number" min="0" step="0.01" value={line.unit_cost} onChange={e => onChange({ ...line, unit_cost: Number(e.target.value) })} />
    <BrandButton aria-label="Remove line" variant="ghost" size="sm" onClick={onRemove}><X className="h-4 w-4" /></BrandButton>
  </div>;
}
function ReceiveLine({ line, value, onChange }: { line: PurchaseOrderItem; value?: { purchase_order_item_id: number; quantity_received: number; unit_cost: number; warehouse_location: string }; onChange: (value: { purchase_order_item_id: number; quantity_received: number; unit_cost: number; warehouse_location: string }) => void }) {
  if (!value) return null;
  const remaining = Number(line.quantity_ordered) - Number(line.quantity_received);
  const item = line.warehouse_item ?? line.warehouseItem;
  return <div className="grid gap-3 rounded-xl border border-border p-3 sm:grid-cols-[2fr_1fr_1fr]"><div><p className="font-semibold">{item?.name ?? line.description ?? `Line ${line.id}`}</p><p className="text-xs text-muted-foreground">Remaining: {remaining} {line.unit}</p></div><Field label="Receive now"><Input type="number" min="0" max={remaining} step="0.01" value={value.quantity_received} onChange={e => onChange({ ...value, quantity_received: Number(e.target.value) })} /></Field><Field label="Actual unit cost"><Input type="number" min="0" step="0.01" value={value.unit_cost} onChange={e => onChange({ ...value, unit_cost: Number(e.target.value) })} /></Field></div>;
}
