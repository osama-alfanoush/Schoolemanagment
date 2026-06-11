import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Users, GraduationCap, Building, FileText } from "lucide-react";
export default function AdminDashboard() {
  const {
    t
  } = useTranslation();
  const {
    data: kpis,
    isLoading
  } = useQuery({
    queryKey: ["admin", "kpis"],
    queryFn: Admin.kpis
  }) as any;
  if (isLoading) return <div className="p-8">{t("common.loading")}</div>;
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.dashboard")}</h1>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Students</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{kpis?.students || 0}</div>
          </CardContent>
        </BrandCard>
        
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Teachers</CardTitle>
            <Building className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{kpis?.teachers || 0}</div>
          </CardContent>
        </BrandCard>
        
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Classes</CardTitle>
            <GraduationCap className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{kpis?.classes || 0}</div>
          </CardContent>
        </BrandCard>
        
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Pending HR Requests</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{kpis?.pending_hr_requests || 0}</div>
          </CardContent>
        </BrandCard>
      </div>
    </div>;
}