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
import { Plus, BookOpen } from "lucide-react";

const EMPTY = { name: "", grade_level: "", section: "", capacity: "" };

export default function AdminClasses() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();

  const [open, setOpen] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [form, setForm] = useState({ ...EMPTY });

  // Assign-subject dialog state.
  const [subjOpen, setSubjOpen] = useState(false);
  const [subjClass, setSubjClass] = useState<{ id: number; name: string } | null>(null);
  const [assign, setAssign] = useState({ subject_id: "", teacher_user_id: "" });

  const { data, isLoading } = useQuery({ queryKey: ["admin", "classes"], queryFn: Admin.classes }) as any;
  const { data: subjectsData } = useQuery({ queryKey: ["admin", "subjects"], queryFn: Admin.subjects }) as any;
  const { data: teachersData } = useQuery({ queryKey: ["admin", "users", "teacher"], queryFn: () => Admin.users({ role: "teacher" }) }) as any;

  const classes = Array.isArray(data) ? data : data?.data ?? [];
  const subjects = Array.isArray(subjectsData) ? subjectsData : subjectsData?.data ?? [];
  const teachers = Array.isArray(teachersData)
    ? teachersData
    : Array.isArray(teachersData?.data)
      ? teachersData.data
      : teachersData?.data?.data ?? [];

  const reset = () => { setForm({ ...EMPTY }); setEditingId(null); };
  const invalidate = () => void qc.invalidateQueries({ queryKey: ["admin", "classes"] });

  const save = useMutation({
    mutationFn: (body: any) => {
      const payload: any = { name: body.name, section: body.section || undefined };
      if (body.grade_level !== "") payload.grade = String(body.grade_level);
      if (body.capacity !== "") payload.capacity = Number(body.capacity);
      return editingId ? Admin.updateClass(editingId, payload) : Admin.createClass({ ...payload, grade: Number(body.grade_level) || undefined, capacity: Number(body.capacity) || undefined });
    },
    onSuccess: () => { invalidate(); toast({ title: editingId ? "Class updated" : "Class created" }); setOpen(false); reset(); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const assignMutation = useMutation({
    mutationFn: (body: any) => Admin.assignSubjectTeacher(subjClass!.id, { subject_id: Number(body.subject_id), teacher_user_id: Number(body.teacher_user_id) } as any),
    onSuccess: () => { invalidate(); toast({ title: "Subject assigned" }); setSubjOpen(false); setAssign({ subject_id: "", teacher_user_id: "" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const openCreate = () => { reset(); setOpen(true); };
  const openEdit = (row: any) => {
    setEditingId(row.id);
    setForm({
      name: row.name ?? "",
      grade_level: String(row.grade_level ?? row.grade ?? ""),
      section: row.section ?? "",
      capacity: String(row.capacity ?? ""),
    });
    setOpen(true);
  };
  const openSubjects = (row: any) => { setSubjClass({ id: row.id, name: row.name }); setAssign({ subject_id: "", teacher_user_id: "" }); setSubjOpen(true); };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.classes")}</h1>
        <BrandButton onClick={openCreate}><Plus className="me-2 h-4 w-4" />{t("common.create")} Class</BrandButton>
      </div>

      <div>
        <DataTable
          columns={[
            { key: "name", label: "Name", sortable: true },
            { key: "grade_level", label: "Grade Level", sortable: true, render: (val, row) => `Grade ${val ?? row.grade ?? "-"}` },
            { key: "section", label: "Section", render: (val) => val ? <Badge variant="outline">{val}</Badge> : "-" },
            { key: "capacity", label: "Capacity", render: (_, row) => `${row.students_count || 0} / ${row.capacity ?? "-"}` },
          ]}
          data={classes}
          isLoading={isLoading}
          emptyMessage={t("common.empty")}
          rowActions={[
            { label: t("common.edit"), onClick: (row: any) => openEdit(row), variant: "default" },
            { label: "Subjects", icon: <BookOpen className="h-4 w-4" />, onClick: (row: any) => openSubjects(row) },
          ]}
        />
      </div>

      {/* Create / edit class */}
      <Dialog open={open} onOpenChange={(v) => { setOpen(v); if (!v) reset(); }}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{editingId ? t("common.edit") : t("common.create")} Class</DialogTitle>
            <DialogDescription>{editingId ? "Update this class room." : "Add a new class room."}</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="cls-name">Name</Label>
              <Input id="cls-name" value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} placeholder="e.g. 10A" />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="cls-grade">Grade Level</Label>
              <Input id="cls-grade" type="number" value={form.grade_level} onChange={(e) => setForm({ ...form, grade_level: e.target.value })} placeholder="e.g. 10" />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="cls-section">Section</Label>
              <Input id="cls-section" value={form.section} onChange={(e) => setForm({ ...form, section: e.target.value })} placeholder="e.g. A" />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="cls-capacity">Capacity</Label>
              <Input id="cls-capacity" type="number" value={form.capacity} onChange={(e) => setForm({ ...form, capacity: e.target.value })} placeholder="e.g. 30" />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => { setOpen(false); reset(); }}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => save.mutate(form)} disabled={save.isPending || !form.name}>
              {save.isPending ? t("common.loading") : editingId ? t("common.save") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Assign subject + teacher */}
      <Dialog open={subjOpen} onOpenChange={setSubjOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Assign Subject{subjClass ? ` — ${subjClass.name}` : ""}</DialogTitle>
            <DialogDescription>Pick a subject and the teacher who will teach it for this class. Re-assigning a subject updates its teacher.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="as-subject">Subject</Label>
              <select id="as-subject" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={assign.subject_id} onChange={(e) => setAssign({ ...assign, subject_id: e.target.value })}>
                <option value="">Select…</option>
                {subjects.map((s: any) => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="as-teacher">Teacher</Label>
              <select id="as-teacher" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={assign.teacher_user_id} onChange={(e) => setAssign({ ...assign, teacher_user_id: e.target.value })}>
                <option value="">Select…</option>
                {teachers.map((tch: any) => <option key={tch.id} value={tch.id}>{tch.name}</option>)}
              </select>
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setSubjOpen(false)}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => assignMutation.mutate(assign)} disabled={assignMutation.isPending || !assign.subject_id || !assign.teacher_user_id}>
              {assignMutation.isPending ? t("common.loading") : "Assign"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
