/**
 * Typed fetch client for the Laravel School Management API.
 * - Uses encrypted httpOnly cookies for browser credentials.
 * - Sends a double-submit CSRF token for state-changing requests.
 * - Auto-refreshes the cookie session on 401 once per request.
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
  Supplier,
  PurchaseOrder,
  PurchaseOrderItem,
  GoodsReceipt,
  SupplierInvoice,
  ProcurementDashboardData,
  PaymentPlan,
  InstallmentRow,
  PaymentReceipt,
  StudentFinancialAdjustment,
  StudentFinanceProfile,
  StudentStatement,
  JournalBatch,
  CreatePaymentPlanRequest,
  PayInstallmentRequest,
  PayrollRunRow,
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
  CreateSupplierRequest,
  CreatePurchaseOrderRequest,
  ReceivePurchaseOrderRequest,
  CreateSupplierInvoiceRequest,
  RecordSupplierPaymentRequest,
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
  Supplier,
  PurchaseOrder,
  PurchaseOrderItem,
  GoodsReceipt,
  SupplierInvoice,
  ProcurementDashboardData,
  PaymentPlan,
  InstallmentRow,
  PaymentReceipt,
  StudentFinancialAdjustment,
  StudentFinanceProfile,
  StudentStatement,
  JournalBatch,
  CreatePaymentPlanRequest,
  PayInstallmentRequest,
  PayrollRunRow,
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
  CreateSupplierRequest,
  CreatePurchaseOrderRequest,
  ReceivePurchaseOrderRequest,
  CreateSupplierInvoiceRequest,
  RecordSupplierPaymentRequest,
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
  permissions?: string[];
}

export interface LoginResponse {
  token_type: string;
  expires_in: number;
  must_change_password?: boolean;
  user: AuthUser;
}

export interface MfaRequiredResponse {
  mfa_required: true;
  mfa_enrollment_required: boolean;
  mfa_token: string;
  token_type: "Bearer";
  expires_in: number;
}

export type LoginResult = LoginResponse | MfaRequiredResponse;

export interface MfaEnrollmentResponse {
  secret: string;
  otpauth_url: string;
}

export interface MfaCompletionResponse {
  expires_in: number;
  recovery_codes?: string[];
  message?: string;
}

const STORAGE_KEYS = {
  session: "sm_cookie_session",
  user: "sm_user",
};

function notifyAuthChanged() {
  if (typeof window !== "undefined") {
    window.dispatchEvent(new Event("school-auth-changed"));
  }
}

/** Base URL for all API requests. Uses VITE_API_BASE_URL in production, falls back to /api. */
export const API_BASE_URL: string =
  import.meta.env.VITE_API_BASE_URL || "/api";

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

/**
 * URL for a user's profile photo.
 *
 * Profile photos are personal data and no longer live on the public storage
 * disk, so there is no storage URL to build. This points at an API endpoint
 * that checks school scope, the viewer's relationship to the subject and their
 * role before streaming a single byte.
 *
 * An <img> to a same-site URL under /api sends the session cookie, so the
 * browser client needs no extra handling; native clients attach their bearer
 * token. A viewer who is not permitted to see the photo gets 403 and the
 * component falls back to initials.
 */
export function profilePhotoUrl(userId?: number | null): string {
  if (!userId) return "";

  return `${API_BASE_URL.replace(/\/$/, "")}/files/profile-photo/${userId}`;
}

/** Request timeout in milliseconds. */
const REQUEST_TIMEOUT_MS = Number(
  import.meta.env.VITE_API_TIMEOUT_MS || 15000,
);

/** Minimal user shape persisted in localStorage — avoids storing full object. */
interface StoredUser {
  id: number;
  name: string;
  email: string;
  role: UserRole;
  locale?: string | null;
  photo_path?: string | null;
  permissions?: string[];
}

