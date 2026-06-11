import { useQuery } from "@tanstack/react-query";
import { Student } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { format } from "date-fns";

export default function StudentAttendance() {
  const { t } = useTranslation();
  
  const { data, isLoading } = useQuery({
    queryKey: ["student", "attendance"],
    queryFn: Student.attendance,
  }) as any;

  const records = Array.isArray(data) ? data : (data?.data ?? []);

  const getStatusColor = (status: string) => {
    switch(status) {
      case 'present': return 'default';
      case 'absent': return 'destructive';
      case 'late': return 'secondary';
      case 'excused': return 'outline';
      default: return 'outline';
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.attendance")}</h1>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>{t("common.date")}</TableHead>
              <TableHead>{t("common.status")}</TableHead>
              <TableHead>{t("common.notes")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              <TableRow>
                <TableCell colSpan={3} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow>
            ) : records.length === 0 ? (
              <TableRow>
                <TableCell colSpan={3} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow>
            ) : (
              records.map((record: any, idx: number) => (
                <TableRow key={idx}>
                  <TableCell className="font-medium">
                    {record.date ? format(new Date(record.date), 'MMM d, yyyy') : '-'}
                  </TableCell>
                  <TableCell>
                    <Badge variant={getStatusColor(record.status)} className="capitalize">
                      {t(`common.${record.status}`)}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-muted-foreground">
                    {record.note || '-'}
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>
    </div>
  );
}
