import { FormEvent, useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "./response";

type ConductCategory = "positive" | "warning" | "incident";
type Severity = "low" | "medium" | "high";

export default function TeacherConduct() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();

  const { data: classesData } = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes,
  });

  const [classId, setClassId] = useState<number | "">("");
  const [studentId, setStudentId] = useState<number | "">("");
  const [category, setCategory] = useState<ConductCategory>("positive");
  const [severity, setSeverity] = useState<Severity>("low");
  const [description, setDescription] = useState("");

  const { data: studentsData } = useQuery({
    queryKey: ["teacher", "class-students", classId],
    queryFn: () => Teacher.classStudents(classId as number),
    enabled: !!classId,
  });

  const classes = toArray(classesData);
  const students = toArray(studentsData);

  const mutation = useMutation({
    mutationFn: (data: {
      student_user_id: number;
      category: ConductCategory;
      title: string;
      note: string;
    }) => Teacher.logConduct(data),
    onSuccess: () => {
      toast({
        title: "Success",
        description: "Conduct incident logged successfully.",
      });
      setStudentId("");
      setDescription("");
      qc.invalidateQueries({ queryKey: ["teacher", "class-students"] });
    },
    onError: () =>
      toast({
        title: "Error",
        description: "Failed to log conduct.",
        variant: "destructive",
      }),
  });

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    if (!classId || !studentId || !description.trim()) return;

    mutation.mutate({
      student_user_id: studentId as number,
      category,
      title: `${severity[0].toUpperCase()}${severity.slice(1)} ${category} conduct`,
      note: description.trim(),
    });
  };

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.conduct")}</h1>

      <form onSubmit={handleSubmit} className="space-y-4 max-w-xl rounded-lg border p-6 bg-card">
        <h2 className="text-lg font-semibold">Log Conduct Incident</h2>

        <div className="space-y-2">
          <label className="text-sm font-medium">Class</label>
          <select
            className="w-full rounded-md border bg-background px-3 py-2 text-sm"
            value={classId}
            onChange={(e) => {
              setClassId(Number(e.target.value) || "");
              setStudentId("");
            }}
          >
            <option value="">Select class...</option>
            {classes.map((c: any) => (
              <option key={c.id} value={c.id}>
                {c.name ?? `Class ${c.id}`}
                {c.grade ? ` - ${c.grade}` : ""}
                {c.section ? ` ${c.section}` : ""}
              </option>
            ))}
          </select>
        </div>

        <div className="space-y-2">
          <label className="text-sm font-medium">Student</label>
          <select
            className="w-full rounded-md border bg-background px-3 py-2 text-sm"
            value={studentId}
            onChange={(e) => setStudentId(Number(e.target.value) || "")}
            disabled={!classId}
          >
            <option value="">Select student...</option>
            {students.map((s: any) => (
              <option key={s.id ?? s.user_id} value={s.id ?? s.user_id}>
                {s.name ?? s.user?.name ?? `Student #${s.id ?? s.user_id}`}
              </option>
            ))}
          </select>
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <label className="text-sm font-medium">Category</label>
            <select
              className="w-full rounded-md border bg-background px-3 py-2 text-sm"
              value={category}
              onChange={(e) => setCategory(e.target.value as ConductCategory)}
            >
              <option value="positive">Positive</option>
              <option value="warning">Warning</option>
              <option value="incident">Incident</option>
            </select>
          </div>
          <div className="space-y-2">
            <label className="text-sm font-medium">Severity</label>
            <select
              className="w-full rounded-md border bg-background px-3 py-2 text-sm"
              value={severity}
              onChange={(e) => setSeverity(e.target.value as Severity)}
            >
              <option value="low">Low</option>
              <option value="medium">Medium</option>
              <option value="high">High</option>
            </select>
          </div>
        </div>

        <div className="space-y-2">
          <label className="text-sm font-medium">Description</label>
          <textarea
            className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[100px]"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Describe the conduct incident..."
          />
        </div>

        <button
          type="submit"
          disabled={mutation.isPending || !classId || !studentId || !description.trim()}
          className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
        >
          {mutation.isPending ? "Logging..." : "Log Conduct Incident"}
        </button>
      </form>
    </div>
  );
}
