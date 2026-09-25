import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Parent } from "@/lib/api";
import { renderUser, renderGrade, renderDate, renderStatus } from "@/lib/tableHelpers";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function ParentGrades() {
  const { t } = useTranslation();
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
      <PageHeader icon="UI" title={t("parentPages.gradesTitle")} subtitle={t("parentPages.gradesSubtitle")} />

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
        <BrandEmptyState icon="UI" title={t("parentPages.noGrades")} subtitle={t("parentPages.noGradesHint")} />
      ) : (
        <DataTable
          data={grades}
          isLoading={isLoading}
          columns={[
            ...(showStudentColumn
              ? [{ key: "student", label: t("parentPages.student"), render: (_: any, row: any) => renderUser(row.student_name ?? "-", "") }]
              : []
            ),
            { key: "subject", label: t("parentPages.subject"), sortable: true, render: (_: any, row: any) => row.subject?.name ?? row.subject_name ?? row.component?.subject?.name ?? "-" },
            { key: "assessment", label: t("parentPages.assessment"), render: (_: any, row: any) => row.exam?.name ?? row.component?.name ?? row.component_name ?? "-" },
            { key: "score", label: t("parentPages.score"), sortable: true, render: (v: any, row: any) => renderGrade(v ?? row.marks_obtained ?? null) },
            { key: "date", label: t("parentPages.date"), sortable: true, hide: "lg", render: (v: any) => renderDate(v) },
            { key: "status", label: t("common.status"), render: (v: any) => renderStatus(v) },
          ]}
          emptyMessage={t("parentPages.noGrades")}
          emptyIcon="UI"
        />
      )}
    </div>
  );
}
