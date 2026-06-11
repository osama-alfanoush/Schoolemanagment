import { lazy, Suspense, ComponentType } from "react";
import { Switch, Route, Router as WouterRouter, Redirect } from "wouter";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import { AuthProvider, useAuth } from "@/lib/auth";

import { RoleGuard } from "@/components/layout/RoleGuard";
import { AppLayout } from "@/components/layout";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Role } from "@/lib/api";

import LoginPage from "@/pages/auth/LoginPage";

// Lazy-loaded portal pages — each group becomes a separate chunk
const StudentDashboardPage = lazy(() => import("@/pages/student/DashboardPage"));
const StudentTimetable = lazy(() => import("@/pages/student/Timetable"));
const StudentAssignments = lazy(() => import("@/pages/student/Assignments"));
const StudentAttendance = lazy(() => import("@/pages/student/Attendance"));
const StudentGrades = lazy(() => import("@/pages/student/Grades"));
const StudentReportCard = lazy(() => import("@/pages/student/ReportCard"));
const StudentAnnouncements = lazy(() => import("@/pages/student/Announcements"));
const StudentCalendar = lazy(() => import("@/pages/student/Calendar"));
const StudentLibrary = lazy(() => import("@/pages/student/Library"));
const StudentTransport = lazy(() => import("@/pages/student/Transport"));
const StudentNotifications = lazy(() => import("@/pages/student/Notifications"));
const StudentMedical = lazy(() => import("@/pages/student/Medical"));

const TeacherDashboard = lazy(() => import("@/pages/teacher/Dashboard"));
const TeacherClasses = lazy(() => import("@/pages/teacher/Classes"));
const TeacherAssignments = lazy(() => import("@/pages/teacher/Assignments"));
const TeacherAttendance = lazy(() => import("@/pages/teacher/Attendance"));
const TeacherTimetable = lazy(() => import("@/pages/teacher/Timetable"));
const TeacherGrades = lazy(() => import("@/pages/teacher/Grades"));
const TeacherConduct = lazy(() => import("@/pages/teacher/Conduct"));
const TeacherAnnouncements = lazy(() => import("@/pages/teacher/Announcements"));
const TeacherHr = lazy(() => import("@/pages/teacher/Hr"));
const TeacherNotifications = lazy(() => import("@/pages/teacher/Notifications"));

const AdminDashboardPage = lazy(() => import("@/pages/admin/DashboardPage"));
const AdminUsers = lazy(() => import("@/pages/admin/Users"));
const AdminClasses = lazy(() => import("@/pages/admin/Classes"));
const AdminSubjects = lazy(() => import("@/pages/admin/Subjects"));
const AdminExams = lazy(() => import("@/pages/admin/Exams"));
const AdminAcademicYears = lazy(() => import("@/pages/admin/AcademicYears"));
const AdminAudit = lazy(() => import("@/pages/admin/Audit"));
const AdminHrRequests = lazy(() => import("@/pages/admin/HrRequests"));
const AdminCalendar = lazy(() => import("@/pages/admin/Calendar"));
const AdminReports = lazy(() => import("@/pages/admin/Reports"));
const AdminTimetable = lazy(() => import("@/pages/admin/Timetable"));
const AdminAttendance = lazy(() => import("@/pages/admin/Attendance"));
const AdminNotifications = lazy(() => import("@/pages/admin/Notifications"));
const AdminAnnouncements = lazy(() => import("@/pages/admin/Announcements"));
const SchoolSettings = lazy(() => import("@/pages/admin/SchoolSettings"));
const AdminLibrary = lazy(() => import("@/pages/admin/Library"));
const AdminTransport = lazy(() => import("@/pages/admin/Transport"));
const AdminMedical = lazy(() => import("@/pages/admin/Medical"));

const ParentDashboard = lazy(() => import("@/pages/parent/Dashboard"));
const ParentChildDetail = lazy(() => import("@/pages/parent/ChildDetail"));
const ParentAnnouncements = lazy(() => import("@/pages/parent/Announcements"));
const ParentNotifications = lazy(() => import("@/pages/parent/Notifications"));
const ParentChildren = lazy(() => import("@/pages/parent/Children"));
const ParentGrades = lazy(() => import("@/pages/parent/Grades"));
const ParentAttendance = lazy(() => import("@/pages/parent/Attendance"));
const ParentInvoices = lazy(() => import("@/pages/parent/Invoices"));

