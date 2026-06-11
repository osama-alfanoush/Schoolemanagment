import { useQuery } from "@tanstack/react-query";
import { useAuth } from "@/lib/auth";
import { Admin } from "@/lib/api";
import { cn } from "@/lib/utils";
import StatCard from "@/components/ui/StatCard";
import BrandCard from "@/components/ui/BrandCard";
import BrandBadge from "@/components/ui/BrandBadge";
import BrandAvatar from "@/components/ui/BrandAvatar";
import { Link } from "wouter";
import { useTranslation } from "react-i18next";
import {
  PieChart,
  Pie,
  Cell,
  ResponsiveContainer,
  Tooltip,
} from "recharts";

/* ─── Donut chart colors ─── */
const DONUT_COLORS = {
  present: "#43D9A2",
  absent: "#FF5C5C",
  late: "#FFB347",
};

/* ─── Quick action cards config ─── */
const getQuickActions = (t: (k: string) => string) => [
  { label: t("adminDashboard.actionManageUsers"), emoji: "👤", href: "/admin/users", gradient: "gradient-purple" },
  { label: t("adminDashboard.actionClassesTimetable"), emoji: "🏫", href: "/admin/classes", gradient: "gradient-mint" },
  { label: t("adminDashboard.actionAcademicCalendar"), emoji: "📅", href: "/admin/calendar", gradient: "gradient-ocean" },
  { label: t("adminDashboard.actionAttendanceReport"), emoji: "📋", href: "/admin/attendance", gradient: "gradient-pink" },
  { label: t("adminDashboard.actionFinancialReport"), emoji: "💰", href: "/finance/reports", gradient: "gradient-pink" },
  { label: t("adminDashboard.actionHrManagement"), emoji: "👥", href: "/admin/hr-requests", gradient: "gradient-purple" },
  { label: t("adminDashboard.actionAnnouncements"), emoji: "📢", href: "/admin/announcements", gradient: "gradient-sunset" },
  { label: t("adminDashboard.actionAuditLogs"), emoji: "🔍", href: "/admin/audit", gradient: "gradient-ocean" },
];

/* ─── Build system health from API response ─── */
function buildSystemHealth(health: any, t: (k: string) => string) {
  if (!health) return [];
  return [
    {
      label: t("health.apiServer"),
      status: health.status === "ok" ? "online" : "degraded",
      detail: health.status === "ok" ? t("health.online") : t("health.degraded"),
    },
    {
      label: t("health.database"),
      status: health.checks?.database?.status === "ok" ? "online" : "error",
      detail: health.checks?.database?.status === "ok" ? t("health.connected") : t("health.error"),
    },
    {
      label: t("health.redis"),
      status: health.checks?.redis?.status === "ok" ? "online" : "error",
      detail: health.checks?.redis?.status === "ok" ? t("health.connected") : t("health.error"),
    },
    {
      label: t("health.storage"),
      status: (health.checks?.storage?.free_percent ?? 100) > 10 ? "online" : "error",
      detail: health.checks?.storage
        ? `${health.checks.storage.free_percent}% ${t("health.free")}`
        : t("health.unknown"),
      pct: health.checks?.storage?.used_percent ?? undefined,
    },
  ];
}

function unwrapData<T = any>(payload: any): T {
  return (payload?.data ?? payload) as T;
}

function unwrapList(payload: any): any[] {
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload?.data)) return payload.data;
  if (Array.isArray(payload?.data?.data)) return payload.data.data;
  return [];
}

