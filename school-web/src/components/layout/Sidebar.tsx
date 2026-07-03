import { useMemo } from "react";
import { Link, useLocation } from "wouter";
import { useAuth } from "@/lib/auth";
import { useTheme } from "@/lib/ThemeContext";
import { useTranslation } from "react-i18next";
import { Role, mediaUrl } from "@/lib/api";
import { cn } from "@/lib/utils";
import BrandAvatar from "@/components/ui/BrandAvatar";
import BrandBadge from "@/components/ui/BrandBadge";
import {
  LayoutDashboard,
  CalendarClock,
  FileText,
  GraduationCap,
  ClipboardCheck,
  ScrollText,
  CalendarDays,
  Megaphone,
  MessageSquare,
  Bell,
  Users,
  Building2,
  BookOpen,
  Briefcase,
  ListChecks,
  ShieldCheck,
  Receipt,
  Wallet,
  PiggyBank,
  AlertTriangle,
  TimerReset,
  Baby,
  Bus,
  Library,
  DollarSign,
  Settings,
  LogOut,
  ChevronLeft,
  ChevronRight,
  Boxes,
  ClipboardList,
  ArchiveRestore,
  FolderKanban,
} from "lucide-react";

/* ─── Nav items per role ─── */
type NavItem = { href: string; label: string; icon: any; badge?: number };

// Finance and Accounting share one combined menu so a single Finance & Accounting
// user can reach both areas. The modules/data stay separate — only access is unified.
const financeAndAccountingNav: NavItem[] = [
  { href: "/finance", label: "roles.finance", icon: LayoutDashboard },
  { href: "/finance/fee-structures", label: "nav.feeStructures", icon: Wallet },
  { href: "/finance/invoices", label: "nav.invoices", icon: Receipt },
  { href: "/finance/payments", label: "nav.payments", icon: DollarSign },
  { href: "/finance/outstanding", label: "financeDashboard.outstandingAccounts", icon: AlertTriangle },
  { href: "/finance/payroll", label: "nav.payroll", icon: PiggyBank },
  { href: "/finance/reports", label: "nav.reports", icon: ListChecks },
  { href: "/accounting", label: "roles.accounting", icon: BookOpen },
  { href: "/accounting/journal-entries", label: "accountingDashboard.recentJournalEntries", icon: FileText },
  { href: "/accounting/chart-of-accounts", label: "nav.chartOfAccounts", icon: BookOpen },
  { href: "/accounting/budget", label: "nav.budget", icon: Wallet },
  { href: "/accounting/closings", label: "nav.closings", icon: ArchiveRestore },
  { href: "/accounting/audit", label: "nav.auditTrail", icon: ShieldCheck },
];

