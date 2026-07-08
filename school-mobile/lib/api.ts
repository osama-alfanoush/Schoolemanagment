import AsyncStorage from "@react-native-async-storage/async-storage";

// expo-secure-store is unavailable on web — fall back to AsyncStorage
let SecureStore: {
  getItemAsync: (key: string) => Promise<string | null>;
  setItemAsync: (key: string, value: string) => Promise<void>;
  deleteItemAsync: (key: string) => Promise<void>;
} | null = null;
try {
  SecureStore = require("expo-secure-store");
} catch {}

const KEYS = {
  access: "sm_access",
  refresh: "sm_refresh",
  user: "sm_user",
};

const store = {
  async get(key: string): Promise<string | null> {
    if (SecureStore) {
      try {
        return await SecureStore.getItemAsync(key);
      } catch {}
    }
    return AsyncStorage.getItem(key);
  },
  async set(key: string, value: string): Promise<void> {
    if (SecureStore) {
      try {
        await SecureStore.setItemAsync(key, value);
        return;
      } catch {}
    }
    await AsyncStorage.setItem(key, value);
  },
  async remove(key: string): Promise<void> {
    if (SecureStore) {
      try {
        await SecureStore.deleteItemAsync(key);
      } catch {}
    }
    await AsyncStorage.removeItem(key).catch(() => {});
  },
};

export type Role =
  | "student"
  | "parent"
  | "teacher"
  | "admin"
  | "finance"
  | "hr"
  | "warehouse";

export interface User {
  id: number;
  name: string;
  email: string;
  role: Role;
  phone?: string | null;
  locale?: "en" | "ar" | null;
  photo_path?: string | null;
  is_active?: boolean;
  student_profile?: {
    id: number;
    admission_no?: string;
    class_room_id?: number;
    class_room?: { id: number; name: string; grade: string; section?: string };
    date_of_birth?: string;
    gender?: string;
    address?: string;
  } | null;
  staff_profile?: {
    id: number;
    department?: string;
    position?: string;
    hire_date?: string;
    contract_type?: string;
    base_salary?: number;
    qualifications?: string;
  } | null;
}

export interface SchoolSettings {
  school_name?: string | null;
  school_motto?: string | null;
  academic_year?: string | null;
  address?: string | null;
  primary_color?: string | null;
  accent_color?: string | null;
  sidebar_style?: "white" | "gradient" | "dark" | null;
  border_radius?: "sharp" | "medium" | "rounded" | null;
  font_style?: "modern" | "classic" | "friendly" | null;
  school_logo?: string | null;
}

export interface LoginResponse {
  access_token: string;
  refresh_token: string;
  token_type: "Bearer";
  expires_in: number;
  user: User;
}

export const tokenStore = {
  async getAccess() {
    return store.get(KEYS.access);
  },
  async getRefresh() {
    return store.get(KEYS.refresh);
  },
  async getUser(): Promise<User | null> {
    const raw = await store.get(KEYS.user);
    return raw ? (JSON.parse(raw) as User) : null;
  },
  async setSession(access: string, refresh: string, user: User) {
    await Promise.all([
      store.set(KEYS.access, access),
      store.set(KEYS.refresh, refresh),
      store.set(KEYS.user, JSON.stringify(user)),
    ]);
  },
  async setTokens(access: string, refresh: string) {
    await Promise.all([
      store.set(KEYS.access, access),
      store.set(KEYS.refresh, refresh),
    ]);
  },
  async setUser(user: User) {
    await store.set(KEYS.user, JSON.stringify(user));
  },
  async clear() {
    await Promise.all([
      store.remove(KEYS.access),
      store.remove(KEYS.refresh),
      store.remove(KEYS.user),
    ]);
  },
};

export class ApiError extends Error {
  status: number;
  data: any;
  constructor(status: number, message: string, data?: any) {
    super(message);
    this.status = status;
    this.data = data;
  }
}

/**
 * Resolve the absolute base URL for the Laravel API.
 *
 * Priority:
 * 1. `EXPO_PUBLIC_API_URL` — set this to the backend origin (with or
 *    without a trailing `/api`; it is appended when missing).
 * 2. Legacy `EXPO_PUBLIC_DOMAIN` (Replit dev proxy).
 * 3. The production Railway deployment. Note the GitHub Pages site
 *    (osama-alfanoush.github.io/Schoolemanagment) is a static frontend and
 *    cannot serve the API — the Laravel backend lives on Railway.
 */
