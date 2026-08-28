import BrandButton from "@/components/ui/BrandButton";
import { useQuery, useMutation } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
export default function FinanceOutstanding() {
  const {
    t
  } = useTranslation();
  const { toast } = useToast();
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["finance", "outstanding"],
    queryFn: () => Finance.outstanding()
  }) as any;
  const accounts = Array.isArray(data) ? data : data?.data ?? [];
  const reminders = useMutation({
    mutationFn: () => Finance.sendReminders(),
    onSuccess: (res: any) => toast({ title: t("financePages.remindersSent"), description: `${res?.reminded ?? 0} notified.` }),
    onError: (e: any) => toast({ variant: "destructive", title: t("financePages.failed"), description: e?.data?.message ?? e?.message }),
  });
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("financePages.outstandingAccountsTitle")}</h1>
        <BrandButton variant="outline" onClick={() => reminders.mutate()} disabled={reminders.isPending}>
          {reminders.isPending ? t("common.loading") : t("financePages.sendReminders")}
        </BrandButton>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>{t("financePages.student")}</TableHead>
              <TableHead className="text-right">{t("financePages.totalOutstanding")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={2} className="text-center p-8">{t("common.loading")}</TableCell>
              </TableRow> : accounts.length === 0 ? <TableRow>
                <TableCell colSpan={2} className="text-center p-8 text-muted-foreground">{t("common.empty")}</TableCell>
              </TableRow> : accounts.map((acc: any, i: number) => <TableRow key={i}>
                  <TableCell className="font-medium">{acc.student?.name ?? acc.student_name ?? t("financePages.unknown")}</TableCell>
                  <TableCell className="text-destructive font-medium text-right">${Number(acc.outstanding ?? acc.total_outstanding ?? 0).toFixed(2)}</TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </div>;
}