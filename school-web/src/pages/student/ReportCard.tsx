import { useQuery } from "@tanstack/react-query";
import { Student } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";

export default function StudentReportCard() {
  const { t } = useTranslation();
  
  const { data, isLoading } = useQuery({
    queryKey: ["student", "report-card"],
    queryFn: Student.reportCard,
  }) as any;

  const reports = Array.isArray(data) ? data : data?.data || [];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.reportCard")}</h1>
      </div>

      <div className="border rounded-md p-6 bg-card">
        {isLoading ? (
          <div className="text-center py-8">{t("common.loading")}</div>
        ) : reports.length === 0 ? (
          <div className="text-center py-8 text-muted-foreground">{t("common.empty")}</div>
        ) : (
          <div className="space-y-6">
            {reports.map((report: any, idx: number) => (
              <div key={idx} className="space-y-4">
                <h3 className="text-lg font-semibold border-b pb-2">{report.term || "Term Report"}</h3>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Subject</TableHead>
                      <TableHead>Score</TableHead>
                      <TableHead>Grade</TableHead>
                      <TableHead>Remarks</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {report.subjects?.map((sub: any, i: number) => (
                      <TableRow key={i}>
                        <TableCell className="font-medium">{sub.name}</TableCell>
                        <TableCell>{sub.score} / {sub.max_score}</TableCell>
                        <TableCell>{sub.grade}</TableCell>
                        <TableCell className="text-muted-foreground">{sub.remarks || "-"}</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
