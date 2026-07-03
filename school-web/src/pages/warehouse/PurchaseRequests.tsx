import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Warehouse, PurchaseRequest, WarehouseItem } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { renderDate, renderCurrency, renderStatus, renderUser } from "@/lib/tableHelpers";
import { CheckIcon, XIcon } from "@/lib/icons";
import { useToast } from "@/hooks/use-toast";
import { paginationMeta, toArray } from "@/lib/response";

const EMPTY = { item_id: "", quantity_requested: "", unit: "", justification: "", estimated_cost: "" };

export default function PurchaseRequests() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState<any>({ ...EMPTY });

  const { data, isLoading } = useQuery({
    queryKey: ["purchase-requests", activeFilters, page],
    queryFn: () => Warehouse.purchaseRequests({ status: activeFilters.status || undefined, page, per_page: 20 }),
  }) as any;
  const { data: itemsData } = useQuery({
    queryKey: ["warehouse-items", "all-for-pr"],
    queryFn: () => Warehouse.items({ per_page: 100 }),
  }) as any;

  const requests = toArray<PurchaseRequest>(data);
  const items = toArray<WarehouseItem>(itemsData);
  const meta = paginationMeta(data);

  const reviewMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: any }) => Warehouse.reviewPurchaseRequest(id, data),
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["purchase-requests"] }); toast({ title: "Request updated" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const create = useMutation({
    mutationFn: () => Warehouse.createPurchaseRequest({
      item_id: Number(form.item_id),
      quantity_requested: Number(form.quantity_requested),
      unit: form.unit,
      justification: form.justification || undefined,
      estimated_cost: form.estimated_cost ? Number(form.estimated_cost) : undefined,
    }),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["purchase-requests"] });
      toast({ title: "Request submitted" });
      setOpen(false);
      setForm({ ...EMPTY });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Purchase Requests" subtitle="Procurement requests and approvals" actions={<BrandButton variant="primary" onClick={() => { setForm({ ...EMPTY }); setOpen(true); }}>+ New Request</BrandButton>} />

      <DataTable
        title="Purchase Requests"
        columns={[
          { key: "request_no", label: "Request #", render: (v) => <span className="font-mono text-xs text-muted-foreground">{v ?? "-"}</span> },
          { key: "item", label: "Item", render: (_, row) => row.item?.name ?? "—" },
          { key: "requested_by", label: "Requested By", render: (_, row) => renderUser(row.requestedBy?.name ?? "-", ""), hide: "md" as const },
          { key: "quantity_requested", label: "Qty", align: "center" as const, render: (v, row) => <span className="text-sm font-semibold text-foreground">{Number(v ?? 0)} {row.unit ?? ""}</span> },
          { key: "estimated_cost", label: "Est. Cost", render: (v) => v ? renderCurrency(v) : <span className="text-muted-foreground/70 text-xs">TBD</span>, align: "right" as const },
          { key: "created_at", label: "Requested", render: (v) => renderDate(v), sortable: true },
          { key: "status", label: "Status", render: (v) => renderStatus(v ?? "pending") },
        ]}
        data={requests}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder="Search purchase requests..."
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "status", label: "Status", options: [
                { value: "pending", label: "Pending" }, { value: "approved", label: "Approved" }, { value: "rejected", label: "Rejected" }, { value: "purchased", label: "Purchased" },
              ]},
            ]}
          />
        }
        rowActions={[
          { label: "Approve", icon: <CheckIcon />, onClick: (row) => reviewMutation.mutate({ id: row.id, data: { status: "approved" } }), show: (row) => row.status === "pending" },
          { label: "Reject", icon: <XIcon />, onClick: (row) => reviewMutation.mutate({ id: row.id, data: { status: "rejected" } }), variant: "danger" as const, show: (row) => row.status === "pending" },
        ]}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? requests.length, perPage: 20, onPageChange: setPage }}
        emptyMessage="No purchase requests found."
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>New Purchase Request</DialogTitle>
            <DialogDescription>Request the procurement of a warehouse item.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Item</Label>
              <select className="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={form.item_id} onChange={e => {
                const it = items.find((x: any) => String(x.id) === e.target.value);
                setForm({ ...form, item_id: e.target.value, unit: form.unit || (it as any)?.unit || "" });
              }}>
                <option value="">Select item…</option>
                {items.map((it: any) => <option key={it.id} value={it.id}>{it.name}{it.sku ? ` (${it.sku})` : ""}</option>)}
              </select>
            </div>
            <div className="flex gap-3">
              <div className="space-y-1.5 flex-1">
                <Label>Quantity</Label>
                <Input type="number" step="0.01" value={form.quantity_requested} onChange={e => setForm({ ...form, quantity_requested: e.target.value })} />
              </div>
              <div className="space-y-1.5 flex-1">
                <Label>Unit</Label>
                <Input value={form.unit} onChange={e => setForm({ ...form, unit: e.target.value })} placeholder="e.g. Boxes" />
              </div>
            </div>
            <div className="space-y-1.5">
              <Label>Estimated Cost (optional)</Label>
              <Input type="number" step="0.01" value={form.estimated_cost} onChange={e => setForm({ ...form, estimated_cost: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Justification</Label>
              <Input value={form.justification} onChange={e => setForm({ ...form, justification: e.target.value })} placeholder="Why is this needed?" />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>Cancel</BrandButton>
            <BrandButton variant="primary" onClick={() => create.mutate()} disabled={create.isPending || !form.item_id || !form.quantity_requested || !form.unit}>
              {create.isPending ? "Saving..." : "Submit Request"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
