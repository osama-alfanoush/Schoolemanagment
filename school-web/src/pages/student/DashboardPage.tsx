import { useQuery } from "@tanstack/react-query";
import { useAuth } from "@/lib/auth";
import { Student } from "@/lib/api";
import { cn } from "@/lib/utils";
import StatCard from "@/components/ui/StatCard";
import BrandCard from "@/components/ui/BrandCard";
import BrandBadge from "@/components/ui/BrandBadge";
import BrandAvatar from "@/components/ui/BrandAvatar";
import { Link } from "wouter";
import { useTranslation } from "react-i18next";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";

/* ─── Helpers ─── */
function getGreeting(t: (k: string) => string) {
  const h = new Date().getHours();
  if (h < 12) return t("studentDashboard.greetingMorning");
  if (h < 17) return t("studentDashboard.greetingAfternoon");
  return t("studentDashboard.greetingEvening");
}

function daysUntil(dateStr: string) {
  const diff = new Date(dateStr).getTime() - Date.now();
  return Math.ceil(diff / 86400000);
}

const subjectColors = [
  "bg-brand-purple",
  "bg-brand-pink",
  "bg-brand-mint",
  "bg-brand-sky",
  "bg-brand-amber",
  "bg-brand-lavender",
  "bg-brand-red",
  "bg-brand-orange",
];

function subjectColor(name: string) {
  let hash = 0;
  for (let i = 0; i < name.length; i++) hash = name.charCodeAt(i) + ((hash << 5) - hash);
  return subjectColors[Math.abs(hash) % subjectColors.length];
}

function scoreColor(pct: number) {
  if (pct >= 80) return "bg-brand-mint";
  if (pct >= 60) return "bg-brand-amber";
  return "bg-brand-red";
}

function letterGrade(pct: number) {
  if (pct >= 90) return "A";
  if (pct >= 80) return "B";
  if (pct >= 70) return "C";
  if (pct >= 60) return "D";
  return "F";
}

/* ─── Performance chart colors ─── */
const chartColors: Record<string, string> = {
  Math: "#6C63FF",
  English: "#FF6584",
  Science: "#43D9A2",
  History: "#4DC9F6",
};

/* ─── Attendance mini-calendar ─── */
function AttendanceCalendar({ records }: { records?: any[] }) {
  const { t } = useTranslation();
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth();
  const firstDay = new Date(year, month, 1).getDay();
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  const attendanceMap = new Map<string, string>();
  (records ?? []).forEach((rec: any) => {
    const dateKey = new Date(rec.date).toISOString().split("T")[0];
    attendanceMap.set(dateKey, rec.status);
  });

  const present = (records ?? []).filter((v: any) => v.status === "present").length;
  const absent = (records ?? []).filter((v: any) => v.status === "absent").length;
  const late = (records ?? []).filter((v: any) => v.status === "late").length;

  const dotColor = (d: number) => {
    const dow = new Date(year, month, d).getDay();
    if (dow === 0 || dow === 6) return "bg-gray-200";
    const dayKey = new Date(year, month, d).toISOString().split("T")[0];
    const status = attendanceMap.get(dayKey);
    if (!status) return "bg-muted/50";
    return status === "present"
      ? "bg-brand-mint"
      : status === "absent"
        ? "bg-brand-red"
        : "bg-brand-amber";
  };

  const cells: React.ReactNode[] = [];
  for (let i = 0; i < firstDay; i++) cells.push(<div key={`e${i}`} />);
  for (let d = 1; d <= daysInMonth; d++) {
    cells.push(
      <div key={d} className="flex items-center justify-center h-6">
        <div className={cn("w-2.5 h-2.5 rounded-full", dotColor(d))} />
      </div>
    );
  }

  return (
    <div>
      <div className="grid grid-cols-7 gap-0.5 mb-3">{cells}</div>
      <div className="flex gap-4 text-xs text-ink-muted">
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-brand-mint" /> {t("studentDashboard.presentCount", { count: present })}</span>
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-brand-red" /> {t("studentDashboard.absentCount", { count: absent })}</span>
        <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-brand-amber" /> {t("studentDashboard.lateCount", { count: late })}</span>
      </div>
    </div>
  );
}

