import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Admin, ClassRoom } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

const DAYS = ["Mon", "Tue", "Wed", "Thu", "Fri"];
const HOURS = Array.from({ length: 9 }, (_, i) => `${String(i + 7).padStart(2, "0")}:00`);

export default function AdminTimetable() {
  const [selectedClass, setSelectedClass] = useState<number | null>(null);

  const { data: classesData } = useQuery({
    queryKey: ["admin", "classes"],
    queryFn: () => Admin.classes(),
  }) as any;
  const { data: timetableData, isLoading } = useQuery({
    queryKey: ["admin", "timetable", selectedClass],
    queryFn: () => Admin.timetable(selectedClass!),
    enabled: selectedClass !== null,
  }) as any;
  const classes = classesData ?? [];
  const entries = timetableData ?? [];

  const getEntry = (day: string, time: string) => {
    const dayIndex = DAYS.indexOf(day) + 1;
    return entries.find(
      (e: any) => e.day_of_week === dayIndex && e.start_time && e.start_time.slice(0, 5) === time
    );
  };

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Timetable Management" subtitle="School-wide schedule overview" />

      <div className="flex items-center gap-3">
        <select
          value={selectedClass ?? ""}
          onChange={(e) => setSelectedClass(e.target.value ? Number(e.target.value) : null)}
          className="border border-border rounded-xl px-4 py-2.5 text-sm outline-none focus:border-brand-purple focus:ring-2 focus:ring-brand-purple/20 transition-all"
        >
          <option value="">Select Class...</option>
          {classes.map((c: any) => (
            <option key={c.id} value={c.id}>{c.name} - Grade {c.grade}{c.section ? ` (${c.section})` : ""}</option>
          ))}
        </select>
      </div>

      {!selectedClass ? (
        <BrandEmptyState icon="UI" title="Select a class" subtitle="Choose a class from the dropdown to view its timetable." />
      ) : isLoading ? (
        <div className="animate-pulse space-y-3">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="grid grid-cols-6 gap-2">
              {Array.from({ length: 6 }).map((_, j) => (
                <div key={j} className="h-16 bg-muted/50 rounded-lg" />
              ))}
            </div>
          ))}
        </div>
      ) : entries.length === 0 ? (
        <BrandEmptyState icon="UI" title="No timetable entries" subtitle="No schedule has been set for this class yet." />
      ) : (
        <div className="overflow-x-auto">
          <div className="grid grid-cols-6 gap-2 min-w-[600px]">
            <div className="text-xs font-semibold text-muted-foreground p-2" />
            {DAYS.map((day) => (
              <div key={day} className="text-xs font-semibold text-muted-foreground p-2 text-center">{day}</div>
            ))}
            {HOURS.map((hour) => (
              <>
                <div key={hour} className="text-xs text-muted-foreground/70 p-2 flex items-start">{hour}</div>
                {DAYS.map((day) => {
                  const entry = getEntry(day, hour);
                  return (
                    <div key={`${day}-${hour}`} className="border border-border/50 rounded-lg min-h-[60px] p-1">
                      {entry && (
                        <div className="h-full rounded-lg p-2 text-white text-xs" style={{ background: "var(--gradient-main)" }}>
                          <p className="font-semibold truncate">{entry.subject?.name ?? "-"}</p>
                          <p className="opacity-80 truncate mt-0.5">{entry.teacher?.name ?? entry.teacher_name ?? ""}</p>
                        </div>
                      )}
                    </div>
                  );
                })}
              </>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
