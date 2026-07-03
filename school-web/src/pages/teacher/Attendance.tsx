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
type Status = "present" | "absent" | "late" | "excused";
export default function TeacherAttendance() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [classId, setClassId] = useState<number | null>(null);
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10));
  const [marks, setMarks] = useState<Record<number, Status>>({});
  const {
    data: classesData
  } = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes
  }) as any;
  const classes = toArray(classesData);
  const {
    data: studentsData,
    isLoading: loadingStudents
  } = useQuery({
    queryKey: ["teacher", "class-students", classId],
    queryFn: () => Teacher.classStudents(classId!),
    enabled: !!classId
  }) as any;
  const students = toArray(studentsData);
  const markAll = (s: Status) => {
    const next: Record<number, Status> = {};
    for (const st of students) next[st.id] = s;
    setMarks(next);
  };
  const submit = useMutation({
    mutationFn: () => Teacher.markAttendance({
      class_room_id: classId!,
      date,
      records: Object.entries(marks).map(([id, status]) => ({
        student_user_id: Number(id),
        status
      }))
    }),
    onSuccess: () => {
      void qc.invalidateQueries({
        queryKey: ["teacher"]
      });
      toast({
        title: "Attendance saved"
      });
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed",
      description: e?.message
    })
  });
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
        {t("nav.attendance")}
      </h1>

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle className="text-base">Class & date</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-4 sm:grid-cols-3 max-w-2xl">
          <div className="space-y-1.5 sm:col-span-2">
            <Label>Class</Label>
            <div className="flex flex-wrap gap-2">
              {classes.length === 0 ? <span className="text-sm text-muted-foreground">
                  {t("common.empty")}
                </span> : classes.map((c: any) => <Badge key={c.id} variant={classId === c.id ? "default" : "outline"} className="cursor-pointer px-3 py-1" onClick={() => {
              setClassId(c.id);
              setMarks({});
            }}>
                    {c.name || `Class ${c.id}`}
                  </Badge>)}
            </div>
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="date">{t("common.date")}</Label>
            <Input id="date" type="date" value={date} onChange={e => setDate(e.target.value)} />
          </div>
        </CardContent>
      </BrandCard>

      {classId ? <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex-row items-center justify-between">
            <CardTitle className="text-base">Students</CardTitle>
            <div className="flex gap-2">
              <BrandButton size="sm" variant="outline" onClick={() => markAll("present")}>
                All present
              </BrandButton>
              <BrandButton size="sm" variant="outline" onClick={() => markAll("absent")}>
                All absent
              </BrandButton>
              <BrandButton size="sm" onClick={() => submit.mutate()} disabled={submit.isPending || Object.keys(marks).length === 0}>
                {submit.isPending ? t("common.loading") : t("common.save")}
              </BrandButton>
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Student</TableHead>
                  <TableHead className="text-right">{t("common.status")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loadingStudents ? <TableRow>
                    <TableCell colSpan={2} className="text-center p-8">
                      {t("common.loading")}
                    </TableCell>
                  </TableRow> : students.length === 0 ? <TableRow>
                    <TableCell colSpan={2} className="text-center p-8 text-muted-foreground">
                      {t("common.empty")}
                    </TableCell>
                  </TableRow> : students.map((s: any) => <TableRow key={s.id}>
                      <TableCell className="font-medium">{s.name}</TableCell>
                      <TableCell className="text-right">
                        <div className="inline-flex gap-1">
                          {(["present", "absent", "late", "excused"] as Status[]).map(st => <Badge key={st} variant={marks[s.id] === st ? "default" : "outline"} className="cursor-pointer capitalize" onClick={() => setMarks({
                    ...marks,
                    [s.id]: st
                  })}>
                                {st}
                              </Badge>)}
                        </div>
                      </TableCell>
                    </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </BrandCard> : <div className="p-8 text-center border rounded-md text-muted-foreground">
          Select a class to mark attendance.
        </div>}
    </div>;
}