import { useQuery } from "@tanstack/react-query";
import { Parent } from "@/lib/api";
import { renderUser, renderProgress } from "@/lib/tableHelpers";
import { useLocation } from "wouter";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function ParentChildren() {
  const [, navigate] = useLocation();

  const { data: children, isLoading } = useQuery({
    queryKey: ["parent-children"],
    queryFn: () => Parent.children(),
  }) as any;
const list = Array.isArray(children) ? children : children?.data ?? [];

  if (isLoading) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title="My Children" subtitle="Overview of all your children's progress" />
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {Array.from({ length: 2 }).map((_, i) => (
            <div key={i} className="rounded-2xl p-6 bg-card shadow-card animate-pulse">
              <div className="flex items-center gap-4 mb-4">
                <div className="w-12 h-12 rounded-full bg-muted/50" />
                <div className="flex-1 space-y-2">
                  <div className="w-32 h-4 bg-muted/50 rounded" />
                  <div className="w-24 h-3 bg-muted/30 rounded" />
                </div>
              </div>
              <div className="grid grid-cols-3 gap-3 pt-4 border-t border-border/50">
                {Array.from({ length: 3 }).map((_, j) => (
                  <div key={j} className="text-center">
                    <div className="w-12 h-6 bg-muted/50 rounded mx-auto" />
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (list.length === 0) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title="My Children" subtitle="Overview of all your children's progress" />
        <BrandEmptyState icon="UI" title="No children registered" subtitle="Contact the school admin to link your children" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="My Children" subtitle="Overview of all your children's progress" />

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {list.map((child: any) => (
          <BrandCard
            key={child.id}
            onClick={() => navigate(`/parent/children/${child.id}`)}
          >
            <div className="flex items-center gap-4 mb-4">
              {renderUser(child.name, `Grade ${child.studentProfile?.grade_level ?? "?"} - ${child.studentProfile?.class_name ?? ""}`)}
              <BrandButton variant="ghost" size="sm">View details</BrandButton>
            </div>

            <div className="grid grid-cols-3 gap-3 pt-4 border-t border-border/50">
              <div className="text-center">
                <p className="text-2xl font-bold" style={{ color: "var(--color-primary)" }}>
                  {child.attendance_rate ?? "-"}%
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">Attendance</p>
              </div>
              <div className="text-center">
                <p className="text-2xl font-bold" style={{ color: "var(--color-primary)" }}>
                  {child.average_grade ?? "-"}%
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">Avg Grade</p>
              </div>
              <div className="text-center">
                <p className="text-2xl font-bold" style={{ color: "var(--color-primary)" }}>
                  {child.pending_assignments ?? 0}
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">Pending Tasks</p>
              </div>
            </div>

            <div className="mt-4">
              <p className="text-xs text-muted-foreground mb-2">Overall Performance</p>
              {renderProgress(child.average_grade ?? 0, 100)}
            </div>

            <div className="flex gap-2 mt-4 flex-wrap">
              <BrandButton variant="ghost" size="sm" onClick={() => navigate(`/parent/children/${child.id}`)}>Overview</BrandButton>
              <BrandButton variant="ghost" size="sm" onClick={() => navigate(`/parent/children/${child.id}`)}>Grades</BrandButton>
              <BrandButton variant="ghost" size="sm" onClick={() => navigate(`/parent/children/${child.id}`)}>Attendance</BrandButton>
            </div>
          </BrandCard>
        ))}
      </div>
    </div>
  );
}

