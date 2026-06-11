import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Parent, ParentChild, AttendanceRecord } from "@/lib/api";
import { renderUser, renderDate, renderStatus } from "@/lib/tableHelpers";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function ParentAttendance() {
  const [selectedChild, setSelectedChild] = useState<number | "all">("all");

  const { data: childrenData } = useQuery({
    queryKey: ["parent-children"],
    queryFn: () => Parent.children(),
  }) as any;
  const children = Array.isArray(childrenData) ? childrenData : childrenData?.data ?? [];

  const { data: attendanceData, isLoading } = useQuery({
    queryKey: ["parent-attendance", selectedChild],
    queryFn: () => {
      const id = selectedChild === "all" ? children[0]?.id : selectedChild;
      if (!id) return Promise.resolve([]);
      return Parent.childAttendance(id);
    },
    enabled: children.length > 0,
  }) as any;
const attendance = Array.isArray(attendanceData) ? attendanceData : attendanceData?.data ?? [];

  const presentCount = attendance.filter((a: any) => a.status === "present").length;
  const absentCount = attendance.filter((a: any) => a.status === "absent").length;
  const lateCount = attendance.filter((a: any) => a.status === "late" || a.status === "excused").length;

  const showStudentColumn = children.length > 1 && selectedChild === "all";

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Children's Attendance" subtitle="Daily attendance records for your children" />

      {children.length > 1 && (
        <div className="flex gap-2 flex-wrap">
          <button
            onClick={() => setSelectedChild("all")}
            className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
              selectedChild === "all" ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
            }`}
            style={selectedChild === "all" ? { background: "var(--gradient-main)" } : undefined}
          >
            All Children
          </button>
          {children.map((c: any) => (
            <button
              key={c.id}
              onClick={() => setSelectedChild(c.id)}
              className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
                selectedChild === c.id ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
              }`}
              style={selectedChild === c.id ? { background: "var(--gradient-main)" } : undefined}
            >
              {c.name}
            </button>
          ))}
        </div>
      )}

      {attendance.length > 0 && (
        <div className="flex gap-3 flex-wrap">
          <span className="bg-green-50 text-green-700 px-3 py-1.5 rounded-full text-sm font-medium">
            Done {presentCount} Present
          </span>
          <span className="bg-red-50 text-red-700 px-3 py-1.5 rounded-full text-sm font-medium">
            Absent {absentCount} Absent
          </span>
          <span className="bg-amber-50 text-amber-700 px-3 py-1.5 rounded-full text-sm font-medium">
            Late {lateCount} Late
          </span>
        </div>
      )}

      {attendance.length === 0 && !isLoading ? (
        <BrandEmptyState icon="UI" title="No attendance records" subtitle="No attendance records found." />
      ) : (
        <DataTable
          data={attendance}
          isLoading={isLoading}
          columns={[
            ...(showStudentColumn
              ? [{ key: "student", label: "Student", render: (_: any, row: any) => renderUser(row.student_name ?? "-", "") }]
              : []
            ),
            { key: "date", label: "Date", sortable: true, render: (v: any) => renderDate(v) },
            { key: "subject", label: "Subject", render: (_: any, row: any) => row.subject?.name ?? row.class_name ?? "-" },
            { key: "status", label: "Status", render: (v: any) => renderStatus(v) },
            { key: "notes", label: "Notes", hide: "md", render: (v: any) => v ? <span className="italic text-sm">{v}</span> : "-" },
          ]}
          emptyMessage="No attendance records."
        />
      )}
    </div>
  );
}