const navMap: Record<Role, NavItem[]> = {
  student: [
    { href: "/student", label: "nav.dashboard", icon: LayoutDashboard },
    { href: "/student/timetable", label: "nav.timetable", icon: CalendarClock },
    { href: "/student/assignments", label: "nav.assignments", icon: FileText },
    { href: "/student/grades", label: "nav.grades", icon: GraduationCap },
    { href: "/student/attendance", label: "nav.attendance", icon: ClipboardCheck },
    { href: "/student/report-card", label: "nav.reportCard", icon: ScrollText },
    { href: "/student/announcements", label: "nav.announcements", icon: Megaphone },
    { href: "/student/calendar", label: "nav.calendar", icon: CalendarDays },
    { href: "/student/library", label: "nav.library", icon: Library },
    { href: "/student/transport", label: "nav.transport", icon: Bus },
    { href: "/student/messages", label: "nav.messages", icon: MessageSquare },
    { href: "/student/notifications", label: "common.notifications", icon: Bell },
  ],
  parent: [
    { href: "/parent", label: "nav.dashboard", icon: LayoutDashboard },
    { href: "/parent/children", label: "nav.children", icon: Baby },
    { href: "/parent/grades", label: "nav.grades", icon: GraduationCap },
    { href: "/parent/attendance", label: "nav.attendance", icon: ClipboardCheck },
    { href: "/parent/invoices", label: "nav.invoices", icon: Receipt },
    { href: "/parent/announcements", label: "nav.announcements", icon: Megaphone },
    { href: "/parent/messages", label: "nav.messages", icon: MessageSquare },
    { href: "/parent/notifications", label: "common.notifications", icon: Bell },
  ],
  teacher: [
    { href: "/teacher", label: "nav.dashboard", icon: LayoutDashboard },
    { href: "/teacher/classes", label: "teacherDashboard.myClasses", icon: Users },
    { href: "/teacher/timetable", label: "nav.timetable", icon: CalendarClock },
    { href: "/teacher/assignments", label: "nav.assignments", icon: FileText },
    { href: "/teacher/grades", label: "nav.grades", icon: GraduationCap },
    { href: "/teacher/attendance", label: "nav.attendance", icon: ClipboardCheck },
    { href: "/teacher/conduct", label: "nav.conduct", icon: AlertTriangle },
    { href: "/teacher/announcements", label: "nav.announcements", icon: Megaphone },
    { href: "/teacher/hr", label: "nav.hrRequests", icon: Briefcase },
    { href: "/teacher/messages", label: "nav.messages", icon: MessageSquare },
    { href: "/teacher/notifications", label: "common.notifications", icon: Bell },
  ],
  admin: [
    { href: "/admin", label: "nav.dashboard", icon: LayoutDashboard },
    { href: "/admin/users", label: "common.users", icon: Users },
    { href: "/admin/classes", label: "nav.classes", icon: Building2 },
    { href: "/admin/subjects", label: "nav.subjects", icon: BookOpen },
    { href: "/admin/exams", label: "nav.exams", icon: FileText },
    { href: "/admin/academic-years", label: "adminDashboard.academicYear", icon: CalendarDays },
    { href: "/admin/timetable", label: "nav.timetable", icon: CalendarClock },
    { href: "/admin/calendar", label: "nav.calendar", icon: CalendarDays },
    { href: "/admin/attendance", label: "nav.attendance", icon: ClipboardCheck },
    { href: "/admin/library", label: "nav.library", icon: Library },
    { href: "/admin/transport", label: "nav.transport", icon: Bus },
    { href: "/admin/hr-requests", label: "nav.hrRequests", icon: Briefcase },
    { href: "/admin/reports", label: "nav.reports", icon: ListChecks },
    { href: "/admin/announcements", label: "nav.announcements", icon: Megaphone },
    { href: "/admin/notifications", label: "common.notifications", icon: Bell },
    { href: "/admin/audit", label: "nav.audit", icon: ShieldCheck },
    { href: "/admin/settings", label: "common.settings", icon: Settings },
  ],
  finance: financeAndAccountingNav,
  hr: [
    { href: "/hr", label: "nav.dashboard", icon: LayoutDashboard },
    { href: "/hr/staff", label: "nav.staff", icon: Users },
    { href: "/hr/leave", label: "nav.leave", icon: TimerReset },
    { href: "/hr/requests", label: "nav.hrRequests", icon: Briefcase },
    { href: "/hr/attendance", label: "nav.attendance", icon: ClipboardCheck },
    { href: "/hr/evaluations", label: "nav.evaluations", icon: ClipboardList },
    { href: "/hr/recruitment", label: "nav.recruitment", icon: Briefcase },
    { href: "/hr/reports", label: "nav.reports", icon: ListChecks },
    { href: "/hr/messages", label: "nav.messages", icon: MessageSquare },
  ],
  warehouse: [
    { href: "/warehouse", label: "nav.dashboard", icon: LayoutDashboard },
    { href: "/warehouse/categories", label: "nav.categories", icon: FolderKanban },
    { href: "/warehouse/items", label: "nav.items", icon: ClipboardCheck },
    { href: "/warehouse/movements", label: "nav.movements", icon: FileText },
    { href: "/warehouse/inventory-counts", label: "nav.inventoryCounts", icon: Boxes },
    { href: "/warehouse/purchase-requests", label: "nav.purchaseRequests", icon: ListChecks },
    { href: "/warehouse/reports", label: "nav.reports", icon: ListChecks },
  ],
};

interface SidebarProps {
  collapsed: boolean;
  onToggle: () => void;
  /** Mobile drawer open state (ignored on md+ where the sidebar is docked). */
  mobileOpen?: boolean;
  /** Close the mobile drawer (e.g. after navigating). */
  onClose?: () => void;
}