export const authStore = {
  hasSession: () => localStorage.getItem(STORAGE_KEYS.session) === "1",
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
  setSession(user: AuthUser) {
    // This marker coordinates tabs; it is not a credential. The real session
    // remains inside scoped httpOnly cookies that JavaScript cannot inspect.
    localStorage.setItem(STORAGE_KEYS.session, "1");
    const minimal: StoredUser = {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      locale: user.locale,
      photo_path: user.photo_path,
      permissions: user.permissions,
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
      permissions: user.permissions,
    };
    localStorage.setItem(STORAGE_KEYS.user, JSON.stringify(minimal));
  },
  clear() {
    // Only announce a change when there was a session to clear. This keeps
    // listeners that react by refetching (and may 401 → clear again) from
    // looping forever on an already-empty store.
    const hadSession = Object.values(STORAGE_KEYS).some((k) => localStorage.getItem(k) !== null);
    Object.values(STORAGE_KEYS).forEach((k) => localStorage.removeItem(k));
    if (hadSession) notifyAuthChanged();
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

let csrfToken: string | null = null;
let csrfRequest: Promise<string> | null = null;
let refreshing: Promise<boolean> | null = null;

async function ensureCsrfToken(force = false): Promise<string> {
  if (force) csrfToken = null;
  if (csrfToken) return csrfToken;
  if (csrfRequest) return csrfRequest;

  csrfRequest = (async () => {
    const res = await fetch(`${API_BASE_URL}/auth/csrf-cookie`, {
      credentials: "include",
      headers: { Accept: "application/json", "X-Auth-Mode": "cookie" },
    });
    if (!res.ok) throw new ApiError(res.status, "Unable to initialize secure session");
    const body = (await res.json()) as { csrf_token?: string };
    if (!body.csrf_token) throw new ApiError(0, "CSRF token was not returned by the server");
    csrfToken = body.csrf_token;
    return csrfToken;
  })().finally(() => {
    csrfRequest = null;
  });

  return csrfRequest;
}

async function refreshSession(): Promise<boolean> {
  if (refreshing) return refreshing;
  refreshing = (async () => {
    const csrf = await ensureCsrfToken();
    try {
      const res = await fetch(`${API_BASE_URL}/auth/refresh`, {
        method: "POST",
        credentials: "include",
        headers: {
          Accept: "application/json",
          "X-Auth-Mode": "cookie",
          "X-XSRF-TOKEN": csrf,
        },
      });
      if (!res.ok) {
        if (res.status === 401 || res.status === 419) authStore.clear();
        return false;
      }
      return true;
    } catch (error) {
      if (error instanceof ApiError) throw error;
      throw new ApiError(0, "Network error while refreshing session");
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

  const method = (init.method ?? "GET").toUpperCase();
  const isUnsafe = !["GET", "HEAD", "OPTIONS"].includes(method);

  const buildHeaders = (csrf?: string): Headers => {
    const headers = new Headers(init.headers);
    if (!headers.has("Accept")) headers.set("Accept", "application/json");
    headers.set("X-Auth-Mode", "cookie");
    if (csrf) headers.set("X-XSRF-TOKEN", csrf);
    if (init.body !== undefined && !init.raw && !headers.has("Content-Type")) {
      headers.set("Content-Type", "application/json");
    }
    return headers;
  };

  const buildBody = () => {
    if (init.body === undefined) return undefined;
    if (init.raw) return init.body as BodyInit;
    return JSON.stringify(init.body);
  };

  // Each attempt gets its OWN controller + timeout so the post-refresh retry
  // is also bounded (previously the retry ran without any timeout).
  const doFetch = async (csrf?: string): Promise<Response> => {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);
    try {
      return await fetch(url.toString(), {
        method,
        headers: buildHeaders(csrf),
        body: buildBody(),
        credentials: "include",
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

  let requestCsrf = isUnsafe ? await ensureCsrfToken() : undefined;
  let res = await doFetch(requestCsrf);

  if (res.status === 419 && isUnsafe) {
    requestCsrf = await ensureCsrfToken(true);
    res = await doFetch(requestCsrf);
  }

  const refreshEligible = !path.startsWith("/auth/login")
    && !path.startsWith("/auth/refresh")
    && authStore.hasSession();
  if (res.status === 401 && refreshEligible) {
    if (await refreshSession()) {
      res = await doFetch(requestCsrf);
    }
  }

  const ct = res.headers.get("content-type") || "";
  const isJson = ct.includes("application/json");

  if (!res.ok) {
    // A 401 that survived the refresh attempt means the session is dead.
    // Clear it so AuthProvider (listening for the auth-changed event) can
    // drop the user and RoleGuard can route to /login — instead of leaving
    // a zombie UI where every request silently fails. Login itself is
    // exempt so a failed sign-in never wipes an unrelated stored session.
    if (res.status === 401 && !path.startsWith("/auth/login")) {
      authStore.clear();
    }
    const data: unknown = isJson ? await res.json().catch(() => ({})) : await res.text();
    const message = typeof data === "object" && data !== null && "message" in data
      ? (data as { message?: unknown }).message
      : undefined;
    const msg = (typeof message === "string" && message) || res.statusText || "Request failed";
    throw new ApiError(res.status, msg, data);
  }

  if (res.status === 204) return undefined as T;
  if (isJson) {
    const payload: unknown = await res.json();
    return payload as T;
  }
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
  const doFetch = async (): Promise<Response> => {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);
    try {
      return await fetch(urlStr, {
        credentials: "include",
        headers: { "X-Auth-Mode": "cookie" },
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

  let res = await doFetch();

  // Refresh and retry once on access-token expiry — the same path apiFetch uses —
  // so report cards, receipts and other downloads keep working after rotation.
  if (res.status === 401 && authStore.hasSession()) {
    if (await refreshSession()) {
      res = await doFetch();
    }
  }

  if (res.status === 401) {
    authStore.clear();
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
    apiFetch<LoginResult>("/auth/login", { method: "POST", body: { email, password } }),
  mfaEnroll: (token: string) =>
    apiFetch<MfaEnrollmentResponse>("/auth/mfa/enroll", { method: "POST", headers: { Authorization: `Bearer ${token}` } }),
  mfaConfirm: (token: string, code: string) =>
    apiFetch<MfaCompletionResponse>("/auth/mfa/confirm", { method: "POST", headers: { Authorization: `Bearer ${token}` }, body: { code, device_name: "web" } }),
  mfaChallenge: (token: string, value: string, recovery = false) =>
    apiFetch<MfaCompletionResponse>("/auth/mfa/challenge", { method: "POST", headers: { Authorization: `Bearer ${token}` }, body: recovery ? { recovery_code: value, device_name: "web" } : { code: value, device_name: "web" } }),
  logout: async () => {
    try {
      return await apiFetch("/auth/logout", { method: "POST" });
    } finally {
      // Logout expires the server-side CSRF cookie. Never reuse the matching
      // in-memory token if the user signs in again without a full page reload.
      csrfToken = null;
    }
  },
  me: async () => {
    const result = await apiFetch<{ user: AuthUser; permissions?: string[] }>("/auth/me");
    return { ...result, user: { ...result.user, permissions: result.permissions ?? result.user.permissions ?? [] } };
  },
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

export interface PermissionDef {
  id: number;
  key: string;
  module: string;
  action: string;
  description?: string | null;
}

export interface UserPermissionsResponse {
  user_id: number;
  role: string;
  role_keys: string[];
  grants: string[];
  denies: string[];
  effective: string[];
}

export const Admin = {
  users: (q?: { role?: string; q?: string }): Promise<PaginatedResponse<User>> => apiFetch("/admin/users", { query: q }),
  createUser: (data: CreateUserRequest): Promise<unknown> => apiFetch("/admin/users", { method: "POST", body: data }),
  updateUser: (id: number, data: UpdateUserRequest): Promise<unknown> =>
    apiFetch(`/admin/users/${id}`, { method: "PATCH", body: data }),
  deactivateUser: (id: number, reason: string): Promise<unknown> =>
    apiFetch(`/admin/users/${id}`, { method: "DELETE", body: { reason } }),
  listPermissions: (): Promise<{ data: Record<string, PermissionDef[]> }> => apiFetch("/admin/permissions"),
  rolePermissions: (role: string): Promise<{ role: string; keys: string[] }> =>
    apiFetch(`/admin/roles/${role}/permissions`),
  updateRolePermissions: (role: string, keys: string[]): Promise<{ role: string; keys: string[] }> =>
    apiFetch(`/admin/roles/${role}/permissions`, { method: "PUT", body: { keys } }),
  userPermissions: (id: number): Promise<UserPermissionsResponse> =>
    apiFetch(`/admin/users/${id}/permissions`),
  updateUserPermissions: (id: number, data: { grants: string[]; denies: string[] }): Promise<{ user_id: number; permissions: string[] }> =>
    apiFetch(`/admin/users/${id}/permissions`, { method: "PUT", body: data }),
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
    apiFetch(`/finance/invoices/${invoiceId}/payments`, { method: "POST", headers: { "Idempotency-Key": crypto.randomUUID() }, body: data }),
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

export const FinanceWorkspace = {
  searchStudents: (q: string, page = 1): Promise<PaginatedResponse<User>> =>
    apiFetch("/finance/students/search", { query: { q, page, per_page: 20 } }),
  studentProfile: (studentId: number): Promise<StudentFinanceProfile> =>
    apiFetch(`/finance/students/${studentId}`),
  studentStatement: (studentId: number, params?: QueryParams): Promise<StudentStatement> =>
    apiFetch(`/finance/students/${studentId}/statement`, { query: params }),
  receipts: (params?: QueryParams): Promise<PaginatedResponse<PaymentReceipt>> =>
    apiFetch("/finance/receipts", { query: params }),
  createReceipt: (data: {
    student_user_id: number;
    amount: number;
    method: "cash" | "bank_transfer" | "card" | "online";
    receipt_date: string;
    reference?: string;
    cash_account?: string;
    note?: string;
    allocations?: Array<{ invoice_id: number; installment_id?: number; amount: number }>;
  }): Promise<PaymentReceipt> =>
    apiFetch("/finance/receipts", { method: "POST", headers: { "Idempotency-Key": crypto.randomUUID() }, body: data }),
  approveReceipt: (id: number): Promise<PaymentReceipt> =>
    apiFetch(`/finance/receipts/${id}/approve`, { method: "POST" }),
  postReceipt: (id: number): Promise<PaymentReceipt> =>
    apiFetch(`/finance/receipts/${id}/post`, { method: "POST" }),
  reverseReceipt: (id: number, reason: string): Promise<PaymentReceipt> =>
    apiFetch(`/finance/receipts/${id}/reverse`, { method: "POST", body: { reason } }),
  receiptPdf: (id: number, receiptNo: string) =>
    apiDownload(`/finance/receipts/${id}/pdf`, `receipt-${receiptNo}.pdf`),
  adjustments: (params?: QueryParams): Promise<PaginatedResponse<StudentFinancialAdjustment>> =>
    apiFetch("/finance/adjustments", { query: params }),
  createAdjustment: (data: {
    student_user_id: number;
    invoice_id?: number;
    type: "discount" | "adjustment" | "refund";
    direction: "debit" | "credit";
    calculation_type: "amount" | "percentage";
    value: number;
    reason: string;
  }): Promise<StudentFinancialAdjustment> => apiFetch("/finance/adjustments", { method: "POST", body: data }),
  approveAdjustment: (id: number): Promise<StudentFinancialAdjustment> =>
    apiFetch(`/finance/adjustments/${id}/approve`, { method: "POST" }),
  postAdjustment: (id: number): Promise<StudentFinancialAdjustment> =>
    apiFetch(`/finance/adjustments/${id}/post`, { method: "POST" }),
  reverseAdjustment: (id: number, reason: string): Promise<StudentFinancialAdjustment> =>
    apiFetch(`/finance/adjustments/${id}/reverse`, { method: "POST", body: { reason } }),
  report: <T>(type: string, params?: QueryParams): Promise<PaginatedResponse<T>> =>
    apiFetch(`/finance/workspace-reports/${type}`, { query: params }),
};

export const Hr = {
  staff: (q?: { role?: string; q?: string; contract_expires_within?: number; employment_status?: string; uninsured?: boolean }): Promise<PaginatedResponse<Staff>> => apiFetch("/hr/staff", { query: q }),
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
  journalBatches: (params?: QueryParams): Promise<PaginatedResponse<JournalBatch>> =>
    apiFetch("/accounting/journal-batches", { query: params }),
  createJournalBatch: (data: unknown): Promise<JournalBatch> =>
    apiFetch("/accounting/journal-batches", { method: "POST", body: data }),
  approveJournalBatch: (id: number): Promise<JournalBatch> =>
    apiFetch(`/accounting/journal-batches/${id}/approve`, { method: "POST" }),
  postJournalBatch: (id: number): Promise<JournalBatch> =>
    apiFetch(`/accounting/journal-batches/${id}/post`, { method: "POST" }),
  reverseJournalBatch: (id: number, reason: string): Promise<JournalBatch> =>
    apiFetch(`/accounting/journal-batches/${id}/reverse`, { method: "POST", body: { reason } }),
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

export const Procurement = {
  dashboard: (): Promise<ProcurementDashboardData> => apiFetch("/procurement/dashboard"),
  suppliers: (params?: QueryParams): Promise<PaginatedResponse<Supplier>> =>
    apiFetch("/procurement/suppliers", { query: params }),
  createSupplier: (data: CreateSupplierRequest): Promise<Supplier> =>
    apiFetch("/procurement/suppliers", { method: "POST", body: data }),
  updateSupplier: (id: number, data: Partial<CreateSupplierRequest> & { is_active?: boolean }): Promise<Supplier> =>
    apiFetch(`/procurement/suppliers/${id}`, { method: "PATCH", body: data }),
  purchaseOrders: (params?: QueryParams): Promise<PaginatedResponse<PurchaseOrder>> =>
    apiFetch("/procurement/purchase-orders", { query: params }),
  purchaseOrder: (id: number): Promise<PurchaseOrder> =>
    apiFetch(`/procurement/purchase-orders/${id}`),
  createPurchaseOrder: (data: CreatePurchaseOrderRequest): Promise<PurchaseOrder> =>
    apiFetch("/procurement/purchase-orders", { method: "POST", body: data }),
  submitPurchaseOrder: (id: number): Promise<PurchaseOrder> =>
    apiFetch(`/procurement/purchase-orders/${id}/submit`, { method: "POST" }),
  approvePurchaseOrder: (id: number, data: { action?: 'approve' | 'reject'; reason?: string } = {}): Promise<PurchaseOrder> =>
    apiFetch(`/procurement/purchase-orders/${id}/approve`, { method: "POST", body: data }),
  cancelPurchaseOrder: (id: number): Promise<PurchaseOrder> =>
    apiFetch(`/procurement/purchase-orders/${id}/cancel`, { method: "POST" }),
  receivePurchaseOrder: (id: number, data: ReceivePurchaseOrderRequest): Promise<GoodsReceipt> =>
    apiFetch(`/procurement/purchase-orders/${id}/receive`, { method: "POST", body: data }),
  goodsReceipts: (params?: QueryParams): Promise<PaginatedResponse<GoodsReceipt>> =>
    apiFetch("/procurement/goods-receipts", { query: params }),
  goodsReceipt: (id: number): Promise<GoodsReceipt> =>
    apiFetch(`/procurement/goods-receipts/${id}`),
  items: (params?: QueryParams): Promise<PaginatedResponse<WarehouseItem>> =>
    apiFetch("/procurement/items", { query: params }),
};

export const AccountsPayable = {
  invoices: (params?: QueryParams): Promise<PaginatedResponse<SupplierInvoice>> =>
    apiFetch("/finance/ap/supplier-invoices", { query: params }),
  createInvoice: (data: CreateSupplierInvoiceRequest): Promise<SupplierInvoice> =>
    apiFetch("/finance/ap/supplier-invoices", { method: "POST", body: data }),
  recordPayment: (id: number, data: RecordSupplierPaymentRequest): Promise<unknown> =>
    apiFetch(`/finance/ap/supplier-invoices/${id}/payments`, { method: "POST", body: data }),
  aging: (): Promise<{ data: Array<{ supplier: Supplier; buckets: Record<string, number>; total_outstanding: number }>; total_payable: number }> =>
    apiFetch("/finance/ap/reports/ap-aging"),
};

export const Installments = {
  plans: (params?: QueryParams): Promise<PaginatedResponse<PaymentPlan>> =>
    apiFetch("/finance/installments/plans", { query: params }),
  plan: (id: number): Promise<PaymentPlan> => apiFetch(`/finance/installments/plans/${id}`),
  createPlan: (data: CreatePaymentPlanRequest): Promise<PaymentPlan> =>
    apiFetch("/finance/installments/plans", { method: "POST", body: data }),
  cancelPlan: (id: number): Promise<PaymentPlan> =>
    apiFetch(`/finance/installments/plans/${id}/cancel`, { method: "POST" }),
  pay: (id: number, data: PayInstallmentRequest): Promise<InstallmentRow> =>
    apiFetch(`/finance/installments/installments/${id}/pay`, { method: "POST", body: data }),
  waive: (id: number): Promise<InstallmentRow> =>
    apiFetch(`/finance/installments/installments/${id}/waive`, { method: "POST" }),
  due: (days?: number): Promise<{ data: InstallmentRow[] }> =>
    apiFetch("/finance/installments/due", { query: { days } }),
  sendReminders: (): Promise<{ reminders_sent: number }> =>
    apiFetch("/finance/installments/send-reminders", { method: "POST" }),
};

export const PayrollRuns = {
  runs: (params?: QueryParams): Promise<PaginatedResponse<PayrollRunRow>> =>
    apiFetch("/finance/payroll/runs", { query: params }),
  run: (id: number): Promise<PayrollRunRow> => apiFetch(`/finance/payroll/runs/${id}`),
  createRun: (data: { year: number; month: number }): Promise<PayrollRunRow> =>
    apiFetch("/finance/payroll/runs", { method: "POST", body: data }),
  updateRecord: (id: number, data: { allowances?: number; deductions?: number; reason: string }): Promise<unknown> =>
    apiFetch(`/finance/payroll/records/${id}`, { method: "PATCH", body: data }),
  processRun: (id: number): Promise<PayrollRunRow> =>
    apiFetch(`/finance/payroll/runs/${id}/process`, { method: "POST" }),
  approveRun: (id: number): Promise<PayrollRunRow> =>
    apiFetch(`/finance/payroll/runs/${id}/approve`, { method: "POST" }),
  payRun: (id: number): Promise<PayrollRunRow> =>
    apiFetch(`/finance/payroll/runs/${id}/pay`, { method: "POST" }),
  reverseRun: (id: number, reason: string): Promise<PayrollRunRow> =>
    apiFetch(`/finance/payroll/runs/${id}/reverse`, { method: "POST", body: { reason } }),
  payslip: (recordId: number): Promise<void> => apiDownload(`/finance/payroll/records/${recordId}/payslip`, `payslip-${recordId}.pdf`),
};

export const Payments = {
  createIntent: (data: PaymentIntentRequest): Promise<unknown> =>
    apiFetch("/payments/create-intent", { method: "POST", headers: { "Idempotency-Key": crypto.randomUUID() }, body: data }),
  confirm: (data: ConfirmPaymentRequest): Promise<unknown> =>
    apiFetch("/payments/confirm", { method: "POST", body: data }),
  status: (paymentIntentId: string): Promise<unknown> =>
    apiFetch(`/payments/status/${paymentIntentId}`),
  methods: (): Promise<unknown> => apiFetch("/payments/methods"),
  setupIntent: (): Promise<unknown> =>
    apiFetch("/payments/setup-intent", { method: "POST" }),
};
