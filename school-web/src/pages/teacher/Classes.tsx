import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useQuery } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Users, BookOpen } from "lucide-react";
import { toArray } from "./response";
export default function TeacherClasses() {
  const {
    t
  } = useTranslation();
  const {
    data,
    isLoading,
    error
  } = useQuery({
    queryKey: ["teacher", "classes"],
    queryFn: Teacher.classes
  }) as any;
  const classes = toArray(data);
  const getStudentCount = (cls: any) => Number(cls.students_count ?? cls.students?.length ?? 0);
  const formatGradeSection = (cls: any) => {
    const grade = cls.grade ?? cls.grade_level;
    const section = cls.section;
    if (grade && section) return `Grade ${grade} - ${section}`;
    if (grade) return `Grade ${grade}`;
    return section || "Class";
  };
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.classes")}</h1>
      </div>

      {isLoading ? <div className="p-8 text-center">{t("common.loading")}</div> : error ? <div className="p-8 text-center border rounded-md text-destructive">
          {(error as Error)?.message || t("common.error")}
        </div> : classes.length === 0 ? <div className="p-8 text-center border rounded-md text-muted-foreground">{t("common.empty")}</div> : <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {classes.map((cls: any) => <BrandCard key={cls.id} className="overflow-hidden">
              <CardHeader className="pb-4 bg-muted/30 border-b">
                <CardTitle className="text-lg flex items-center justify-between">
                  <span>{cls.name}</span>
                  {cls.section && <span className="text-sm font-normal text-muted-foreground bg-background px-2 py-1 rounded-md border">
                      {cls.section}
                    </span>}
                </CardTitle>
                <CardDescription>{formatGradeSection(cls)}</CardDescription>
              </CardHeader>
              <CardContent className="pt-4 space-y-4">
                {toArray(cls.subjects).length > 0 && <div className="flex items-center text-sm text-muted-foreground">
                    <BookOpen className="h-4 w-4 me-2" />
                    {toArray(cls.subjects).map((subject: any) => subject.name).filter(Boolean).join(", ")}
                  </div>}
                <div className="flex items-center justify-between text-sm">
                  <span className="flex items-center text-muted-foreground">
                    <Users className="h-4 w-4 me-2" /> Students
                  </span>
                  <span className="font-medium">{getStudentCount(cls)}</span>
                </div>
                <div className="flex space-x-2 rtl:space-x-reverse pt-2">
                  <BrandButton variant="outline" className="w-full flex-1">Roster</BrandButton>
                  <BrandButton className="w-full flex-1">Attendance</BrandButton>
                </div>
              </CardContent>
            </BrandCard>)}
        </div>}
    </div>;
}