import { useQuery } from "@tanstack/react-query";
import { Student } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function StudentTransport() {
  const { data: route, isLoading } = useQuery({
    queryKey: ["student-transport"],
    queryFn: () => Student.myTransportRoute(),
  }) as any;
  if (isLoading) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title="My Transport" subtitle="Your assigned bus route and schedule" />
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {Array.from({ length: 2 }).map((_, i) => (
            <div key={i} className="rounded-2xl p-6 bg-card shadow-card animate-pulse">
              <div className="w-48 h-4 bg-muted/50 rounded mb-4" />
              <div className="grid grid-cols-2 gap-3">
                {Array.from({ length: 6 }).map((_, j) => (
                  <div key={j} className="bg-muted/30 rounded-xl p-3">
                    <div className="w-12 h-3 bg-muted/50 rounded mb-2" />
                    <div className="w-20 h-4 bg-muted/50 rounded" />
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (!route) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title="My Transport" subtitle="Your assigned bus route and schedule" />
        <BrandEmptyState
          icon="UI"
          title="No transport assigned"
          subtitle="You are not currently assigned to a bus route. Contact the school admin if you need transport."
        />
      </div>
    );
  }

  const stops = Array.isArray(route.stops) ? route.stops : [];

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="My Transport" subtitle="Your assigned bus route and schedule" />

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <BrandCard>
          <div className="flex items-center gap-3 mb-4">
            <div className="w-12 h-12 rounded-2xl flex items-center justify-center text-white font-bold text-lg" style={{ background: "var(--gradient-main)" }}>
              {route.bus_number ?? route.route_name?.charAt(0) ?? "R"}
            </div>
            <div>
              <p className="font-semibold text-foreground">{route.route_name ?? "Route"}</p>
              <p className="text-sm text-muted-foreground">{route.vehicle_plate ?? ""}{route.vehicle_plate && route.capacity ? " - " : ""}{route.capacity ? `${route.capacity} seats` : ""}</p>
            </div>
          </div>

          <div className="grid grid-cols-2 gap-3">
            {[
              { label: "Driver", value: route.driver_name },
              { label: "Driver Phone", value: route.driver_phone },
              { label: "Pickup Time", value: route.pickup_time },
              { label: "Drop-off Time", value: route.dropoff_time },
              { label: "Pickup Stop", value: route.pickup_stop },
              { label: "Morning KM", value: route.distance ? `${route.distance} km` : "-" },
            ].map((item) => (
              <div key={item.label} className="bg-muted/30 rounded-xl p-3">
                <p className="text-xs text-muted-foreground">{item.label}</p>
                <p className="text-sm font-semibold text-foreground mt-0.5">{item.value ?? "-"}</p>
              </div>
            ))}
          </div>
        </BrandCard>

        <BrandCard>
          <h3 className="font-semibold text-foreground mb-4">Route Stops</h3>
          <div className="relative pl-8">
            <div className="absolute left-3 top-2 bottom-2 w-0.5 bg-muted/50" />
            {stops.length === 0 ? (
              <p className="text-sm text-muted-foreground/70 text-center py-8">No stops defined</p>
            ) : (
              stops.map((stop: any, i: number) => {
                const isCurrent = route.pickup_stop && stop.name === route.pickup_stop;
                return (
                  <div key={i} className="flex items-start gap-3 mb-4 relative">
                    <div
                      className="absolute left-[-20px] w-4 h-4 rounded-full border-2 border-white"
                      style={isCurrent ? { background: "var(--color-primary)", boxShadow: "0 0 0 3px var(--color-primary-light, rgba(108,99,255,0.2))" } : { background: "#e5e7eb" }}
                    />
                    <div>
                      <p className="text-sm font-medium text-foreground">{stop.name}</p>
                      <p className="text-xs text-muted-foreground/70">{stop.time ?? ""}</p>
                      {isCurrent && (
                        <span className="inline-block px-2 py-0.5 rounded-full text-xs mt-1" style={{ background: "var(--color-primary-light)", color: "var(--color-primary)" }}>
                          Your stop
                        </span>
                      )}
                    </div>
                  </div>
                );
              })
            )}
          </div>
        </BrandCard>
      </div>
    </div>
  );
}
