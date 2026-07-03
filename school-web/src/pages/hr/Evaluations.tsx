import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiFetch } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function HrEvaluations() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [showForm, setShowForm] = useState(false);
  const [staffId, setStaffId] = useState<number | "">("");
  const [period, setPeriod] = useState("");
  const [rating, setRating] = useState(3);
  const [comments, setComments] = useState("");
  const [goals, setGoals] = useState("");

  const { data: evaluations, isLoading } = useQuery({
    queryKey: ["hr-evaluations"],
    queryFn: () => apiFetch<any>("/hr/evaluations"),
  });

  const { data: staffList } = useQuery({
    queryKey: ["hr-staff-list"],
    queryFn: () => apiFetch<any>("/hr/staff"),
  });

  const createMutation = useMutation({
    mutationFn: (data: any) => apiFetch("/hr/evaluations", { method: "POST", body: data }),
    onSuccess: () => {
      toast({ title: "Success", description: "Evaluation created." });
      setShowForm(false); setStaffId(""); setPeriod(""); setRating(3); setComments(""); setGoals("");
      void qc.invalidateQueries({ queryKey: ["hr-evaluations"] });
    },
    onError: () => toast({ title: "Error", description: "Failed to create evaluation.", variant: "destructive" }),
  });

  const evalItems = toArray(evaluations);
  const staffItems = toArray(staffList);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!staffId || !period.trim()) return;
    createMutation.mutate({ staff_user_id: staffId, period: period.trim(), overall_rating: rating, comments: comments.trim() || undefined, goals: goals.trim() || undefined });
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Performance Evaluations</h1>
        <button onClick={() => setShowForm(!showForm)} className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90">
          {showForm ? "Cancel" : "+ New Evaluation"}
        </button>
      </div>

      {showForm && (
        <form onSubmit={handleSubmit} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">Create Evaluation</h2>
          <div className="space-y-2">
            <label htmlFor="evaluation-staff" className="text-sm font-medium">Staff Member</label>
            <select id="evaluation-staff" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={staffId} onChange={(e) => setStaffId(Number(e.target.value) || "")}>
              <option value="">Select staff…</option>
              {staffItems.map((s: any) => <option key={s.id} value={s.id}>{s.name ?? s.user?.name}</option>)}
            </select>
          </div>
          <div className="space-y-2">
            <label htmlFor="evaluation-period" className="text-sm font-medium">Period</label>
            <input id="evaluation-period" className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="e.g. Q1 2026, Annual 2026" value={period} onChange={(e) => setPeriod(e.target.value)} />
          </div>
          <div className="space-y-2">
            <label htmlFor="evaluation-rating" className="text-sm font-medium">Overall Rating: {rating}/5</label>
            <input id="evaluation-rating" type="range" min={1} max={5} step={1} value={rating} onChange={(e) => setRating(Number(e.target.value))} className="w-full accent-primary" />
            <div className="flex justify-between text-xs text-muted-foreground"><span>Poor</span><span>Below Avg</span><span>Average</span><span>Good</span><span>Excellent</span></div>
          </div>
          <div className="space-y-2">
            <label htmlFor="evaluation-comments" className="text-sm font-medium">Comments</label>
            <textarea id="evaluation-comments" className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[80px]" value={comments} onChange={(e) => setComments(e.target.value)} placeholder="Performance comments…" />
          </div>
          <div className="space-y-2">
            <label htmlFor="evaluation-goals" className="text-sm font-medium">Goals for Next Period</label>
            <textarea id="evaluation-goals" className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[60px]" value={goals} onChange={(e) => setGoals(e.target.value)} placeholder="Goals…" />
          </div>
          <button type="submit" disabled={createMutation.isPending || !staffId || !period.trim()} className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50">
            {createMutation.isPending ? "Creating…" : "Create Evaluation"}
          </button>
        </form>
      )}

      <div className="rounded-lg border bg-card overflow-x-auto">
        <table className="w-full text-sm">
          <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Staff</th><th className="text-left p-3">Period</th><th className="text-center p-3">Rating</th><th className="text-left p-3">Comments</th><th className="text-left p-3">Date</th></tr></thead>
          <tbody>
            {isLoading ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
            evalItems.length === 0 ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No evaluations yet</td></tr> :
            evalItems.map((ev: any) => (
              <tr key={ev.id} className="border-b hover:bg-muted/30">
                <td className="p-3 font-medium">{ev.staff?.name ?? ev.staff_name ?? "—"}</td>
                <td className="p-3">{ev.period ?? "—"}</td>
                <td className="p-3 text-center">
                  <span className={`px-2 py-0.5 rounded-full text-xs font-bold ${(ev.overall_rating ?? 0) >= 4 ? "bg-green-500/10 text-green-600" : (ev.overall_rating ?? 0) >= 3 ? "bg-yellow-500/10 text-yellow-600" : "bg-red-500/10 text-red-600"}`}>
                    {ev.overall_rating ?? "—"}/5
                  </span>
                </td>
                <td className="p-3 text-muted-foreground truncate max-w-[200px]">{ev.comments ?? "—"}</td>
                <td className="p-3 text-muted-foreground">{ev.created_at ? new Date(ev.created_at).toLocaleDateString() : "—"}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
