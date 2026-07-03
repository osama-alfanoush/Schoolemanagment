import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";
import { Play } from "lucide-react";

const MONTHS = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
];

export default function FinancePayroll() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const now = new Date();
  const [year, setYear] = useState(now.getFullYear());
  const [month, setMonth] = useState(now.getMonth() + 1);

  const { data, isLoading } = useQuery({
    queryKey: ["finance", "payroll", year, month],
    queryFn: () => Finance.payrollFor(year, month),
  }) as any;
  const payrolls = Array.isArray(data) ? data : data?.data ?? [];

  const invalidate = () => void qc.invalidateQueries({ queryKey: ["finance", "payroll", year, month] });

  const process = useMutation({
    mutationFn: () => Finance.processPayroll(year, month),
    onSuccess: (res: any) => {
      invalidate();
      toast({ title: "Payroll processed", description: `${res?.processed ?? 0} records.` });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const markPaid = useMutation({
    mutationFn: (id: number) => Finance.markPayrollPaid(id),
    onSuccess: () => { invalidate(); toast({ title: "Marked as paid" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const selectClass = "rounded-md border bg-background px-3 py-2 text-sm";

  return <div className="space-y-6">
      <div className="flex justify-between items-center flex-wrap gap-3">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.payroll")}</h1>
        <div className="flex items-center gap-2 flex-wrap">
          <select className={selectClass} value={month} onChange={e => setMonth(Number(e.target.value))}>
            {MONTHS.map((m, i) => <option key={m} value={i + 1}>{m}</option>)}
          </select>
          <select className={selectClass} value={year} onChange={e => setYear(Number(e.target.value))}>
            {Array.from({ length: 6 }, (_, i) => now.getFullYear() - i).map(y => <option key={y} value={y}>{y}</option>)}
          </select>
          <BrandButton onClick={() => { if (confirm(`Process payroll for ${MONTHS[month - 1]} ${year}?`)) process.mutate(); }} disabled={process.isPending}>
            <Play className="me-2 h-4 w-4" />
            {process.isPending ? t("common.loading") : "Process Payroll"}
          </BrandButton>
        </div>
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
                <TableCell colSpan={7} className="text-center p-8 text-muted-foreground">No payroll for this period — use “Process Payroll”.</TableCell>
              </TableRow> : payrolls.map((pr: any) => {
                  const deductions = Number(pr.deductions ?? 0) + Number(pr.advance_deduction ?? 0);
                  return <TableRow key={pr.id}>
                  <TableCell className="font-medium">{pr.staff?.name || "Unknown"}</TableCell>
                  <TableCell className="capitalize">{pr.staff?.role || "-"}</TableCell>
                  <TableCell>${Number(pr.base_salary ?? 0).toFixed(2)}</TableCell>
                  <TableCell className="text-destructive">${deductions.toFixed(2)}</TableCell>
                  <TableCell className="font-bold">${Number(pr.net_pay ?? 0).toFixed(2)}</TableCell>
                  <TableCell>
                    <Badge variant={pr.status === "paid" ? "default" : "secondary"} className="capitalize">
                      {pr.status}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-right space-x-2 rtl:space-x-reverse">
                    <BrandButton
                      variant="ghost"
                      size="sm"
                      disabled={pr.status === "paid" || (markPaid.isPending && markPaid.variables === pr.id)}
                      onClick={() => markPaid.mutate(pr.id)}
                    >
                      Mark Paid
                    </BrandButton>
                  </TableCell>
                </TableRow>;
                })}
          </TableBody>
        </Table>
      </div>
    </div>;
}
