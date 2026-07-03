import { useState, useMemo } from "react";
import { Link, useLocation } from "wouter";
import { useTranslation } from "react-i18next";
import { useTheme } from "next-themes";
import { setLocale } from "@/lib/i18n";
import { useAuth } from "@/lib/auth";
import {
  MessageSquare,
  Menu,
  LogOut,
  User as UserIcon,
  Globe,
  LayoutDashboard,
  Users,
  GraduationCap,
  CalendarDays,
  FileText,
  Briefcase,
  Receipt,
  Megaphone,
  ClipboardCheck,
  BookOpen,
  CalendarClock,
  ScrollText,
  ShieldCheck,
  Building2,
  Wallet,
  TimerReset,
  PiggyBank,
  ListChecks,
  AlertTriangle,
  Sun,
  Moon,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { useQuery } from "@tanstack/react-query";
import { mediaUrl, Messaging, Role } from "@/lib/api";
import NotificationBell from "@/components/layout/NotificationBell";

type NavItem = { href: string; label: string; icon: any };

const buildNav = (role: Role, t: (k: string) => string): NavItem[] => {
  switch (role) {
    case "student":
      return [
        { href: `/student`, label: t("nav.dashboard"), icon: LayoutDashboard },
        { href: `/student/timetable`, label: t("nav.timetable"), icon: CalendarClock },
        { href: `/student/assignments`, label: t("nav.assignments"), icon: FileText },
        { href: `/student/grades`, label: t("nav.grades"), icon: GraduationCap },
        { href: `/student/attendance`, label: t("nav.attendance"), icon: ClipboardCheck },
        { href: `/student/report-card`, label: t("nav.reportCard"), icon: ScrollText },
        { href: `/student/calendar`, label: t("nav.calendar"), icon: CalendarDays },
        { href: `/student/announcements`, label: t("nav.announcements"), icon: Megaphone },
        { href: `/student/messages`, label: t("nav.messages"), icon: MessageSquare },
      ];
    case "parent":
      return [
        { href: `/parent`, label: t("nav.dashboard") + " / " + t("nav.children"), icon: LayoutDashboard },
        { href: `/parent/announcements`, label: t("nav.announcements"), icon: Megaphone },
        { href: `/parent/messages`, label: t("nav.messages"), icon: MessageSquare },
      ];
    case "teacher":
      return [
        { href: `/teacher`, label: t("nav.dashboard"), icon: LayoutDashboard },
        { href: `/teacher/classes`, label: t("nav.classes"), icon: Users },
        { href: `/teacher/timetable`, label: t("nav.timetable"), icon: CalendarClock },
        { href: `/teacher/attendance`, label: t("nav.attendance"), icon: ClipboardCheck },
        { href: `/teacher/assignments`, label: t("nav.assignments"), icon: FileText },
        { href: `/teacher/grades`, label: t("nav.grades"), icon: GraduationCap },
        { href: `/teacher/conduct`, label: t("nav.conduct"), icon: AlertTriangle },
        { href: `/teacher/announcements`, label: t("nav.announcements"), icon: Megaphone },
        { href: `/teacher/hr`, label: t("nav.hrRequests"), icon: Briefcase },
        { href: `/teacher/messages`, label: t("nav.messages"), icon: MessageSquare },
      ];
    case "admin":
      return [
        { href: `/admin`, label: t("nav.dashboard"), icon: LayoutDashboard },
        { href: `/admin/users`, label: t("nav.students") + " / " + t("nav.staff"), icon: Users },
        { href: `/admin/classes`, label: t("nav.classes"), icon: Building2 },
        { href: `/admin/subjects`, label: t("nav.subjects"), icon: BookOpen },
        { href: `/admin/exams`, label: t("nav.grades"), icon: GraduationCap },
        { href: `/admin/academic-years`, label: t("nav.calendar"), icon: CalendarDays },
        { href: `/admin/calendar`, label: t("nav.calendar"), icon: CalendarClock },
        { href: `/admin/hr-requests`, label: t("nav.hrRequests"), icon: Briefcase },
        { href: `/admin/announcements`, label: t("nav.announcements"), icon: Megaphone },
        { href: `/admin/reports`, label: t("nav.reports"), icon: ListChecks },
        { href: `/admin/audit`, label: t("nav.audit"), icon: ShieldCheck },
        { href: `/admin/messages`, label: t("nav.messages"), icon: MessageSquare },
      ];
    case "finance":
      return [
        { href: `/finance`, label: t("nav.dashboard"), icon: LayoutDashboard },
        { href: `/finance/invoices`, label: t("nav.invoices"), icon: Receipt },
        { href: `/finance/outstanding`, label: t("nav.payments"), icon: AlertTriangle },
        { href: `/finance/fee-structures`, label: t("nav.feeStructures"), icon: Wallet },
        { href: `/finance/payroll`, label: t("nav.payroll"), icon: PiggyBank },
        { href: `/finance/reports`, label: t("nav.reports"), icon: ListChecks },
        { href: `/finance/messages`, label: t("nav.messages"), icon: MessageSquare },
      ];
    case "hr":
      return [
        { href: `/hr`, label: t("nav.dashboard"), icon: LayoutDashboard },
        { href: `/hr/staff`, label: t("nav.employees"), icon: Users },
        { href: `/hr/leave`, label: t("nav.leave"), icon: TimerReset },
        { href: `/hr/attendance`, label: t("nav.attendance"), icon: ClipboardCheck },
        { href: `/hr/reports`, label: t("nav.reports"), icon: ListChecks },
        { href: `/hr/messages`, label: t("nav.messages"), icon: MessageSquare },
      ];
    default:
      return [];
  }
};

export function AppShell({ children }: { children: React.ReactNode }) {
  const { t, i18n } = useTranslation();
  const { user, logout } = useAuth();
  const { theme, setTheme } = useTheme();
  const [pathname, setLocation] = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const { data: unread } = useQuery({
    queryKey: ["unread-count"],
    queryFn: Messaging.unreadCount,
    enabled: !!user,
    refetchInterval: 30000,
  });

  const toggleLanguage = () => {
    setLocale(i18n.language === "en" ? "ar" : "en");
  };

  const handleLogout = async () => {
    await logout();
    setLocation("/login");
  };

  const navItems = useMemo(
    () => (user ? buildNav(user.role, t) : []),
    // `t` already changes identity on language switch, so i18n.language is redundant.
    [user, t],
  );

  if (!user) return null;

  const isActive = (href: string) =>
    pathname === href || (href !== `/${user.role}` && pathname.startsWith(href));

  return (
    <div className="min-h-screen bg-background flex flex-col md:flex-row">
      {sidebarOpen && (
        <button
          type="button"
          aria-label="Close menu"
          className="fixed inset-0 z-40 bg-black/50 md:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      <aside
        className={`
          fixed inset-y-0 start-0 z-50 w-64 bg-sidebar border-e border-sidebar-border flex flex-col
          transform transition-transform duration-200 ease-in-out md:relative md:translate-x-0
          ${sidebarOpen ? "translate-x-0" : "-translate-x-full rtl:translate-x-full md:rtl:translate-x-0"}
        `}
      >
        <div className="h-16 flex items-center px-6 border-b border-sidebar-border">
          <div className="flex items-center justify-center h-8 w-8 rounded-lg bg-sidebar-primary/15 me-3">
            <GraduationCap className="h-5 w-5 text-sidebar-primary" />
          </div>
          <span className="font-serif font-bold text-base text-sidebar-foreground truncate tracking-tight">
            {t("common.appName")}
          </span>
        </div>

        <nav className="p-3 space-y-0.5 overflow-y-auto flex-1">
          <div className="px-3 py-2 text-xs font-semibold uppercase tracking-wider text-sidebar-foreground/40">
            {t(`roles.${user.role}`)}
          </div>
          {navItems.map((item, idx) => {
            const active = isActive(item.href);
            return (
              <Link
                key={`${item.href}-${idx}`}
                href={item.href}
                onClick={() => setSidebarOpen(false)}
                className={`
                  flex items-center px-3 py-2 rounded-md text-sm font-medium transition-colors relative
                  ${active
                    ? "bg-sidebar-accent text-sidebar-accent-foreground font-semibold"
                    : "text-sidebar-foreground/70 hover:bg-sidebar-accent/50 hover:text-sidebar-accent-foreground"}
                `}
              >
                {active && (
                  <div className="absolute start-0 top-1/2 -translate-y-1/2 w-1 h-5 bg-sidebar-primary rounded-e-full" />
                )}
                <item.icon className="h-4 w-4 me-3 shrink-0 opacity-80" />
                <span className="truncate">{item.label}</span>
              </Link>
            );
          })}
        </nav>

        <div className="p-3 border-t border-sidebar-border">
          <Link
            href={`/${user.role}/profile`}
            onClick={() => setSidebarOpen(false)}
            className="flex items-center gap-3 px-3 py-2 rounded-md text-sm hover:bg-sidebar-accent hover:text-sidebar-accent-foreground transition-colors"
          >
            <Avatar className="h-8 w-8 border border-sidebar-border">
              <AvatarImage src={mediaUrl(user.photo_path)} alt={user.name} />
              <AvatarFallback className="text-xs bg-sidebar-primary/20 text-sidebar-primary font-semibold">
                {user.name.substring(0, 2).toUpperCase()}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1 min-w-0">
              <div className="font-medium truncate text-sidebar-foreground">{user.name}</div>
              <div className="text-xs text-sidebar-foreground/50 truncate">{user.email}</div>
            </div>
          </Link>
        </div>
      </aside>

      <div className="flex-1 flex flex-col min-w-0">
        <header className="h-16 bg-card border-b border-border flex items-center justify-between px-4 sm:px-6 z-10 sticky top-0 shadow-academic">
          <div className="flex items-center gap-2">
            <Button
              variant="ghost"
              size="icon"
              className="md:hidden"
              onClick={() => setSidebarOpen(true)}
            >
              <Menu className="h-5 w-5" />
            </Button>
            <Badge variant="outline" className="hidden sm:inline-flex capitalize text-primary border-primary/30 bg-primary/5">
              {t(`roles.${user.role}`)}
            </Badge>
          </div>

          <div className="flex items-center gap-1">
            <Button variant="ghost" size="sm" onClick={toggleLanguage} title={t("common.language")}>
              <Globe className="h-4 w-4 me-1.5" />
              <span className="text-xs font-semibold uppercase">
                {i18n.language === "en" ? "AR" : "EN"}
              </span>
            </Button>

            <Button
              variant="ghost"
              size="icon"
              onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
              title={theme === "dark" ? "Switch to light mode" : "Switch to dark mode"}
            >
              {theme === "dark" ? <Sun className="h-5 w-5" /> : <Moon className="h-5 w-5" />}
            </Button>

            <NotificationBell role={user.role} />

            <Button variant="ghost" size="icon" className="relative" asChild>
              <Link href={`/${user.role}/messages`}>
                <MessageSquare className="h-5 w-5" />
                {unread?.messages ? (
                  <span className="absolute top-1.5 end-1.5 h-2 w-2 rounded-full bg-destructive" />
                ) : null}
              </Link>
            </Button>

            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" className="relative h-9 w-9 rounded-full ms-1">
                  <Avatar className="h-9 w-9">
                    <AvatarImage src={mediaUrl(user.photo_path)} alt={user.name} />
                    <AvatarFallback>{user.name.substring(0, 2).toUpperCase()}</AvatarFallback>
                  </Avatar>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-56">
                <DropdownMenuLabel className="font-normal">
                  <div className="flex flex-col space-y-1">
                    <p className="text-sm font-medium leading-none">{user.name}</p>
                    <p className="text-xs leading-none text-muted-foreground">{user.email}</p>
                  </div>
                </DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem asChild>
                  <Link href={`/${user.role}/profile`} className="cursor-pointer">
                    <UserIcon className="me-2 h-4 w-4" />
                    <span>{t("common.profile")}</span>
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem
                  onClick={() => {
                    void handleLogout();
                  }}
                  className="text-destructive focus:text-destructive cursor-pointer"
                >
                  <LogOut className="me-2 h-4 w-4" />
                  <span>{t("common.logout")}</span>
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </header>

        <main className="flex-1 overflow-auto p-6 sm:p-8">{children}</main>
      </div>
    </div>
  );
}
