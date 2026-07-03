import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

export default function AdminTransport() {
  const { toast } = useToast();
  const qc = useQueryClient();

  const [tab, setTab] = useState<"routes" | "vehicles" | "assignments">("routes");
  const [showForm, setShowForm] = useState(false);

  // Route form — fields match the backend validation (departure/return/fee/capacity required).
  const [route, setRoute] = useState({
    name: "",
    description: "",
    departure_time: "07:00",
    return_time: "15:00",
    fee: "",
    capacity: "",
  });

  // Vehicle form.
  const [vehicle, setVehicle] = useState({
    registration_number: "",
    model: "",
    type: "bus",
    capacity: "",
  });

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

  const createRoute = useMutation({
    mutationFn: (data: any) => Admin.createTransportRoute(data),
    onSuccess: () => {
      toast({ title: "Success", description: "Route created." });
      setShowForm(false);
      setRoute({ name: "", description: "", departure_time: "07:00", return_time: "15:00", fee: "", capacity: "" });
      void qc.invalidateQueries({ queryKey: ["admin-transport-routes"] });
    },
    onError: (e: any) =>
      toast({ title: "Error", description: e?.data?.message ?? "Failed to create route.", variant: "destructive" }),
  });

  const createVehicle = useMutation({
    mutationFn: (data: any) => Admin.createTransportVehicle(data),
    onSuccess: () => {
      toast({ title: "Success", description: "Vehicle added." });
      setShowForm(false);
      setVehicle({ registration_number: "", model: "", type: "bus", capacity: "" });
      void qc.invalidateQueries({ queryKey: ["admin-transport-vehicles"] });
    },
    onError: (e: any) =>
      toast({ title: "Error", description: e?.data?.message ?? "Failed to add vehicle.", variant: "destructive" }),
  });

  const routeItems = Array.isArray(routes) ? routes : (routes as any)?.data ?? [];
  const vehicleItems = Array.isArray(vehicles) ? vehicles : (vehicles as any)?.data ?? [];
  const assignmentItems = Array.isArray(assignments) ? assignments : (assignments as any)?.data ?? [];

  const inputClass = "w-full rounded-md border bg-background px-3 py-2 text-sm";

  const submitRoute = (e: React.FormEvent) => {
    e.preventDefault();
    if (!route.name.trim()) return;
    createRoute.mutate({
      name: route.name.trim(),
      description: route.description.trim() || undefined,
      departure_time: route.departure_time,
      return_time: route.return_time,
      fee: Number(route.fee || 0),
      capacity: Number(route.capacity || 0),
    });
  };

  const submitVehicle = (e: React.FormEvent) => {
    e.preventDefault();
    if (!vehicle.registration_number.trim()) return;
    createVehicle.mutate({
      registration_number: vehicle.registration_number.trim(),
      model: vehicle.model.trim() || undefined,
      type: vehicle.type,
      capacity: Number(vehicle.capacity || 0),
    });
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Transport Management</h1>
        {(tab === "routes" || tab === "vehicles") && (
          <button
            onClick={() => setShowForm((v) => !v)}
            className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
          >
            {showForm ? "Cancel" : tab === "routes" ? "+ Add Route" : "+ Add Vehicle"}
          </button>
        )}
      </div>

      {showForm && tab === "routes" && (
        <form onSubmit={submitRoute} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">Create Transport Route</h2>
          <input className={inputClass} placeholder="Route name *" value={route.name} onChange={(e) => setRoute({ ...route, name: e.target.value })} />
          <textarea className={`${inputClass} min-h-[80px]`} placeholder="Description" value={route.description} onChange={(e) => setRoute({ ...route, description: e.target.value })} />
          <div className="grid grid-cols-2 gap-3">
            <label className="text-sm space-y-1"><span className="text-muted-foreground">Departure</span><input type="time" className={inputClass} value={route.departure_time} onChange={(e) => setRoute({ ...route, departure_time: e.target.value })} /></label>
            <label className="text-sm space-y-1"><span className="text-muted-foreground">Return</span><input type="time" className={inputClass} value={route.return_time} onChange={(e) => setRoute({ ...route, return_time: e.target.value })} /></label>
            <label className="text-sm space-y-1"><span className="text-muted-foreground">Fee</span><input type="number" min="0" step="0.01" className={inputClass} placeholder="0.00" value={route.fee} onChange={(e) => setRoute({ ...route, fee: e.target.value })} /></label>
            <label className="text-sm space-y-1"><span className="text-muted-foreground">Capacity</span><input type="number" min="1" className={inputClass} placeholder="e.g. 40" value={route.capacity} onChange={(e) => setRoute({ ...route, capacity: e.target.value })} /></label>
          </div>
          <button type="submit" disabled={createRoute.isPending} className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50">
            {createRoute.isPending ? "Creating…" : "Create Route"}
          </button>
        </form>
      )}

      {showForm && tab === "vehicles" && (
        <form onSubmit={submitVehicle} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">Add Vehicle</h2>
          <input className={inputClass} placeholder="Registration number *" value={vehicle.registration_number} onChange={(e) => setVehicle({ ...vehicle, registration_number: e.target.value })} />
          <input className={inputClass} placeholder="Model (e.g. Toyota Coaster)" value={vehicle.model} onChange={(e) => setVehicle({ ...vehicle, model: e.target.value })} />
          <div className="grid grid-cols-2 gap-3">
            <label className="text-sm space-y-1"><span className="text-muted-foreground">Type</span>
              <select className={inputClass} value={vehicle.type} onChange={(e) => setVehicle({ ...vehicle, type: e.target.value })}>
                <option value="bus">Bus</option>
                <option value="van">Van</option>
                <option value="car">Car</option>
              </select>
            </label>
            <label className="text-sm space-y-1"><span className="text-muted-foreground">Capacity</span><input type="number" min="1" className={inputClass} placeholder="e.g. 40" value={vehicle.capacity} onChange={(e) => setVehicle({ ...vehicle, capacity: e.target.value })} /></label>
          </div>
          <button type="submit" disabled={createVehicle.isPending} className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50">
            {createVehicle.isPending ? "Adding…" : "Add Vehicle"}
          </button>
        </form>
      )}

      <div className="flex gap-1 rounded-lg bg-muted p-1">
        {(["routes", "vehicles", "assignments"] as const).map((t) => (
          <button key={t} onClick={() => { setTab(t); setShowForm(false); }} className={`flex-1 rounded-md px-3 py-2 text-sm font-medium transition ${tab === t ? "bg-background shadow-sm" : "hover:bg-background/50"}`}>
            {t === "routes" ? "🛣️ Routes" : t === "vehicles" ? "🚌 Vehicles" : "👥 Assignments"}
          </button>
        ))}
      </div>

      {tab === "routes" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Route Name</th><th className="text-left p-3">Description</th><th className="text-center p-3">Departure</th><th className="text-center p-3">Return</th><th className="text-center p-3">Fee</th><th className="text-center p-3">Capacity</th></tr></thead>
            <tbody>
              {routesLoading ? <tr><td colSpan={6} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              routeItems.length === 0 ? <tr><td colSpan={6} className="p-8 text-center text-muted-foreground">No routes</td></tr> :
              routeItems.map((r: any) => (
                <tr key={r.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{r.name}</td>
                  <td className="p-3 text-muted-foreground">{r.description ?? "—"}</td>
                  <td className="p-3 text-center">{r.departure_time ?? "—"}</td>
                  <td className="p-3 text-center">{r.return_time ?? "—"}</td>
                  <td className="p-3 text-center">{r.fee ?? "—"}</td>
                  <td className="p-3 text-center">{r.capacity ?? "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {tab === "vehicles" && (
        <div className="rounded-lg border bg-card overflow-x-auto">
          <table className="w-full text-sm">
            <thead><tr className="border-b bg-muted/50"><th className="text-left p-3">Registration</th><th className="text-left p-3">Model</th><th className="text-left p-3">Type</th><th className="text-center p-3">Capacity</th></tr></thead>
            <tbody>
              {vehiclesLoading ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">Loading…</td></tr> :
              vehicleItems.length === 0 ? <tr><td colSpan={4} className="p-8 text-center text-muted-foreground">No vehicles</td></tr> :
              vehicleItems.map((v: any) => (
                <tr key={v.id} className="border-b hover:bg-muted/30">
                  <td className="p-3 font-medium">{v.registration_number ?? "—"}</td>
                  <td className="p-3">{v.model ?? "—"}</td>
                  <td className="p-3 capitalize">{v.type ?? "—"}</td>
                  <td className="p-3 text-center">{v.capacity ?? "—"}</td>
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
