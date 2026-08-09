import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Eye } from "lucide-react";
import { Procurement, type GoodsReceipt } from "@/lib/api";
import { paginationMeta, toArray } from "@/lib/response";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { dateText, money, StatusBadge } from "./shared";

export default function GoodsReceipts() {
  const { toast } = useToast();
  const [selected, setSelected] = useState<GoodsReceipt | null>(null);
  const [page, setPage] = useState(1);
  const { data, isLoading, error } = useQuery({ queryKey: ["goods-receipts", page], queryFn: () => Procurement.goodsReceipts({ page, per_page: 20 }) });
  const meta = paginationMeta(data);

  const openDetail = async (row: GoodsReceipt) => {
    try { setSelected(await Procurement.goodsReceipt(row.id)); }
    catch (e) { toast({ variant: "destructive", title: "Could not load receipt", description: (e as Error).message }); }
  };
  const lines = selected?.items ?? [];
  const total = lines.reduce((sum, line) => sum + Number(line.quantity_received) * Number(line.unit_cost), 0);

  return <div className="space-y-6">
    <PageHeader icon="GR" title="Goods receipts" subtitle="Deliveries posted against purchase orders — each receipt updated inventory automatically" />
    <DataTable<GoodsReceipt> title="Receipts" data={toArray<GoodsReceipt>(data)} isLoading={isLoading} error={(error as Error)?.message}
      columns={[
        { key: "grn_no", label: "GRN number", sortable: true, render: v => <span className="font-semibold">{v}</span> },
        { key: "purchase_order.po_no", label: "Purchase order" },
        { key: "purchase_order.supplier.name", label: "Supplier", hide: "sm" },
        { key: "received_at", label: "Received", sortable: true, render: dateText },
        { key: "received_by.name", label: "Received by", hide: "md" },
        { key: "status", label: "Status", render: v => <StatusBadge status={v} /> },
      ]}
      rowActions={[{ label: "View lines", icon: <Eye className="h-4 w-4" />, onClick: row => void openDetail(row) }]}
      pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? 0, perPage: 20, onPageChange: setPage }}
      emptyMessage="No goods receipts yet. Receive an approved purchase order to create one." />

    <Dialog open={!!selected} onOpenChange={open => !open && setSelected(null)}>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle>{selected?.grn_no}</DialogTitle>
          <DialogDescription>
            PO {selected?.purchase_order?.po_no} — {selected?.purchase_order?.supplier?.name} · {dateText(selected?.received_at)}
          </DialogDescription>
        </DialogHeader>
        <div className="space-y-2">
          {lines.map(line => {
            const item = line.purchase_order_item?.warehouse_item;
            return <div key={line.id} className="flex items-center justify-between rounded-xl border border-border p-3">
              <div>
                <p className="font-semibold">{item?.name ?? line.purchase_order_item?.description ?? `Line ${line.id}`}</p>
                <p className="text-xs text-muted-foreground">{item?.sku ?? ""}</p>
              </div>
              <div className="text-end">
                <p className="text-sm">{Number(line.quantity_received)} × {money(line.unit_cost)}</p>
                <p className="text-sm font-semibold">{money(Number(line.quantity_received) * Number(line.unit_cost))}</p>
              </div>
            </div>;
          })}
          {selected?.notes && <p className="text-sm text-muted-foreground">Notes: {selected.notes}</p>}
          <div className="flex justify-end text-lg font-bold">Total: {money(total)}</div>
        </div>
        <DialogFooter><BrandButton variant="ghost" onClick={() => setSelected(null)}>Close</BrandButton></DialogFooter>
      </DialogContent>
    </Dialog>
  </div>;
}
