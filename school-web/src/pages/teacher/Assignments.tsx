import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Plus, FileText, Users } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "./response";
export default function TeacherAssignments() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [createFor, setCreateFor] = useState<any>(null);
  const [form, setForm] = useState({
    title: "",
    description: "",
    due_date: "",
    subject_id: "",
    file: null as File | null
  });
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes
  }) as any;
  const classes = toArray(data);
  const create = useMutation({
    mutationFn: (fd: FormData) => Teacher.createAssignment(fd),
    onSuccess: () => {
      void qc.invalidateQueries({
        queryKey: ["teacher"]
      });
      toast({
        title: "Assignment created"
      });
      setCreateFor(null);
      setForm({
        title: "",
        description: "",
        due_date: "",
        subject_id: "",
        file: null
      });
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed",
      description: e?.message
    })
  });
  const submit = () => {
    if (!createFor) return;
    const fd = new FormData();
    fd.append("class_room_ids[]", String(createFor.id));
    fd.append("subject_id", form.subject_id);
    fd.append("title", form.title);
    fd.append("instructions", form.description);
    fd.append("due_at", form.due_date);
    if (form.file) fd.append("attachment", form.file);
    create.mutate(fd);
  };
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
        {t("nav.assignments")}
      </h1>
      <p className="text-sm text-muted-foreground">
        Pick a class to create an assignment.
      </p>

      {isLoading ? <div className="text-center text-muted-foreground py-12">
          {t("common.loading")}
        </div> : classes.length === 0 ? <div className="text-center text-muted-foreground py-12">
          {t("common.empty")}
        </div> : <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {classes.map((cls: any) => <BrandCard key={cls.id} className="hover:shadow-md transition-shadow">
              <CardHeader className="pb-3">
                <div className="flex items-start justify-between">
                  <CardTitle className="text-base">
                    {cls.name || `Class ${cls.id}`}
                  </CardTitle>
                  {cls.grade_level ? <Badge variant="outline">{cls.grade_level}</Badge> : null}
                </div>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex items-center text-sm text-muted-foreground gap-3">
                  <span className="inline-flex items-center gap-1">
                    <Users className="h-3.5 w-3.5" />
                    {cls.student_count ?? cls.students_count ?? 0}
                  </span>
                  {cls.subject?.name || toArray(cls.subjects).length > 0 ? <span className="inline-flex items-center gap-1">
                      <FileText className="h-3.5 w-3.5" />
                      {cls.subject?.name ?? toArray(cls.subjects).map((subject: any) => subject.name).filter(Boolean).join(", ")}
                    </span> : null}
                </div>
                <BrandButton size="sm" className="w-full" onClick={() => {
            const subject = cls.subject ?? toArray(cls.subjects)[0];
            setCreateFor(cls);
            setForm(f => ({
              ...f,
              subject_id: subject?.id ? String(subject.id) : ""
            }));
          }}>
                  <Plus className="h-3.5 w-3.5 me-1.5" />
                  {t("common.create")}
                </BrandButton>
              </CardContent>
            </BrandCard>)}
        </div>}

      <Dialog open={!!createFor} onOpenChange={o => !o && setCreateFor(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>New assignment</DialogTitle>
            <DialogDescription>
              {createFor?.name ?? "Class"}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="t">Title</Label>
              <Input id="t" value={form.title} onChange={e => setForm({
              ...form,
              title: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="d">Description</Label>
              <Textarea id="d" rows={3} value={form.description} onChange={e => setForm({
              ...form,
              description: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="due">Due date</Label>
              <Input id="due" type="datetime-local" value={form.due_date} onChange={e => setForm({
              ...form,
              due_date: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="sub">Subject ID</Label>
              <Input id="sub" type="number" value={form.subject_id} onChange={e => setForm({
              ...form,
              subject_id: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="f">Attachment (optional)</Label>
              <Input id="f" type="file" onChange={e => setForm({
              ...form,
              file: e.target.files?.[0] ?? null
            })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setCreateFor(null)}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton onClick={submit} disabled={!form.title || !form.due_date || !form.subject_id || create.isPending}>
              {create.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}
