import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Finance } from "@/lib/api";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { DollarSign, FileText, AlertCircle, Users } from "lucide-react";
export default function FinanceDashboard() {
  const {
    t
  } = useTranslation();
  const {
    data: reports,
    isLoading
  } = useQuery({
    queryKey: ["finance", "reports"],
    queryFn: () => Finance.reports()
  }) as any;
  const {
    data: outstanding
  } = useQuery({
    queryKey: ["finance", "outstanding"],
    queryFn: Finance.outstanding
  }) as any;
  if (isLoading) return <div className="p-8">{t("common.loading")}</div>;
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.dashboard")}</h1>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("financeDashboard.totalRevenue")}</CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${reports?.total_revenue || 0}</div>
          </CardContent>
        </BrandCard>
        
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("financeDashboard.invoicesIssued")}</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{reports?.total_invoices || 0}</div>
          </CardContent>
        </BrandCard>
        
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("financeDashboard.outstandingAccounts")}</CardTitle>
            <AlertCircle className="h-4 w-4 text-destructive" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{outstanding?.length || 0}</div>
          </CardContent>
        </BrandCard>

        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("financeDashboard.payrollProcessed")}</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{reports?.payroll_count || 0}</div>
          </CardContent>
        </BrandCard>
      </div>
    </div>;
}