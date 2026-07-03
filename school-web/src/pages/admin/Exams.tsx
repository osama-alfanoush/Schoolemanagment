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

const EMPTY = { class_room_id: "", subject_id: "", title: "", exam_date: "", start_time: "09:00", end_time: "10:30", room: "" };

export default function AdminExams() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({ ...EMPTY });

  const { data, isLoading } = useQuery({ queryKey: ["admin", "exams"], queryFn: Admin.exams }) as any;
  const { data: classesData } = useQuery({ queryKey: ["admin", "classes"], queryFn: Admin.classes }) as any;
  const { data: subjectsData } = useQuery({ queryKey: ["admin", "subjects"], queryFn: Admin.subjects }) as any;

  const exams = Array.isArray(data) ? data : data?.data ?? [];
  const classes = Array.isArray(classesData) ? classesData : classesData?.data ?? [];
  const subjects = Array.isArray(subjectsData) ? subjectsData : subjectsData?.data ?? [];

  const create = useMutation({
    mutationFn: (body: any) =>
      Admin.createExam({
        class_room_id: Number(body.class_room_id),
        subject_id: Number(body.subject_id),
        title: body.title,
        exam_date: body.exam_date,
        start_time: body.start_time,
        end_time: body.end_time,
        room: body.room || undefined,
      }),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["admin", "exams"] });
      toast({ title: "Exam created" });
      setOpen(false);
      setForm({ ...EMPTY });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const valid = form.class_room_id && form.subject_id && form.title && form.exam_date && form.start_time && form.end_time;

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Exams</h1>
        <BrandButton onClick={() => setOpen(true)}>
          <Plus className="me-2 h-4 w-4" />
          {t("common.create")} Exam
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Title</TableHead>
              <TableHead>Class</TableHead>
              <TableHead>Subject</TableHead>
              <TableHead>Date</TableHead>
              <TableHead>Time</TableHead>
              <TableHead>Room</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              <TableRow><TableCell colSpan={6} className="text-center p-8">{t("common.loading")}</TableCell></TableRow>
            ) : exams.length === 0 ? (
              <TableRow><TableCell colSpan={6} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell></TableRow>
            ) : (
              exams.map((exam: any) => (
                <TableRow key={exam.id}>
                  <TableCell className="font-medium">{exam.title}</TableCell>
                  <TableCell>{exam.class_room?.name ?? exam.classRoom?.name ?? "-"}</TableCell>
                  <TableCell>{exam.subject?.name ?? "-"}</TableCell>
                  <TableCell>{exam.exam_date ? format(new Date(exam.exam_date), "MMM d, yyyy") : "-"}</TableCell>
                  <TableCell>{exam.start_time ? `${String(exam.start_time).slice(0, 5)} – ${String(exam.end_time).slice(0, 5)}` : "-"}</TableCell>
                  <TableCell>{exam.room ?? "-"}</TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("common.create")} Exam</DialogTitle>
            <DialogDescription>Schedule an exam for a class and subject.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="exam-title">Title</Label>
              <Input id="exam-title" value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} placeholder="e.g. Midterm — Algebra" />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label htmlFor="exam-class">Class</Label>
                <select id="exam-class" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.class_room_id} onChange={(e) => setForm({ ...form, class_room_id: e.target.value })}>
                  <option value="">Select…</option>
                  {classes.map((c: any) => <option key={c.id} value={c.id}>{c.name}</option>)}
                </select>
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="exam-subject">Subject</Label>
                <select id="exam-subject" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.subject_id} onChange={(e) => setForm({ ...form, subject_id: e.target.value })}>
                  <option value="">Select…</option>
                  {subjects.map((s: any) => <option key={s.id} value={s.id}>{s.name}</option>)}
                </select>
              </div>
            </div>
            <div className="grid grid-cols-3 gap-3">
              <div className="space-y-1.5">
                <Label htmlFor="exam-date">Date</Label>
                <Input id="exam-date" type="date" value={form.exam_date} onChange={(e) => setForm({ ...form, exam_date: e.target.value })} />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="exam-start">Start</Label>
                <Input id="exam-start" type="time" value={form.start_time} onChange={(e) => setForm({ ...form, start_time: e.target.value })} />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="exam-end">End</Label>
                <Input id="exam-end" type="time" value={form.end_time} onChange={(e) => setForm({ ...form, end_time: e.target.value })} />
              </div>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="exam-room">Room (optional)</Label>
              <Input id="exam-room" value={form.room} onChange={(e) => setForm({ ...form, room: e.target.value })} placeholder="e.g. Hall A" />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => create.mutate(form)} disabled={create.isPending || !valid}>
              {create.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
