import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Hr } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function HrAttendance() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();

  const now = new Date();
  const [year, setYear] = useState(now.getFullYear());
  const [month, setMonth] = useState(now.getMonth() + 1);

  const { data, isLoading } = useQuery({
    queryKey: ["hr-staff-attendance", year, month],
    queryFn: () => Hr.staffAttendance(year, month),
  });

  const { data: staffList } = useQuery({
    queryKey: ["hr-staff-list"],
    queryFn: () => Hr.staff(),
  });

  const [records, setRecords] = useState<Record<number, "present" | "absent" | "late">>({});

  const mutation = useMutation({
    mutationFn: (recs: { staff_user_id: number; status: string }[]) =>
      Hr.markStaffAttendance(recs),
    onSuccess: () => {
      toast({ title: "Success", description: "Staff attendance saved." });
      setRecords({});
      qc.invalidateQueries({ queryKey: ["hr-staff-attendance"] });
    },
    onError: () => toast({ title: "Error", description: "Failed to save attendance.", variant: "destructive" }),
  });

  const staffItems = toArray(staffList);
  const todayRecords = toArray((data as any)?.data ?? data);

  const handleSave = () => {
    const recs = Object.entries(records).map(([id, status]) => ({ staff_user_id: Number(id), status }));
    if (recs.length === 0) return;
    mutation.mutate(recs);
  };

  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.attendance")}</h1>

      {/* Filters */}
      <div className="flex items-center gap-4 flex-wrap">
        <div className="flex items-center gap-2">
          <label className="text-sm font-medium">Year</label>
          <select className="rounded-md border bg-background px-3 py-2 text-sm" value={year} onChange={(e) => setYear(Number(e.target.value))}>
            {[now.getFullYear() - 1, now.getFullYear(), now.getFullYear() + 1].map((y) => (
              <option key={y} value={y}>{y}</option>
            ))}
          </select>
        </div>
        <div className="flex items-center gap-2">
          <label className="text-sm font-medium">Month</label>
          <select className="rounded-md border bg-background px-3 py-2 text-sm" value={month} onChange={(e) => setMonth(Number(e.target.value))}>
            {months.map((m, i) => (
              <option key={i} value={i + 1}>{m}</option>
            ))}
          </select>
        </div>
      </div>

      {/* Mark Attendance */}
      <div className="rounded-lg border bg-card">
        <div className="flex items-center justify-between border-b p-4">
          <h2 className="font-semibold">Mark Today's Attendance</h2>
          <button
            onClick={handleSave}
            disabled={mutation.isPending || Object.keys(records).length === 0}
            className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
          >
            {mutation.isPending ? "Saving…" : "Save Attendance"}
          </button>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b bg-muted/50">
                <th className="text-left p-3">Staff Member</th>
                <th className="text-left p-3">Role</th>
                <th className="text-center p-3">Present</th>
                <th className="text-center p-3">Absent</th>
                <th className="text-center p-3">Late</th>
              </tr>
            </thead>
            <tbody>
              {staffItems.length === 0 ? (
                <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No staff data</td></tr>
              ) : (
                staffItems.map((s: any) => {
                  const id = s.id ?? s.user_id;
                  const current = records[id];
                  return (
                    <tr key={id} className="border-b hover:bg-muted/30">
                      <td className="p-3 font-medium">{s.name ?? s.user?.name ?? `Staff #${id}`}</td>
                      <td className="p-3 text-muted-foreground capitalize">{s.role ?? s.user?.role ?? "—"}</td>
                      {(["present", "absent", "late"] as const).map((status) => (
                        <td key={status} className="p-3 text-center">
                          <input
                            type="radio"
                            name={`staff-${id}`}
                            checked={current === status}
                            onChange={() => setRecords((prev) => ({ ...prev, [id]: status }))}
                            className="accent-primary h-4 w-4"
                          />
                        </td>
                      ))}
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Summary */}
      {isLoading ? (
        <div className="p-8 text-center text-muted-foreground">Loading attendance data…</div>
      ) : todayRecords.length > 0 ? (
        <div className="rounded-lg border bg-card p-4">
          <h2 className="font-semibold mb-3">Attendance Records ({month}/{year})</h2>
          <div className="grid grid-cols-3 gap-4 text-center">
            <div className="rounded-md bg-green-500/10 p-3">
              <div className="text-2xl font-bold text-green-600">{todayRecords.filter((r: any) => r.status === "present").length}</div>
              <div className="text-xs text-muted-foreground">Present</div>
            </div>
            <div className="rounded-md bg-red-500/10 p-3">
              <div className="text-2xl font-bold text-red-600">{todayRecords.filter((r: any) => r.status === "absent").length}</div>
              <div className="text-xs text-muted-foreground">Absent</div>
            </div>
            <div className="rounded-md bg-yellow-500/10 p-3">
              <div className="text-2xl font-bold text-yellow-600">{todayRecords.filter((r: any) => r.status === "late").length}</div>
              <div className="text-xs text-muted-foreground">Late</div>
            </div>
          </div>
        </div>
      ) : null}
    </div>
  );
}
