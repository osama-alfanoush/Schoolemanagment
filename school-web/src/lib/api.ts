/**
 * Typed fetch client for the Laravel School Management API.
 * - Reads access + refresh tokens from localStorage.
 * - Auto-refreshes on 401 once per request.
 * - All endpoints are listed in `Endpoints` for autocomplete; arbitrary calls
 *   are also supported via `apiFetch(path, init)`.
 */

import type {
  User,
  StudentProfile,
  StaffProfile,
  UserRole,
  GradeComponentType,
  StudentDashboardData,
  TimetableSlot,
  Assignment,
  Grade,
  AttendanceRecord,
  CalendarEvent,
  PaginatedChartData,
  LibraryBook,
  PaginatedResponse,
  ParentChild,
  ChildOverview,
  Invoice,
  AdminKpis,
  AttendanceDashboard,
  ClassRoom,
  Subject,
  AcademicYear,
  Announcement,
  FeeStructure,
  PayrollRecord,
  OutstandingAccount,
  FinanceReports,
  Staff,
  LeaveRequest,
  StaffAttendanceData,
  MessageThread,
  Message,
  JournalEntry,
  ChartOfAccount,
  BudgetPlan,
  FinancialClosing,
  TrialBalanceData,
  AuditTrailEntry,
  WarehouseCategory,
  WarehouseItem,
  StockMovement,
  PurchaseRequest,
  InventoryCount,
  ConsumptionRow,
  WarehouseStats,
  TransportRoute,
  AuditLog,
  TimetableEntry,
  // Request types
  MarkAttendanceRequest,
  EnterGradeRequest,
  GenerateInvoicesRequest,
  RecordPaymentRequest,
  CreateJournalEntryRequest,
  CreateAccountRequest,
  UpdateAccountRequest,
  CreateBudgetRequest,
  UpdateBudgetRequest,
  CloseMonthRequest,
  CreateUserRequest,
  UpdateUserRequest,
  CreateClassRoomRequest,
  UpdateClassRoomRequest,
  AssignSubjectTeacherRequest,
  CreateTimetableEntryRequest,
  CreateSubjectRequest,
  UpdateSubjectRequest,
  CreateExamRequest,
  CreateAcademicYearRequest,
  CreateCalendarEventRequest,
  CreateAnnouncementRequest,
  CreateLibraryBookRequest,
  UpdateLibraryBookRequest,
  CreateTransportRouteRequest,
  CreateTransportVehicleRequest,
  UpdateStaffRequest,
  CreateLeaveRequest,
  MarkStaffAttendanceRequest,
  CreateAssignmentRequest,
  GradeSubmissionRequest,
  CreateGradeComponentRequest,
  LogConductRequest,
  CreateCategoryRequest,
  CreateWarehouseItemRequest,
  UpdateWarehouseItemRequest,
  StockMovementRequest,
  CreatePurchaseRequestData,
  ReviewPurchaseRequestData,
  CreateInventoryCountRequest,
  PaymentIntentRequest,
  ConfirmPaymentRequest,
  NotificationPreferencesRequest,
  RegisterDeviceRequest,
  SendMessageRequest,
  CreateFeeStructureRequest,
  UpdateFeeStructureRequest,
  QueryParams,
} from '../types/api.types';

// Re-export so consumers can import from this module
export type {
  User,
  StudentProfile,
  StaffProfile,
  UserRole,
  GradeComponentType,
  StudentDashboardData,
  TimetableSlot,
  Assignment,
  Grade,
  AttendanceRecord,
  CalendarEvent,
  PaginatedChartData,
  LibraryBook,
  PaginatedResponse,
  ParentChild,
  ChildOverview,
  Invoice,
  AdminKpis,
  AttendanceDashboard,
  ClassRoom,
  Subject,
  AcademicYear,
  Announcement,
  FeeStructure,
  PayrollRecord,
  OutstandingAccount,
  FinanceReports,
  Staff,
  LeaveRequest,
  StaffAttendanceData,
  MessageThread,
  Message,
  JournalEntry,
  ChartOfAccount,
  BudgetPlan,
  FinancialClosing,
  TrialBalanceData,
  AuditTrailEntry,
  WarehouseCategory,
  WarehouseItem,
  StockMovement,
  PurchaseRequest,
  InventoryCount,
  ConsumptionRow,
  WarehouseStats,
  TransportRoute,
  AuditLog,
  TimetableEntry,
  MarkAttendanceRequest,
  EnterGradeRequest,
  GenerateInvoicesRequest,
  RecordPaymentRequest,
  CreateJournalEntryRequest,
  CreateAccountRequest,
  UpdateAccountRequest,
  CreateBudgetRequest,
  UpdateBudgetRequest,
  CloseMonthRequest,
  CreateUserRequest,
  UpdateUserRequest,
  CreateClassRoomRequest,
  UpdateClassRoomRequest,
  AssignSubjectTeacherRequest,
  CreateTimetableEntryRequest,
  CreateSubjectRequest,
  UpdateSubjectRequest,
  CreateExamRequest,
  CreateAcademicYearRequest,
  CreateCalendarEventRequest,
  CreateAnnouncementRequest,
  CreateLibraryBookRequest,
  UpdateLibraryBookRequest,
  CreateTransportRouteRequest,
  CreateTransportVehicleRequest,
  UpdateStaffRequest,
  CreateLeaveRequest,
  MarkStaffAttendanceRequest,
  CreateAssignmentRequest,
  GradeSubmissionRequest,
  CreateGradeComponentRequest,
  LogConductRequest,
  CreateCategoryRequest,
  CreateWarehouseItemRequest,
  UpdateWarehouseItemRequest,
  StockMovementRequest,
  CreatePurchaseRequestData,
  ReviewPurchaseRequestData,
  CreateInventoryCountRequest,
  PaymentIntentRequest,
  ConfirmPaymentRequest,
  NotificationPreferencesRequest,
  RegisterDeviceRequest,
  SendMessageRequest,
  CreateFeeStructureRequest,
  UpdateFeeStructureRequest,
  QueryParams,
  
};