const FinanceDashboard = lazy(() => import("@/pages/finance/Dashboard"));
const FinanceInvoices = lazy(() => import("@/pages/finance/Invoices"));
const FinancePayroll = lazy(() => import("@/pages/finance/Payroll"));
const FinanceOutstanding = lazy(() => import("@/pages/finance/Outstanding"));
const FinanceFeeStructures = lazy(() => import("@/pages/finance/FeeStructures"));
const FinanceReports = lazy(() => import("@/pages/finance/Reports"));
const FinancePayments = lazy(() => import("@/pages/finance/Payments"));

const HrDashboard = lazy(() => import("@/pages/hr/Dashboard"));
const HrStaff = lazy(() => import("@/pages/hr/Staff"));
const HrLeave = lazy(() => import("@/pages/hr/Leave"));
const HrAttendance = lazy(() => import("@/pages/hr/Attendance"));
const HrReports = lazy(() => import("@/pages/hr/Reports"));
const HrEvaluations = lazy(() => import("@/pages/hr/Evaluations"));
const HrRecruitment = lazy(() => import("@/pages/hr/Recruitment"));

const AccountingDashboard = lazy(() => import("@/pages/accounting/Dashboard"));
const JournalEntries = lazy(() => import("@/pages/accounting/JournalEntries"));
const ChartOfAccounts = lazy(() => import("@/pages/accounting/ChartOfAccounts"));
const Budget = lazy(() => import("@/pages/accounting/Budget"));
const Closings = lazy(() => import("@/pages/accounting/Closings"));
const AccountingReports = lazy(() => import("@/pages/accounting/Reports"));
const AuditTrail = lazy(() => import("@/pages/accounting/AuditTrail"));

const WarehouseDashboard = lazy(() => import("@/pages/warehouse/Dashboard"));
const WarehouseCategories = lazy(() => import("@/pages/warehouse/Categories"));
const WarehouseItems = lazy(() => import("@/pages/warehouse/Items"));
const Movements = lazy(() => import("@/pages/warehouse/Movements"));
const InventoryCounts = lazy(() => import("@/pages/warehouse/InventoryCounts"));
const PurchaseRequests = lazy(() => import("@/pages/warehouse/PurchaseRequests"));
const WarehouseReports = lazy(() => import("@/pages/warehouse/Reports"));

const Profile = lazy(() => import("@/pages/common/Profile"));
const Messages = lazy(() => import("@/pages/common/Messages"));
const NotFound = lazy(() => import("@/pages/not-found"));

function PageLoader() {
  return (
    <div className="min-h-[50vh] w-full flex items-center justify-center bg-background">
      <div className="flex flex-col items-center gap-3">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-primary border-t-transparent" />
        <p className="text-sm text-muted-foreground">Loading…</p>
      </div>
    </div>
  );
}

function SuspenseWrapper({ children }: { children: React.ReactNode }) {
  return <Suspense fallback={<PageLoader />}>{children}</Suspense>;
}

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: false,
      refetchOnWindowFocus: false,
      staleTime: 30_000,
      gcTime: 5 * 60_000,
    },
    mutations: {
      retry: false,
    },
  },
});

function IndexRoute() {
  const { user, loading } = useAuth();
  if (loading) {
    return (
      <div className="min-h-screen w-full flex items-center justify-center bg-background">
        <div className="text-sm text-muted-foreground animate-pulse">Loading…</div>
      </div>
    );
  }
  if (!user) return <Redirect to="/login" />;
  return <Redirect to={`/${user.role}`} />;
}

function Portal({
  roles,
  Component,
  path,
}: {
  roles: Role[];
  Component: ComponentType<any>;
  path: string;
}) {
  const segments = path.split("/").filter(Boolean);
  const title = segments.length <= 1
    ? "Dashboard"
    : segments.slice(1).map(s => s.replace(/[-_]/g, " ").replace(/\b\w/g, c => c.toUpperCase())).join(" — ");

  return (
    <RoleGuard roles={roles}>
      <AppLayout title={title}>
        <SuspenseWrapper>
          <Component />
        </SuspenseWrapper>
      </AppLayout>
    </RoleGuard>
  );
}

