import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from "react";
import { ApiError, Auth, authStore, AuthUser, MfaRequiredResponse, Role } from "./api";

export class MfaRequiredError extends Error {
  constructor(public readonly challenge: MfaRequiredResponse) {
    super("Multi-factor authentication required");
  }
}

interface AuthState {
  user: AuthUser | null;
  loading: boolean;
  login: (email: string, password: string) => Promise<AuthUser>;
  completeMfa: (challenge: MfaRequiredResponse, value: string, recovery?: boolean) => Promise<{ user: AuthUser; recoveryCodes: string[] }>;
  acceptMfaSession: (user: AuthUser) => void;
  logout: () => Promise<void>;
  refreshUser: () => Promise<void>;
}

const AuthContext = createContext<AuthState | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(() => {
    const stored = authStore.getUser();
    return authStore.hasSession() ? stored : null;
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // The local marker is deliberately non-secret, but it lets us distinguish
    // a returning browser session from an anonymous visit. Avoid probing
    // /auth/me for every anonymous login-page load, where the expected 401 is
    // otherwise reported by the browser as a console error.
    if (!authStore.hasSession()) {
      setUser(null);
      setLoading(false);
      return;
    }

    Auth.me()
      .then(({ user }) => {
        setUser(user);
        authStore.setSession(user);
      })
      .catch((error: unknown) => {
        // Only a definitive 401 means the session is gone — apiFetch has
        // already cleared the store by then. A network error, a timeout or a
        // request aborted because the user navigated mid-load must leave the
        // session intact, otherwise a slow page or a flaky connection silently
        // signs the user out.
        if (error instanceof ApiError && error.status === 401) {
          authStore.clear();
          setUser(null);
        }
      })
      .finally(() => setLoading(false));
  }, []);

  // Keep React state in sync with the non-secret session marker. When refresh
  // fails (or another tab logs out), the store clears itself and fires these
  // events — without this, the UI kept a "zombie" session where every request
  // failed until a manual reload.
  useEffect(() => {
    const syncFromStore = () => {
      if (!authStore.hasSession()) {
        setUser((current) => (current === null ? current : null));
        return;
      }
      void Auth.me().then(({ user }) => {
        setUser(user);
        authStore.setUser(user);
      }).catch((error: unknown) => {
        // Same rule as the bootstrap probe: keep the session unless the server
        // actually rejected it.
        if (error instanceof ApiError && error.status === 401) {
          authStore.clear();
          setUser(null);
        }
      });
    };
    window.addEventListener("school-auth-changed", syncFromStore);
    window.addEventListener("storage", syncFromStore);
    return () => {
      window.removeEventListener("school-auth-changed", syncFromStore);
      window.removeEventListener("storage", syncFromStore);
    };
  }, []);

  const login = useCallback(async (email: string, password: string) => {
    const res = await Auth.login(email, password);
    if ("mfa_required" in res) throw new MfaRequiredError(res);
    // The login payload carries the flag top-level; make sure it survives on
    // the user object even when the /auth/me hydration below fails.
    let user: AuthUser = { ...res.user, must_change_password: res.must_change_password ?? res.user.must_change_password };
    authStore.setSession(user);
    try {
      user = (await Auth.me()).user;
      authStore.setUser(user);
    } catch (error) {
      // Keep a valid cookie session during a transient network error, but never
      // recreate UI state after a terminal 401 cleared the session marker.
      if (!authStore.hasSession()) throw error;
    }
    setUser(user);
    return user;
  }, []);

  const completeMfa = useCallback(async (challenge: MfaRequiredResponse, value: string, recovery = false) => {
    const result = challenge.mfa_enrollment_required
      ? await Auth.mfaConfirm(challenge.mfa_token, value)
      : await Auth.mfaChallenge(challenge.mfa_token, value, recovery);
    const { user } = await Auth.me();
    authStore.setSession(user);
    return { user, recoveryCodes: result.recovery_codes ?? [] };
  }, []);

  const acceptMfaSession = useCallback((nextUser: AuthUser) => {
    setUser(nextUser);
    authStore.setUser(nextUser);
  }, []);

  const logout = useCallback(async () => {
    try {
      await Auth.logout();
    } catch {
      // Local logout should still clear client state if the API call fails.
    }
    authStore.clear();
    setUser(null);
  }, []);

  const refreshUser = useCallback(async () => {
    const { user } = await Auth.me();
    setUser(user);
    authStore.setUser(user);
  }, []);

  return (
    <AuthContext.Provider value={{ user, loading, login, completeMfa, acceptMfaSession, logout, refreshUser }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be inside <AuthProvider>");
  return ctx;
}

export function useRequireRole(allowed: Role[]) {
  const { user, loading } = useAuth();
  if (loading) return { ok: false as const, redirectTo: null };
  if (!user) return { ok: false as const, redirectTo: "/login" };
  if (!allowed.includes(user.role))
    return { ok: false as const, redirectTo: `/${user.role}` };
  return { ok: true as const, user };
}