/* ─── Main Component ─── */
export default function StudentDashboardPage() {
  const { user } = useAuth();
  const { t, i18n } = useTranslation();
  
  const { data: dashboard, isLoading } = useQuery({
    queryKey: ["student", "dashboard"],
    queryFn: Student.dashboard,
  }) as any;

  const { data: perfData } = useQuery({
    queryKey: ["student", "performance-chart"],
    queryFn: () => Student.performanceChart(),
  }) as any;

  const { data: attendanceData } = useQuery({
    queryKey: ["student", "attendance"],
    queryFn: () => Student.attendance(),
  }) as any;

  const chartData = (perfData?.data ?? []).length > 0
    ? (perfData?.data ?? []).map((item: any) => ({
        month: item.month ?? item.period,
        ...item,
      }))
    : [];

  const attendanceRecords: any[] = Array.isArray(attendanceData?.data)
    ? attendanceData.data
    : Array.isArray(attendanceData)
      ? attendanceData
      : [];

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-brand-purple border-t-transparent" />
      </div>
    );
  }

  const name = user?.name ?? "Student";
  const pendingCount = typeof dashboard?.pending_assignments === "number" ? dashboard.pending_assignments : 0;
  const assignments: any[] = Array.isArray(dashboard?.upcoming_assignments) ? dashboard.upcoming_assignments : [];
  const grades: any[] = Array.isArray(dashboard?.recent_grades) ? dashboard.recent_grades : [];
  const timetable: any[] = Array.isArray(dashboard?.today_schedule) ? dashboard.today_schedule : [];
  const announcements: any[] = Array.isArray(dashboard?.announcements) ? dashboard.announcements : [];

  return (
    <div className="space-y-6">
      {/* ── SECTION 1: Welcome Hero ── */}
      <div className="gradient-sunset rounded-2xl p-6 md:p-8 flex items-center justify-between relative overflow-hidden">
        <div className="absolute -bottom-8 -right-8 w-32 h-32 rounded-full bg-card/10" />
        <div className="absolute top-4 right-20 text-white/30 text-xl animate-float">✦</div>
        <div className="absolute top-8 right-40 text-white/20 text-sm animate-float" style={{ animationDelay: "1s" }}>✦</div>

        <div>
          <h1 className="font-display text-3xl text-white font-bold">
            {getGreeting(t)}, {name.split(" ")[0]}! 🌟
          </h1>
          <p className="text-white/80 mt-1">
            {dashboard?.grade ? `${t("studentDashboard.gradeLabel")} ${String(dashboard.grade)}` : ""} {dashboard?.class_name ? `• ${String(dashboard.class_name)}` : ""}
          </p>
          <p className="text-white/60 text-sm mt-1">
            {new Date().toLocaleDateString(i18n.language === "ar" ? "ar-EG" : "en-US", { weekday: "long", year: "numeric", month: "long", day: "numeric" })}
          </p>
        </div>
        <BrandAvatar name={name} role="student" size="xl" className="hidden sm:block ring-4 ring-white/30" />
      </div>

      {/* ── SECTION 2: Quick Stats ── */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard
          title={t("studentDashboard.assignmentsDue")}
          value={pendingCount}
          icon={<span className="text-lg">📝</span>}
          trend={assignments.length > 0 ? { value: assignments.length, label: t("studentDashboard.thisWeek"), up: false } : undefined}
        />
        <StatCard
          title={t("studentDashboard.attendanceRate")}
          value={dashboard?.attendance_rate
            ? `${dashboard.attendance_rate}%`
            : isLoading ? "..." : "N/A"}
          icon={<span className="text-lg">✅</span>}
        />
        <StatCard
          title={t("studentDashboard.averageGrade")}
          value={dashboard?.average_grade
            ? `${dashboard.average_grade}%`
            : isLoading ? "..." : "N/A"}
          icon={<span className="text-lg">🎯</span>}
        />
        <StatCard
          title={t("studentDashboard.unreadMessages")}
          value={dashboard?.unread_messages ?? 0}
          icon={<span className="text-lg">💬</span>}
          subtitle="notifications"
        />
      </div>

      {/* ── SECTION 3: Two-column layout ── */}
      <div className="grid lg:grid-cols-3 gap-6">
        {/* LEFT COLUMN */}
        <div className="lg:col-span-2 space-y-6">
          {/* Upcoming Assignments */}
          <BrandCard className="!p-0 overflow-hidden">
            <div className="flex items-center justify-between p-5 pb-3">
              <h3 className="font-display text-lg font-bold text-ink-dark">{t("studentDashboard.upcomingAssignments")}</h3>
              <Link href="/student/assignments" className="text-brand-purple text-sm font-medium hover:underline">
                {t("studentDashboard.viewAll")}
              </Link>
            </div>
            <div className="px-5 pb-5">
              {assignments.length > 0 ? (
                <div className="space-y-2.5">
                  {assignments.slice(0, 5).map((a: any, i: number) => {
                    const days = a.due_at ? daysUntil(a.due_at) : 99;
                    const dot = subjectColor(a.subject?.name ?? "");
                    return (
                      <div key={i} className="flex items-center gap-3 p-3 rounded-xl bg-surface-bg/60 hover:bg-surface-bg transition-colors">
                        <div className={cn("w-2.5 h-2.5 rounded-full shrink-0", dot)} />
                        <div className="flex-1 min-w-0">
                          <p className="font-semibold text-sm text-ink-dark truncate">{typeof a.title === "string" ? a.title : String(a.title ?? "—")}</p>
                          <p className="text-xs text-ink-muted">{a.subject?.name ?? "—"}</p>
                        </div>
                        <div className="text-right shrink-0 rtl:text-left">
                          {days <= 0 ? (
                            <span className="text-xs font-semibold text-brand-red animate-pulse-soft">{t("studentDashboard.dueToday")}</span>
                          ) : days === 1 ? (
                            <span className="text-xs font-semibold text-brand-red">{t("studentDashboard.dueTomorrow")}</span>
                          ) : days <= 3 ? (
                            <span className="text-xs font-semibold text-brand-amber">{t("studentDashboard.dueInDays", { days })}</span>
                          ) : (
                            <span className="text-xs text-ink-muted">{t("studentDashboard.dueInDays", { days })}</span>
                          )}
                          <div className="mt-0.5">
                            <BrandBadge
                              label={a.status ?? "Pending"} variant={a.status === "Submitted" ? "mint" : a.status === "Late" ? "red" : a.status === "Graded" ? "sky" : "amber"}
                            />
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              ) : (
                <div className="text-center py-10">
                  <p className="text-4xl mb-2">🎉</p>
                  <p className="text-ink-muted text-sm">{t("studentDashboard.noAssignments")}</p>
                </div>
              )}
            </div>
          </BrandCard>

          {/* Recent Grades */}
          <BrandCard className="!p-0 overflow-hidden">
            <div className="flex items-center justify-between p-5 pb-3">
              <h3 className="font-display text-lg font-bold text-ink-dark">{t("studentDashboard.recentGrades")}</h3>
              <Link href="/student/grades" className="text-brand-purple text-sm font-medium hover:underline">
                {t("studentDashboard.seeAllGrades")}
              </Link>
            </div>
            <div className="px-5 pb-5">
              {grades.length > 0 ? (
                <div className="space-y-2.5">
                  {grades.slice(0, 5).map((g: any, i: number) => {
                    const pct = g.max_score ? (g.score / g.max_score) * 100 : 0;
                    return (
                      <div key={i} className="flex items-center gap-3 p-3 rounded-xl bg-surface-bg/60">
                        <div className={cn("w-2.5 h-2.5 rounded-full shrink-0", subjectColor(g.subject?.name ?? ""))} />
                        <div className="flex-1 min-w-0">
                          <p className="font-semibold text-sm text-ink-dark truncate">{g.subject?.name ?? (typeof g.component === "string" ? g.component : g.component?.name) ?? "—"}</p>
                          <p className="text-xs text-ink-muted">{typeof g.component === "string" ? g.component : g.component?.name ?? "Overall"}</p>
                        </div>
                        <div className="flex-1 max-w-[120px]">
                          <div className="h-2 rounded-full bg-surface-border overflow-hidden">
                            <div className={cn("h-full rounded-full transition-all", scoreColor(pct))} style={{ width: `${pct}%` }} />
                          </div>
                        </div>
                        <div className="text-right shrink-0 rtl:text-left">
                          <p className="font-semibold text-sm">{String(g.score ?? "—")}/{String(g.max_score ?? "—")}</p>
                          <p className={cn("text-xs font-bold", pct >= 80 ? "text-brand-mint" : pct >= 60 ? "text-brand-amber" : "text-brand-red")}>
                            {letterGrade(pct)}
                          </p>
                        </div>
                      </div>
                    );
                  })}
                </div>
              ) : (
                <p className="text-sm text-ink-muted text-center py-8">{t("studentDashboard.noGrades")}</p>
              )}
            </div>
          </BrandCard>
        </div>

        {/* RIGHT COLUMN */}
        <div className="space-y-6">
          {/* Today's Schedule */}
          <BrandCard className="!p-0 overflow-hidden">
            <div className="p-5 pb-3">
              <h3 className="font-display text-lg font-bold text-ink-dark">{t("studentDashboard.todaySchedule")}</h3>
            </div>
            <div className="px-5 pb-5">
              {timetable.length > 0 ? (
                <div className="relative ps-6 space-y-3">
                  {/* Timeline line */}
                  <div className="absolute start-2 top-1 bottom-1 w-0.5 bg-surface-border" />
                  {timetable.map((p: any, i: number) => {
                    const isCurrent = p.is_current;
                    return (
                      <div key={i} className="relative">
                        {/* Timeline dot */}
                        <div className={cn(
                          "absolute -start-5 top-1.5 w-3 h-3 rounded-full border-2 border-white",
                          isCurrent ? "bg-brand-purple shadow-glow" : "bg-surface-border"
                        )} />
                        <div className={cn(
                          "p-3 rounded-xl transition-colors",
                          isCurrent ? "gradient-purple text-white shadow-glow" : "bg-surface-bg/60"
                        )}>
                          <p className={cn("text-xs font-medium", isCurrent ? "text-white/80" : "text-ink-muted")}>
                            {p.start_time} – {p.end_time}
                          </p>
                          <div className="flex items-center gap-2 mt-0.5">
                            <div className={cn("w-2 h-2 rounded-full", subjectColor(p.subject?.name ?? ""), isCurrent && "ring-1 ring-white/50")} />
                            <p className={cn("font-semibold text-sm", isCurrent ? "text-white" : "text-ink-dark")}>{p.subject?.name}</p>
                          </div>
                          <p className={cn("text-xs mt-0.5", isCurrent ? "text-white/70" : "text-ink-muted")}>
                            {p.teacher_name} • Room {p.room ?? "—"}
                          </p>
                        </div>
                      </div>
                    );
                  })}
                </div>
              ) : (
                <p className="text-sm text-ink-muted text-center py-6">{t("studentDashboard.noClasses")}</p>
              )}
            </div>
          </BrandCard>

          {/* Attendance This Month */}
          <BrandCard>
            <h3 className="font-display text-base font-bold text-ink-dark mb-3">{t("studentDashboard.attendanceThisMonth")}</h3>
            <AttendanceCalendar records={attendanceRecords} />
          </BrandCard>

          {/* Announcements */}
          <BrandCard className="!p-0 overflow-hidden">
            <div className="flex items-center justify-between p-5 pb-3">
              <h3 className="font-display text-base font-bold text-ink-dark">{t("nav.announcements")}</h3>
              <Link href="/student/announcements" className="text-brand-purple text-xs font-medium hover:underline">
                {t("studentDashboard.viewAll")}
              </Link>
            </div>
            <div className="px-5 pb-5 space-y-2.5">
              {announcements.length > 0 ? announcements.slice(0, 3).map((a: any, i: number) => (
                <div
                  key={i}
                  className={cn(
                    "ps-3 py-2 border-s-4 rounded-e-lg",
                    a.priority === "high" ? "border-s-brand-red bg-brand-red/5" : "border-s-brand-purple bg-brand-purple/5"
                  )}
                >
                  <p className="font-medium text-sm text-ink-dark">{a.title}</p>
                  <p className="text-xs text-ink-muted mt-0.5">
                    {new Date(a.created_at).toLocaleDateString(i18n.language === "ar" ? "ar-EG" : "en-US")}
                  </p>
                </div>
              )) : (
                <div className="text-center py-8 text-muted-foreground/70">
                  <div className="text-3xl mb-2">📢</div>
                  <p className="text-sm">{t("common.empty")}</p>
                </div>
              )}
            </div>
          </BrandCard>
        </div>
      </div>

      {/* ── SECTION 4: Performance Chart ── */}
      <BrandCard>
        <h3 className="font-display text-lg font-bold text-ink-dark mb-4">{t("studentDashboard.performanceThisTerm")}</h3>
        <div className="h-72">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={chartData.length > 0 ? chartData : [{ month: t("studentDashboard.noData") }]}>
              <CartesianGrid strokeDasharray="3 3" stroke="#E5E3FF" />
              <XAxis dataKey="month" tick={{ fontSize: 12, fill: "#6B7280" }} />
              <YAxis domain={[0, 100]} tick={{ fontSize: 12, fill: "#6B7280" }} />
              <Tooltip
                contentStyle={{
                  borderRadius: "1rem",
                  border: "1px solid #E5E3FF",
                  boxShadow: "0 4px 24px rgba(108,99,255,0.08)",
                }}
              />
              <Legend />
              {Object.entries(chartColors).map(([key, color]) => (
                <Line
                  key={key}
                  type="monotone"
                  dataKey={key}
                  stroke={color}
                  strokeWidth={2.5}
                  dot={{ r: 4, fill: color, strokeWidth: 0 }}
                  activeDot={{ r: 6 }}
                />
              ))}
            </LineChart>
          </ResponsiveContainer>
        </div>
      </BrandCard>
    </div>
  );
}
