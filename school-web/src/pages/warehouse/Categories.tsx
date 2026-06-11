import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Warehouse, WarehouseCategory } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandButton from "@/components/ui/BrandButton";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function Categories() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({ name: "", description: "" });

  const { data, isLoading, error } = useQuery({
    queryKey: ["warehouse-categories"],
    queryFn: () => Warehouse.categories(),
  });

  const createCategory = useMutation({
    mutationFn: () => Warehouse.createCategory({
      name: form.name,
      description: form.description || undefined,
    }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["warehouse-categories"] });
      toast({ title: "Category created" });
      setOpen(false);
      setForm({ name: "", description: "" });
    },
    onError: (e: unknown) =>
      toast({ variant: "destructive", title: "Create failed", description: (e as Error)?.message }),
  });

  const categories = toArray<WarehouseCategory>(data);

  return (
    <div className="space-y-6">
      <PageHeader
        icon="CA"
        title="Warehouse Categories"
        subtitle="Group inventory items for cleaner stock tracking"
        actions={<BrandButton variant="primary" onClick={() => setOpen(true)}>Add Category</BrandButton>}
      />

      <DataTable<WarehouseCategory>
        title="Categories"
        columns={[
          { key: "name", label: "Name", sortable: true },
          { key: "description", label: "Description", render: (v) => v || "No description" },
          { key: "items_count", label: "Items", align: "center", render: (v) => v ?? 0, sortable: true },
        ]}
        data={categories}
        isLoading={isLoading}
        error={(error as Error)?.message}
        emptyMessage="No warehouse categories found."
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add Category</DialogTitle>
            <DialogDescription>Create a category for warehouse inventory.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name</Label>
              <Input
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                placeholder="e.g. Stationery"
              />
            </div>
            <div className="space-y-1.5">
              <Label>Description</Label>
              <Input
                value={form.description}
                onChange={(e) => setForm({ ...form, description: e.target.value })}
                placeholder="Optional"
              />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>Cancel</BrandButton>
            <BrandButton
              variant="primary"
              onClick={() => createCategory.mutate()}
              disabled={createCategory.isPending || !form.name}
            >
              {createCategory.isPending ? "Saving..." : "Save Category"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
