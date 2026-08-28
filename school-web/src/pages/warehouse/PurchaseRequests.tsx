import { useState } from "react";
import { useTranslation } from "react-i18next";
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
  const { t } = useTranslation();
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
    onSuccess: () => { void qc.invalidateQueries({ queryKey: ["purchase-requests"] }); toast({ title: t("warehouse.requestUpdated") }); },
    onError: (e: any) => toast({ variant: "destructive", title: t("warehouse.failed"), description: e?.data?.message ?? e?.message }),
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
      toast({ title: t("warehouse.requestSubmitted") });
      setOpen(false);
      setForm({ ...EMPTY });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("warehouse.requestsTitle")} subtitle={t("warehouse.requestsSubtitle")} actions={<BrandButton variant="primary" onClick={() => { setForm({ ...EMPTY }); setOpen(true); }}>+ {t("warehouse.newRequest")}</BrandButton>} />

      <DataTable
        title={t("warehouse.requestsTitle")}
        columns={[
          { key: "request_no", label: t("warehouse.requestNo"), render: (v) => <span className="font-mono text-xs text-muted-foreground">{v ?? "-"}</span> },
          { key: "item", label: t("warehouse.item"), render: (_, row) => row.item?.name ?? "—" },
          { key: "requested_by", label: t("warehouse.requestedBy"), render: (_, row) => renderUser(row.requestedBy?.name ?? "-", ""), hide: "md" as const },
          { key: "quantity_requested", label: "Qty", align: "center" as const, render: (v, row) => <span className="text-sm font-semibold text-foreground">{Number(v ?? 0)} {row.unit ?? ""}</span> },
          { key: "estimated_cost", label: t("warehouse.estCost"), render: (v) => v ? renderCurrency(v) : <span className="text-muted-foreground/70 text-xs">TBD</span>, align: "right" as const },
          { key: "created_at", label: t("warehouse.requestedOn"), render: (v) => renderDate(v), sortable: true },
          { key: "status", label: t("common.status"), render: (v) => renderStatus(v ?? "pending") },
        ]}
        data={requests}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder={t("warehouse.searchRequests")}
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "status", label: t("common.status"), options: [
                { value: "pending", label: t("status.pending") }, { value: "approved", label: t("status.approved") }, { value: "rejected", label: t("status.rejected") }, { value: "purchased", label: t("warehouse.purchased") },
              ]},
            ]}
          />
        }
        rowActions={[
          { label: t("warehouse.approve"), icon: <CheckIcon />, onClick: (row) => reviewMutation.mutate({ id: row.id, data: { status: "approved" } }), show: (row) => row.status === "pending" },
          { label: t("warehouse.reject"), icon: <XIcon />, onClick: (row) => reviewMutation.mutate({ id: row.id, data: { status: "rejected" } }), variant: "danger" as const, show: (row) => row.status === "pending" },
        ]}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? requests.length, perPage: 20, onPageChange: setPage }}
        emptyMessage={t("warehouse.noRequests")}
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("warehouse.newRequestTitle")}</DialogTitle>
            <DialogDescription>{t("warehouse.newRequestHint")}</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>{t("warehouse.item")}</Label>
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
                <Label>{t("warehouse.quantity")}</Label>
                <Input type="number" step="0.01" value={form.quantity_requested} onChange={e => setForm({ ...form, quantity_requested: e.target.value })} />
              </div>
              <div className="space-y-1.5 flex-1">
                <Label>{t("warehouse.unitLabel")}</Label>
                <Input value={form.unit} onChange={e => setForm({ ...form, unit: e.target.value })} placeholder="e.g. Boxes" />
              </div>
            </div>
            <div className="space-y-1.5">
              <Label>{t("warehouse.estCost")}</Label>
              <Input type="number" step="0.01" value={form.estimated_cost} onChange={e => setForm({ ...form, estimated_cost: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>{t("warehouse.justification")}</Label>
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