const PROD_API_URL = "https://schoolemanagment-production.up.railway.app/api";

export function getApiBaseUrl(): string {
  const explicit = process.env.EXPO_PUBLIC_API_URL;
  if (explicit) {
    const trimmed = explicit.replace(/\/+$/, "");
    return trimmed.endsWith("/api") ? trimmed : `${trimmed}/api`;
  }
  const domain = process.env.EXPO_PUBLIC_DOMAIN;
  if (domain) {
    return `https://${domain}/api`;
  }
  return PROD_API_URL;
}

let refreshing: Promise<string | null> | null = null;

async function refreshTokens(): Promise<string | null> {
  if (refreshing) return refreshing;
  const refresh = await tokenStore.getRefresh();
  if (!refresh) return null;
  refreshing = (async () => {
    try {
      const res = await fetch(`${getApiBaseUrl()}/auth/refresh`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${refresh}`,
          Accept: "application/json",
        },
      });
      if (!res.ok) {
        await tokenStore.clear();
        return null;
      }
      const body = (await res.json()) as {
        access_token: string;
        refresh_token: string;
      };
      await tokenStore.setTokens(body.access_token, body.refresh_token);
      return body.access_token;
    } catch {
      return null;
    } finally {
      refreshing = null;
    }
  })();
  return refreshing;
}

interface RequestInitX {
  method?: string;
  body?: any;
  headers?: Record<string, string>;
  query?: Record<string, string | number | boolean | null | undefined>;
  raw?: boolean;
}

export async function apiFetch<T = any>(
  path: string,
  init: RequestInitX = {},
): Promise<T> {
  const base = getApiBaseUrl();
  let url = base + path;
  if (init.query) {
    const params = new URLSearchParams();
    Object.entries(init.query).forEach(([k, v]) => {
      if (v !== undefined && v !== null && v !== "") {
        params.set(k, String(v));
      }
    });
    const qs = params.toString();
    if (qs) url += (url.includes("?") ? "&" : "?") + qs;
  }

  const buildHeaders = (token: string | null) => {
    const h: Record<string, string> = { Accept: "application/json" };
    if (token) h.Authorization = `Bearer ${token}`;
    if (init.body !== undefined && !init.raw) {
      h["Content-Type"] = "application/json";
    }
    return { ...h, ...(init.headers ?? {}) };
  };

  const buildBody = () => {
    if (init.body === undefined) return undefined;
    if (init.raw) return init.body as any;
    return JSON.stringify(init.body);
  };

  const doFetch = (token: string | null) =>
    fetch(url, {
      method: init.method ?? "GET",
      headers: buildHeaders(token),
      body: buildBody(),
    });

  let token = await tokenStore.getAccess();
  let res = await doFetch(token);

  if (res.status === 401 && (await tokenStore.getRefresh())) {
    const next = await refreshTokens();
    if (next) {
      res = await doFetch(next);
    }
  }

  const ct = res.headers.get("content-type") || "";
  const isJson = ct.includes("application/json");

  if (!res.ok) {
    const data = isJson ? await res.json().catch(() => ({})) : await res.text();
    const msg =
      (isJson && (data as any)?.message) ||
      (typeof data === "string" && data) ||
      res.statusText ||
      "Request failed";
    throw new ApiError(res.status, msg, data);
  }
  if (res.status === 204) return undefined as T;
  if (isJson) return (await res.json()) as T;
  return (await res.text()) as unknown as T;
}

export async function authedDownloadUrl(path: string): Promise<{
  url: string;
  headers: Record<string, string>;
}> {
  const token = await tokenStore.getAccess();
  return {
    url: getApiBaseUrl() + path,
    headers: token ? { Authorization: `Bearer ${token}` } : {},
  };
}

// ---------------------------------------------------------------------------
// Endpoint helpers — the subset the mobile app uses (Student + Parent + Teacher).
// ---------------------------------------------------------------------------

export const Auth = {
  login: (email: string, password: string) =>
    apiFetch<LoginResponse>("/auth/login", {
      method: "POST",
      body: { email, password },
    }),
  logout: () => apiFetch("/auth/logout", { method: "POST" }),
  me: () => apiFetch<{ user: User }>("/auth/me"),
  forgotPassword: (email: string) =>
    apiFetch("/auth/forgot-password", { method: "POST", body: { email } }),
  changePassword: (data: {
    current_password: string;
    new_password: string;
    new_password_confirmation: string;
  }) => apiFetch("/auth/change-password", { method: "POST", body: data }),
  updateProfile: (data: Partial<Pick<User, "name" | "phone" | "locale">>) =>
    apiFetch<{ user: User }>("/auth/profile", { method: "PATCH", body: data }),
  registerPushToken: (token: string, platform: "ios" | "android" | "web") =>
    apiFetch("/auth/push-token", {
      method: "POST",
      body: { token, platform },
    }).catch(() => null),
  uploadProfilePhoto: (photo: any) => {
    const fd = new FormData();
    fd.append("photo", photo as any);
    return apiFetch<{ photo_url: string; user: User }>("/auth/profile/photo", {
      method: "POST",
      body: fd,
      raw: true,
    });
  },
};

export const SchoolSettingsApi = {
  /** Returns the settings flat or `{ data: {...} }` depending on backend version. */
  get: async (): Promise<SchoolSettings> => {
    const res = await apiFetch<any>("/school-settings");
    return (res?.data ?? res ?? {}) as SchoolSettings;
  },
};

export const Student = {
  dashboard: () => apiFetch<any>("/student/dashboard"),
  timetable: () => apiFetch<any>("/student/timetable"),
  assignments: () => apiFetch<any>("/student/assignments"),
  submitAssignment: (id: number, content_text?: string, file?: any) => {
    const fd = new FormData();
    if (content_text) fd.append("content_text", content_text);
    if (file) fd.append("file", file as any);
    return apiFetch(`/student/assignments/${id}/submit`, {
      method: "POST",
      body: fd,
      raw: true,
    });
  },
  grades: () => apiFetch<any>("/student/grades"),
  attendance: () => apiFetch<any>("/student/attendance"),
  reportCard: () => apiFetch<any>("/student/report-card"),
  announcements: () => apiFetch<any>("/student/announcements"),
  calendar: () => apiFetch<any>("/student/calendar"),
  performanceChart: () => apiFetch<any>("/student/performance-chart"),
  libraryBooks: (search?: string) =>
    apiFetch<any>("/student/library/books", { query: { search } }),
  myBorrowings: () => apiFetch<any>("/student/library/my-borrowings"),
  borrowBook: (id: number) =>
    apiFetch(`/student/library/books/${id}/borrow`, { method: "POST" }),
  returnBook: (borrowingId: number) =>
    apiFetch(`/student/library/borrowings/${borrowingId}/return`, {
      method: "POST",
    }),
  transportRoute: () => apiFetch<any>("/student/transport/my-route"),
};

export const Parent = {
  children: () => apiFetch<any>("/parent/children"),
  childOverview: (id: number) => apiFetch<any>(`/parent/children/${id}/overview`),
  childGrades: (id: number) => apiFetch<any>(`/parent/children/${id}/grades`),
  childAssignments: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/assignments`),
  childAttendance: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/attendance`),
  childInvoices: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/invoices`),
  childPayments: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/payments`),
  childConduct: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/conduct`),
  childReportCard: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/report-card`),
  childPerformanceChart: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/performance-chart`),
  childTransport: (id: number) =>
    apiFetch<any>(`/parent/children/${id}/transport`),
  announcements: () => apiFetch<any>("/parent/announcements"),
};

