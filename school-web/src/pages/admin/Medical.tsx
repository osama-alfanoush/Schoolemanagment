import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function AdminMedical() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [tab, setTab] = useState<"records" | "visits">("records");

  const { data: records, isLoading: recordsLoading } = useQuery({
    queryKey: ["admin-medical-records"],
    queryFn: () => Admin.medicalRecords(),
    enabled: tab === "records",
  });

  const { data: visits, isLoading: visitsLoading } = useQuery({
    queryKey: ["admin-medical-visits"],
    queryFn: () => Admin.medicalVisits(),
    enabled: tab === "visits",
  });

  const notifyMutation = useMutation({
    mutationFn: (visitId: number) => Admin.notifyParentMedical(visitId),
    onSuccess: () => toast({ title: "Success", description: "Parent notified." }),
    onError: () => toast({ title: "Error", description: "Failed to notify parent.", variant: "destructive" }),
  });

  const recordItems = Array.isArray(records) ? records : (records as any)?.data ?? [];
  const visitItems = Array.isArray(visits) ? visits : (visits as any)?.data ?? [];

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Medical Management</h1>

      <div className="flex gap-1 rounded-lg bg-muted p-1">
        {(["records", "visits"] as const).map((t) => (
          <button key={t} onClick={() => setTab(t)} className={`flex-1 rounded-md px-3 py-2 text-sm font-medium transition ${tab === t ? "bg-background shadow-sm" : "hover:bg-background/50"}`}>
            {t === "records" ? "📋 Medical Records" : "🏥 Clinic Visits"}
          </button>
        ))}
      </div>

      {tab === "records" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Student</th><th className="text-left p-3">Condition</th><th className="text-left p-3">Allergies</th><th className="text-left p-3">Blood Type</th><th className="text-left p-3">Notes</th></tr></thead>
            <tbody>
              {recordsLoading ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              recordItems.length === 0 ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No medical records</td></tr> :
              recordItems.map((r: any) => (
                <tr key={r.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{r.student?.name ?? r.student_name ?? "—"}</td>
                  <td className="p-3">{r.condition ?? r.chronic_conditions ?? "—"}</td>
                  <td className="p-3 text-red-600">{r.allergies ?? "None"}</td>
                  <td className="p-3">{r.blood_type ?? "—"}</td>
                  <td className="p-3 text-muted-foreground truncate max-w-[200px]">{r.notes ?? "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {tab === "visits" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Student</th><th className="text-left p-3">Date</th><th className="text-left p-3">Reason</th><th className="text-left p-3">Treatment</th><th className="text-center p-3">Action</th></tr></thead>
            <tbody>
              {visitsLoading ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              visitItems.length === 0 ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No clinic visits</td></tr> :
              visitItems.map((v: any) => (
                <tr key={v.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{v.student?.name ?? v.student_name ?? "—"}</td>
                  <td className="p-3">{v.visited_at ? new Date(v.visited_at).toLocaleDateString() : v.created_at ? new Date(v.created_at).toLocaleDateString() : "—"}</td>
                  <td className="p-3">{v.reason ?? v.complaint ?? "—"}</td>
                  <td className="p-3 text-muted-foreground">{v.treatment ?? v.action_taken ?? "—"}</td>
                  <td className="p-3 text-center">
                    <button
                      onClick={() => notifyMutation.mutate(v.id)}
                      disabled={notifyMutation.isPending}
                      className="text-xs rounded-md bg-blue-500/10 text-blue-600 px-2 py-1 hover:bg-blue-500/20"
                    >
                      Notify Parent
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
