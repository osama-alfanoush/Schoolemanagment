import { useState, useEffect } from "react";
import { useLocation, Redirect } from "wouter";
import { useAuth } from "@/lib/auth";
import { ApiError, Auth, AuthUser, MfaEnrollmentResponse, MfaRequiredResponse, Role } from "@/lib/api";
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
  { key: "procurement", emoji: "🛒", labelKey: "roles.procurement" },
];

const demoCredentials: Record<Role, { email: string; password: string }> | null = import.meta.env.DEV ? {
  student: { email: "ali1@school.test", password: "password" },
  parent: { email: "parent1@school.test", password: "password" },
  teacher: { email: "teacher1@school.test", password: "password" },
  admin: { email: "admin@school.test", password: "password" },
  finance: { email: "finance@school.test", password: "password" },
  hr: { email: "hr@school.test", password: "password" },
  warehouse: { email: "warehouse@school.test", password: "password" },
  procurement: { email: "procurement@school.test", password: "password" },
} : null;

const demoEmails = new Set(Object.values(demoCredentials ?? {}).map((d) => d.email));

function loginErrorMessage(error: unknown, invalidCredentials: string): string {
  // The login endpoint intentionally returns the generic top-level
  // "Validation failed" envelope. Translate authentication failures into a
  // useful, safe message without exposing which half of the credential pair
  // was incorrect.
  if (error instanceof ApiError && (error.status === 401 || error.status === 422)) {
    return invalidCredentials;
  }
  return error instanceof Error ? error.message : invalidCredentials;
}

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
  const { login, user, completeMfa, acceptMfaSession } = useAuth();
  const [, setLocation] = useLocation();
  const { t } = useTranslation();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState<Role>("student");
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState("");
  const [showDemo, setShowDemo] = useState(false);
  const [mfa, setMfa] = useState<MfaRequiredResponse | null>(null);
  const [mfaEnrollment, setMfaEnrollment] = useState<MfaEnrollmentResponse | null>(null);
  const [mfaValue, setMfaValue] = useState("");
  const [useRecovery, setUseRecovery] = useState(false);
  const [recoveryCodes, setRecoveryCodes] = useState<string[]>([]);
  const [pendingUser, setPendingUser] = useState<AuthUser | null>(null);

  // Slide-in animation trigger
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  if (user) return <Redirect to={user.must_change_password ? "/change-password" : `/${user.role}`} />;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setIsLoading(true);
    try {
      const u = await login(email, password);
      setLocation(u.must_change_password ? "/change-password" : `/${u.role}`);
    } catch (err: unknown) {
      const challenge = typeof err === "object" && err !== null && "challenge" in err
        ? (err as { challenge: MfaRequiredResponse }).challenge
        : null;
      if (challenge?.mfa_required) {
        setMfa(challenge);
        if (challenge.mfa_enrollment_required) {
          try {
            setMfaEnrollment(await Auth.mfaEnroll(challenge.mfa_token));
          } catch (enrollmentError) {
            setError(enrollmentError instanceof Error ? enrollmentError.message : "Unable to start MFA enrollment");
          }
        }
      } else {
        setError(loginErrorMessage(err, t("login.invalidCredentials")));
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleMfa = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!mfa) return;
    setError("");
    setIsLoading(true);
    try {
      const result = await completeMfa(mfa, mfaValue, useRecovery);
      if (result.recoveryCodes.length > 0) {
        setRecoveryCodes(result.recoveryCodes);
        setPendingUser(result.user);
      } else {
        acceptMfaSession(result.user);
        setLocation(result.user.must_change_password ? "/change-password" : `/${result.user.role}`);
      }
    } catch (mfaError) {
      setError(mfaError instanceof Error ? mfaError.message : "Invalid authentication code");
    } finally {
      setIsLoading(false);
    }
  };

  const fillDemo = (r: Role) => {
    if (!demoCredentials) return;
    const d = demoCredentials[r];
    setEmail(d.email);
    setPassword(d.password);
    setRole(r);
  };

  const selectRole = (r: Role) => {
    setRole(r);
    if (demoCredentials && (!email || demoEmails.has(email))) {
      const d = demoCredentials[r];
      setEmail(d.email);
      setPassword(d.password);
    }
  };

  if (recoveryCodes.length > 0 && pendingUser) {
    return (
      <div className="min-h-screen bg-surface-bg flex items-center justify-center p-6">
        <div className="w-full max-w-lg rounded-2xl bg-card border border-border p-8 shadow-xl">
          <h1 className="text-2xl font-bold">Save your recovery codes</h1>
          <p className="text-muted-foreground mt-2">Each code works once. Store them in a secure password manager; they will not be shown again.</p>
          <div className="grid grid-cols-2 gap-2 my-6 font-mono text-sm">
            {recoveryCodes.map((code) => <div key={code} className="rounded bg-muted p-3 text-center">{code}</div>)}
          </div>
          <button className="w-full rounded-lg bg-primary text-primary-foreground py-3 font-semibold" onClick={() => acceptMfaSession(pendingUser)}>
            I have saved these codes
          </button>
        </div>
      </div>
    );
  }

  if (mfa) {
    return (
      <div className="min-h-screen bg-surface-bg flex items-center justify-center p-6">
        <form onSubmit={(event) => { void handleMfa(event); }} className="w-full max-w-md rounded-2xl bg-card border border-border p-8 shadow-xl">
          <h1 className="text-2xl font-bold">Multi-factor authentication</h1>
          {mfa.mfa_enrollment_required && mfaEnrollment ? (
            <div className="mt-4 space-y-2">
              <p className="text-sm text-muted-foreground">Add this account to your authenticator app, then enter its six-digit code.</p>
              <div className="rounded bg-muted p-3 font-mono text-sm break-all">{mfaEnrollment.secret}</div>
              <a className="text-sm text-primary underline" href={mfaEnrollment.otpauth_url}>Open in authenticator app</a>
            </div>
          ) : (
            <button type="button" className="mt-4 text-sm text-primary underline" onClick={() => { setUseRecovery((value) => !value); setMfaValue(""); }}>
              {useRecovery ? "Use authenticator code" : "Use a recovery code"}
            </button>
          )}
          <label className="block mt-6 text-sm font-medium">{useRecovery ? "Recovery code" : "Authentication code"}</label>
          <input value={mfaValue} onChange={(e) => setMfaValue(e.target.value)} inputMode={useRecovery ? "text" : "numeric"} maxLength={useRecovery ? 11 : 6} className="mt-2 w-full rounded-lg border border-border bg-background px-4 py-3 font-mono tracking-widest" required />
          {error && <p className="mt-3 text-sm text-destructive">{error}</p>}
          <button disabled={isLoading} className="mt-6 w-full rounded-lg bg-primary text-primary-foreground py-3 font-semibold disabled:opacity-50">
            {isLoading ? "Verifying…" : "Verify"}
          </button>
          <button type="button" className="mt-3 w-full text-sm text-muted-foreground" onClick={() => { setMfa(null); setMfaEnrollment(null); setError(""); }}>Cancel</button>
        </form>
      </div>
    );
  }

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
          <div data-testid="role-selector" className="grid grid-cols-2 sm:grid-cols-3 gap-2">
            {roles.map((r) => (
              <button
                key={r.key}
                type="button"
                onClick={() => selectRole(r.key)}
                className={cn(
                  "min-h-10 min-w-0 flex items-center justify-center gap-1.5 px-2.5 py-2 rounded-xl text-xs sm:text-sm font-medium leading-tight transition-all duration-200",
                  role === r.key
                    ? "gradient-purple text-white shadow-glow"
                    : "bg-card border border-surface-border text-ink-muted hover:border-brand-purple/40"
                )}
              >
                <span>{r.emoji}</span>
                <span className="text-center">{t(r.labelKey)}</span>
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
          {demoCredentials && <div className="text-center">
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
          </div>}
        </div>
      </div>
    </div>
  );
}
