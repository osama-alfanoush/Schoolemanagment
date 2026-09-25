import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Warehouse, StockMovement, WarehouseItem } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { renderDate, renderUser } from "@/lib/tableHelpers";
import { paginationMeta, toArray } from "@/lib/response";

const EMPTY = { item_id: "", movement_type: "in", quantity: "", reference_no: "", reason: "" };

export default function Movements() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState<any>({ ...EMPTY });

  const { data, isLoading } = useQuery({
    queryKey: ["stock-movements", search, activeFilters, page],
    queryFn: () => Warehouse.movements({ movement_type: activeFilters.movement_type || undefined, page, per_page: 25 }),
  }) as any;
  const { data: itemsData } = useQuery({
    queryKey: ["warehouse-items", "all-for-movement"],
    queryFn: () => Warehouse.items({ per_page: 100 }),
  }) as any;
  const movements = toArray<StockMovement>(data);
  const items = toArray<WarehouseItem>(itemsData);
  const meta = paginationMeta(data);

  const record = useMutation({
    mutationFn: () => Warehouse.createMovement({
      item_id: Number(form.item_id),
      movement_type: form.movement_type,
      quantity: Number(form.quantity),
      reference_no: form.reference_no || undefined,
      reason: form.reason || undefined,
    }),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["stock-movements"] });
      void qc.invalidateQueries({ queryKey: ["warehouse-items"] });
      toast({ title: t("warehouse.movementRecorded") });
      setOpen(false);
      setForm({ ...EMPTY });
    },
    onError: (e: any) => toast({ variant: "destructive", title: t("warehouse.failed"), description: e?.data?.message ?? e?.message }),
  });

  const typeStyle: Record<string, { bg: string; text: string; label: string }> = {
    in: { bg: "#dcfce7", text: "#166534", label: t("warehouse.stockIn") },
    out: { bg: "#fee2e2", text: "#991b1b", label: t("warehouse.stockOut") },
    return: { bg: "#dbeafe", text: "#1e40af", label: t("warehouse.returned") },
    adjustment: { bg: "#fef9c3", text: "#854d0e", label: t("warehouse.adjustment") },
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("warehouse.movementsTitle")} subtitle={t("warehouse.movementsSubtitle")} actions={<BrandButton variant="primary" onClick={() => { setForm({ ...EMPTY }); setOpen(true); }}>+ {t("warehouse.recordMovement")}</BrandButton>} />

      <DataTable
        title={t("warehouse.movementHistory")}
        columns={[
          { key: "movement_type", label: t("warehouse.type"), render: (v) => {
            const cfg = typeStyle[v] ?? typeStyle.adjustment;
            return <span style={{ backgroundColor: cfg.bg, color: cfg.text, display: "inline-flex", alignItems: "center", gap: "4px", padding: "3px 10px", borderRadius: "9999px", fontSize: "11px", fontWeight: 500 }}>{cfg.label}</span>;
          }},
          { key: "item", label: t("warehouse.item"), sortable: true, render: (_, row) => (
            <div>
              <div className="text-sm font-medium text-foreground">{row.item?.name ?? "—"}</div>
              <div className="text-xs text-muted-foreground/70">{row.item?.sku ?? ""}</div>
            </div>
          )},
          { key: "quantity", label: t("warehouse.qty"), align: "center" as const, render: (v, row) => (
            <span className={`text-sm font-bold ${row.movement_type === "in" || row.movement_type === "return" ? "text-green-600" : row.movement_type === "out" ? "text-red-600" : "text-blue-600"}`}>
              {row.movement_type === "in" || row.movement_type === "return" ? "+" : row.movement_type === "out" ? "-" : ""}{Number(v ?? 0)}
            </span>
          )},
          { key: "movement_date", label: t("warehouse.date"), render: (v) => renderDate(v), sortable: true },
          { key: "performed_by", label: t("warehouse.by"), render: (_, row) => renderUser(row.performedBy?.name ?? "-", row.reason), hide: "md" as const },
          { key: "reference_no", label: t("warehouse.ref"), render: (v) => v ? <span className="font-mono text-xs text-muted-foreground/70">{v}</span> : <span className="text-muted-foreground/50">-</span>, hide: "lg" as const },
        ]}
        data={movements}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder={t("warehouse.searchMovements")}
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "movement_type", label: t("warehouse.movementType"), options: [
                { value: "in", label: t("warehouse.stockIn") }, { value: "out", label: t("warehouse.stockOut") },
                { value: "return", label: t("warehouse.returned") }, { value: "adjustment", label: t("warehouse.adjustment") },
              ]},
            ]}
          />
        }
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? movements.length, perPage: 25, onPageChange: setPage }}
        emptyMessage="No movements recorded."
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Record Stock Movement</DialogTitle>
            <DialogDescription>Add or remove stock for an item.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Item</Label>
              <select className="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={form.item_id} onChange={e => setForm({ ...form, item_id: e.target.value })}>
                <option value="">Select item…</option>
                {items.map((it: any) => <option key={it.id} value={it.id}>{it.name}{it.sku ? ` (${it.sku})` : ""}</option>)}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>Type</Label>
              <select className="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={form.movement_type} onChange={e => setForm({ ...form, movement_type: e.target.value })}>
                <option value="in">Stock In</option>
                <option value="out">Stock Out</option>
                <option value="adjustment">Adjustment</option>
                <option value="return">Return</option>
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>Quantity</Label>
              <Input type="number" step="0.01" value={form.quantity} onChange={e => setForm({ ...form, quantity: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Reference No (Optional)</Label>
              <Input value={form.reference_no} onChange={e => setForm({ ...form, reference_no: e.target.value })} placeholder="e.g. PO-12345" />
            </div>
            <div className="space-y-1.5">
              <Label>Reason / Notes</Label>
              <Input value={form.reason} onChange={e => setForm({ ...form, reason: e.target.value })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>Cancel</BrandButton>
            <BrandButton variant="primary" onClick={() => record.mutate()} disabled={record.isPending || !form.item_id || !form.quantity}>
              {record.isPending ? t("warehouse.loading") : t("warehouse.record")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
