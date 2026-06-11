import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function AdminTransport() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();

  const [tab, setTab] = useState<"routes" | "vehicles" | "assignments">("routes");
  const [showForm, setShowForm] = useState(false);
  const [routeName, setRouteName] = useState("");
  const [routeDescription, setRouteDescription] = useState("");

  const { data: routes, isLoading: routesLoading } = useQuery({
    queryKey: ["admin-transport-routes"],
    queryFn: () => Admin.transportRoutes(),
    enabled: tab === "routes",
  });

  const { data: vehicles, isLoading: vehiclesLoading } = useQuery({
    queryKey: ["admin-transport-vehicles"],
    queryFn: () => Admin.transportVehicles(),
    enabled: tab === "vehicles",
  });

  const { data: assignments, isLoading: assignmentsLoading } = useQuery({
    queryKey: ["admin-transport-assignments"],
    queryFn: () => Admin.transportAssignments(),
    enabled: tab === "assignments",
  });

  const createMutation = useMutation({
    mutationFn: (data: any) => Admin.createTransportRoute(data),
    onSuccess: () => {
      toast({ title: "Success", description: "Route created." });
      setShowForm(false); setRouteName(""); setRouteDescription("");
      qc.invalidateQueries({ queryKey: ["admin-transport-routes"] });
    },
    onError: () => toast({ title: "Error", description: "Failed to create route.", variant: "destructive" }),
  });

  const routeItems = Array.isArray(routes) ? routes : (routes as any)?.data ?? [];
  const vehicleItems = Array.isArray(vehicles) ? vehicles : (vehicles as any)?.data ?? [];
  const assignmentItems = Array.isArray(assignments) ? assignments : (assignments as any)?.data ?? [];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Transport Management</h1>
        {tab === "routes" && (
          <button onClick={() => setShowForm(!showForm)} className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90">
            {showForm ? "Cancel" : "+ Add Route"}
          </button>
        )}
      </div>

      {showForm && (
        <form onSubmit={(e) => { e.preventDefault(); if (routeName.trim()) createMutation.mutate({ name: routeName.trim(), description: routeDescription.trim() || undefined }); }} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">Create Transport Route</h2>
          <input className="w-full rounded-md border bg-background px-3 py-2 text-sm" placeholder="Route name *" value={routeName} onChange={(e) => setRouteName(e.target.value)} />
          <textarea className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[80px]" placeholder="Description" value={routeDescription} onChange={(e) => setRouteDescription(e.target.value)} />
          <button type="submit" disabled={createMutation.isPending} className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50">
            {createMutation.isPending ? "Creating…" : "Create Route"}
          </button>
        </form>
      )}

      <div className="flex gap-1 rounded-lg bg-muted p-1">
        {(["routes", "vehicles", "assignments"] as const).map((t) => (
          <button key={t} onClick={() => setTab(t)} className={`flex-1 rounded-md px-3 py-2 text-sm font-medium transition ${tab === t ? "bg-background shadow-sm" : "hover:bg-background/50"}`}>
            {t === "routes" ? "🛣️ Routes" : t === "vehicles" ? "🚌 Vehicles" : "👥 Assignments"}
          </button>
        ))}
      </div>

      {tab === "routes" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Route Name</th><th className="text-left p-3">Description</th><th className="text-center p-3">Stops</th><th className="text-center p-3">Students</th></tr></thead>
            <tbody>
              {routesLoading ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              routeItems.length === 0 ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">No routes</td></tr> :
              routeItems.map((r: any) => (
                <tr key={r.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{r.name}</td>
                  <td className="p-3 text-muted-foreground">{r.description ?? "—"}</td>
                  <td className="p-3 text-center">{r.stops_count ?? r.stops?.length ?? "—"}</td>
                  <td className="p-3 text-center">{r.students_count ?? "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {tab === "vehicles" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Vehicle</th><th className="text-left p-3">Plate</th><th className="text-center p-3">Capacity</th><th className="text-center p-3">Status</th></tr></thead>
            <tbody>
              {vehiclesLoading ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              vehicleItems.length === 0 ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">No vehicles</td></tr> :
              vehicleItems.map((v: any) => (
                <tr key={v.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{v.name ?? v.make ?? "—"}</td>
                  <td className="p-3">{v.plate_number ?? v.license_plate ?? "—"}</td>
                  <td className="p-3 text-center">{v.capacity ?? "—"}</td>
                  <td className="p-3 text-center"><span className={`px-2 py-0.5 rounded-full text-xs ${v.status === "active" ? "bg-green-500/10 text-green-600" : "bg-gray-500/10 text-muted-foreground"}`}>{v.status ?? "—"}</span></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {tab === "assignments" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Student</th><th className="text-left p-3">Route</th><th className="text-left p-3">Stop</th></tr></thead>
            <tbody>
              {assignmentsLoading ? <tr><td colSpan={3} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              assignmentItems.length === 0 ? <tr><td colSpan={3} className="p-8 text-center text-muted-foreground">No assignments</td></tr> :
              assignmentItems.map((a: any, i: number) => (
                <tr key={i} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{a.student?.name ?? a.student_name ?? "—"}</td>
                  <td className="p-3">{a.route?.name ?? a.route_name ?? "—"}</td>
                  <td className="p-3 text-muted-foreground">{a.stop?.name ?? a.stop_name ?? "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