export type Role = UserRole;

// AuthUser = User + session-specific fields
export interface AuthUser extends User {
  locale?: 'en' | 'ar' | null;
  photo_path?: string | null;
}

export interface LoginResponse {
  access_token: string;
  refresh_token: string;
  token_type: string;
  expires_in: number;
  user: AuthUser;
}

const STORAGE_KEYS = {
  access: "sm_access_token",
  refresh: "sm_refresh_token",
  user: "sm_user",
};

function notifyAuthChanged() {
  if (typeof window !== "undefined") {
    window.dispatchEvent(new Event("school-auth-changed"));
  }
}

/** Base URL for all API requests. Uses VITE_API_BASE_URL in production, falls back to /api. */
export const API_BASE_URL: string =
  (typeof import.meta !== "undefined" &&
    (import.meta as Record<string, any>).env?.VITE_API_BASE_URL) ||
  "/api";

export function mediaUrl(path?: string | null): string {
  if (!path) return "";

  const apiRoot = API_BASE_URL.replace(/\/api\/?$/, "");
  if (/^(data:|blob:)/i.test(path)) return path;
  if (/^https?:/i.test(path)) {
    try {
      const url = new URL(path);
      if (url.pathname.startsWith("/storage/") && /^https?:\/\//i.test(apiRoot)) {
        return new URL(url.pathname + url.search + url.hash, apiRoot).toString();
      }
    } catch {
      // Keep the original path if URL parsing fails.
    }
    return path;
  }

  const cleanPath = path.replace(/^\/+/, "");
  const storagePath = cleanPath.startsWith("storage/") ? cleanPath : `storage/${cleanPath}`;

  return new URL(`/${storagePath}`, apiRoot || window.location.origin).toString();
}

/** Max attempts for token refresh before giving up (circuit-breaker). */
const MAX_REFRESH_ATTEMPTS = 3;

/** Request timeout in milliseconds. */
const REQUEST_TIMEOUT_MS = Number(
  (typeof import.meta !== "undefined" &&
    (import.meta as Record<string, any>).env?.VITE_API_TIMEOUT_MS) ||
    15000,
);

/** Minimal user shape persisted in localStorage — avoids storing full object. */
interface StoredUser {
  id: number;
  name: string;
  email: string;
  role: UserRole;
  locale?: string | null;
  photo_path?: string | null;
}

export const tokenStore = {
  getAccess: () => localStorage.getItem(STORAGE_KEYS.access),
  getRefresh: () => localStorage.getItem(STORAGE_KEYS.refresh),
  getUser: (): AuthUser | null => {
    const raw = localStorage.getItem(STORAGE_KEYS.user);
    if (!raw) return null;
    try {
      const parsed = JSON.parse(raw) as StoredUser;
      return parsed as AuthUser;
    } catch {
      localStorage.removeItem(STORAGE_KEYS.user);
      return null;
    }
  },
  setSession(access: string, refresh: string, user: AuthUser) {
    localStorage.setItem(STORAGE_KEYS.access, access);
    localStorage.setItem(STORAGE_KEYS.refresh, refresh);
    const minimal: StoredUser = {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      locale: user.locale,
      photo_path: user.photo_path,
    };
    localStorage.setItem(STORAGE_KEYS.user, JSON.stringify(minimal));
    notifyAuthChanged();
  },
  setUser(user: AuthUser) {
    const minimal: StoredUser = {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      locale: user.locale,
      photo_path: user.photo_path,
    };
    localStorage.setItem(STORAGE_KEYS.user, JSON.stringify(minimal));
  },
  setTokens(access: string, refresh: string) {
    localStorage.setItem(STORAGE_KEYS.access, access);
    localStorage.setItem(STORAGE_KEYS.refresh, refresh);
    notifyAuthChanged();
  },
  clear() {
    Object.values(STORAGE_KEYS).forEach((k) => localStorage.removeItem(k));
    notifyAuthChanged();
  },
};

export class ApiError extends Error {
  status: number;
  data: unknown;
  constructor(status: number, message: string, data?: unknown) {
    super(message);
    this.status = status;
    this.data = data;
  }
}

let refreshing: Promise<string | null> | null = null;
let refreshAttempts = 0;

