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
import { format } from "date-fns";
export default function AdminExams() {
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
    term: "",
    start_date: "",
    end_date: "",
    academic_year_id: "1"
  });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["admin", "exams"],
    queryFn: Admin.exams
  }) as any;
  const exams = Array.isArray(data) ? data : data?.data || [];
  const create = useMutation({
    mutationFn: (body: any) => Admin.createExam(body),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["admin", "exams"]
      });
      toast({
        title: "Exam created"
      });
      setOpen(false);
      setForm({
        name: "",
        term: "",
        start_date: "",
        end_date: "",
        academic_year_id: "1"
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
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Exams</h1>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Name</TableHead>
              <TableHead>Term</TableHead>
              <TableHead>Start Date</TableHead>
              <TableHead>End Date</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={5} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : exams.length === 0 ? <TableRow>
                <TableCell colSpan={5} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : exams.map((exam: any) => <TableRow key={exam.id}>
                  <TableCell className="font-medium">{exam.name}</TableCell>
                  <TableCell>{exam.term}</TableCell>
                  <TableCell>{exam.start_date ? format(new Date(exam.start_date), 'MMM d, yyyy') : '-'}</TableCell>
                  <TableCell>{exam.end_date ? format(new Date(exam.end_date), 'MMM d, yyyy') : '-'}</TableCell>
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
            <DialogTitle>{t("common.create")} Exam</DialogTitle>
            <DialogDescription>Add a new exam period.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label>Name</Label>
              <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} placeholder="e.g. Midterms" />
            </div>
            <div className="space-y-1.5">
              <Label>Term</Label>
              <Input value={form.term} onChange={e => setForm({
              ...form,
              term: e.target.value
            })} placeholder="e.g. Fall" />
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