import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Plus } from "lucide-react";
export default function FinanceFeeStructures() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const EMPTY = { name: "", grade: "", amount: "", billing_cycle: "yearly", is_active: true };
  const [form, setForm] = useState<any>({ ...EMPTY });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["finance", "fee-structures"],
    queryFn: Finance.feeStructures
  }) as any;
  const structures = Array.isArray(data) ? data : data?.data ?? [];
  const reset = () => { setEditingId(null); setForm({ ...EMPTY }); };
  const openCreate = () => { reset(); setOpen(true); };
  const openEdit = (fs: any) => {
    setEditingId(fs.id);
    setForm({
      name: fs.name ?? "",
      grade: fs.grade ?? "",
      amount: String(fs.amount ?? ""),
      billing_cycle: fs.billing_cycle ?? "yearly",
      is_active: fs.is_active ?? true,
    });
    setOpen(true);
  };
  const save = useMutation({
    mutationFn: (body: any) => {
      const payload: any = {
        name: body.name,
        amount: Number(body.amount),
        billing_cycle: body.billing_cycle,
        grade: body.grade === "" ? null : String(body.grade),
        is_active: body.is_active,
      };
      return editingId ? Finance.updateFeeStructure(editingId, payload) : Finance.createFeeStructure(payload);
    },
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["finance", "fee-structures"] });
      toast({ title: editingId ? "Fee structure updated" : "Fee structure created" });
      setOpen(false);
      reset();
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed",
      description: e?.data?.message ?? e?.message
    })
  });
  const remove = useMutation({
    mutationFn: (id: number) => Finance.deleteFeeStructure(id),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["finance", "fee-structures"] });
      toast({ title: "Fee structure deleted" });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.feeStructures")}</h1>
        <BrandButton onClick={openCreate}>
          <Plus className="me-2 h-4 w-4" />
          Create Structure
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead>Grade</TableHead>
              <TableHead>Billing Cycle</TableHead>
              <TableHead>Amount</TableHead>
              <TableHead>Status</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={6} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : structures.length === 0 ? <TableRow>
                <TableCell colSpan={6} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : structures.map((fs: any) => <TableRow key={fs.id}>
                  <TableCell className="font-medium">{fs.name}</TableCell>
                  <TableCell>{fs.grade != null && fs.grade !== "" ? `Grade ${fs.grade}` : "All grades"}</TableCell>
                  <TableCell className="capitalize">{fs.billing_cycle ?? "-"}</TableCell>
                  <TableCell className="font-medium">${parseFloat(fs.amount ?? 0).toFixed(2)}</TableCell>
                  <TableCell>{fs.is_active ? "Active" : "Inactive"}</TableCell>
                  <TableCell className="text-right space-x-1">
                    <BrandButton variant="ghost" size="sm" onClick={() => openEdit(fs)}>{t("common.edit")}</BrandButton>
                    <BrandButton variant="ghost" size="sm" onClick={() => { if (confirm("Delete this fee structure?")) remove.mutate(fs.id); }}>{t("common.delete")}</BrandButton>
                  </TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>

      <Dialog open={open} onOpenChange={(v) => { setOpen(v); if (!v) reset(); }}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{editingId ? "Edit" : "Create"} Fee Structure</DialogTitle>
            <DialogDescription>Define a fee, its billing cycle and an optional grade (leave grade empty to apply to all grades).</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name</Label>
              <Input value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} placeholder="e.g. Tuition Fee" />
            </div>
            <div className="space-y-1.5">
              <Label>Grade (optional)</Label>
              <Input type="number" value={form.grade} onChange={e => setForm({ ...form, grade: e.target.value })} placeholder="e.g. 10 — leave empty for all" />
            </div>
            <div className="space-y-1.5">
              <Label>Billing Cycle</Label>
              <select
                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                value={form.billing_cycle}
                onChange={e => setForm({ ...form, billing_cycle: e.target.value })}
              >
                <option value="monthly">Monthly</option>
                <option value="semester">Semester</option>
                <option value="yearly">Yearly</option>
                <option value="one-time">One-time</option>
              </select>
            </div>
            <div className="space-y-1.5">
              <Label>Amount</Label>
              <Input type="number" step="0.01" value={form.amount} onChange={e => setForm({ ...form, amount: e.target.value })} placeholder="e.g. 500.00" />
            </div>
            {editingId && (
              <label className="flex items-center gap-2 text-sm">
                <input type="checkbox" checked={!!form.is_active} onChange={e => setForm({ ...form, is_active: e.target.checked })} />
                Active
              </label>
            )}
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => { setOpen(false); reset(); }}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => save.mutate(form)} disabled={save.isPending || !form.name || !form.amount}>
              {save.isPending ? t("common.loading") : editingId ? t("common.save") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}