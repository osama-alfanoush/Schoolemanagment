import { useState } from "react";
import { useTranslation } from "react-i18next";
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
  const { t } = useTranslation();
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
      void qc.invalidateQueries({ queryKey: ["warehouse-categories"] });
      toast({ title: t("warehouse.categoryCreated") });
      setOpen(false);
      setForm({ name: "", description: "" });
    },
    onError: (e: unknown) =>
      toast({ variant: "destructive", title: t("warehouse.createFailed"), description: (e as Error)?.message }),
  });

  const categories = toArray<WarehouseCategory>(data);

  return (
    <div className="space-y-6">
      <PageHeader
        icon="CA"
        title={t("warehouse.categoriesTitle")}
        subtitle={t("warehouse.categoriesSubtitle")}
        actions={<BrandButton variant="primary" onClick={() => setOpen(true)}>{t("warehouse.addCategory")}</BrandButton>}
      />

      <DataTable<WarehouseCategory>
        title={t("warehouse.categories")}
        columns={[
          { key: "name", label: t("warehouse.nameLabel"), sortable: true },
          { key: "description", label: t("warehouse.descriptionLabel"), render: (v) => v || t("warehouse.noDescription") },
          { key: "items_count", label: t("warehouse.itemsCount"), align: "center", render: (v) => v ?? 0, sortable: true },
        ]}
        data={categories}
        isLoading={isLoading}
        error={(error as Error)?.message}
        emptyMessage={t("warehouse.noCategories")}
      />

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("warehouse.addCategory")}</DialogTitle>
            <DialogDescription>{t("warehouse.newCategory")}</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>{t("warehouse.nameLabel")}</Label>
              <Input
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                placeholder={t("warehouse.itemNamePlaceholder")}
              />
            </div>
            <div className="space-y-1.5">
              <Label>{t("warehouse.descriptionLabel")}</Label>
              <Input
                value={form.description}
                onChange={(e) => setForm({ ...form, description: e.target.value })}
                placeholder={t("warehouse.descriptionOptional")}
              />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>{t("warehouse.cancel")}</BrandButton>
            <BrandButton
              variant="primary"
              onClick={() => createCategory.mutate()}
              disabled={createCategory.isPending || !form.name}
            >
              {createCategory.isPending ? t("warehouse.saving") : t("warehouse.saveCategory")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
