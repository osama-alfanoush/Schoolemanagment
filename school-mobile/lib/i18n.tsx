import AsyncStorage from "@react-native-async-storage/async-storage";
import React, {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";

export type Locale = "en" | "ar";

type Bag = Record<string, string>;
type Bundle = Record<string, Bag>;

const en: Bundle = {
  common: {
    app: "School Portal",
    welcome: "Welcome",
    signIn: "Sign in",
    signOut: "Sign out",
    email: "Email",
    password: "Password",
    submit: "Submit",
    cancel: "Cancel",
    save: "Save",
    loading: "Loading…",
    empty: "Nothing to show yet",
    error: "Something went wrong",
    retry: "Retry",
    today: "Today",
    yesterday: "Yesterday",
    profile: "Profile",
    language: "Language",
    english: "English",
    arabic: "العربية",
    changePassword: "Change password",
    notifications: "Notifications",
    messages: "Messages",
    offline: "Offline — showing cached data",
    selectChild: "Select child",
    open: "Open",
    download: "Download",
    receipt: "Receipt",
    send: "Send",
    typeMessage: "Type a message",
    of: "of",
    points: "points",
    invalidLogin: "Invalid email or password",
    enterCredentials: "Enter your school account",
    noAccount: "Demo accounts use password: password",
    overall: "Overall",
    average: "Average",
    backendUnreachable:
      "Cannot reach the school server. Check your internet connection.",
  },
  tabs: {
    home: "Home",
    homework: "Homework",
    grades: "Grades",
    attendance: "Attendance",
    finance: "Finance",
    more: "More",
  },
  student: {
    upcoming: "Upcoming homework",
    recentGrades: "Recent grades",
    timetable: "Timetable",
    announcements: "Announcements",
    reportCard: "Report card",
    submitWork: "Submit work",
    pickFile: "Attach file",
    yourAnswer: "Your answer (optional)",
    submitted: "Submitted",
    pending: "Pending",
    overdue: "Overdue",
    due: "Due",
    score: "Score",
    subject: "Subject",
    component: "Component",
    notGraded: "Not graded",
  },
  parent: {
    myChildren: "My children",
    overview: "Overview",
    grades: "Grades",
    attendance: "Attendance",
    homework: "Homework",
    finance: "Finance",
    invoices: "Invoices",
    payments: "Payments",
    conduct: "Conduct",
    paid: "Paid",
    due: "Due",
    overdue: "Overdue",
    partial: "Partial",
    balance: "Balance",
    nothingDue: "All paid up",
    presentDays: "Present days",
    absentDays: "Absent days",
    lateDays: "Late days",
  },
  attendance: {
    present: "Present",
    absent: "Absent",
    late: "Late",
    excused: "Excused",
  },
  status: {
    pending: "Pending",
    approved: "Approved",
    rejected: "Rejected",
    paid: "Paid",
    unpaid: "Unpaid",
    partial: "Partial",
    overdue: "Overdue",
  },
};

const ar: Bundle = {
  common: {
    app: "بوابة المدرسة",
    welcome: "مرحباً",
    signIn: "تسجيل الدخول",
    signOut: "تسجيل الخروج",
    email: "البريد الإلكتروني",
    password: "كلمة المرور",
    submit: "إرسال",
    cancel: "إلغاء",
    save: "حفظ",
    loading: "جارٍ التحميل…",
    empty: "لا يوجد شيء بعد",
    error: "حدث خطأ ما",
    retry: "إعادة المحاولة",
    today: "اليوم",
    yesterday: "الأمس",
    profile: "الملف الشخصي",
    language: "اللغة",
    english: "English",
    arabic: "العربية",
    changePassword: "تغيير كلمة المرور",
    notifications: "الإشعارات",
    messages: "الرسائل",
    offline: "غير متصل — عرض البيانات المخزنة",
    selectChild: "اختر الطفل",
    open: "فتح",
    download: "تحميل",
    receipt: "إيصال",
    send: "إرسال",
    typeMessage: "اكتب رسالة",
    of: "من",
    points: "نقطة",
    invalidLogin: "البريد الإلكتروني أو كلمة المرور غير صحيحة",
    enterCredentials: "أدخل حساب المدرسة الخاص بك",
    noAccount: "كلمة المرور للحسابات التجريبية: password",
    overall: "الإجمالي",
    average: "المعدل",
    backendUnreachable:
      "تعذّر الوصول إلى خادم المدرسة. تحقّق من اتصال الإنترنت.",
  },
  tabs: {
    home: "الرئيسية",
    homework: "الواجبات",
    grades: "الدرجات",
    attendance: "الحضور",
    finance: "المالية",
    more: "المزيد",
  },
  student: {
    upcoming: "الواجبات القادمة",
    recentGrades: "آخر الدرجات",
    timetable: "الجدول الدراسي",
    announcements: "الإعلانات",
    reportCard: "بطاقة الدرجات",
    submitWork: "تسليم الواجب",
    pickFile: "إرفاق ملف",
    yourAnswer: "إجابتك (اختياري)",
    submitted: "تم التسليم",
    pending: "قيد التنفيذ",
    overdue: "متأخر",
    due: "موعد التسليم",
    score: "الدرجة",
    subject: "المادة",
    component: "المكوّن",
    notGraded: "لم يتم تقييمه",
  },
  parent: {
    myChildren: "أبنائي",
    overview: "نظرة عامة",
    grades: "الدرجات",
    attendance: "الحضور",
    homework: "الواجبات",
    finance: "المالية",
    invoices: "الفواتير",
    payments: "المدفوعات",
    conduct: "السلوك",
    paid: "مدفوعة",
    due: "مستحقة",
    overdue: "متأخرة",
    partial: "جزئية",
    balance: "الرصيد",
    nothingDue: "لا توجد مستحقات",
    presentDays: "أيام الحضور",
    absentDays: "أيام الغياب",
    lateDays: "أيام التأخير",
  },
  attendance: {
    present: "حاضر",
    absent: "غائب",
    late: "متأخر",
    excused: "بعذر",
  },
  status: {
    pending: "قيد المراجعة",
    approved: "موافق عليه",
    rejected: "مرفوض",
    paid: "مدفوع",
    unpaid: "غير مدفوع",
    partial: "جزئي",
    overdue: "متأخر",
  },
};

const RESOURCES: Record<Locale, Bundle> = { en, ar };

const STORAGE_KEY = "sm_locale";

interface LocaleCtx {
  locale: Locale;
  setLocale: (l: Locale) => void;
  t: (key: string) => string;
  isRTL: boolean;
}

const Ctx = createContext<LocaleCtx | undefined>(undefined);

export function I18nProvider({ children }: { children: React.ReactNode }) {
  const [locale, setLocaleState] = useState<Locale>("en");

  useEffect(() => {
    AsyncStorage.getItem(STORAGE_KEY).then((v) => {
      if (v === "ar" || v === "en") setLocaleState(v);
    });
  }, []);

  const setLocale = useCallback((l: Locale) => {
    setLocaleState(l);
    AsyncStorage.setItem(STORAGE_KEY, l);
  }, []);

  const t = useCallback(
    (key: string) => {
      const [ns, k] = key.split(".");
      const bundle = RESOURCES[locale];
      const fallback = RESOURCES.en;
      return bundle[ns]?.[k] ?? fallback[ns]?.[k] ?? key;
    },
    [locale],
  );

  const value = useMemo(
    () => ({ locale, setLocale, t, isRTL: locale === "ar" }),
    [locale, setLocale, t],
  );

  return <Ctx.Provider value={value}>{children}</Ctx.Provider>;
}

export function useI18n() {
  const ctx = useContext(Ctx);
  if (!ctx) throw new Error("useI18n must be used inside <I18nProvider>");
  return ctx;
}