export default function Sidebar({ collapsed, onToggle, mobileOpen = false, onClose }: SidebarProps) {
  const { t } = useTranslation();
  const { user, logout } = useAuth();
  const { theme } = useTheme();
  const [pathname] = useLocation();

  const navItems = useMemo(
    () => (user ? navMap[user.role] ?? [] : []),
    [user]
  );

  if (!user) return null;

  const sidebarStyle = theme.sidebar_style ?? "white";
  const isDarkSidebar = sidebarStyle === "dark" || sidebarStyle === "gradient";
  const schoolLogo = mediaUrl(theme.school_logo);
  const isActive = (href: string) =>
    pathname === href || (href !== `/${user.role}` && pathname.startsWith(href));

  return (
    <aside
      className={cn(
        "h-screen flex flex-col border-r transition-transform duration-300 shrink-0",
        // Mobile: off-canvas drawer; Desktop (md+): docked in the flex row.
        "fixed inset-y-0 start-0 z-50 md:static md:z-auto md:translate-x-0",
        mobileOpen ? "translate-x-0 shadow-2xl" : "-translate-x-full rtl:translate-x-full md:translate-x-0 md:rtl:translate-x-0",
        sidebarStyle === "white" && "bg-card border-surface-border",
        sidebarStyle === "dark" && "bg-gray-950 border-gray-800",
        sidebarStyle === "gradient" && "border-transparent",
        collapsed ? "w-[72px]" : "w-[260px]"
      )}
      style={sidebarStyle === "gradient" ? { background: "var(--gradient-main)" } : undefined}
    >
      {/* Logo area */}
      <div className={cn("flex items-center gap-3 px-4 h-16 border-b relative", isDarkSidebar ? "border-white/15" : "border-surface-border")}>
        <div className={cn("rounded-2xl w-9 h-9 flex items-center justify-center overflow-hidden shrink-0", isDarkSidebar ? "bg-card/15" : "gradient-purple")}>
          {schoolLogo ? (
            <img
              src={schoolLogo}
              alt={`${theme.school_name || "School"} logo`}
              className="h-full w-full bg-card object-contain p-1"
            />
          ) : (
            <GraduationCap className="h-5 w-5 text-white" />
          )}
        </div>
        {!collapsed && (
          <span className={cn("font-display text-base font-bold truncate", isDarkSidebar ? "text-white" : "text-ink-dark")}>
            {theme.school_name || "School Suite"}
          </span>
        )}
        <button
          onClick={onToggle}
          aria-label="Toggle sidebar"
          className={cn(
            "absolute -right-3 top-1/2 -translate-y-1/2 w-6 h-6 rounded-full border shadow-sm hidden md:flex items-center justify-center transition-colors z-10",
            isDarkSidebar
              ? "bg-gray-950 border-white/20 text-white/70 hover:text-white"
              : "bg-card border-surface-border text-ink-muted hover:text-[var(--color-primary)]"
          )}
        >
          {collapsed ? <ChevronRight className="h-3.5 w-3.5" /> : <ChevronLeft className="h-3.5 w-3.5" />}
        </button>
      </div>

      {/* Navigation */}
      <nav className="flex-1 overflow-y-auto py-3 px-2.5 space-y-1">
        {!collapsed && (
          <p className={cn(
            "px-3 pt-1 pb-2 text-[11px] font-semibold uppercase tracking-wider",
            isDarkSidebar ? "text-white/40" : "text-ink-light"
          )}>
            {t("common.menu", "Menu")}
          </p>
        )}
        {navItems.map((item, idx) => {
          const active = isActive(item.href);
          return (
            <Link
              key={`${item.href}-${idx}`}
              href={item.href}
              onClick={onClose}
              title={collapsed ? t(item.label) : undefined}
              aria-current={active ? "page" : undefined}
              className={cn(
                "group relative flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium transition-all duration-200",
                collapsed && "justify-center px-0",
                active
                  ? "gradient-purple text-white shadow-[var(--shadow-card)] font-semibold"
                  : isDarkSidebar
                    ? "text-white/70 hover:bg-white/10 hover:text-white"
                    : "text-ink-muted hover:bg-[var(--color-primary-subtle)] hover:text-[var(--color-primary)]"
              )}
            >
              {active && !collapsed && (
                <span className="absolute inset-y-1.5 -start-2.5 w-1 rounded-e-full bg-[var(--color-accent)]" />
              )}
              <item.icon
                className={cn(
                  "h-5 w-5 shrink-0 transition-transform duration-200 group-hover:scale-110",
                  active ? "text-white" : isDarkSidebar ? "text-white/60" : "text-ink-light group-hover:text-[var(--color-primary)]"
                )}
              />
              {!collapsed && <span className="truncate">{t(item.label)}</span>}
              {!collapsed && item.badge && (
                <span className="ml-auto bg-brand-red text-white text-[10px] font-bold rounded-full min-w-5 h-5 px-1 flex items-center justify-center">
                  {item.badge}
                </span>
              )}
            </Link>
          );
        })}
      </nav>

      {/* Bottom user section */}
      <div className={cn("border-t p-3", isDarkSidebar ? "border-white/15" : "border-surface-border")}>
        <div className={cn("flex items-center gap-3", collapsed && "justify-center")}>
          <BrandAvatar name={user.name} variant={user.role} size="sm" />
          {!collapsed && (
            <div className="flex-1 min-w-0">
              <p className={cn("text-sm font-semibold truncate", isDarkSidebar ? "text-white" : "text-ink-dark")}>{user.name}</p>
              <BrandBadge label={user.role} variant={user.role === "admin" ? "sky" : user.role === "student" ? "purple" : user.role === "teacher" ? "mint" : user.role === "parent" ? "pink" : user.role === "finance" ? "amber" : "lavender"} />
            </div>
          )}
        </div>
        {!collapsed && (
          <div className="flex items-center gap-2 mt-3">
            <Link
              href={`/${user.role}/profile`}
              onClick={onClose}
              className={cn("flex-1 flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs transition-colors", isDarkSidebar ? "text-white/70 hover:bg-card/10" : "text-ink-muted hover:bg-surface-bg")}
            >
              <Settings className="h-3.5 w-3.5" />
              {t("common.settings")}
            </Link>
            <button
              onClick={() => {
                void logout();
              }}
              className={cn("flex-1 flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs transition-colors", isDarkSidebar ? "text-white/70 hover:text-white hover:bg-card/10" : "text-ink-muted hover:text-brand-red hover:bg-brand-red/5")}
            >
              <LogOut className="h-3.5 w-3.5" />
              {t("common.logout")}
            </button>
          </div>
        )}
      </div>
    </aside>
  );
}
