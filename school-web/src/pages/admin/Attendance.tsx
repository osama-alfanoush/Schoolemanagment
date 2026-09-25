import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import PageHeader from "@/components/ui/PageHeader";
import DataTable from "@/components/ui/DataTable";
import SearchAndFilter from "@/components/ui/SearchAndFilter";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";

export default function AdminAttendance() {
  const { t } = useTranslation();
  const today = new Date().toISOString().slice(0, 10);
  const [selectedDate, setSelectedDate] = useState(today);
  const [search, setSearch] = useState("");
  const [activeFilters, setActiveFilters] = useState<Record<string, string>>({});

  const { data: dashboard, isLoading: dashboardLoading } = useQuery({
    queryKey: ["admin", "attendance-dashboard", selectedDate],
    queryFn: () => Admin.attendanceDashboard(),
  }) as any;
  const todayData = dashboard?.today ?? {};
  const presentCount = todayData.present ?? 0;
  const absentCount = todayData.absent ?? 0;
  const lateCount = todayData.late ?? 0;
  const totalAttended = presentCount + absentCount + lateCount;
  const rate = totalAttended > 0 ? Math.round((presentCount / totalAttended) * 100) : 0;

  const byClass = Array.isArray(dashboard?.by_class) ? dashboard.by_class : [];

  return (
    <div className="space-y-6">
      <PageHeader icon="UI" title={t("adminPages.attendanceOverview")} subtitle={t("adminPages.attendanceSubtitle")} />

      <div className="grid grid-cols-4 gap-4 mb-6">
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">{t("adminPages.presentToday")}</p>
          <p className="text-2xl font-bold text-green-600 mt-1">{presentCount}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">{t("adminPages.absentToday")}</p>
          <p className="text-2xl font-bold text-red-600 mt-1">{absentCount}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">{t("adminPages.lateToday")}</p>
          <p className="text-2xl font-bold text-amber-600 mt-1">{lateCount}</p>
        </BrandCard>
        <BrandCard className="p-4">
          <p className="text-xs text-muted-foreground">{t("adminPages.attendanceRate")}</p>
          <p className="text-2xl font-bold mt-1" style={{ color: "var(--color-primary)" }}>{rate}%</p>
        </BrandCard>
      </div>

      <div className="flex items-center gap-3 mb-4">
        <span className="text-sm text-muted-foreground">Date:</span>
        <input
          type="date"
          value={selectedDate}
          onChange={(e) => setSelectedDate(e.target.value)}
          className="border border-border rounded-xl px-3 py-2 text-sm outline-none focus:border-brand-purple focus:ring-2 focus:ring-brand-purple/20"
        />
        <BrandButton variant="secondary" size="sm" onClick={() => setSelectedDate(today)}>
          Today
        </BrandButton>
      </div>

      {byClass.length === 0 && !dashboardLoading ? (
        <BrandEmptyState icon="UI" title={t("adminPages.noAttendanceRecords")} subtitle={t("adminPages.noAttendanceData")} />
      ) : (
        <DataTable
          title={t("adminPages.attendanceRecords")}
          data={byClass}
          isLoading={dashboardLoading}
          columns={[
            { key: "class", label: t("adminPages.classLabel"), render: (_: any, row: any) => `Class #${row.class_room_id}` },
            { key: "present", label: t("status.present"), sortable: true },
            { key: "absent", label: t("status.absent"), sortable: true },
            { key: "late", label: t("status.late"), sortable: true },
          ]}
          toolbar={
            <SearchAndFilter
              placeholder={t("adminPages.searchStudents")}
              value={search}
              onChange={setSearch}
              filters={[
                { key: "status", label: t("common.status"), options: [
                  { value: "present", label: t("status.present") },
                  { value: "absent", label: t("status.absent") },
                  { value: "late", label: t("status.late") },
                  { value: "excused", label: t("status.excused") },
                ]},
              ]}
              activeFilters={activeFilters}
              onFilterChange={(key, val) => setActiveFilters((p) => ({ ...p, [key]: val }))}
              onClearFilters={() => setActiveFilters({})}
            />
          }
        />
      )}
    </div>
  );
}