async function refreshTokens(): Promise<string | null> {
  if (refreshAttempts >= MAX_REFRESH_ATTEMPTS) {
    tokenStore.clear();
    return null;
  }
  if (refreshing) return refreshing;
  const refresh = tokenStore.getRefresh();
  if (!refresh) return null;
  refreshing = (async () => {
    try {
      const res = await fetch(`${API_BASE_URL}/auth/refresh`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${refresh}`,
          Accept: "application/json",
        },
      });
      if (!res.ok) {
        refreshAttempts++;
        tokenStore.clear();
        return null;
      }
      refreshAttempts = 0;
      const body = (await res.json()) as { access_token: string; refresh_token: string };
      tokenStore.setTokens(body.access_token, body.refresh_token);
      return body.access_token;
    } catch {
      refreshAttempts++;
      tokenStore.clear();
      return null;
    } finally {
      refreshing = null;
    }
  })();
  return refreshing;
}

interface RequestInitX extends Omit<RequestInit, "body"> {
  body?: unknown;
  query?: QueryParams;
  raw?: boolean;
}

export async function apiFetch<T = unknown>(path: string, init: RequestInitX = {}): Promise<T> {
  const url = new URL(API_BASE_URL + path, window.location.origin);
  if (init.query) {
    Object.entries(init.query).forEach(([k, v]) => {
      if (v !== undefined && v !== null && v !== "") url.searchParams.set(k, String(v));
    });
  }

  const buildHeaders = (token: string | null): HeadersInit => {
    const h: Record<string, string> = {
      Accept: "application/json",
    };
    if (token) h.Authorization = `Bearer ${token}`;
    if (init.body !== undefined && !init.raw) h["Content-Type"] = "application/json";
    return { ...h, ...(init.headers as Record<string, string>) };
  };

  const buildBody = () => {
    if (init.body === undefined) return undefined;
    if (init.raw) return init.body as BodyInit;
    return JSON.stringify(init.body);
  };

  // Each attempt gets its OWN controller + timeout so the post-refresh retry
  // is also bounded (previously the retry ran without any timeout).
  const doFetch = async (token: string | null): Promise<Response> => {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);
    try {
      return await fetch(url.toString(), {
        method: init.method ?? "GET",
        headers: buildHeaders(token),
        body: buildBody(),
        signal: controller.signal,
      });
    } catch (err) {
      if ((err as Error).name === "AbortError") {
        throw new ApiError(0, "Request timed out");
      }
      throw new ApiError(0, "Network error");
    } finally {
      clearTimeout(timeoutId);
    }
  };

  let res = await doFetch(tokenStore.getAccess());

  if (res.status === 401 && tokenStore.getRefresh()) {
    const newAccess = await refreshTokens();
    if (newAccess) {
      res = await doFetch(newAccess);
    }
  }

  const ct = res.headers.get("content-type") || "";
  const isJson = ct.includes("application/json");

  if (!res.ok) {
    const data = isJson ? await res.json().catch(() => ({})) : await res.text();
    const msg = (isJson && (data as { message?: string }).message) || res.statusText || "Request failed";
    throw new ApiError(res.status, msg, data);
  }

  if (res.status === 204) return undefined as T;
  if (isJson) return (await res.json()) as T;
  return (await res.blob()) as unknown as T;
}

export async function apiDownload(path: string, filename: string, params?: QueryParams) {
  const url = new URL(API_BASE_URL + path, window.location.origin);
  if (params) {
    Object.entries(params).forEach(([k, v]) => {
      if (v !== undefined && v !== null && v !== "") url.searchParams.set(k, String(v));
    });
  }
  const urlStr = url.toString();

  // Each attempt gets its own controller + timeout so the post-refresh retry is
  // also bounded (mirrors apiFetch).
  const doFetch = async (token: string | null): Promise<Response> => {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);
    try {
      return await fetch(urlStr, {
        headers: token ? { Authorization: `Bearer ${token}` } : {},
        signal: controller.signal,
      });
    } catch (err) {
      if ((err as Error).name === "AbortError") {
        throw new ApiError(0, "Download timed out");
      }
      throw new ApiError(0, "Network error");
    } finally {
      clearTimeout(timeoutId);
    }
  };

  let res = await doFetch(tokenStore.getAccess());

  // Refresh and retry once on access-token expiry — the same path apiFetch uses —
  // so report cards, receipts and other downloads keep working after rotation.
  if (res.status === 401 && tokenStore.getRefresh()) {
    const newAccess = await refreshTokens();
    if (newAccess) {
      res = await doFetch(newAccess);
    }
  }

  if (res.status === 401) {
    tokenStore.clear();
    window.location.href = "/login";
    throw new ApiError(401, "Not authenticated");
  }
  if (!res.ok) throw new ApiError(res.status, "Download failed");

  const blob = await res.blob();
  const a = document.createElement("a");
  a.href = URL.createObjectURL(blob);
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(a.href), 60_000);
}

// ---------------------------------------------------------------------------
// Endpoint helpers — every Laravel API route grouped by portal.
// ---------------------------------------------------------------------------

export const Auth = {
  login: (email: string, password: string) =>
    apiFetch<LoginResponse>("/auth/login", { method: "POST", body: { email, password } }),
  logout: () => apiFetch("/auth/logout", { method: "POST" }),
  me: () => apiFetch<{ user: AuthUser }>("/auth/me"),
  forgotPassword: (email: string) =>
    apiFetch("/auth/forgot-password", { method: "POST", body: { email } }),
  resetPassword: (data: { token: string; email: string; password: string; password_confirmation: string }) =>
    apiFetch("/auth/reset-password", { method: "POST", body: data }),
  changePassword: (data: { current_password: string; new_password: string; new_password_confirmation: string }) =>
    apiFetch("/auth/change-password", { method: "POST", body: data }),
  updateProfile: (data: Partial<Pick<AuthUser, 'name' | 'phone' | 'locale'>>) =>
    apiFetch<{ user: AuthUser }>("/auth/profile", { method: "PATCH", body: data }),
  uploadProfilePhoto: (file: File) => {
    const fd = new FormData();
    fd.append("photo", file);
    return apiFetch<{ photo_url: string; user: AuthUser }>("/auth/profile/photo", {
      method: "POST",
      body: fd,
      raw: true,
    });
  },
};

export const Student = {
  dashboard: (): Promise<StudentDashboardData> => apiFetch("/student/dashboard"),
  timetable: (): Promise<TimetableSlot[]> => apiFetch("/student/timetable"),
  assignments: (): Promise<Assignment[]> => apiFetch("/student/assignments"),
  submitAssignment: (id: number, contentText?: string, file?: File) => {
    const fd = new FormData();
    if (contentText) fd.append("content_text", contentText);
    if (file) fd.append("file", file);
    return apiFetch(`/student/assignments/${id}/submit`, { method: "POST", body: fd, raw: true });
  },
  grades: (): Promise<Grade[]> => apiFetch("/student/grades"),
  attendance: (): Promise<AttendanceRecord[]> => apiFetch("/student/attendance"),
  reportCard: (): Promise<unknown> => apiFetch("/student/report-card"),
  reportCardPdf: (params?: QueryParams) => apiDownload("/student/report-card/pdf", "report-card.pdf", params),
  announcements: (): Promise<unknown> => apiFetch("/student/announcements"),
  calendar: (): Promise<CalendarEvent[]> => apiFetch("/student/calendar"),
  performanceChart: (): Promise<PaginatedChartData> => apiFetch("/student/performance-chart"),
  libraryBooks: (params?: QueryParams): Promise<PaginatedResponse<LibraryBook>> =>
    apiFetch("/student/library/books", { query: params }),
  myBorrowings: (): Promise<unknown> => apiFetch("/student/library/my-borrowings"),
  borrowBook: (id: number): Promise<unknown> =>
    apiFetch(`/student/library/books/${id}/borrow`, { method: "POST" }),
  returnBook: (id: number): Promise<unknown> =>
    apiFetch(`/student/library/borrowings/${id}/return`, { method: "POST" }),
  myTransportRoute: (): Promise<TransportRoute> => apiFetch("/student/transport/my-route"),
};

export const Parent = {
  children: (): Promise<ParentChild[]> => apiFetch("/parent/children"),
  childOverview: (id: number): Promise<ChildOverview> => apiFetch(`/parent/children/${id}/overview`),
  childGrades: (id: number): Promise<unknown> => apiFetch(`/parent/children/${id}/grades`),
  childAssignments: (id: number): Promise<unknown> => apiFetch(`/parent/children/${id}/assignments`),
  childAttendance: (id: number): Promise<AttendanceRecord[]> => apiFetch(`/parent/children/${id}/attendance`),
  childInvoices: (id: number): Promise<{ invoices: Invoice[]; outstanding_total: number }> =>
    apiFetch(`/parent/children/${id}/invoices`),
  childPayments: (id: number): Promise<unknown> => apiFetch(`/parent/children/${id}/payments`),
  childConduct: (id: number): Promise<unknown> => apiFetch(`/parent/children/${id}/conduct`),
  childInvoiceReceipt: (studentId: number, invoiceId: number, invoiceNo: string) =>
    apiDownload(
      `/parent/children/${studentId}/invoices/${invoiceId}/receipt-pdf`,
      `receipt-${invoiceNo}.pdf`,
    ),
  announcements: (): Promise<unknown> => apiFetch("/parent/announcements"),
  childReportCard: (childId: number): Promise<unknown> =>
    apiFetch(`/parent/children/${childId}/report-card`),
  childReportCardPdf: (childId: number) =>
    apiDownload(`/parent/children/${childId}/report-card/pdf`, "report-card.pdf"),
  childPerformanceChart: (childId: number): Promise<PaginatedChartData> =>
    apiFetch(`/parent/children/${childId}/performance-chart`),
  childTransport: (childId: number): Promise<unknown> =>
    apiFetch(`/parent/children/${childId}/transport`),
};

export const Teacher = {
  classes: (): Promise<ClassRoom[]> => apiFetch("/teacher/classes"),
  timetable: (): Promise<TimetableSlot[]> => apiFetch("/teacher/timetable"),
  classStudents: (classId: number): Promise<unknown> => apiFetch(`/teacher/classes/${classId}/students`),
  createAssignment: (data: FormData) =>
    apiFetch("/teacher/assignments", { method: "POST", body: data, raw: true }),
  assignmentSubmissions: (id: number) => apiFetch(`/teacher/assignments/${id}/submissions`),
  gradeSubmission: (id: number, score: number, feedback?: string): Promise<unknown> =>
    apiFetch(`/teacher/submissions/${id}/grade`, {
      method: "PATCH",
      body: { score, feedback } satisfies GradeSubmissionRequest,
    }),
  markAttendance: (data: MarkAttendanceRequest): Promise<unknown> =>
    apiFetch("/teacher/attendance", { method: "POST", body: data }),
  gradeComponents: (classId: number, subjectId: number, data?: CreateGradeComponentRequest): Promise<unknown> =>
    apiFetch(`/teacher/grade-components/${classId}/${subjectId}`, data ? { method: "POST", body: data } : {}),
  enterGrade: (data: EnterGradeRequest): Promise<unknown> => apiFetch("/teacher/grades", { method: "POST", body: data }),
  logConduct: (data: LogConductRequest): Promise<unknown> => apiFetch("/teacher/conduct", { method: "POST", body: data }),
  announce: (data: { class_room_id: number; title: string; body: string }): Promise<unknown> =>
    apiFetch("/teacher/announcements", { method: "POST", body: data }),
  submitHrRequest: (data: CreateLeaveRequest): Promise<unknown> =>
    apiFetch("/hr-requests", { method: "POST", body: data }),
  myHrRequests: (): Promise<unknown> => apiFetch("/hr-requests"),
  getAnnouncements: (params?: QueryParams): Promise<PaginatedResponse<Announcement>> =>
    apiFetch("/teacher/announcements", { query: params }),
  gradesExport: (params?: QueryParams): Promise<unknown> =>
    apiFetch("/teacher/grades/export", { query: params }),
};

export const Admin = {
  users: (q?: { role?: string; q?: string }): Promise<PaginatedResponse<User>> => apiFetch("/admin/users", { query: q }),
  createUser: (data: CreateUserRequest): Promise<unknown> => apiFetch("/admin/users", { method: "POST", body: data }),
  updateUser: (id: number, data: UpdateUserRequest): Promise<unknown> =>
    apiFetch(`/admin/users/${id}`, { method: "PATCH", body: data }),
  deactivateUser: (id: number): Promise<unknown> => apiFetch(`/admin/users/${id}`, { method: "DELETE" }),
  linkParent: (parent_user_id: number, student_user_id: number, relation?: string): Promise<unknown> =>
    apiFetch("/admin/users/link-parent", {
      method: "POST",
      body: { parent_user_id, student_user_id, relation },
    }),
  importStudents: (file: File) => {
    const fd = new FormData();
    fd.append("file", file);
    return apiFetch("/admin/users/import-students", { method: "POST", body: fd, raw: true });
  },
  classes: (): Promise<ClassRoom[]> => apiFetch("/admin/classes"),
  createClass: (data: CreateClassRoomRequest): Promise<ClassRoom> =>
    apiFetch("/admin/classes", { method: "POST", body: data }),
  updateClass: (id: number, data: Partial<CreateClassRoomRequest>): Promise<ClassRoom> =>
    apiFetch(`/admin/classes/${id}`, { method: "PATCH", body: data }),
  deleteClass: (id: number): Promise<void> =>
    apiFetch(`/admin/classes/${id}`, { method: "DELETE" }),
  assignSubjectTeacher: (classId: number, data: AssignSubjectTeacherRequest): Promise<{ message: string }> =>
    apiFetch(`/admin/classes/${classId}/assign-subject-teacher`, { method: "POST", body: data }),
  timetable: (classId: number): Promise<TimetableEntry[]> => apiFetch(`/admin/classes/${classId}/timetable`),
  addTimetableEntry: (classId: number, data: CreateTimetableEntryRequest): Promise<TimetableEntry> =>
    apiFetch(`/admin/classes/${classId}/timetable`, { method: "POST", body: data }),
  deleteTimetableEntry: (classId: number, entryId: number): Promise<void> =>
    apiFetch(`/admin/classes/${classId}/timetable/${entryId}`, { method: "DELETE" }),
  subjects: (): Promise<Subject[]> => apiFetch("/admin/subjects"),
  createSubject: (data: CreateSubjectRequest): Promise<Subject> =>
    apiFetch("/admin/subjects", { method: "POST", body: data }),
  updateSubject: (id: number, data: Partial<CreateSubjectRequest>): Promise<Subject> =>
    apiFetch(`/admin/subjects/${id}`, { method: "PATCH", body: data }),
  deleteSubject: (id: number): Promise<void> =>
    apiFetch(`/admin/subjects/${id}`, { method: "DELETE" }),
  exams: (): Promise<any[]> => apiFetch("/admin/exams"),
  createExam: (data: CreateExamRequest): Promise<any> =>
    apiFetch("/admin/exams", { method: "POST", body: data }),
  updateExam: (id: number, data: Partial<CreateExamRequest>): Promise<any> =>
    apiFetch(`/admin/exams/${id}`, { method: "PATCH", body: data }),
  deleteExam: (id: number): Promise<void> =>
    apiFetch(`/admin/exams/${id}`, { method: "DELETE" }),
  academicYears: (): Promise<AcademicYear[]> => apiFetch("/admin/academic-years"),
  createAcademicYear: (data: CreateAcademicYearRequest): Promise<AcademicYear> =>
    apiFetch("/admin/academic-years", { method: "POST", body: data }),
  updateAcademicYear: (id: number, data: Partial<CreateAcademicYearRequest>): Promise<AcademicYear> =>
    apiFetch(`/admin/academic-years/${id}`, { method: "PATCH", body: data }),
  deleteAcademicYear: (id: number): Promise<void> =>
    apiFetch(`/admin/academic-years/${id}`, { method: "DELETE" }),
  calendar: (): Promise<CalendarEvent[]> => apiFetch("/admin/calendar"),
  createCalendarEvent: (data: CreateCalendarEventRequest): Promise<CalendarEvent> =>
    apiFetch("/admin/calendar", { method: "POST", body: data }),
  updateCalendarEvent: (id: number, data: Partial<CreateCalendarEventRequest>): Promise<CalendarEvent> =>
    apiFetch(`/admin/calendar/${id}`, { method: "PATCH", body: data }),
  deleteCalendarEvent: (id: number): Promise<void> =>
    apiFetch(`/admin/calendar/${id}`, { method: "DELETE" }),
  hrRequests: (): Promise<PaginatedResponse<any>> => apiFetch("/admin/hr-requests"),
  reviewHrRequest: (id: number, status: "approved" | "rejected", admin_response?: string): Promise<any> =>
    apiFetch(`/admin/hr-requests/${id}/review`, {
      method: "PATCH",
      body: { status, admin_response },
    }),
  kpis: (): Promise<AdminKpis> => apiFetch("/admin/dashboard/kpis"),
  attendanceDashboard: (): Promise<AttendanceDashboard> => apiFetch("/admin/attendance/dashboard"),
  monthlyReports: (year?: number, month?: number): Promise<any> =>
    apiFetch("/admin/reports/monthly", { query: { year, month } }),
  auditLogs: (): Promise<AuditLog[]> => apiFetch("/admin/audit-logs"),
  announce: (data: CreateAnnouncementRequest): Promise<Announcement> =>
    apiFetch("/admin/announcements", { method: "POST", body: data }),
  deleteAnnouncement: (id: number): Promise<void> =>
    apiFetch(`/admin/announcements/${id}`, { method: "DELETE" }),
  schoolSettings: (): Promise<any> => apiFetch("/admin/school-settings"),
  updateSchoolSettings: (data: FormData): Promise<any> =>
    apiFetch("/admin/school-settings", { method: "POST", body: data, raw: true }),
  getAnnouncements: (params?: QueryParams): Promise<PaginatedResponse<Announcement>> =>
    apiFetch("/admin/announcements", { query: params }),
  libraryBooks: (params?: QueryParams): Promise<PaginatedResponse<LibraryBook>> =>
    apiFetch("/admin/library/books", { query: params }),
  createLibraryBook: (data: CreateLibraryBookRequest): Promise<LibraryBook> =>
    apiFetch("/admin/library/books", { method: "POST", body: data }),
  updateLibraryBook: (id: number, data: UpdateLibraryBookRequest): Promise<LibraryBook> =>
    apiFetch(`/admin/library/books/${id}`, { method: "PATCH", body: data }),
  libraryBorrowings: (params?: QueryParams): Promise<PaginatedResponse<any>> =>
    apiFetch("/admin/library/borrowings", { query: params }),
  libraryOverdue: (): Promise<any[]> => apiFetch("/admin/library/overdue"),
  transportRoutes: (params?: QueryParams): Promise<TransportRoute[]> =>
    apiFetch("/admin/transport/routes", { query: params }),
  createTransportRoute: (data: CreateTransportRouteRequest): Promise<TransportRoute> =>
    apiFetch("/admin/transport/routes", { method: "POST", body: data }),
  transportVehicles: (): Promise<any[]> => apiFetch("/admin/transport/vehicles"),
  createTransportVehicle: (data: CreateTransportVehicleRequest): Promise<any> =>
    apiFetch("/admin/transport/vehicles", { method: "POST", body: data }),
  transportAssignments: (): Promise<any[]> => apiFetch("/admin/transport/assignments"),
};

export const Finance = {
  feeStructures: (): Promise<FeeStructure[]> => apiFetch("/finance/fee-structures"),
  createFeeStructure: (data: CreateFeeStructureRequest): Promise<unknown> =>
    apiFetch("/finance/fee-structures", { method: "POST", body: data }),
  updateFeeStructure: (id: number, data: UpdateFeeStructureRequest): Promise<unknown> =>
    apiFetch(`/finance/fee-structures/${id}`, { method: "PATCH", body: data }),
  deleteFeeStructure: (id: number): Promise<void> =>
    apiFetch(`/finance/fee-structures/${id}`, { method: "DELETE" }),
  invoices: (q?: { status?: string; student_user_id?: number }): Promise<PaginatedResponse<Invoice>> =>
    apiFetch("/finance/invoices", { query: q }),
  generateInvoices: (data: GenerateInvoicesRequest): Promise<unknown> =>
    apiFetch("/finance/invoices/generate", { method: "POST", body: data }),
  recordPayment: (invoiceId: number, data: RecordPaymentRequest): Promise<unknown> =>
    apiFetch(`/finance/invoices/${invoiceId}/payments`, { method: "POST", body: data }),
  receiptPdf: (invoiceId: number, invoiceNo: string) =>
    apiDownload(`/finance/invoices/${invoiceId}/receipt-pdf`, `receipt-${invoiceNo}.pdf`),
  sendReminders: (): Promise<unknown> => apiFetch("/finance/invoices/send-reminders", { method: "POST" }),
  outstanding: (): Promise<OutstandingAccount[]> => apiFetch("/finance/outstanding"),
  payroll: (year?: number, month?: number): Promise<PayrollRecord[]> =>
    apiFetch("/finance/payroll", { query: { year, month } }),
  processPayroll: (year: number, month: number): Promise<unknown> =>
    apiFetch("/finance/payroll/process", { method: "POST", body: { year, month } }),
  payrollFor: (year: number, month: number): Promise<PayrollRecord[]> =>
    apiFetch("/finance/payroll", { query: { year, month } }),
  markPayrollPaid: (id: number): Promise<unknown> =>
    apiFetch(`/finance/payroll/${id}/pay`, { method: "PATCH" }),
  reports: (year?: number, month?: number): Promise<FinanceReports> =>
    apiFetch("/finance/reports", { query: { year, month } }),
};

export const Hr = {
  staff: (q?: { role?: string; q?: string }): Promise<PaginatedResponse<Staff>> => apiFetch("/hr/staff", { query: q }),
  staffDetail: (id: number): Promise<Staff> => apiFetch(`/hr/staff/${id}`),
  updateStaff: (id: number, data: UpdateStaffRequest): Promise<unknown> =>
    apiFetch(`/hr/staff/${id}`, { method: "PATCH", body: data }),
  leaveRequests: (status?: string): Promise<LeaveRequest[]> => apiFetch("/hr/leave-requests", { query: { status } }),
  requests: (status?: string): Promise<LeaveRequest[]> => apiFetch("/hr/requests", { query: { status } }),
  reviewRequest: (id: number, status: "approved" | "rejected", response?: string): Promise<unknown> =>
    apiFetch(`/hr/requests/${id}/review`, { method: "PATCH", body: { status, response } }),
  leaveBalances: (): Promise<unknown> => apiFetch("/hr/leave-balances"),
  staffAttendance: (year?: number, month?: number): Promise<StaffAttendanceData> =>
    apiFetch("/hr/staff-attendance", { query: { year, month } }),
  markStaffAttendance: (records: MarkStaffAttendanceRequest["records"]): Promise<unknown> =>
    apiFetch("/hr/staff-attendance", {
      method: "POST",
      body: { date: new Date().toISOString().slice(0, 10), records },
    }),
  staffMonthlyReport: (year?: number, month?: number): Promise<unknown> =>
    apiFetch("/hr/staff-attendance/report", { query: { year, month } }),
};

export const Messaging = {
  threads: (): Promise<MessageThread[]> => apiFetch("/messages/threads"),
  recipients: (search?: string): Promise<Array<{ id: number; name: string; email?: string; role: Role; photo_path?: string | null }>> =>
    apiFetch("/messages/recipients", { query: { search } }),
  conversation: (otherId: number): Promise<Message[]> => apiFetch(`/messages/conversation/${otherId}`),
  send: (data: SendMessageRequest): Promise<unknown> =>
    apiFetch("/messages", { method: "POST", body: data }),
  notifications: (): Promise<PaginatedResponse<unknown>> => apiFetch("/notifications"),
  unreadCount: () => apiFetch<{
    total_unread: number;
    high_priority_unread?: number;
    notifications: number;
    messages: number;
  }>("/notifications/unread-count"),
  markRead: (id: number): Promise<unknown> => apiFetch(`/notifications/${id}/read`, { method: "PATCH" }),
  markAllRead: (): Promise<unknown> => apiFetch("/notifications/read-all", { method: "PATCH" }),
  markAsClicked: (id: number): Promise<unknown> =>
    apiFetch(`/notifications/${id}/click`, { method: "PATCH" }),
  getPreferences: (): Promise<unknown> => apiFetch("/notifications/preferences"),
  updatePreferences: (data: NotificationPreferencesRequest): Promise<unknown> =>
    apiFetch("/notifications/preferences", { method: "PATCH", body: data }),
  registerDevice: (data: RegisterDeviceRequest): Promise<unknown> =>
    apiFetch("/notifications/register-device", { method: "POST", body: data }),
  unregisterDevice: (token: string): Promise<unknown> =>
    apiFetch("/notifications/unregister-device", { method: "POST", body: { token } }),
  getDevices: (): Promise<unknown> => apiFetch("/notifications/devices"),
};

export const Accounting = {
  journalEntries: (params?: QueryParams): Promise<PaginatedResponse<JournalEntry>> =>
    apiFetch("/accounting/journal-entries", { query: params }),
  createJournalEntry: (data: CreateJournalEntryRequest): Promise<unknown> =>
    apiFetch("/accounting/journal-entries", { method: "POST", body: data }),
  getJournalEntry: (id: number): Promise<JournalEntry> =>
    apiFetch(`/accounting/journal-entries/${id}`),
  deleteJournalEntry: (id: number): Promise<unknown> =>
    apiFetch(`/accounting/journal-entries/${id}`, { method: "DELETE" }),
  chartOfAccounts: (params?: QueryParams): Promise<ChartOfAccount[]> =>
    apiFetch("/accounting/chart-of-accounts", { query: params }),
  createAccount: (data: CreateAccountRequest): Promise<unknown> =>
    apiFetch("/accounting/chart-of-accounts", { method: "POST", body: data }),
  updateAccount: (id: number, data: UpdateAccountRequest): Promise<unknown> =>
    apiFetch(`/accounting/chart-of-accounts/${id}`, { method: "PATCH", body: data }),
  budgets: (params?: QueryParams): Promise<BudgetPlan[]> =>
    apiFetch("/accounting/budget", { query: params }),
  createBudget: (data: CreateBudgetRequest): Promise<unknown> =>
    apiFetch("/accounting/budget", { method: "POST", body: data }),
  updateBudget: (id: number, data: UpdateBudgetRequest): Promise<unknown> =>
    apiFetch(`/accounting/budget/${id}`, { method: "PATCH", body: data }),
  syncBudgetActuals: (data?: { fiscal_year?: number; alert_threshold?: number }): Promise<unknown> =>
    apiFetch("/accounting/budget/sync-actuals", {
      method: "POST",
      body: data ?? { fiscal_year: new Date().getFullYear() },
    }),
  closings: (): Promise<FinancialClosing[]> => apiFetch("/accounting/closings"),
  createClosing: (data: CloseMonthRequest): Promise<unknown> =>
    apiFetch("/accounting/closings", { method: "POST", body: data }),
  trialBalance: (params?: QueryParams): Promise<TrialBalanceData> =>
    apiFetch("/accounting/reports/trial-balance", { query: params }),
  trialBalancePdf: (params?: QueryParams) =>
    apiDownload("/accounting/reports/trial-balance/pdf", "trial-balance.pdf", params),
  incomeStatement: (params?: QueryParams): Promise<unknown> =>
    apiFetch("/accounting/reports/income-statement", { query: params }),
  incomeStatementPdf: (params?: QueryParams) =>
    apiDownload("/accounting/reports/income-statement/pdf", "income-statement.pdf", params),
  balanceSheet: (params?: QueryParams): Promise<unknown> =>
    apiFetch("/accounting/reports/balance-sheet", { query: params }),
  auditTrail: (params?: QueryParams): Promise<PaginatedResponse<AuditTrailEntry>> =>
    apiFetch("/accounting/audit-trail", { query: params }),
};

export const Warehouse = {
  categories: (): Promise<WarehouseCategory[]> => apiFetch("/warehouse/categories"),
  createCategory: (data: CreateCategoryRequest): Promise<unknown> =>
    apiFetch("/warehouse/categories", { method: "POST", body: data }),
  items: (params?: QueryParams): Promise<PaginatedResponse<WarehouseItem>> =>
    apiFetch("/warehouse/items", { query: params }),
  createItem: (data: CreateWarehouseItemRequest): Promise<unknown> =>
    apiFetch("/warehouse/items", { method: "POST", body: data }),
  getItem: (id: number): Promise<WarehouseItem> => apiFetch(`/warehouse/items/${id}`),
  updateItem: (id: number, data: UpdateWarehouseItemRequest): Promise<unknown> =>
    apiFetch(`/warehouse/items/${id}`, { method: "PATCH", body: data }),
  movements: (params?: QueryParams): Promise<PaginatedResponse<StockMovement>> =>
    apiFetch("/warehouse/movements", { query: params }),
  createMovement: (data: StockMovementRequest): Promise<unknown> =>
    apiFetch("/warehouse/movements", { method: "POST", body: data }),
  purchaseRequests: (params?: QueryParams): Promise<PaginatedResponse<PurchaseRequest>> =>
    apiFetch("/warehouse/purchase-requests", { query: params }),
  createPurchaseRequest: (data: CreatePurchaseRequestData): Promise<unknown> =>
    apiFetch("/warehouse/purchase-requests", { method: "POST", body: data }),
  reviewPurchaseRequest: (id: number, data: ReviewPurchaseRequestData): Promise<unknown> =>
    apiFetch(`/warehouse/purchase-requests/${id}/review`, { method: "PATCH", body: data }),
  inventoryCounts: (): Promise<InventoryCount[]> => apiFetch("/warehouse/inventory-counts"),
  createInventoryCount: (data: CreateInventoryCountRequest): Promise<unknown> =>
    apiFetch("/warehouse/inventory-counts", { method: "POST", body: data }),
  dashboard: (): Promise<WarehouseStats> => apiFetch("/warehouse/dashboard"),
  consumptionReport: (params?: QueryParams): Promise<PaginatedResponse<ConsumptionRow>> =>
    apiFetch("/warehouse/reports/consumption", { query: params }),
  consumptionPdf: (params?: QueryParams) =>
    apiDownload("/warehouse/reports/consumption/pdf", "consumption.pdf", params),
  inventoryReport: (params?: QueryParams): Promise<unknown> =>
    apiFetch("/warehouse/reports/inventory", { query: params }),
  inventoryPdf: (params?: QueryParams) =>
    apiDownload("/warehouse/reports/inventory/pdf", "inventory.pdf", params),
};

export const Payments = {
  createIntent: (data: PaymentIntentRequest): Promise<unknown> =>
    apiFetch("/payments/create-intent", { method: "POST", body: data }),
  confirm: (data: ConfirmPaymentRequest): Promise<unknown> =>
    apiFetch("/payments/confirm", { method: "POST", body: data }),
  status: (paymentIntentId: string): Promise<unknown> =>
    apiFetch(`/payments/status/${paymentIntentId}`),
  methods: (): Promise<unknown> => apiFetch("/payments/methods"),
  setupIntent: (): Promise<unknown> =>
    apiFetch("/payments/setup-intent", { method: "POST" }),
};
