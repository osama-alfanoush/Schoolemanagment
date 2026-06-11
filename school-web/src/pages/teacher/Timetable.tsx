import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { CalendarDays } from "lucide-react";
import { toArray } from "./response";
export default function TeacherTimetable() {
  const {
    t
  } = useTranslation();
  const {
    data: timetable,
    isLoading,
    error
  } = useQuery({
    queryKey: ["teacher", "timetable"],
    queryFn: Teacher.timetable
  }) as any;
  const entries = toArray(timetable);
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.timetable")}</h1>
      </div>

      {isLoading ? <div className="p-8 text-center">{t("common.loading")}</div> : error ? <div className="p-8 text-center border rounded-md text-destructive">
          {(error as Error)?.message || t("common.error")}
        </div> : entries.length === 0 ? <div className="p-8 text-center border rounded-md text-muted-foreground">{t("common.empty")}</div> : <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {entries.map((entry: any, i: number) => <BrandCard key={i}>
              <CardHeader className="pb-4">
                <CardTitle className="text-lg flex items-center">
                  <CalendarDays className="me-2 h-5 w-5 text-primary" />
                  {entry.subject?.name || "Unknown"}
                </CardTitle>
                <CardDescription>
                  {entry.day_of_week} • {entry.start_time} - {entry.end_time}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="text-sm">
                  <span className="font-medium">Class: </span> {entry.class_room?.name ?? entry.classRoom?.name ?? "TBA"}
                </div>
                <div className="text-sm mt-1">
                  <span className="font-medium">Room: </span> {entry.room || "TBA"}
                </div>
              </CardContent>
            </BrandCard>)}
        </div>}
    </div>;
}