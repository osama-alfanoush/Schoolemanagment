import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Student } from "@/lib/api";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
export default function StudentDashboard() {
  const {
    t
  } = useTranslation();
  const {
    data: dashboard,
    isLoading
  } = useQuery({
    queryKey: ["student", "dashboard"],
    queryFn: Student.dashboard
  }) as any;
  if (isLoading) return <div>{t("common.loading")}</div>;
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.dashboard")}</h1>
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Pending Assignments</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{dashboard?.pending_assignments || 0}</div>
          </CardContent>
        </BrandCard>
      </div>
    </div>;
}