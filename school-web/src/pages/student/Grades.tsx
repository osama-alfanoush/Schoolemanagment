import { useQuery } from "@tanstack/react-query";
import { Student } from "@/lib/api";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import { Badge } from "@/components/ui/badge";

export default function StudentGrades() {
  const { t } = useTranslation();
  
  const { data, isLoading } = useQuery({
    queryKey: ["student", "grades"],
    queryFn: Student.grades,
  }) as any;

  const grades = Array.isArray(data) ? data : (data?.data ?? []);

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.grades")}</h1>
      </div>

      <div>
        <DataTable
          columns={[
            {
              key: "component.subject.name",
              label: t("studentPages.subject"),
              sortable: true,
              render: (_, grade) => <span className="font-medium">{grade.component?.subject?.name || t("studentPages.unknownSubject")}</span>,
            },
            { key: "term", label: "Term", sortable: true },
            {
              key: "component.name",
              label: t("studentPages.component"),
              sortable: true,
              render: (_, grade) => grade.component?.name || t("studentPages.overall"),
            },
            {
              key: "score",
              label: t("studentPages.score"),
              sortable: true,
              render: (_, grade) => <span className="font-medium">{grade.score} / {grade.component?.max_score}</span>,
            },
            {
              key: "percentage",
              label: t("studentPages.percentage"),
              sortable: true,
              render: (_, grade) => {
                const ratio = grade.component?.max_score ? grade.score / grade.component.max_score : 0;
                return (
                  <Badge
                    variant={
                      ratio >= 0.9 ? "default" : ratio >= 0.7 ? "secondary" : "destructive"
                    }
                  >
                    {Math.round(ratio * 100)}%
                  </Badge>
                );
              },
            },
          ]}
          data={grades}
          isLoading={isLoading}
          emptyMessage={t("common.empty")}
        />
      </div>
    </div>
  );
}
