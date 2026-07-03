import { useState, useEffect } from "react";
import { useLocation, Redirect } from "wouter";
import { useAuth } from "@/lib/auth";
import { Role } from "@/lib/api";
import { cn } from "@/lib/utils";
import { Eye, EyeOff, ArrowRight, Loader2, Mail, Lock, X } from "lucide-react";
import { useTranslation } from "react-i18next";

/* ─── Role selector config ─── */
const roles: { key: Role; emoji: string; labelKey: string }[] = [
  { key: "student", emoji: "🎓", labelKey: "roles.student" },
  { key: "parent", emoji: "👨‍👩‍👧", labelKey: "roles.parent" },
  { key: "teacher", emoji: "📖", labelKey: "roles.teacher" },
  { key: "admin", emoji: "⚙️", labelKey: "roles.admin" },
  { key: "finance", emoji: "💰", labelKey: "roles.finance" },
  { key: "hr", emoji: "👥", labelKey: "roles.hr" },
  { key: "warehouse", emoji: "📦", labelKey: "roles.warehouse" },
];

const demoCredentials: Record<Role, { email: string; password: string }> = {
  student: { email: "ali1@school.test", password: "password" },
  parent: { email: "parent1@school.test", password: "password" },
  teacher: { email: "teacher1@school.test", password: "password" },
  admin: { email: "admin@school.test", password: "password" },
  finance: { email: "finance@school.test", password: "password" },
  hr: { email: "hr@school.test", password: "password" },
  warehouse: { email: "warehouse@school.test", password: "password" },
};

const demoEmails = new Set(Object.values(demoCredentials).map((d) => d.email));

/* ─── School illustration (pure CSS/SVG) ─── */
function SchoolIllustration() {
  return (
    <div className="relative flex flex-col items-center">
      {/* Roof */}
      <div
        className="w-48 h-0 border-l-[72px] border-r-[72px] border-b-[60px]
        border-l-transparent border-r-transparent border-b-brand-purple"
      />

      {/* Building body */}
      <div className="w-48 bg-card rounded-b-2xl relative">
        {/* SMS text */}
        <div className="absolute -top-10 left-1/2 -translate-x-1/2 font-display text-white text-lg font-bold tracking-wider">
          SMS
        </div>

        {/* Windows row */}
        <div className="grid grid-cols-4 gap-2 px-4 pt-4">
          <div className="w-8 h-8 rounded-md bg-brand-purple/80" />
          <div className="w-8 h-8 rounded-md bg-brand-pink/80" />
          <div className="w-8 h-8 rounded-md bg-brand-mint/80" />
          <div className="w-8 h-8 rounded-md bg-brand-sky/80" />
        </div>

        {/* Door */}
        <div className="mx-auto mt-3 mb-4 w-10 h-14 rounded-t-lg bg-brand-pink" />
      </div>

      {/* Floating stars */}
      <span className="absolute -top-4 -left-8 text-white text-2xl animate-float">✦</span>
      <span
        className="absolute -top-8 right-0 text-white text-lg animate-float"
        style={{ animationDelay: "1s" }}
      >
        ✦
      </span>
      <span
        className="absolute top-12 -left-12 text-white text-sm animate-float"
        style={{ animationDelay: "2s" }}
      >
        ✦
      </span>

      {/* Floating dots */}
      <span
        className="absolute top-20 -right-10 w-3 h-3 rounded-full bg-brand-mint animate-float"
        style={{ animationDelay: "0.5s" }}
      />
      <span
        className="absolute bottom-4 -left-14 w-2.5 h-2.5 rounded-full bg-brand-amber animate-float"
        style={{ animationDelay: "1.5s" }}
      />
    </div>
  );
}

