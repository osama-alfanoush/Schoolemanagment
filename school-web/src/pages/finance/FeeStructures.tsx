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
  const [form, setForm] = useState({
    name: "",
    grade_level: "",
    amount: "",
    description: ""
  });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["finance", "fee-structures"],
    queryFn: Finance.feeStructures
  }) as any;
  const structures = data ?? [];
  const create = useMutation({
    mutationFn: (body: any) => Finance.createFeeStructure({
      ...body,
      amount: Number(body.amount),
      grade: Number(body.grade_level),
      billing_cycle: 'yearly'
    }),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["finance", "fee-structures"]
      });
      toast({
        title: "Fee structure created"
      });
      setOpen(false);
      setForm({
        name: "",
        grade_level: "",
        amount: "",
        description: ""
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
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.feeStructures")}</h1>
        <BrandButton onClick={() => setOpen(true)}>
          <Plus className="me-2 h-4 w-4" />
          Create Structure
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead>Grade Level</TableHead>
              <TableHead>Amount</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={4} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : structures.length === 0 ? <TableRow>
                <TableCell colSpan={4} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : structures.map((fs: any) => <TableRow key={fs.id}>
                  <TableCell className="font-medium">{fs.name}</TableCell>
                  <TableCell>Grade {fs.grade_level}</TableCell>
                  <TableCell className="font-medium">${parseFloat(fs.amount).toFixed(2)}</TableCell>
                  <TableCell className="text-right">
                    <BrandButton variant="ghost" size="sm">{t("common.edit")}</BrandButton>
                  </TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Create Fee Structure</DialogTitle>
            <DialogDescription>Define a new fee structure for a specific grade level.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name</Label>
              <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} placeholder="e.g. Tuition Fee" />
            </div>
            <div className="space-y-1.5">
              <Label>Grade Level</Label>
              <Input type="number" value={form.grade_level} onChange={e => setForm({
              ...form,
              grade_level: e.target.value
            })} placeholder="e.g. 10" />
            </div>
            <div className="space-y-1.5">
              <Label>Amount</Label>
              <Input type="number" step="0.01" value={form.amount} onChange={e => setForm({
              ...form,
              amount: e.target.value
            })} placeholder="e.g. 500.00" />
            </div>
            <div className="space-y-1.5">
              <Label>Description</Label>
              <Input value={form.description} onChange={e => setForm({
              ...form,
              description: e.target.value
            })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => create.mutate(form)} disabled={create.isPending || !form.name || !form.amount}>
              {create.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}