/* ─── Main Component ─── */
export default function AdminDashboardPage() {
  const { user } = useAuth();
  const { t, i18n } = useTranslation();

  const { data: kpis, isLoading } = useQuery({
    queryKey: ["admin", "kpis"],
    queryFn: Admin.kpis,
  }) as any;

  const { data: hrRequests } = useQuery({
    queryKey: ["admin", "hr-requests"],
    queryFn: () => Admin.hrRequests(),
  }) as any;

  const { data: auditLogs } = useQuery({
    queryKey: ["admin", "audit-logs"],
    queryFn: () => Admin.auditLogs(),
  }) as any;

  const { data: announcements } = useQuery({
    queryKey: ["admin", "announcements"],
    queryFn: () => Admin.getAnnouncements(),
  }) as any;

  const { data: healthData } = useQuery({
    queryKey: ["admin", "system-health"],
    queryFn: () => fetch("/api/health").then(r => r.json()),
    refetchInterval: 30000,
  }) as any;

  const systemHealth = buildSystemHealth(healthData, t);
  const quickActions = getQuickActions(t);
  const kpiData = unwrapData<any>(kpis);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-brand-purple border-t-transparent" />
      </div>
    );
  }

  const attendanceData = [
    { name: t("common.present"), value: kpiData?.present_count || 850, key: "present" },
    { name: t("common.absent"), value: kpiData?.absent_count || 30, key: "absent" },
    { name: t("common.late"), value: kpiData?.late_count || 20, key: "late" },
  ];

  const pendingHr: any[] = unwrapList(hrRequests).filter((r: any) => r.status === "pending").slice(0, 4);

  const recentLogs: any[] = unwrapList(auditLogs).slice(0, 5);

  const recentAnnouncements: any[] = unwrapList(announcements).slice(0, 3);

  const today = new Date().toLocaleDateString(i18n.language === "ar" ? "ar-EG" : "en-US", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return (
    <div className="space-y-6">
      {/* ── SECTION 1: Header Banner ── */}
      <div className="gradient-ocean rounded-2xl p-6 md:p-8 flex flex-col md:flex-row items-start md:items-center justify-between relative overflow-hidden">
        <div className="absolute -bottom-8 -right-8 w-40 h-40 rounded-full bg-card/10" />
        <div>
          <h1 className="font-display text-3xl text-white font-bold">
            {t("adminDashboard.title")}
          </h1>
          <p className="text-white/70 mt-1 text-sm">{today}</p>
          <p className="text-white/50 text-xs mt-0.5">
            {t("adminDashboard.academicYear")} {kpiData?.academic_year ?? new Date().getFullYear()}-{new Date().getFullYear() + 1}
          </p>
        </div>
        <div className="flex flex-wrap gap-2 mt-4 md:mt-0 z-10">
          <Link
            href="/admin/users"
            className="px-4 py-2 rounded-xl border border-white/30 text-white text-sm font-medium hover:bg-card/10 transition-colors"
          >
            {t("adminDashboard.addUser")}
          </Link>
          <Link
            href="/admin/announcements"
            className="px-4 py-2 rounded-xl border border-white/30 text-white text-sm font-medium hover:bg-card/10 transition-colors"
          >
            {t("adminDashboard.addAnnouncement")}
          </Link>
          <button className="px-4 py-2 rounded-xl border border-white/30 text-white text-sm font-medium hover:bg-card/10 transition-colors">
            {t("adminDashboard.monthlyReport")}
          </button>
        </div>
      </div>

      {/* ── SECTION 2: KPI Stats ── */}
      <div className="grid grid-cols-2 lg:grid-cols-3 gap-4">
        <StatCard
          title={t("adminDashboard.totalStudents")}
          value={kpiData?.students ?? 0}
          icon={<span className="text-lg">🎓</span>}
        />
        <StatCard
          title={t("adminDashboard.totalTeachers")}
          value={kpiData?.teachers ?? 0}
          icon={<span className="text-lg">📖</span>}
        />
        <StatCard
          title={t("adminDashboard.totalStaff")}
          value={kpiData?.staff ?? 0}
          icon={<span className="text-lg">👥</span>}
        />
        <StatCard
          title={t("adminDashboard.todayAttendance")}
          value={`${kpiData?.today_attendance_rate ?? 95.2}%`}
          icon={<span className="text-lg">✅</span>}
        />
        <StatCard
          title={t("adminDashboard.pendingRequests")}
          value={kpiData?.pending_hr_requests ?? 0}
          icon={<span className="text-lg">📋</span>}
        />
        <StatCard
          title={t("adminDashboard.outstandingFees")}
          value={`$${(kpiData?.outstanding_fees ?? 12400).toLocaleString()}`}
          icon={<span className="text-lg">💰</span>}
        />
      </div>

      {/* ── SECTION 3: Two-column layout ── */}
      <div className="grid lg:grid-cols-2 gap-6">
        {/* LEFT: Attendance Donut */}
        <BrandCard>
          <div className="flex items-center justify-between mb-4">
            <h3 className="font-display text-lg font-bold text-ink-dark">{t("adminDashboard.attendanceOverview")}</h3>
            <div className="flex gap-1">
              {[t("adminDashboard.today"), t("adminDashboard.thisWeek"), t("adminDashboard.thisMonth")].map((f, i) => (
                <button
                  key={f}
                  className={cn(
                    "px-3 py-1 rounded-lg text-xs font-medium transition-colors",
                    i === 0 ? "gradient-purple text-white" : "text-ink-muted hover:bg-surface-bg"
                  )}
                >
                  {f}
                </button>
              ))}
            </div>
          </div>
          <div className="flex items-center gap-6">
            <div className="w-40 h-40 shrink-0">
              <ResponsiveContainer width="100%" height="100%">
                <PieChart>
                  <Pie
                    data={attendanceData}
                    cx="50%"
                    cy="50%"
                    innerRadius={50}
                    outerRadius={70}
                    paddingAngle={4}
                    dataKey="value"
                  >
                    {attendanceData.map((entry, i) => (
                      <Cell key={i} fill={DONUT_COLORS[entry.key as keyof typeof DONUT_COLORS]} />
                    ))}
                  </Pie>
                  <Tooltip
                    contentStyle={{
                      borderRadius: "1rem",
                      border: "1px solid #E5E3FF",
                      fontSize: "0.75rem",
                    }}
                  />
                </PieChart>
              </ResponsiveContainer>
            </div>
            <div className="space-y-3 flex-1">
              {attendanceData.map((d) => (
                <div key={d.key} className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <span
                      className="w-3 h-3 rounded-full"
                      style={{ backgroundColor: DONUT_COLORS[d.key as keyof typeof DONUT_COLORS] }}
                    />
                    <span className="text-sm text-ink-dark">{d.name}</span>
                  </div>
                  <span className="font-semibold text-sm text-ink-dark">{d.value}</span>
                </div>
              ))}
            </div>
          </div>
        </BrandCard>

        {/* RIGHT: HR Requests + Announcements */}
        <div className="space-y-6">
          {/* Pending HR Requests */}
          <BrandCard className="!p-0 overflow-hidden">
            <div className="flex items-center justify-between p-5 pb-3">
              <h3 className="font-display text-base font-bold text-ink-dark">{t("adminDashboard.pendingHrRequests")}</h3>
              <Link href="/admin/hr-requests" className="text-brand-purple text-xs font-medium hover:underline">{t("studentDashboard.viewAll")}</Link>
            </div>
            <div className="px-5 pb-5 space-y-2.5">
              {pendingHr.length > 0 ? pendingHr.map((r: any, i: number) => (
                <div key={i} className="flex items-center gap-3 p-3 rounded-xl bg-surface-bg/60">
                  <BrandAvatar name={r.user?.name ?? "Staff"} size="sm" />
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold text-sm text-ink-dark truncate">{r.user?.name ?? "Staff"}</p>
                    <BrandBadge
                      label={r.type ?? "Leave"} variant={r.type === "Advance" ? "amber" : r.type === "General" ? "lavender" : "purple"}
                    />
                  </div>
                  <div className="text-right shrink-0 rtl:text-left">
                    <p className="text-xs text-ink-muted">{new Date(r.created_at).toLocaleDateString(i18n.language === "ar" ? "ar-EG" : "en-US")}</p>
                    <Link href="/admin/hr-requests" className="text-brand-purple text-xs font-medium hover:underline">{t("adminDashboard.pendingHrRequests").split(" ")[0]} →</Link>
                  </div>
                </div>
              )) : (
                <p className="text-sm text-muted-foreground/70 text-center py-4">✅ {t("common.empty")}</p>
              )}
            </div>
          </BrandCard>

          {/* Recent Announcements */}
          <BrandCard className="!p-0 overflow-hidden">
            <div className="flex items-center justify-between p-5 pb-3">
              <h3 className="font-display text-base font-bold text-ink-dark">{t("adminDashboard.recentAnnouncements")}</h3>
              <Link href="/admin/announcements" className="text-brand-purple text-xs font-medium hover:underline">{t("adminDashboard.newAnnouncement")}</Link>
            </div>
            <div className="px-5 pb-5 space-y-2.5">
              {recentAnnouncements.length > 0 ? recentAnnouncements.map((a: any, i: number) => (
                <div
                  key={i}
                  className="ps-3 py-2 border-s-4 border-s-brand-purple bg-brand-purple/5 rounded-e-lg"
                >
                  <p className="font-medium text-sm text-ink-dark">{a.title}</p>
                  <p className="text-xs text-ink-muted mt-0.5">
                    {a.audience} • {new Date(a.created_at).toLocaleDateString(i18n.language === "ar" ? "ar-EG" : "en-US")}
                  </p>
                </div>
              )) : (
                <div className="text-center py-6 text-muted-foreground/70">
                  <div className="text-3xl mb-2">📢</div>
                  <p className="text-sm">{t("common.empty")}</p>
                </div>
              )}
            </div>
          </BrandCard>
        </div>
      </div>

      {/* ── SECTION 4: Quick Actions Grid ── */}
      <div>
        <h3 className="font-display text-lg font-bold text-ink-dark mb-4">{t("adminDashboard.quickActions")}</h3>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
          {quickActions.map((action) => (
            <Link
              key={action.label}
              href={action.href}
              className="bg-card rounded-2xl p-5 flex flex-col items-center gap-3 shadow-card hover:shadow-hover hover:-translate-y-1 transition-all duration-300 cursor-pointer group"
            >
              <div className={cn("w-12 h-12 rounded-xl flex items-center justify-center text-2xl", action.gradient)}>
                {action.emoji}
              </div>
              <span className="text-sm font-medium text-ink-dark text-center group-hover:text-brand-purple transition-colors">
                {action.label}
              </span>
            </Link>
          ))}
        </div>
      </div>

      {/* ── SECTION 5: Bottom row ── */}
      <div className="grid lg:grid-cols-2 gap-6">
        {/* Recent Activity */}
        <BrandCard className="!p-0 overflow-hidden">
          <div className="p-5 pb-3">
            <h3 className="font-display text-base font-bold text-ink-dark">{t("adminDashboard.recentActivity")}</h3>
          </div>
          <div className="px-5 pb-5">
            <div className="relative ps-6 space-y-3">
              <div className="absolute start-2 top-1 bottom-1 w-0.5 bg-surface-border" />
              {recentLogs.length > 0 ? recentLogs.map((log: any, i: number) => {
                const typeColor: Record<string, string> = {
                  create: "bg-brand-mint",
                  finance: "bg-brand-amber",
                  hr: "bg-brand-lavender",
                  grade: "bg-brand-sky",
                  default: "bg-brand-purple",
                };
                const dot = typeColor[log.type] || typeColor.default;
                return (
                  <div key={i} className="relative">
                    <div className={cn("absolute -start-5 top-1.5 w-3 h-3 rounded-full border-2 border-white", dot)} />
                    <div className="flex items-start gap-2">
                      <BrandAvatar name={log.user?.name ?? "User"} size="sm" />
                      <div>
                        <p className="text-sm text-ink-dark">
                          <span className="font-semibold">{log.user?.name}</span> {log.action}
                        </p>
                        <p className="text-xs text-ink-muted mt-0.5">
                          {new Date(log.created_at).toLocaleString(i18n.language === "ar" ? "ar-EG" : "en-US")}
                        </p>
                      </div>
                    </div>
                  </div>
                );
              }) : (
                <p className="text-sm text-muted-foreground/70 text-center py-4">{t("common.empty")}</p>
              )}
            </div>
          </div>
        </BrandCard>

        {/* System Health */}
        <BrandCard>
          <h3 className="font-display text-base font-bold text-ink-dark mb-4">{t("adminDashboard.systemHealth")}</h3>
          <div className="space-y-3">
            {systemHealth.map((s) => (
              <div key={s.label} className="flex items-center justify-between p-3 rounded-xl bg-surface-bg/60">
                <div className="flex items-center gap-2">
                  <span
                    className={cn(
                      "w-2.5 h-2.5 rounded-full",
                      s.status === "online" ? "bg-brand-mint" : "bg-brand-red"
                    )}
                  />
                  <span className="text-sm font-medium text-ink-dark">{s.label}</span>
                </div>
                <div className="flex items-center gap-2">
                  {s.pct !== undefined && (
                    <div className="w-20 h-1.5 rounded-full bg-surface-border overflow-hidden">
                      <div className="h-full rounded-full bg-brand-amber" style={{ width: `${s.pct}%` }} />
                    </div>
                  )}
                  <BrandBadge
                    label={s.detail} variant={s.status === "online" ? "mint" : "red"}
                  />
                </div>
              </div>
            ))}
          </div>
        </BrandCard>
      </div>
    </div>
  );
}
