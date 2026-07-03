import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Hr } from "@/lib/api";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Users, Clock, CheckCircle, Briefcase } from "lucide-react";
import { toArray } from "@/lib/response";
import { Link } from "wouter";

export default function HrDashboard() {
  const {
    t
  } = useTranslation();
  const {
    data: staff,
    isLoading: isLoadingStaff
  } = useQuery({
    queryKey: ["hr", "staff"],
    queryFn: () => Hr.staff()
  }) as any;
  const {
    data: leave,
    isLoading: isLoadingLeave
  } = useQuery({
    queryKey: ["hr", "leave-requests", "pending"],
    queryFn: () => Hr.leaveRequests("pending")
  }) as any;
  const {
    data: hrReqs,
    isLoading: isLoadingHrReqs
  } = useQuery({
    queryKey: ["hr", "requests", "pending"],
    queryFn: () => Hr.requests("pending")
  }) as any;

  if (isLoadingStaff || isLoadingLeave || isLoadingHrReqs) return <div className="p-8">{t("common.loading")}</div>;

  const staffList = toArray(staff);
  const leaveRequests = toArray(leave);
  const pendingHrRequests = toArray(hrReqs);

  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.dashboard")}</h1>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("hrDashboard.totalStaff")}</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {staffList.length}
            </div>
          </CardContent>
        </BrandCard>
        
        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("hrDashboard.pendingLeave")}</CardTitle>
            <Clock className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {leaveRequests.length}
            </div>
          </CardContent>
        </BrandCard>

        <Link href="/hr/requests">
          <BrandCard hover className="shadow-academic border-surface-border">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Pending HR Requests</CardTitle>
              <Briefcase className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {pendingHrRequests.length}
              </div>
              <p className="text-xs text-muted-foreground mt-1">Click to review →</p>
            </CardContent>
          </BrandCard>
        </Link>

        <BrandCard className="shadow-academic border-surface-border">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("hrDashboard.presentToday")}</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">--</div>
          </CardContent>
        </BrandCard>
      </div>
    </div>;
}