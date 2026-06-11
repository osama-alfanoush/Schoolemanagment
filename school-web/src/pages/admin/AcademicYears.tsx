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
export default function AdminAcademicYears() {
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
    start_date: "",
    end_date: ""
  });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["admin", "academic-years"],
    queryFn: Admin.academicYears
  }) as any;
  const years = data ?? [];
  const create = useMutation({
    mutationFn: (body: any) => Admin.createAcademicYear(body),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["admin", "academic-years"]
      });
      toast({
        title: "Academic year created"
      });
      setOpen(false);
      setForm({
        name: "",
        start_date: "",
        end_date: ""
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
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Academic Years</h1>
        <BrandButton onClick={() => setOpen(true)}>
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
            {isLoading ? <TableRow>
                <TableCell colSpan={5} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : years.length === 0 ? <TableRow>
                <TableCell colSpan={5} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : years.map((year: any) => <TableRow key={year.id}>
                  <TableCell className="font-medium">{year.name}</TableCell>
                  <TableCell>{year.start_date ? format(new Date(year.start_date), 'MMM d, yyyy') : '-'}</TableCell>
                  <TableCell>{year.end_date ? format(new Date(year.end_date), 'MMM d, yyyy') : '-'}</TableCell>
                  <TableCell>
                    <Badge variant={year.is_active ? "default" : "secondary"}>
                      {year.is_active ? "Active" : "Inactive"}
                    </Badge>
                  </TableCell>
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
            <DialogTitle>{t("common.create")} Academic Year</DialogTitle>
            <DialogDescription>Add a new academic year.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name</Label>
              <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} placeholder="e.g. 2026-2027" />
            </div>
            <div className="space-y-1.5">
              <Label>Start Date</Label>
              <Input type="date" value={form.start_date} onChange={e => setForm({
              ...form,
              start_date: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label>End Date</Label>
              <Input type="date" value={form.end_date} onChange={e => setForm({
              ...form,
              end_date: e.target.value
            })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => create.mutate(form)} disabled={create.isPending || !form.name || !form.start_date}>
              {create.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}