const routes: Array<{ path: string; roles: Role[]; component: ComponentType<any> }> = [
  { path: "/student", roles: ["student"], component: StudentDashboardPage },
  { path: "/student/timetable", roles: ["student"], component: StudentTimetable },
  { path: "/student/assignments", roles: ["student"], component: StudentAssignments },
  { path: "/student/attendance", roles: ["student"], component: StudentAttendance },
  { path: "/student/grades", roles: ["student"], component: StudentGrades },
  { path: "/student/report-card", roles: ["student"], component: StudentReportCard },
  { path: "/student/announcements", roles: ["student"], component: StudentAnnouncements },
  { path: "/student/calendar", roles: ["student"], component: StudentCalendar },
  { path: "/student/library", roles: ["student"], component: StudentLibrary },
  { path: "/student/transport", roles: ["student"], component: StudentTransport },
  { path: "/student/medical", roles: ["student"], component: StudentMedical },
  { path: "/student/notifications", roles: ["student"], component: StudentNotifications },
  { path: "/student/messages", roles: ["student"], component: Messages },
  { path: "/student/profile", roles: ["student"], component: Profile },

  { path: "/teacher", roles: ["teacher"], component: TeacherDashboard },
  { path: "/teacher/classes", roles: ["teacher"], component: TeacherClasses },
  { path: "/teacher/assignments", roles: ["teacher"], component: TeacherAssignments },
  { path: "/teacher/attendance", roles: ["teacher"], component: TeacherAttendance },
  { path: "/teacher/timetable", roles: ["teacher"], component: TeacherTimetable },
  { path: "/teacher/grades", roles: ["teacher"], component: TeacherGrades },
  { path: "/teacher/conduct", roles: ["teacher"], component: TeacherConduct },
  { path: "/teacher/announcements", roles: ["teacher"], component: TeacherAnnouncements },
  { path: "/teacher/hr", roles: ["teacher"], component: TeacherHr },
  { path: "/teacher/notifications", roles: ["teacher"], component: TeacherNotifications },
  { path: "/teacher/messages", roles: ["teacher"], component: Messages },
  { path: "/teacher/profile", roles: ["teacher"], component: Profile },

  { path: "/admin", roles: ["admin"], component: AdminDashboardPage },
  { path: "/admin/users", roles: ["admin"], component: AdminUsers },
  { path: "/admin/classes", roles: ["admin"], component: AdminClasses },
  { path: "/admin/subjects", roles: ["admin"], component: AdminSubjects },
  { path: "/admin/exams", roles: ["admin"], component: AdminExams },
  { path: "/admin/academic-years", roles: ["admin"], component: AdminAcademicYears },
  { path: "/admin/audit", roles: ["admin"], component: AdminAudit },
  { path: "/admin/hr-requests", roles: ["admin"], component: AdminHrRequests },
  { path: "/admin/calendar", roles: ["admin"], component: AdminCalendar },
  { path: "/admin/reports", roles: ["admin"], component: AdminReports },
  { path: "/admin/timetable", roles: ["admin"], component: AdminTimetable },
  { path: "/admin/attendance", roles: ["admin"], component: AdminAttendance },
  { path: "/admin/notifications", roles: ["admin"], component: AdminNotifications },
  { path: "/admin/announcements", roles: ["admin"], component: AdminAnnouncements },
  { path: "/admin/settings", roles: ["admin"], component: SchoolSettings },
  { path: "/admin/library", roles: ["admin"], component: AdminLibrary },
  { path: "/admin/transport", roles: ["admin"], component: AdminTransport },
  { path: "/admin/medical", roles: ["admin"], component: AdminMedical },
  { path: "/admin/messages", roles: ["admin"], component: Messages },
  { path: "/admin/profile", roles: ["admin"], component: Profile },

  { path: "/parent", roles: ["parent"], component: ParentDashboard },
  { path: "/parent/children/:id", roles: ["parent"], component: ParentChildDetail },
  { path: "/parent/children", roles: ["parent"], component: ParentChildren },
  { path: "/parent/grades", roles: ["parent"], component: ParentGrades },
  { path: "/parent/attendance", roles: ["parent"], component: ParentAttendance },
  { path: "/parent/invoices", roles: ["parent"], component: ParentInvoices },
  { path: "/parent/announcements", roles: ["parent"], component: ParentAnnouncements },
  { path: "/parent/notifications", roles: ["parent"], component: ParentNotifications },
  { path: "/parent/messages", roles: ["parent"], component: Messages },
  { path: "/parent/profile", roles: ["parent"], component: Profile },

  { path: "/finance", roles: ["finance", "admin"], component: FinanceDashboard },
  { path: "/finance/invoices", roles: ["finance", "admin"], component: FinanceInvoices },
  { path: "/finance/payments", roles: ["finance", "admin"], component: FinancePayments },
  { path: "/finance/payroll", roles: ["finance", "admin"], component: FinancePayroll },
  { path: "/finance/outstanding", roles: ["finance", "admin"], component: FinanceOutstanding },
  { path: "/finance/fee-structures", roles: ["finance", "admin"], component: FinanceFeeStructures },
  { path: "/finance/reports", roles: ["finance", "admin"], component: FinanceReports },
  { path: "/finance/notifications", roles: ["finance", "admin"], component: StudentNotifications },
  { path: "/finance/messages", roles: ["finance", "admin"], component: Messages },
  { path: "/finance/profile", roles: ["finance", "admin"], component: Profile },

  { path: "/hr", roles: ["hr"], component: HrDashboard },
  { path: "/hr/staff", roles: ["hr"], component: HrStaff },
  { path: "/hr/leave", roles: ["hr"], component: HrLeave },
  { path: "/hr/attendance", roles: ["hr"], component: HrAttendance },
  { path: "/hr/reports", roles: ["hr"], component: HrReports },
  { path: "/hr/evaluations", roles: ["hr"], component: HrEvaluations },
  { path: "/hr/recruitment", roles: ["hr"], component: HrRecruitment },
  { path: "/hr/notifications", roles: ["hr"], component: StudentNotifications },
  { path: "/hr/messages", roles: ["hr"], component: Messages },
  { path: "/hr/profile", roles: ["hr"], component: Profile },

  { path: "/accounting", roles: ["accounting", "admin"], component: AccountingDashboard },
  { path: "/accounting/journal-entries", roles: ["accounting", "admin"], component: JournalEntries },
  { path: "/accounting/chart-of-accounts", roles: ["accounting", "admin"], component: ChartOfAccounts },
  { path: "/accounting/budget", roles: ["accounting", "admin"], component: Budget },
  { path: "/accounting/closings", roles: ["accounting", "admin"], component: Closings },
  { path: "/accounting/reports", roles: ["accounting", "admin"], component: AccountingReports },
  { path: "/accounting/audit", roles: ["accounting", "admin"], component: AuditTrail },
  { path: "/accounting/notifications", roles: ["accounting", "admin"], component: StudentNotifications },
  { path: "/accounting/messages", roles: ["accounting", "admin"], component: Messages },
  { path: "/accounting/profile", roles: ["accounting", "admin"], component: Profile },

  { path: "/warehouse", roles: ["warehouse", "admin"], component: WarehouseDashboard },
  { path: "/warehouse/categories", roles: ["warehouse", "admin"], component: WarehouseCategories },
  { path: "/warehouse/items", roles: ["warehouse", "admin"], component: WarehouseItems },
  { path: "/warehouse/movements", roles: ["warehouse", "admin"], component: Movements },
  { path: "/warehouse/inventory-counts", roles: ["warehouse", "admin"], component: InventoryCounts },
  { path: "/warehouse/purchase-requests", roles: ["warehouse", "admin"], component: PurchaseRequests },
  { path: "/warehouse/reports", roles: ["warehouse", "admin"], component: WarehouseReports },
  { path: "/warehouse/notifications", roles: ["warehouse", "admin"], component: StudentNotifications },
  { path: "/warehouse/messages", roles: ["warehouse", "admin"], component: Messages },
  { path: "/warehouse/profile", roles: ["warehouse", "admin"], component: Profile },
];

function Router() {
  return (
    <Switch>
      <Route path="/" component={IndexRoute} />
      <Route path="/login" component={LoginPage} />
      {routes.map(({ path, roles, component }) => (
        <Route key={path} path={path}>
          <Portal roles={roles} Component={component} path={path} />
        </Route>
      ))}
      <Route>
        <SuspenseWrapper>
          <NotFound />
        </SuspenseWrapper>
      </Route>
    </Switch>
  );
}

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <AuthProvider>
        <TooltipProvider>
          <WouterRouter base={import.meta.env.BASE_URL.replace(/\/$/, "")}>
            <ErrorBoundary>
              <Router />
            </ErrorBoundary>
          </WouterRouter>
          <Toaster />
        </TooltipProvider>
      </AuthProvider>
    </QueryClientProvider>
  );
}

export default App;
