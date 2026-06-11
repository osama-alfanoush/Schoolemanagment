import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { renderUser, renderDate, renderStatus } from "@/lib/tableHelpers";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function AdminAttendance() {
  const today = new Date().toISOString().slice(0, 10);
  const [selectedDate, setSelectedDate] = useState(today);
  const [search, setSearch] = useState("");
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data: dashboard, isLoading: dashboardLoading } = useQuery({
    queryKey: ["admin", "attendance-dashboard", selectedDate],
    queryFn: () => Admin.attendanceDashboard(),
  }) as any;
const todayData = dashboard?.today ?? {};
  const presentCount = (todayData as any).present ?? 0;
  const absentCount = (todayData as any).absent ?? 0;
  const lateCount = (todayData as any).late ?? 0;
  const totalAttended = presentCount + absentCount + lateCount;
  const rate = totalAttended > 0 ? Math.round((presentCount / totalAttended) * 100) : 0;

  const byClass = Array.isArray(dashboard?.by_class) ? dashboard.by_class : [];

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Attendance Overview" subtitle="School-wide daily attendance monitoring" />

      <div className="grid grid-cols-4 gap-4 mb-6">
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">Present Today</p>
          <p className="text-2xl font-bold text-green-600 mt-1">{presentCount}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">Absent Today</p>
          <p className="text-2xl font-bold text-red-600 mt-1">{absentCount}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">Late Today</p>
          <p className="text-2xl font-bold text-amber-600 mt-1">{lateCount}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">Attendance Rate</p>
          <p className="text-2xl font-bold mt-1" style={{ color: "var(--color-primary)" }}>{rate}%</p>
        </BrandCard>
      </div>

      <div className="flex items-center gap-3 mb-4">
        <span className="text-sm text-muted-foreground">Date:</span>
        <input
          type="date"
          value={selectedDate}
          onChange={(e) => setSelectedDate(e.target.value)}
          className="border border-border rounded-xl px-3 py-2 text-sm outline-none focus:border-brand-purple focus:ring-2 focus:ring-brand-purple/20"
        />
        <BrandButton variant="secondary" size="sm" onClick={() => setSelectedDate(today)}>
          Today
        </BrandButton>
      </div>

      {byClass.length === 0 && !dashboardLoading ? (
        <BrandEmptyState icon="UI" title="No attendance records" subtitle="No attendance data for the selected date." />
      ) : (
        <DataTable
          title="Attendance Records"
          data={byClass}
          isLoading={dashboardLoading}
          columns={[
            { key: "class", label: "Class", render: (_: any, row: any) => `Class #${row.class_room_id}` },
            { key: "present", label: "Present", sortable: true },
            { key: "absent", label: "Absent", sortable: true },
            { key: "late", label: "Late", sortable: true },
          ]}
          toolbar={
            <SearchAndFilter
              placeholder="Search students..."
              value={search}
              onChange={setSearch}
              filters={[
                { key: "status", label: "Status", options: [
                  { value: "present", label: "Present" },
                  { value: "absent", label: "Absent" },
                  { value: "late", label: "Late" },
                  { value: "excused", label: "Excused" },
                ]},
              ]}
              activeFilters={activeFilters}
              onFilterChange={(key, val) => setActiveFilters((p) => ({ ...p, [key]: val }))}
              onClearFilters={() => setActiveFilters({})}
            />
          }
        />
      )}
    </div>
  );
}