/* ─── Main LoginPage ─── */
export default function LoginPage() {
  const { login, user } = useAuth();
  const [, setLocation] = useLocation();
  const { t } = useTranslation();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState<Role>("student");
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState("");
  const [showDemo, setShowDemo] = useState(false);

  // Slide-in animation trigger
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  if (user) return <Redirect to={`/${user.role}`} />;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setIsLoading(true);
    try {
      const u = await login(email, password);
      setLocation(`/${u.role}`);
    } catch (err: any) {
      setError(err?.message || t("login.invalidCredentials"));
    } finally {
      setIsLoading(false);
    }
  };

  const fillDemo = (r: Role) => {
    const d = demoCredentials[r];
    setEmail(d.email);
    setPassword(d.password);
    setRole(r);
  };

  const selectRole = (r: Role) => {
    setRole(r);
    if (!email || demoEmails.has(email)) {
      const d = demoCredentials[r];
      setEmail(d.email);
      setPassword(d.password);
    }
  };

  return (
    <div className="min-h-screen flex">
      {/* ─── LEFT PANEL (hidden on mobile) ─── */}
      <div className="hidden lg:flex w-1/2 gradient-sunset flex-col items-center justify-center p-12 relative overflow-hidden">
        {/* Depth overlays */}
        <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_30%_20%,rgba(255,255,255,0.16),transparent_55%)]" />
        <div className="pointer-events-none absolute inset-0 bg-gradient-to-t from-black/25 via-transparent to-transparent" />

        <div className="relative flex flex-col items-center">
          <SchoolIllustration />

          <h1 className="heading-serif text-4xl text-white font-bold mt-10 text-center">
            {t("login.welcomeBack")}
          </h1>
          <p className="text-white/85 text-lg mt-2">{t("login.schoolPortal")}</p>
        </div>

        <div className="flex gap-3 mt-8">
          <span className="bg-card/20 text-white rounded-full px-4 py-2 text-sm">📚 {t("login.learn")}</span>
          <span className="bg-card/20 text-white rounded-full px-4 py-2 text-sm">🎯 {t("login.achieve")}</span>
          <span className="bg-card/20 text-white rounded-full px-4 py-2 text-sm">🌟 {t("login.excel")}</span>
        </div>
      </div>

      {/* ─── RIGHT PANEL ─── */}
      <div
        className={cn(
          "w-full lg:w-1/2 bg-surface-bg flex items-center justify-center p-6 sm:p-10 transition-all duration-700 ease-out",
          mounted ? "translate-x-0 opacity-100" : "translate-x-12 opacity-0"
        )}
      >
        <div className="w-full max-w-md space-y-6">
          {/* Logo + title */}
          <div className="flex flex-col items-center space-y-2">
            <div className="gradient-purple w-16 h-16 rounded-2xl flex items-center justify-center text-3xl">
              🏫
            </div>
            <h2 className="font-display text-2xl text-ink-dark font-bold">{t("login.schoolSuite")}</h2>
            <p className="text-ink-muted text-sm">{t("login.managementSystem")}</p>
          </div>

          {/* Role selector */}
          <div className="flex gap-2 overflow-x-auto pb-2 scrollbar-none">
            {roles.map((r) => (
              <button
                key={r.key}
                type="button"
                onClick={() => selectRole(r.key)}
                className={cn(
                  "flex items-center gap-1.5 px-3 py-2 rounded-full text-sm font-medium whitespace-nowrap transition-all duration-200",
                  role === r.key
                    ? "gradient-purple text-white shadow-glow"
                    : "bg-card border border-surface-border text-ink-muted hover:border-brand-purple/40"
                )}
              >
                <span>{r.emoji}</span>
                <span>{t(r.labelKey)}</span>
              </button>
            ))}
          </div>

          {/* Login form card */}
          <form
            onSubmit={(event) => {
              void handleSubmit(event)
            }}
            className="glass-card p-6 space-y-5"
            style={{ animationDelay: "0.15s" }}
          >
            {/* Email */}
            <div className="space-y-1.5">
              <label htmlFor="login-email" className="text-sm font-medium text-ink-dark">{t("login.email")}</label>
              <div className="relative">
                <Mail className="absolute start-3 top-1/2 -translate-y-1/2 h-4 w-4 text-ink-light" />
                <input
                  id="login-email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="name@school.com"
                  required
                  className="w-full h-11 ps-10 pe-4 rounded-xl border border-surface-border bg-card
                    text-ink-dark placeholder:text-ink-light text-sm
                    focus:outline-none focus:border-brand-purple focus:ring-2 focus:ring-brand-purple/20
                    transition-all duration-200"
                />
              </div>
            </div>

            {/* Password */}
            <div className="space-y-1.5">
              <label htmlFor="login-password" className="text-sm font-medium text-ink-dark">{t("login.password")}</label>
              <div className="relative">
                <Lock className="absolute start-3 top-1/2 -translate-y-1/2 h-4 w-4 text-ink-light" />
                <input
                  id="login-password"
                  type={showPassword ? "text" : "password"}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  required
                  className="w-full h-11 ps-10 pe-11 rounded-xl border border-surface-border bg-card
                    text-ink-dark placeholder:text-ink-light text-sm
                    focus:outline-none focus:border-brand-purple focus:ring-2 focus:ring-brand-purple/20
                    transition-all duration-200"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute end-3 top-1/2 -translate-y-1/2 text-ink-light hover:text-ink-dark transition-colors"
                >
                  {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                </button>
              </div>
            </div>

            {/* Forgot password */}
            <div className="text-right rtl:text-left">
              <button type="button" className="text-brand-purple text-sm hover:underline">{t("login.forgotPassword")}</button>
            </div>

            {/* Submit */}
            <button
              type="submit"
              disabled={isLoading}
              className={cn(
                "w-full h-12 gradient-purple text-white font-semibold rounded-xl flex items-center justify-center gap-2 transition-all duration-200",
                !isLoading && "hover:shadow-glow hover:scale-[1.02] active:scale-[0.98]",
                isLoading && "opacity-80 cursor-not-allowed"
              )}
            >
              {isLoading ? (
                <>
                  <Loader2 className="h-5 w-5 animate-spin" />
                  {t("login.signingIn")}
                </>
              ) : (
                <>
                  {t("login.signIn")}
                  <ArrowRight className="h-5 w-5 rtl:rotate-180" />
                </>
              )}
            </button>
          </form>

          {/* Error message */}
          {error && (
            <div className="flex items-center gap-2 bg-brand-red/10 text-brand-red rounded-full px-4 py-2.5 text-sm font-medium">
              <X className="h-4 w-4 shrink-0" />
              {error}
            </div>
          )}

          {/* Demo credentials */}
          <div className="text-center">
            <button
              type="button"
              onClick={() => setShowDemo(!showDemo)}
              className="text-brand-purple text-sm font-medium hover:underline"
            >
              {t("login.tryDemo")}
            </button>

            {showDemo && (
              <div className="mt-3 glass-card p-4 text-left rtl:text-right">
                <p className="text-xs font-semibold text-ink-muted mb-2">{t("login.demoAccounts")}</p>
                <div className="space-y-1.5">
                  {roles.map((r) => (
                    <button
                      key={r.key}
                      type="button"
                      onClick={() => fillDemo(r.key)}
                      className="w-full flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm
                        hover:bg-surface-border transition-colors text-ink-dark"
                    >
                      <span>{r.emoji}</span>
                      <span className="font-medium">{t(r.labelKey)}:</span>
                      <span className="text-ink-muted">{demoCredentials[r.key].email}</span>
                    </button>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
