import BrandButton from "@/components/ui/BrandButton";
import { useQuery } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Play } from "lucide-react";
import { format } from "date-fns";
export default function FinancePayroll() {
  const {
    t
  } = useTranslation();
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["finance", "payroll"],
    queryFn: () => Finance.payroll()
  }) as any;
  const payrolls = data ?? [];
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.payroll")}</h1>
        <BrandButton>
          <Play className="me-2 h-4 w-4" />
          Process Payroll
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Staff</TableHead>
              <TableHead>Role</TableHead>
              <TableHead>Base Salary</TableHead>
              <TableHead>Deductions</TableHead>
              <TableHead>Net Pay</TableHead>
              <TableHead>Status</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={7} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : payrolls.length === 0 ? <TableRow>
                <TableCell colSpan={7} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : payrolls.map((pr: any) => <TableRow key={pr.id}>
                  <TableCell className="font-medium">{pr.staff?.name || "Unknown"}</TableCell>
                  <TableCell className="capitalize">{pr.staff?.role || "-"}</TableCell>
                  <TableCell>${parseFloat(pr.base_salary).toFixed(2)}</TableCell>
                  <TableCell className="text-destructive">
                    ${parseFloat(pr.deductions).toFixed(2)}
                  </TableCell>
                  <TableCell className="font-bold">
                    ${parseFloat(pr.net_pay).toFixed(2)}
                  </TableCell>
                  <TableCell>
                    <Badge variant={pr.status === "paid" ? "default" : "secondary"}>
                      {pr.status}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-right space-x-2 rtl:space-x-reverse">
                    <BrandButton variant="ghost" size="sm" disabled={pr.status === "paid"}>Mark Paid</BrandButton>
                  </TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </div>;
}