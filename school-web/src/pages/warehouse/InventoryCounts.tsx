import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Warehouse, InventoryCount } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { renderDate } from "@/lib/tableHelpers";
import { toArray } from "@/lib/response";

export default function InventoryCounts() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const today = new Date().toISOString().slice(0, 10);
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({
    count_type: "monthly" as "monthly" | "annual" | "spot",
    count_date: today,
    item_id: "",
    physical_qty: "",
    notes: "",
  });

  const { data, isLoading, error } = useQuery({
    queryKey: ["warehouse-inventory-counts"],
    queryFn: () => Warehouse.inventoryCounts(),
  });

  const createCount = useMutation({
    mutationFn: () => Warehouse.createInventoryCount({
      count_type: form.count_type,
      count_date: form.count_date,
      items: [{
        item_id: Number(form.item_id),
        physical_qty: Number(form.physical_qty),
        notes: form.notes || undefined,
      }],
    }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["warehouse-inventory-counts"] });
      toast({ title: "Inventory count saved" });
      setOpen(false);
      setForm({ count_type: "monthly", count_date: today, item_id: "", physical_qty: "", notes: "" });
    },
    onError: (e: unknown) =>
      toast({ variant: "destructive", title: "Save failed", description: (e as Error)?.message }),
  });

  const counts = toArray<InventoryCount>(data);

  return (
    <div className="space-y-6">
      <PageHeader
        icon="IC"
        title="Inventory Counts"
        subtitle="Record physical stock counts and audit history"
        actions={<BrandButton variant="primary" onClick={() => setOpen(true)}>New Count</BrandButton>}
      />

      <DataTable<InventoryCount>
        title="Count Sessions"
        columns={[
          { key: "count_type", label: "Type", sortable: true },
          { key: "count_date", label: "Date", render: (v) => renderDate(v), sortable: true },
          { key: "id", label: "Reference", render: (v) => `COUNT-${v}`, hide: "md" },
        ]}
        data={counts}
        isLoading={isLoading}
        error={(error as Error)?.message}
        emptyMessage="No inventory counts recorded."
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>New Inventory Count</DialogTitle>
            <DialogDescription>Start with one counted item. More lines can be added from item detail workflows later.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label>Type</Label>
                <select
                  className="w-full h-10 rounded-md border border-input bg-background px-3 py-2 text-sm"
                  value={form.count_type}
                  onChange={(e) => setForm({ ...form, count_type: e.target.value as typeof form.count_type })}
                >
                  <option value="monthly">Monthly</option>
                  <option value="annual">Annual</option>
                  <option value="spot">Spot</option>
                </select>
              </div>
              <div className="space-y-1.5">
                <Label>Date</Label>
                <Input
                  type="date"
                  value={form.count_date}
                  onChange={(e) => setForm({ ...form, count_date: e.target.value })}
                />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label>Item ID</Label>
                <Input
                  type="number"
                  value={form.item_id}
                  onChange={(e) => setForm({ ...form, item_id: e.target.value })}
                  placeholder="Inventory item id"
                />
              </div>
              <div className="space-y-1.5">
                <Label>Physical Quantity</Label>
                <Input
                  type="number"
                  value={form.physical_qty}
                  onChange={(e) => setForm({ ...form, physical_qty: e.target.value })}
                />
              </div>
            </div>
            <div className="space-y-1.5">
              <Label>Notes</Label>
              <Input
                value={form.notes}
                onChange={(e) => setForm({ ...form, notes: e.target.value })}
                placeholder="Optional"
              />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>Cancel</BrandButton>
            <BrandButton
              variant="primary"
              onClick={() => createCount.mutate()}
              disabled={createCount.isPending || !form.item_id || !form.physical_qty || !form.count_date}
            >
              {createCount.isPending ? "Saving..." : "Save Count"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
