import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Plus } from "lucide-react";
export default function AdminSubjects() {
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
    name_ar: "",
    code: "",
    description: ""
  });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["admin", "subjects"],
    queryFn: Admin.subjects
  }) as any;
  const subjects = data ?? [];
  const create = useMutation({
    mutationFn: (body: any) => Admin.createSubject(body),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["admin", "subjects"]
      });
      toast({
        title: "Subject created"
      });
      setOpen(false);
      setForm({
        name: "",
        name_ar: "",
        code: "",
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
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.subjects")}</h1>
        <BrandButton onClick={() => setOpen(true)}>
          <Plus className="me-2 h-4 w-4" />
          {t("common.create")} Subject
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Code</TableHead>
              <TableHead>Name (EN)</TableHead>
              <TableHead>Name (AR)</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={4} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : subjects.length === 0 ? <TableRow>
                <TableCell colSpan={4} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : subjects.map((sub: any) => <TableRow key={sub.id}>
                  <TableCell className="font-mono text-sm">{sub.code}</TableCell>
                  <TableCell className="font-medium">{sub.name}</TableCell>
                  <TableCell>{sub.name_ar}</TableCell>
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
            <DialogTitle>{t("common.create")} Subject</DialogTitle>
            <DialogDescription>Add a new subject.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name (EN)</Label>
              <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} placeholder="e.g. Mathematics" />
            </div>
            <div className="space-y-1.5">
              <Label>Name (AR)</Label>
              <Input value={form.name_ar} onChange={e => setForm({
              ...form,
              name_ar: e.target.value
            })} placeholder="e.g. رياضيات" />
            </div>
            <div className="space-y-1.5">
              <Label>Code</Label>
              <Input value={form.code} onChange={e => setForm({
              ...form,
              code: e.target.value
            })} placeholder="e.g. MATH101" />
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
            <BrandButton onClick={() => create.mutate(form)} disabled={create.isPending || !form.name || !form.code}>
              {create.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}