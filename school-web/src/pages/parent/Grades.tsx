import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Parent } from "@/lib/api";
import { renderUser, renderGrade, renderDate, renderStatus } from "@/lib/tableHelpers";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function ParentGrades() {
  const [selectedChild, setSelectedChild] = useState<number | "all">("all");

  const { data: childrenData } = useQuery({
    queryKey: ["parent-children"],
    queryFn: () => Parent.children(),
  }) as any;
  const children = Array.isArray(childrenData) ? childrenData : childrenData?.data ?? [];

  const { data: gradesData, isLoading } = useQuery({
    queryKey: ["parent-grades", selectedChild],
    queryFn: () => {
      const id = selectedChild === "all" ? children[0]?.id : selectedChild;
      if (!id) return Promise.resolve([]);
      return Parent.childGrades(id);
    },
    enabled: children.length > 0,
  }) as any;
const grades = Array.isArray(gradesData) ? gradesData : gradesData?.data ?? [];

  const showStudentColumn = children.length > 1 && selectedChild === "all";

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title="Children's Grades" subtitle="Academic performance for all your children" />

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

      {grades.length === 0 && !isLoading ? (
        <BrandEmptyState icon="UI" title="No grade records found" subtitle="No grades have been recorded yet." />
      ) : (
        <DataTable
          data={grades}
          isLoading={isLoading}
          columns={[
            ...(showStudentColumn
              ? [{ key: "student", label: "Student", render: (_: any, row: any) => renderUser(row.student_name ?? "-", "") }]
              : []
            ),
            { key: "subject", label: "Subject", sortable: true, render: (_: any, row: any) => row.subject?.name ?? row.subject_name ?? row.component?.subject?.name ?? "-" },
            { key: "assessment", label: "Assessment", render: (_: any, row: any) => row.exam?.name ?? row.component?.name ?? row.component_name ?? "-" },
            { key: "score", label: "Score", sortable: true, render: (v: any, row: any) => renderGrade(v ?? row.marks_obtained ?? null) },
            { key: "date", label: "Date", sortable: true, hide: "lg", render: (v: any) => renderDate(v) },
            { key: "status", label: "Status", render: (v: any) => renderStatus(v) },
          ]}
          emptyMessage="No grade records found"
          emptyIcon="UI"
        />
      )}
    </div>
  );
}
