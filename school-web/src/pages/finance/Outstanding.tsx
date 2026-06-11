import BrandButton from "@/components/ui/BrandButton";
import { useQuery } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
export default function FinanceOutstanding() {
  const {
    t
  } = useTranslation();
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["finance", "outstanding"],
    queryFn: () => Finance.outstanding()
  }) as any;
  const accounts = data ?? [];
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">Outstanding Accounts</h1>
        <BrandButton variant="outline">Send Reminders</BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Student</TableHead>
              <TableHead>Total Outstanding</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={3} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : accounts.length === 0 ? <TableRow>
                <TableCell colSpan={3} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : accounts.map((acc: any, i: number) => <TableRow key={i}>
                  <TableCell className="font-medium">{acc.student_name}</TableCell>
                  <TableCell className="text-destructive font-medium">${parseFloat(acc.total_outstanding).toFixed(2)}</TableCell>
                  <TableCell className="text-right">
                    <BrandButton variant="ghost" size="sm">View Details</BrandButton>
                  </TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </div>;
}