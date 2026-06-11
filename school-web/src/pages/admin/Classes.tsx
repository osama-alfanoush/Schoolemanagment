import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Plus } from "lucide-react";
export default function AdminClasses() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({
    name: "",
    grade_level: "",
    section: "",
    capacity: ""
  });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["admin", "classes"],
    queryFn: Admin.classes
  }) as any;
  const classes = data ?? [];
  const create = useMutation({
    mutationFn: (body: any) => Admin.createClass({
      ...body,
      grade: Number(body.grade_level),
      capacity: Number(body.capacity)
    }),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["admin", "classes"]
      });
      toast({
        title: "Class created"
      });
      setOpen(false);
      setForm({
        name: "",
        grade_level: "",
        section: "",
        capacity: ""
      });
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed",
      description: e?.message
    })
  });
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.classes")}</h1>
        <BrandButton onClick={() => setOpen(true)}>
          <Plus className="me-2 h-4 w-4" />
          {t("common.create")} Class
        </BrandButton>
      </div>

      <div>
        <DataTable
          columns={[
            { key: "name", label: "Name", sortable: true },
            { key: "grade_level", label: "Grade Level", sortable: true, render: (val) => `Grade ${val}` },
            { key: "section", label: "Section", render: (val) => <Badge variant="outline">{val}</Badge> },
            { key: "capacity", label: "Capacity", render: (_, row) => `${row.students_count || 0} / ${row.capacity}` },
          ]}
          data={classes}
          isLoading={isLoading}
          emptyMessage={t("common.empty")}
          rowActions={[
            { label: t("common.edit"), onClick: () => {}, variant: "default" }
          ]}
        />
      </div>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("common.create")} Class</DialogTitle>
            <DialogDescription>Add a new class room.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name</Label>
              <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} placeholder="e.g. 10A" />
            </div>
            <div className="space-y-1.5">
              <Label>Grade Level</Label>
              <Input type="number" value={form.grade_level} onChange={e => setForm({
              ...form,
              grade_level: e.target.value
            })} placeholder="e.g. 10" />
            </div>
            <div className="space-y-1.5">
              <Label>Section</Label>
              <Input value={form.section} onChange={e => setForm({
              ...form,
              section: e.target.value
            })} placeholder="e.g. A" />
            </div>
            <div className="space-y-1.5">
              <Label>Capacity</Label>
              <Input type="number" value={form.capacity} onChange={e => setForm({
              ...form,
              capacity: e.target.value
            })} placeholder="e.g. 30" />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => create.mutate(form)} disabled={create.isPending || !form.name}>
              {create.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}