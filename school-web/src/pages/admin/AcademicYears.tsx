import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Plus } from "lucide-react";
import { format } from "date-fns";

const EMPTY = { name: "", start_date: "", end_date: "", is_current: false };

export default function AdminAcademicYears() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [form, setForm] = useState({ ...EMPTY });

  const { data, isLoading } = useQuery({ queryKey: ["admin", "academic-years"], queryFn: Admin.academicYears }) as any;
  const years = Array.isArray(data) ? data : data?.data ?? [];

  const reset = () => { setForm({ ...EMPTY }); setEditingId(null); };

  const save = useMutation({
    mutationFn: (body: any) => {
      const payload = {
        name: body.name,
        start_date: body.start_date,
        end_date: body.end_date,
        is_current: body.is_current,
      };
      return editingId ? Admin.updateAcademicYear(editingId, payload) : Admin.createAcademicYear(payload);
    },
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["admin", "academic-years"] });
      toast({ title: editingId ? "Academic year updated" : "Academic year created" });
      setOpen(false);
      reset();
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const openCreate = () => { reset(); setOpen(true); };
  const openEdit = (year: any) => {
    setEditingId(year.id);
    setForm({
      name: year.name ?? "",
      start_date: year.start_date ? String(year.start_date).slice(0, 10) : "",
      end_date: year.end_date ? String(year.end_date).slice(0, 10) : "",
      is_current: Boolean(year.is_current),
    });
    setOpen(true);
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Academic Years</h1>
        <BrandButton onClick={openCreate}>
          <Plus className="me-2 h-4 w-4" />
          {t("common.create")} Academic Year
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead>Start Date</TableHead>
              <TableHead>End Date</TableHead>
              <TableHead>Status</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              <TableRow><TableCell colSpan={5} className="text-center p-8">{t("common.loading")}</TableCell></TableRow>
            ) : years.length === 0 ? (
              <TableRow><TableCell colSpan={5} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell></TableRow>
            ) : (
              years.map((year: any) => (
                <TableRow key={year.id}>
                  <TableCell className="font-medium">{year.name}</TableCell>
                  <TableCell>{year.start_date ? format(new Date(year.start_date), "MMM d, yyyy") : "-"}</TableCell>
                  <TableCell>{year.end_date ? format(new Date(year.end_date), "MMM d, yyyy") : "-"}</TableCell>
                  <TableCell>
                    <Badge variant={year.is_current ? "default" : "secondary"}>
                      {year.is_current ? "Current" : "Inactive"}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-right">
                    <BrandButton variant="ghost" size="sm" onClick={() => openEdit(year)}>{t("common.edit")}</BrandButton>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <Dialog open={open} onOpenChange={(v) => { setOpen(v); if (!v) reset(); }}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{editingId ? t("common.edit") : t("common.create")} Academic Year</DialogTitle>
            <DialogDescription>{editingId ? "Update this academic year." : "Add a new academic year."}</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="ay-name">Name</Label>
              <Input id="ay-name" value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} placeholder="e.g. 2026-2027" />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="ay-start">Start Date</Label>
              <Input id="ay-start" type="date" value={form.start_date} onChange={(e) => setForm({ ...form, start_date: e.target.value })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="ay-end">End Date</Label>
              <Input id="ay-end" type="date" value={form.end_date} onChange={(e) => setForm({ ...form, end_date: e.target.value })} />
            </div>
            <label className="flex items-center gap-2 text-sm">
              <input type="checkbox" checked={form.is_current} onChange={(e) => setForm({ ...form, is_current: e.target.checked })} />
              Set as the current academic year
            </label>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => { setOpen(false); reset(); }}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => save.mutate(form)} disabled={save.isPending || !form.name || !form.start_date}>
              {save.isPending ? t("common.loading") : editingId ? t("common.save") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
