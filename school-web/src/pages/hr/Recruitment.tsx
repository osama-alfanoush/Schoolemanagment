import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiFetch } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "@/lib/response";

export default function HrRecruitment() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [tab, setTab] = useState<"jobs" | "applications">("jobs");
  const [showForm, setShowForm] = useState(false);
  const [jobTitle, setJobTitle] = useState("");
  const [department, setDepartment] = useState("");
  const [description, setDescription] = useState("");
  const [requirements, setRequirements] = useState("");
  const [jobType, setJobType] = useState("full_time");

  const { data: jobs, isLoading: jobsLoading } = useQuery({
    queryKey: ["hr-jobs"],
    queryFn: () => apiFetch<any>("/hr/jobs"),
    enabled: tab === "jobs",
  });

  const { data: applications, isLoading: appsLoading } = useQuery({
    queryKey: ["hr-applications"],
    queryFn: () => apiFetch<any>("/hr/applications"),
    enabled: tab === "applications",
  });

  const createMutation = useMutation({
    mutationFn: (data: any) => apiFetch("/hr/jobs", { method: "POST", body: data }),
    onSuccess: () => {
      toast({ title: "Success", description: "Job posted." });
      setShowForm(false); setJobTitle(""); setDepartment(""); setDescription(""); setRequirements("");
      void qc.invalidateQueries({ queryKey: ["hr-jobs"] });
    },
    onError: () => toast({ title: "Error", description: "Failed to post job.", variant: "destructive" }),
  });

  const statusMutation = useMutation({
    mutationFn: ({ id, status }: { id: number; status: string }) =>
      apiFetch(`/hr/applications/${id}/status`, { method: "PATCH", body: { status } }),
    onSuccess: () => {
      toast({ title: "Success", description: "Application status updated." });
      void qc.invalidateQueries({ queryKey: ["hr-applications"] });
    },
    onError: () => toast({ title: "Error", description: "Failed to update status.", variant: "destructive" }),
  });

  const jobItems = toArray(jobs);
  const appItems = toArray(applications);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Recruitment</h1>
        {tab === "jobs" && (
          <button onClick={() => setShowForm(!showForm)} className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90">
            {showForm ? "Cancel" : "+ Post Job"}
          </button>
        )}
      </div>

      {showForm && (
        <form onSubmit={(e) => { e.preventDefault(); if (jobTitle.trim()) createMutation.mutate({ title: jobTitle.trim(), department: department.trim() || undefined, description: description.trim() || undefined, requirements: requirements.trim() || undefined, type: jobType }); }} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">Post New Job</h2>
          <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Job title *" value={jobTitle} onChange={(e) => setJobTitle(e.target.value)} />
          <div className="grid grid-cols-2 gap-4">
            <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Department" value={department} onChange={(e) => setDepartment(e.target.value)} />
            <select className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={jobType} onChange={(e) => setJobType(e.target.value)}>
              <option value="full_time">Full Time</option>
              <option value="part_time">Part Time</option>
              <option value="contract">Contract</option>
            </select>
          </div>
          <textarea className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[80px]" placeholder="Job description" value={description} onChange={(e) => setDescription(e.target.value)} />
          <textarea className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[60px]" placeholder="Requirements" value={requirements} onChange={(e) => setRequirements(e.target.value)} />
          <button type="submit" disabled={createMutation.isPending} className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50">
            {createMutation.isPending ? "Posting…" : "Post Job"}
          </button>
        </form>
      )}

      <div className="flex gap-1 rounded-lg bg-muted p-1">
        {(["jobs", "applications"] as const).map((t) => (
          <button key={t} onClick={() => setTab(t)} className={`flex-1 rounded-md px-3 py-2 text-sm font-medium transition ${tab === t ? "bg-background shadow-sm" : "hover:bg-background/50"}`}>
            {t === "jobs" ? "💼 Job Postings" : "📄 Applications"}
          </button>
        ))}
      </div>

      {tab === "jobs" && (
        <div className="space-y-3">
          {jobsLoading ? <div className="p-8 text-center text-muted-foreground">Loading…</div> :
          jobItems.length === 0 ? <div className="p-8 text-center border rounded-md text-muted-foreground">No job postings</div> :
          jobItems.map((j: any) => (
            <div key={j.id} className="rounded-lg border p-4 bg-card space-y-2">
              <div className="flex items-center justify-between">
                <h3 className="font-semibold text-lg">{j.title}</h3>
                <span className={`px-2 py-0.5 rounded-full text-xs ${j.status === "open" || j.status === "active" ? "bg-green-500/10 text-green-600" : "bg-gray-500/10 text-muted-foreground"}`}>{j.status ?? "open"}</span>
              </div>
              {j.department && <span className="text-sm text-muted-foreground">📍 {j.department}</span>}
              {j.description && <p className="text-sm">{j.description}</p>}
              {j.type && <span className="inline-block text-xs bg-secondary text-secondary-foreground px-2 py-0.5 rounded-full capitalize">{j.type.replace("_", " ")}</span>}
              <div className="text-xs text-muted-foreground">Posted: {j.created_at ? new Date(j.created_at).toLocaleDateString() : "—"} · Applications: {j.applications_count ?? "—"}</div>
            </div>
          ))}
        </div>
      )}

      {tab === "applications" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Applicant</th><th className="text-left p-3">Position</th><th className="text-left p-3">Applied</th><th className="text-center p-3">Status</th><th className="text-center p-3">Actions</th></tr></thead>
            <tbody>
              {appsLoading ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              appItems.length === 0 ? <tr><td colSpan={5} className="p-8 text-center text-muted-foreground">No applications</td></tr> :
              appItems.map((a: any) => (
                <tr key={a.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{a.applicant_name ?? a.name ?? "—"}</td>
                  <td className="p-3">{a.job?.title ?? a.job_title ?? "—"}</td>
                  <td className="p-3 text-muted-foreground">{a.created_at ? new Date(a.created_at).toLocaleDateString() : "—"}</td>
                  <td className="p-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-xs ${a.status === "accepted" || a.status === "hired" ? "bg-green-500/10 text-green-600" : a.status === "rejected" ? "bg-red-500/10 text-red-600" : "bg-yellow-500/10 text-yellow-600"}`}>
                      {a.status ?? "pending"}
                    </span>
                  </td>
                  <td className="p-3 text-center space-x-1">
                    {(a.status === "pending" || a.status === "reviewing") && (
                      <>
                        <button onClick={() => statusMutation.mutate({ id: a.id, status: "shortlisted" })} className="text-xs rounded bg-blue-500/10 text-blue-600 px-2 py-1 hover:bg-blue-500/20">Shortlist</button>
                        <button onClick={() => statusMutation.mutate({ id: a.id, status: "rejected" })} className="text-xs rounded bg-red-500/10 text-red-600 px-2 py-1 hover:bg-red-500/20">Reject</button>
                      </>
                    )}
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
