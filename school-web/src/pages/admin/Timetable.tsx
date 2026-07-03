import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Plus, X } from "lucide-react";

const DAYS = ["Mon", "Tue", "Wed", "Thu", "Fri"];
const DAY_OPTIONS = [
  { value: 1, label: "Monday" }, { value: 2, label: "Tuesday" }, { value: 3, label: "Wednesday" },
  { value: 4, label: "Thursday" }, { value: 5, label: "Friday" }, { value: 6, label: "Saturday" }, { value: 7, label: "Sunday" },
];
const HOURS = Array.from({ length: 9 }, (_, i) => `${String(i + 7).padStart(2, "0")}:00`);
const EMPTY = { subject_id: "", teacher_user_id: "", day_of_week: "1", start_time: "08:00", end_time: "09:00", room: "" };

export default function AdminTimetable() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [selectedClass, setSelectedClass] = useState<number | null>(null);
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({ ...EMPTY });

  const { data: classesData } = useQuery({ queryKey: ["admin", "classes"], queryFn: () => Admin.classes() }) as any;
  const { data: subjectsData } = useQuery({ queryKey: ["admin", "subjects"], queryFn: () => Admin.subjects() }) as any;
  const { data: teachersData } = useQuery({ queryKey: ["admin", "users", "teacher"], queryFn: () => Admin.users({ role: "teacher" }) }) as any;
  const { data: timetableData, isLoading } = useQuery({
    queryKey: ["admin", "timetable", selectedClass],
    queryFn: () => Admin.timetable(selectedClass!),
    enabled: selectedClass !== null,
  }) as any;

  const classes = Array.isArray(classesData) ? classesData : classesData?.data ?? [];
  const subjects = Array.isArray(subjectsData) ? subjectsData : subjectsData?.data ?? [];
  const teachers = Array.isArray(teachersData)
    ? teachersData
    : Array.isArray(teachersData?.data)
      ? teachersData.data
      : teachersData?.data?.data ?? [];
  const entries = Array.isArray(timetableData) ? timetableData : timetableData?.data ?? [];

  const invalidate = () => void qc.invalidateQueries({ queryKey: ["admin", "timetable", selectedClass] });

  const create = useMutation({
    mutationFn: (body: any) => Admin.addTimetableEntry(selectedClass!, {
      subject_id: Number(body.subject_id),
      teacher_user_id: Number(body.teacher_user_id),
      day_of_week: Number(body.day_of_week),
      start_time: body.start_time,
      end_time: body.end_time,
      room: body.room || undefined,
    } as any),
    onSuccess: () => { invalidate(); toast({ title: "Entry added" }); setOpen(false); setForm({ ...EMPTY }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const remove = useMutation({
    mutationFn: (entryId: number) => Admin.deleteTimetableEntry(selectedClass!, entryId),
    onSuccess: () => { invalidate(); toast({ title: "Entry removed" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const getEntry = (day: string, time: string) => {
    const dayIndex = DAYS.indexOf(day) + 1;
    return entries.find(
      (e: any) => e.day_of_week === dayIndex && e.start_time && String(e.start_time).slice(0, 5) === time
    );
  };

  const valid = form.subject_id && form.teacher_user_id && form.start_time && form.end_time;

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Timetable Management" subtitle="Admins build each class's weekly schedule here" />

      <div className="flex items-center gap-3 flex-wrap">
        <select
          value={selectedClass ?? ""}
          onChange={(e) => setSelectedClass(e.target.value ? Number(e.target.value) : null)}
          className="border border-border rounded-xl px-4 py-2.5 text-sm outline-none focus:border-brand-purple focus:ring-2 focus:ring-brand-purple/20 transition-all"
        >
          <option value="">Select Class...</option>
          {classes.map((c: any) => (
            <option key={c.id} value={c.id}>{c.name}{c.grade ? ` - Grade ${c.grade}` : ""}{c.section ? ` (${c.section})` : ""}</option>
          ))}
        </select>
        {selectedClass && (
          <BrandButton onClick={() => { setForm({ ...EMPTY }); setOpen(true); }}><Plus className="me-2 h-4 w-4" />Add Entry</BrandButton>
        )}
      </div>

      {!selectedClass ? (
        <BrandEmptyState icon="UI" title="Select a class" subtitle="Choose a class from the dropdown to view and build its timetable." />
      ) : isLoading ? (
        <div className="animate-pulse space-y-3">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="grid grid-cols-6 gap-2">
              {Array.from({ length: 6 }).map((_, j) => <div key={j} className="h-16 bg-muted/50 rounded-lg" />)}
            </div>
          ))}
        </div>
      ) : entries.length === 0 ? (
        <BrandEmptyState icon="UI" title="No timetable entries" subtitle="Use “Add Entry” to start building this class's schedule." />
      ) : (
        <div className="overflow-x-auto">
          <div className="grid grid-cols-6 gap-2 min-w-[600px]">
            <div className="text-xs font-semibold text-muted-foreground p-2" />
            {DAYS.map((day) => (
              <div key={day} className="text-xs font-semibold text-muted-foreground p-2 text-center">{day}</div>
            ))}
            {HOURS.map((hour) => (
              <div key={hour} className="contents">
                <div className="text-xs text-muted-foreground/70 p-2 flex items-start">{hour}</div>
                {DAYS.map((day) => {
                  const entry = getEntry(day, hour);
                  return (
                    <div key={`${day}-${hour}`} className="border border-border/50 rounded-lg min-h-[60px] p-1">
                      {entry && (
                        <div className="h-full rounded-lg p-2 text-white text-xs relative group" style={{ background: "var(--gradient-main)" }}>
                          <button
                            onClick={() => { if (confirm("Remove this entry?")) remove.mutate(entry.id); }}
                            className="absolute top-1 end-1 opacity-0 group-hover:opacity-100 transition rounded bg-black/20 hover:bg-black/40 p-0.5"
                            aria-label="Remove entry"
                          >
                            <X className="h-3 w-3" />
                          </button>
                          <p className="font-semibold truncate pe-4">{entry.subject?.name ?? "-"}</p>
                          <p className="opacity-80 truncate mt-0.5">{entry.teacher?.name ?? entry.teacher_name ?? ""}</p>
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            ))}
          </div>
        </div>
      )}

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add Timetable Entry</DialogTitle>
            <DialogDescription>Assign a subject and teacher to a day and time slot.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label htmlFor="tt-subject">Subject</Label>
                <select id="tt-subject" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.subject_id} onChange={(e) => setForm({ ...form, subject_id: e.target.value })}>
                  <option value="">Select…</option>
                  {subjects.map((s: any) => <option key={s.id} value={s.id}>{s.name}</option>)}
                </select>
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="tt-teacher">Teacher</Label>
                <select id="tt-teacher" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.teacher_user_id} onChange={(e) => setForm({ ...form, teacher_user_id: e.target.value })}>
                  <option value="">Select…</option>
                  {teachers.map((tch: any) => <option key={tch.id} value={tch.id}>{tch.name}</option>)}
                </select>
              </div>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="tt-day">Day</Label>
              <select id="tt-day" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.day_of_week} onChange={(e) => setForm({ ...form, day_of_week: e.target.value })}>
                {DAY_OPTIONS.map((d) => <option key={d.value} value={d.value}>{d.label}</option>)}
              </select>
            </div>
            <div className="grid grid-cols-3 gap-3">
              <div className="space-y-1.5">
                <Label htmlFor="tt-start">Start</Label>
                <Input id="tt-start" type="time" value={form.start_time} onChange={(e) => setForm({ ...form, start_time: e.target.value })} />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="tt-end">End</Label>
                <Input id="tt-end" type="time" value={form.end_time} onChange={(e) => setForm({ ...form, end_time: e.target.value })} />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="tt-room">Room</Label>
                <Input id="tt-room" value={form.room} onChange={(e) => setForm({ ...form, room: e.target.value })} placeholder="opt." />
              </div>
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(false)}>Cancel</BrandButton>
            <BrandButton onClick={() => create.mutate(form)} disabled={create.isPending || !valid}>
              {create.isPending ? "Saving…" : "Add Entry"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
