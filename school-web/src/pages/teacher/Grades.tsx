import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { toArray } from "./response";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { useToast } from "@/hooks/use-toast";
export default function TeacherGrades() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [classId, setClassId] = useState<number | null>(null);
  const [subjectId, setSubjectId] = useState("");
  const [componentId, setComponentId] = useState("");
  const [scores, setScores] = useState<Record<number, string>>({});
  const {
    data: classesData
  } = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes
  }) as any;
  const classes = toArray(classesData);
  const {
    data: studentsData
  } = useQuery({
    queryKey: ["teacher", "class-students", classId],
    queryFn: () => Teacher.classStudents(classId!),
    enabled: !!classId
  }) as any;
  const students = toArray(studentsData);

  const availableSubjects = classes.find((c: any) => c.id === classId)?.subjects || [];
  const { data: componentsData } = useQuery({
    queryKey: ["teacher", "grade-components", classId, subjectId],
    queryFn: () => Teacher.gradeComponents(classId!, Number(subjectId)),
    enabled: !!classId && !!subjectId
  }) as any;
  const components = toArray(componentsData);

  const enter = useMutation({
    mutationFn: (data: any) => Teacher.enterGrade(data),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["teacher"]
      });
      toast({
        title: "Grade saved"
      });
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed",
      description: e?.message
    })
  });
  const saveAll = async () => {
    if (!classId || !componentId) return;
    const entries = Object.entries(scores).filter(([_, v]) => v !== "");
    for (const [studentId, score] of entries) {
      await enter.mutateAsync({
        student_user_id: Number(studentId),
        grade_component_id: Number(componentId),
        score: Number(score)
      });
    }
  };
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.grades")}</h1>
      
      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle className="text-base">Class · Subject · Grade Component</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-4 sm:grid-cols-3 max-w-3xl">
          <div className="space-y-1.5 sm:col-span-3">
            <Label>Class</Label>
            <div className="flex flex-wrap gap-2">
              {classes.length === 0 ? <span className="text-sm text-muted-foreground">
                  {t("common.empty")}
                </span> : classes.map((c: any) => <Badge key={c.id} variant={classId === c.id ? "default" : "outline"} className="cursor-pointer px-3 py-1" onClick={() => { setClassId(c.id); setSubjectId(""); setComponentId(""); }}>
                    {c.name || `Class ${c.id}`}
                  </Badge>)}
            </div>
          </div>
          <div className="space-y-1.5 sm:col-span-1">
            <Label htmlFor="subj">Subject</Label>
            <select
              id="subj"
              className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors"
              value={subjectId}
              onChange={e => { setSubjectId(e.target.value); setComponentId(""); }}
              disabled={!classId}
            >
              <option value="">Select subject...</option>
              {availableSubjects.map((s: any) => (
                <option key={s.id} value={s.id}>{s.name}</option>
              ))}
            </select>
          </div>
          <div className="space-y-1.5 sm:col-span-1">
            <Label htmlFor="comp">Grade Component</Label>
            <select
              id="comp"
              className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors"
              value={componentId}
              onChange={e => setComponentId(e.target.value)}
              disabled={!subjectId}
            >
              <option value="">Select component...</option>
              {components.map((c: any) => (
                <option key={c.id} value={c.id}>{c.name} (Max {c.max_score})</option>
              ))}
            </select>
          </div>
          <div className="flex items-end">
            <BrandButton className="w-full" onClick={saveAll} disabled={enter.isPending || !classId || !componentId || Object.keys(scores).length === 0}>
              {enter.isPending ? t("common.loading") : t("common.save")}
            </BrandButton>
          </div>
        </CardContent>
      </BrandCard>

      {classId ? <BrandCard className="shadow-academic border-surface-border">
          <CardHeader>
            <CardTitle className="text-base">Students</CardTitle>
          </CardHeader>
          <CardContent className="p-0">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Student</TableHead>
                  <TableHead className="text-right w-32">Score</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {students.length === 0 ? <TableRow>
                    <TableCell colSpan={2} className="text-center p-8 text-muted-foreground">
                      {t("common.empty")}
                    </TableCell>
                  </TableRow> : students.map((s: any) => <TableRow key={s.id}>
                      <TableCell className="font-medium">{s.name}</TableCell>
                      <TableCell className="text-right">
                        <Input type="number" step="0.01" className="w-24 ms-auto text-right font-mono" value={scores[s.id] ?? ""} onChange={e => setScores({
                  ...scores,
                  [s.id]: e.target.value
                })} />
                      </TableCell>
                    </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </BrandCard> : <div className="p-8 text-center border rounded-md text-muted-foreground">
          Select a class to enter grades.
        </div>}
    </div>;
}