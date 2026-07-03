import { createContext, useContext, useEffect, useState, useCallback, ReactNode } from "react";
import { Auth, tokenStore, AuthUser, Role } from "./api";

interface AuthState {
  user: AuthUser | null;
  loading: boolean;
  login: (email: string, password: string) => Promise<AuthUser>;
  logout: () => Promise<void>;
  refreshUser: () => Promise<void>;
}

const AuthContext = createContext<AuthState | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(() => {
    const stored = tokenStore.getUser();
    const token = tokenStore.getAccess();
    // Only trust stored user if a token also exists
    return token && stored ? stored : null;
  });
  const [loading, setLoading] = useState<boolean>(() => {
    const token = tokenStore.getAccess();
    const stored = tokenStore.getUser();
    return !!(token && stored);
  });

  useEffect(() => {
    const token = tokenStore.getAccess();
    if (!token) {
      setUser(null);
      tokenStore.clear();
      setLoading(false);
      return;
    }
    Auth.me()
      .then(({ user }) => {
        setUser(user);
        tokenStore.setUser(user);
      })
      .catch(() => {
        tokenStore.clear();
        setUser(null);
      })
      .finally(() => setLoading(false));
  }, []);

  const login = useCallback(async (email: string, password: string) => {
    const res = await Auth.login(email, password);
    tokenStore.setSession(res.access_token, res.refresh_token, res.user);
    setUser(res.user);
    return res.user;
  }, []);

  const logout = useCallback(async () => {
    try {
      await Auth.logout();
    } catch {
      // Local logout should still clear client state if the API call fails.
    }
    tokenStore.clear();
    setUser(null);
  }, []);

  const refreshUser = useCallback(async () => {
    const { user } = await Auth.me();
    setUser(user);
    tokenStore.setUser(user);
  }, []);

  return (
    <AuthContext.Provider value={{ user, loading, login, logout, refreshUser }}>
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
