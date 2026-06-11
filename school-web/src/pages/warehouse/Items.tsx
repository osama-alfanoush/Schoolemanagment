import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Warehouse, PaginatedResponse, WarehouseItem, WarehouseCategory } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { renderCurrency, renderStatus } from "@/lib/tableHelpers";
import { EyeIcon, PencilIcon, PlusIcon } from "@/lib/icons";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { paginationMeta, toArray } from "@/lib/response";

export default function WarehouseItems() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});
  const [selectedItems, setSelectedItems] = useState<any[]>([]);

  // Dialog states
  const [createItemOpen, setCreateItemOpen] = useState(false);
  const [movementItem, setMovementItem] = useState<any>(null);

  // Forms
  const [itemForm, setItemForm] = useState({ name: "", sku: "", unit: "", unit_cost: "", minimum_stock: "", current_stock: "", category_id: "" });
  const [movementForm, setMovementForm] = useState({ type: "in", quantity: "", unit_cost: "", reference_no: "", notes: "" });

  const { data, isLoading } = useQuery({
    queryKey: ["warehouse-items", search, activeFilters, page],
    queryFn: () => Warehouse.items({ search, ...activeFilters, page }),
  }) as any;
  const { data: catData } = useQuery({
    queryKey: ["warehouse-categories"],
    queryFn: () => Warehouse.categories(),
  }) as any;
  const items = toArray<WarehouseItem>(data);
  const categories = toArray<WarehouseCategory>(catData);
  const meta = paginationMeta(data);

  const createItem = useMutation({
    mutationFn: (body: any) => Warehouse.createItem({ 
      ...body, 
      unit_cost: Number(body.unit_cost), 
      min_stock_qty: Number(body.minimum_stock),
      category_id: Number(body.category_id)
    }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["warehouse-items"] });
      toast({ title: "Item created" });
      setCreateItemOpen(false);
      setItemForm({ name: "", sku: "", unit: "", unit_cost: "", minimum_stock: "", current_stock: "", category_id: "" });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.message }),
  });

  const createMovement = useMutation({
    mutationFn: (body: any) => Warehouse.createMovement({ 
      ...body, 
      warehouse_item_id: movementItem.id,
      quantity: Number(body.quantity),
      unit_cost: body.unit_cost ? Number(body.unit_cost) : undefined
    }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["warehouse-items"] });
      toast({ title: "Movement recorded" });
      setMovementItem(null);
      setMovementForm({ type: "in", quantity: "", unit_cost: "", reference_no: "", notes: "" });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.message }),
  });

  return (
    <div className="space-y-6">
      <PageHeader 
        icon="📦" 
        title="Inventory Items" 
        subtitle="Stock items, quantities, and categories" 
        actions={<BrandButton variant="primary" onClick={() => setCreateItemOpen(true)}>+ Add Item</BrandButton>} 
      />

      <DataTable
        title="All Items"
        columns={[
          { key: "name", label: "Item", sortable: true, render: (v, row) => (
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 rounded-xl bg-muted/50 flex items-center justify-center text-lg flex-shrink-0">{row.category_icon ?? "📦"}</div>
              <div>
                <div className="text-sm font-medium text-foreground">{v}</div>
                <div className="text-xs text-muted-foreground/70">{row.sku ?? row.barcode ?? "—"}</div>
              </div>
            </div>
          )},
          { key: "category_name", label: "Category", sortable: true },
          { key: "current_stock", label: "In Stock", align: "center" as const, sortable: true, render: (v, row) => (
            <div className="text-center">
              <span className={`text-sm font-bold ${v <= 0 ? "text-red-600" : v <= (row.minimum_stock ?? 5) ? "text-amber-600" : "text-foreground"}`}>{v ?? 0}</span>
              <div className="text-xs text-muted-foreground/70">{row.unit ?? "units"}</div>
            </div>
          )},
          { key: "minimum_stock", label: "Min Stock", align: "center" as const, render: (v) => <span className="text-sm text-muted-foreground">{v ?? 0}</span> },
          { key: "unit_cost", label: "Unit Cost", render: (v) => renderCurrency(v ?? 0), align: "right" as const, sortable: true },
          { key: "status", label: "Status", render: (v, row) => {
            const stock = row.current_stock ?? 0;
            const min = row.minimum_stock ?? 5;
            return renderStatus(stock <= 0 ? "out-stock" : stock <= min ? "low-stock" : "in-stock");
          }},
        ]}
        data={items}
        isLoading={isLoading}
        toolbar={
          <SearchAndFilter
            placeholder="Search items by name or SKU..."
            value={search}
            onChange={setSearch}
            activeFilters={activeFilters}
            onFilterChange={(key, value) => setActiveFilters((prev) => ({ ...prev, [key]: value === "__all__" ? "" : value }))}
            filters={[
              { key: "category", label: "Category", options: categories.map((c: any) => ({ value: String(c.id), label: c.name })) },
              { key: "status", label: "Stock Status", options: [
                { value: "in-stock", label: "In Stock" }, { value: "low-stock", label: "Low Stock" }, { value: "out-stock", label: "Out of Stock" },
              ]},
            ]}
          />
        }
        rowActions={[
          { label: "View", icon: <EyeIcon />, onClick: () => {} },
          { label: "Edit", icon: <PencilIcon />, onClick: () => {} },
          { label: "Record Movement", icon: <PlusIcon />, onClick: (row) => setMovementItem(row) },
        ]}
        selectable
        onSelectionChange={setSelectedItems}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? items.length, perPage: 20, onPageChange: setPage }}
        emptyMessage="No items found."
      />

      <Dialog open={createItemOpen} onOpenChange={setCreateItemOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add Inventory Item</DialogTitle>
            <DialogDescription>Create a new item in the warehouse.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Item Name</Label>
              <Input value={itemForm.name} onChange={e => setItemForm({...itemForm, name: e.target.value})} placeholder="e.g. Printer Paper" />
            </div>
            <div className="space-y-1.5">
              <Label>Category</Label>
              <select className="w-full flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={itemForm.category_id} onChange={e => setItemForm({...itemForm, category_id: e.target.value})}>
                <option value="">Select Category</option>
                {categories.map((c: any) => <option key={c.id} value={c.id}>{c.name}</option>)}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>SKU / Barcode</Label>
              <Input value={itemForm.sku} onChange={e => setItemForm({...itemForm, sku: e.target.value})} placeholder="e.g. PP-001" />
            </div>
            <div className="flex gap-3">
              <div className="space-y-1.5 flex-1">
                <Label>Current Stock</Label>
                <Input type="number" value={itemForm.current_stock} onChange={e => setItemForm({...itemForm, current_stock: e.target.value})} />
              </div>
              <div className="space-y-1.5 flex-1">
                <Label>Min Stock</Label>
                <Input type="number" value={itemForm.minimum_stock} onChange={e => setItemForm({...itemForm, minimum_stock: e.target.value})} />
              </div>
            </div>
            <div className="flex gap-3">
              <div className="space-y-1.5 flex-1">
                <Label>Unit of Measure</Label>
                <Input value={itemForm.unit} onChange={e => setItemForm({...itemForm, unit: e.target.value})} placeholder="e.g. Reams, Boxes" />
              </div>
              <div className="space-y-1.5 flex-1">
                <Label>Unit Cost</Label>
                <Input type="number" step="0.01" value={itemForm.unit_cost} onChange={e => setItemForm({...itemForm, unit_cost: e.target.value})} />
              </div>
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setCreateItemOpen(false)}>Cancel</BrandButton>
            <BrandButton variant="primary" onClick={() => createItem.mutate(itemForm)} disabled={createItem.isPending || !itemForm.name || !itemForm.category_id}>
              {createItem.isPending ? "Loading..." : "Save Item"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!movementItem} onOpenChange={open => !open && setMovementItem(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Record Movement</DialogTitle>
            <DialogDescription>Update stock for {movementItem?.name}</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Type</Label>
              <select className="w-full flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={movementForm.type} onChange={e => setMovementForm({...movementForm, type: e.target.value})}>
                <option value="in">Stock In</option>
                <option value="out">Stock Out</option>
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>Quantity</Label>
              <Input type="number" value={movementForm.quantity} onChange={e => setMovementForm({...movementForm, quantity: e.target.value})} />
            </div>
            <div className="space-y-1.5">
              <Label>Reference No (Optional)</Label>
              <Input value={movementForm.reference_no} onChange={e => setMovementForm({...movementForm, reference_no: e.target.value})} placeholder="e.g. PO-12345" />
            </div>
            <div className="space-y-1.5">
              <Label>Notes</Label>
              <Input value={movementForm.notes} onChange={e => setMovementForm({...movementForm, notes: e.target.value})} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setMovementItem(null)}>Cancel</BrandButton>
            <BrandButton variant="primary" onClick={() => createMovement.mutate(movementForm)} disabled={createMovement.isPending || !movementForm.quantity}>
              {createMovement.isPending ? "Loading..." : "Record"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