export const Teacher = {
  classes: () => apiFetch<any>("/teacher/classes"),
  timetable: () => apiFetch<any>("/teacher/timetable"),
  classStudents: (classRoomId: number) =>
    apiFetch<any>(`/teacher/classes/${classRoomId}/students`),
  /**
   * Create an assignment. Backend expects `class_room_ids[]` (multi-class),
   * `subject_id`, `title`, `instructions`, `due_at`, optional `max_score`
   * and `attachment` file — sent as multipart FormData.
   */
  createAssignment: (input: {
    class_room_ids: number[];
    subject_id: number;
    title: string;
    instructions: string;
    due_at: string;
    max_score?: number;
    attachment?: any;
  }) => {
    const fd = new FormData();
    input.class_room_ids.forEach((id) =>
      fd.append("class_room_ids[]", String(id)),
    );
    fd.append("subject_id", String(input.subject_id));
    fd.append("title", input.title);
    fd.append("instructions", input.instructions);
    fd.append("due_at", input.due_at);
    if (input.max_score != null) fd.append("max_score", String(input.max_score));
    if (input.attachment) fd.append("attachment", input.attachment as any);
    return apiFetch<any>("/teacher/assignments", {
      method: "POST",
      body: fd,
      raw: true,
    });
  },
  assignmentSubmissions: (assignmentId: number) =>
    apiFetch<any>(`/teacher/assignments/${assignmentId}/submissions`),
  gradeSubmission: (submissionId: number, score: number, feedback?: string) =>
    apiFetch<any>(`/teacher/submissions/${submissionId}/grade`, {
      method: "PATCH",
      body: { score, feedback },
    }),
  markAttendance: (input: {
    class_room_id: number;
    subject_id?: number | null;
    date: string;
    records: {
      student_user_id: number;
      status: "present" | "absent" | "late" | "excused";
      note?: string;
    }[];
  }) => apiFetch<any>("/teacher/attendance", { method: "POST", body: input }),
  gradeComponents: (classId: number, subjectId: number) =>
    apiFetch<any>(`/teacher/grade-components/${classId}/${subjectId}`),
  createGradeComponent: (
    classId: number,
    subjectId: number,
    input: {
      name: string;
      type: "quiz" | "homework" | "exam";
      weight: number;
      max_score: number;
    },
  ) =>
    apiFetch<any>(`/teacher/grade-components/${classId}/${subjectId}`, {
      method: "POST",
      body: input,
    }),
  enterGrade: (input: {
    student_user_id: number;
    grade_component_id: number;
    score: number;
  }) => apiFetch<any>("/teacher/grades", { method: "POST", body: input }),
  logConduct: (input: {
    student_user_id: number;
    category: "positive" | "warning" | "incident";
    title: string;
    note: string;
  }) => apiFetch<any>("/teacher/conduct", { method: "POST", body: input }),
  announcements: () => apiFetch<any>("/teacher/announcements"),
  announce: (input: { class_room_id: number; title: string; body: string }) =>
    apiFetch<any>("/teacher/announcements", { method: "POST", body: input }),
};

