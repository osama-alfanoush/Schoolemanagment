import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { toArray } from "./response";
import { BookOpen, Users } from "lucide-react";
export default function TeacherDashboard() {
  const {
    t
  } = useTranslation();
  const {
    data: classesData,
    isLoading
  } = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes
  }) as any;
  if (isLoading) return <div className="p-8">{t("common.loading")}</div>;
  const classes = toArray(classesData);
  const getStudentCount = (cls: any) => Number(cls.students_count ?? cls.students?.length ?? 0);
  const totalStudents = classes.reduce((sum, cls: any) => sum + getStudentCount(cls), 0);
  const totalSubjects = classes.reduce((sum, cls: any) => sum + toArray(cls.subjects).length, 0);
  const formatGradeSection = (cls: any) => {
    const grade = cls.grade ?? cls.grade_level;
    const section = cls.section;
    if (grade && section) return `Grade ${grade} - ${section}`;
    if (grade) return `Grade ${grade}`;
    return section || "Class";
  };
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.dashboard")}</h1>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("teacherDashboard.myClasses")}</CardTitle>
            <BookOpen className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{classes.length}</div>
          </CardContent>
        </BrandCard>
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Students</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{totalStudents}</div>
          </CardContent>
        </BrandCard>
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Subjects</CardTitle>
            <BookOpen className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{totalSubjects}</div>
          </CardContent>
        </BrandCard>
      </div>

      <div className="mt-8">
        <h2 className="text-xl font-semibold mb-4">{t("teacherDashboard.upcomingClasses")}</h2>
        {classes.length === 0 ? <div className="rounded-md border p-8 text-center text-muted-foreground">
            {t("common.empty")}
          </div> : <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {classes.slice(0, 6).map((cls: any) => {
          const subjects = toArray(cls.subjects).map((subject: any) => subject.name).filter(Boolean);
          return <BrandCard key={cls.id} className="border-surface-border">
                  <CardHeader className="pb-3">
                    <CardTitle className="text-base">{cls.name}</CardTitle>
                    <p className="text-sm text-muted-foreground">{formatGradeSection(cls)}</p>
                  </CardHeader>
                  <CardContent className="space-y-3">
                    <div className="flex items-center justify-between text-sm">
                      <span className="flex items-center text-muted-foreground">
                        <Users className="me-2 h-4 w-4" />
                        Students
                      </span>
                      <span className="font-semibold">{getStudentCount(cls)}</span>
                    </div>
                    {subjects.length > 0 && <div className="flex items-start text-sm text-muted-foreground">
                        <BookOpen className="me-2 mt-0.5 h-4 w-4 shrink-0" />
                        <span className="line-clamp-2">{subjects.join(", ")}</span>
                      </div>}
                  </CardContent>
                </BrandCard>;
        })}
          </div>}
      </div>
    </div>;
}