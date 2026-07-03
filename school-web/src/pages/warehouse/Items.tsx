import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Warehouse, WarehouseItem, WarehouseCategory } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandButton from "@/components/ui/BrandButton";
import { renderStatus } from "@/lib/tableHelpers";
import { PencilIcon, PlusIcon } from "@/lib/icons";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { paginationMeta, toArray } from "@/lib/response";

const EMPTY_ITEM = { name: "", sku: "", unit: "", min_stock_qty: "", location: "", description: "", category_id: "" };
const EMPTY_MOVEMENT = { movement_type: "in", quantity: "", reference_no: "", reason: "" };

export default function WarehouseItems() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const [createItemOpen, setCreateItemOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [movementItem, setMovementItem] = useState<any>(null);

  const [itemForm, setItemForm] = useState<any>({ ...EMPTY_ITEM });
  const [movementForm, setMovementForm] = useState<any>({ ...EMPTY_MOVEMENT });

  const { data, isLoading } = useQuery({
    queryKey: ["warehouse-items", search, activeFilters, page],
    queryFn: () => Warehouse.items({ search, category_id: activeFilters.category || undefined, low_stock_only: activeFilters.status === "low-stock" ? "1" : undefined, page }),
  }) as any;
  const { data: catData } = useQuery({
    queryKey: ["warehouse-categories"],
    queryFn: () => Warehouse.categories(),
  }) as any;
  const items = toArray<WarehouseItem>(data);
  const categories = toArray<WarehouseCategory>(catData);
  const meta = paginationMeta(data);

  const invalidate = () => void qc.invalidateQueries({ queryKey: ["warehouse-items"] });

  const buildItemPayload = (body: any) => {
    const payload: any = {
      name: body.name,
      category_id: Number(body.category_id),
      unit: body.unit,
      min_stock_qty: Number(body.min_stock_qty || 0),
    };
    if (body.sku) payload.sku = body.sku;
    if (body.location) payload.location = body.location;
    if (body.description) payload.description = body.description;
    return payload;
  };

  const createItem = useMutation({
    mutationFn: (body: any) => Warehouse.createItem(buildItemPayload(body)),
    onSuccess: () => {
      invalidate();
      toast({ title: "Item created" });
      setCreateItemOpen(false);
      setItemForm({ ...EMPTY_ITEM });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const updateItem = useMutation({
    mutationFn: (body: any) => Warehouse.updateItem(editingItem.id, buildItemPayload(body)),
    onSuccess: () => {
      invalidate();
      toast({ title: "Item updated" });
      setEditingItem(null);
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const createMovement = useMutation({
    mutationFn: (body: any) => Warehouse.createMovement({
      item_id: movementItem.id,
      movement_type: body.movement_type,
      quantity: Number(body.quantity),
      reference_no: body.reference_no || undefined,
      reason: body.reason || undefined,
    }),
    onSuccess: () => {
      invalidate();
      toast({ title: "Movement recorded" });
      setMovementItem(null);
      setMovementForm({ ...EMPTY_MOVEMENT });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const openEdit = (row: any) => {
    setEditingItem(row);
    setItemForm({
      name: row.name ?? "",
      sku: row.sku ?? "",
      unit: row.unit ?? "",
      min_stock_qty: String(row.min_stock_qty ?? ""),
      location: row.location ?? "",
      description: row.description ?? "",
      category_id: String(row.category_id ?? ""),
    });
  };

  const itemFields = (
    <div className="space-y-3">
      <div className="space-y-1.5">
        <Label>Item Name</Label>
        <Input value={itemForm.name} onChange={e => setItemForm({ ...itemForm, name: e.target.value })} placeholder="e.g. Printer Paper" />
      </div>
      <div className="space-y-1.5">
        <Label>Category</Label>
        <select className="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={itemForm.category_id} onChange={e => setItemForm({ ...itemForm, category_id: e.target.value })}>
          <option value="">Select Category</option>
          {categories.map((c: any) => <option key={c.id} value={c.id}>{c.name}</option>)}
        </select>
      </div>
      <div className="space-y-1.5">
        <Label>SKU (auto-generated if empty)</Label>
        <Input value={itemForm.sku} onChange={e => setItemForm({ ...itemForm, sku: e.target.value })} placeholder="e.g. PP-001" />
      </div>
      <div className="flex gap-3">
        <div className="space-y-1.5 flex-1">
          <Label>Unit of Measure</Label>
          <Input value={itemForm.unit} onChange={e => setItemForm({ ...itemForm, unit: e.target.value })} placeholder="e.g. Reams, Boxes" />
        </div>
        <div className="space-y-1.5 flex-1">
          <Label>Min Stock</Label>
          <Input type="number" value={itemForm.min_stock_qty} onChange={e => setItemForm({ ...itemForm, min_stock_qty: e.target.value })} />
        </div>
      </div>
      <div className="space-y-1.5">
        <Label>Location (optional)</Label>
        <Input value={itemForm.location} onChange={e => setItemForm({ ...itemForm, location: e.target.value })} placeholder="e.g. Shelf A3" />
      </div>
    </div>
  );

  return (
    <div className="space-y-6">
      <PageHeader
        icon="📦"
        title="Inventory Items"
        subtitle="Stock items, quantities, and categories"
        actions={<BrandButton variant="primary" onClick={() => { setItemForm({ ...EMPTY_ITEM }); setCreateItemOpen(true); }}>+ Add Item</BrandButton>}
      />

      <DataTable
        title="All Items"
        columns={[
          { key: "name", label: "Item", sortable: true, render: (v, row) => (
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 rounded-xl bg-muted/50 flex items-center justify-center text-lg flex-shrink-0">📦</div>
              <div>
                <div className="text-sm font-medium text-foreground">{v}</div>
                <div className="text-xs text-muted-foreground/70">{row.sku ?? "—"}</div>
              </div>
            </div>
          )},
          { key: "category", label: "Category", render: (_, row) => row.category?.name ?? "—" },
          { key: "current_qty", label: "In Stock", align: "center" as const, sortable: true, render: (v, row) => (
            <div className="text-center">
              <span className={`text-sm font-bold ${Number(v) <= 0 ? "text-red-600" : Number(v) <= Number(row.min_stock_qty ?? 0) ? "text-amber-600" : "text-foreground"}`}>{Number(v ?? 0)}</span>
              <div className="text-xs text-muted-foreground/70">{row.unit ?? "units"}</div>
            </div>
          )},
          { key: "min_stock_qty", label: "Min Stock", align: "center" as const, render: (v) => <span className="text-sm text-muted-foreground">{Number(v ?? 0)}</span> },
          { key: "location", label: "Location", render: (v) => v ?? "—" },
          { key: "status", label: "Status", render: (_, row) => {
            const stock = Number(row.current_qty ?? 0);
            const min = Number(row.min_stock_qty ?? 0);
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
                { value: "low-stock", label: "Low / Out of Stock" },
              ]},
            ]}
          />
        }
        rowActions={[
          { label: "Edit", icon: <PencilIcon />, onClick: (row) => openEdit(row) },
          { label: "Record Movement", icon: <PlusIcon />, onClick: (row) => { setMovementForm({ ...EMPTY_MOVEMENT }); setMovementItem(row); } },
        ]}
        pagination={{ currentPage: page, lastPage: meta.last_page ?? 1, total: meta.total ?? items.length, perPage: 20, onPageChange: setPage }}
        emptyMessage="No items found."
      />

      <Dialog open={createItemOpen} onOpenChange={setCreateItemOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add Inventory Item</DialogTitle>
            <DialogDescription>Create a new item. Stock starts at 0 — use “Record Movement” to add stock.</DialogDescription>
          </DialogHeader>
          {itemFields}
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setCreateItemOpen(false)}>Cancel</BrandButton>
            <BrandButton variant="primary" onClick={() => createItem.mutate(itemForm)} disabled={createItem.isPending || !itemForm.name || !itemForm.category_id || !itemForm.unit}>
              {createItem.isPending ? "Loading..." : "Save Item"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!editingItem} onOpenChange={open => !open && setEditingItem(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Edit Item</DialogTitle>
            <DialogDescription>Update item details. Quantity is changed via stock movements.</DialogDescription>
          </DialogHeader>
          {itemFields}
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setEditingItem(null)}>Cancel</BrandButton>
            <BrandButton variant="primary" onClick={() => updateItem.mutate(itemForm)} disabled={updateItem.isPending || !itemForm.name || !itemForm.category_id || !itemForm.unit}>
              {updateItem.isPending ? "Loading..." : "Save Changes"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <Dialog open={!!movementItem} onOpenChange={open => !open && setMovementItem(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Record Movement</DialogTitle>
            <DialogDescription>Update stock for {movementItem?.name} (current: {Number(movementItem?.current_qty ?? 0)} {movementItem?.unit})</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Type</Label>
              <select className="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm" value={movementForm.movement_type} onChange={e => setMovementForm({ ...movementForm, movement_type: e.target.value })}>
                <option value="in">Stock In</option>
                <option value="out">Stock Out</option>
                <option value="adjustment">Adjustment</option>
                <option value="return">Return</option>
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>Quantity</Label>
              <Input type="number" step="0.01" value={movementForm.quantity} onChange={e => setMovementForm({ ...movementForm, quantity: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label>Reference No (Optional)</Label>
              <Input value={movementForm.reference_no} onChange={e => setMovementForm({ ...movementForm, reference_no: e.target.value })} placeholder="e.g. PO-12345" />
            </div>
            <div className="space-y-1.5">
              <Label>Reason / Notes</Label>
              <Input value={movementForm.reason} onChange={e => setMovementForm({ ...movementForm, reason: e.target.value })} />
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