export const Hr = {
  myRequests: () => apiFetch<any>("/hr-requests"),
  submitRequest: (input: {
    type:
      | "leave_sick"
      | "leave_annual"
      | "leave_emergency"
      | "salary_advance"
      | "general";
    subject: string;
    reason: string;
  }) => apiFetch<any>("/hr-requests", { method: "POST", body: input }),
};

export const Messaging = {
  threads: () => apiFetch<any>("/messages/threads"),
  recipients: (search?: string) =>
    apiFetch<any>("/messages/recipients", { query: { search } }),
  conversation: (otherId: number) =>
    apiFetch<any>(`/messages/conversation/${otherId}`),
  send: (recipient_user_id: number, body: string, about_student_user_id?: number) =>
    apiFetch("/messages", {
      method: "POST",
      body: { recipient_user_id, body, about_student_user_id },
    }),
  notifications: () => apiFetch<any>("/notifications"),
  unreadCount: () =>
    apiFetch<{ notifications: number; messages: number; total_unread?: number }>(
      "/notifications/unread-count",
    ),
  markRead: (id: number) =>
    apiFetch(`/notifications/${id}/read`, { method: "PATCH" }),
  markAllRead: () => apiFetch("/notifications/read-all", { method: "PATCH" }),
  registerDevice: (
    device_token: string,
    platform: "ios" | "android" | "web",
    device_name?: string,
  ) =>
    apiFetch("/notifications/register-device", {
      method: "POST",
      body: { device_token, platform, device_name },
    }).catch(() => null),
  unregisterDevice: (token: string) =>
    apiFetch("/notifications/unregister-device", {
      method: "POST",
      body: { token },
    }).catch(() => null),
};

/**
 * Generic shape unwrapper — Laravel often returns `{ data: [...] }` or the
 * array directly. Use this whenever you read collection responses.
 */
export function asArray<T = any>(payload: any): T[] {
  if (Array.isArray(payload)) return payload as T[];
  if (payload && Array.isArray(payload.data)) return payload.data as T[];
  if (payload && typeof payload === "object") {
    for (const v of Object.values(payload)) {
      if (Array.isArray(v)) return v as T[];
    }
  }
  return [];
}
