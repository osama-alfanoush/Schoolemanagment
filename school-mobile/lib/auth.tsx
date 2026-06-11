import React, {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
} from "react";

import { Auth, tokenStore, User } from "./api";

interface AuthState {
  user: User | null;
  loading: boolean;
  login: (email: string, password: string) => Promise<User>;
  logout: () => Promise<void>;
  refreshUser: () => Promise<void>;
  setUserLocal: (user: User) => Promise<void>;
}

const AuthContext = createContext<AuthState | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    let active = true;
    (async () => {
      const cached = await tokenStore.getUser();
      if (active) setUser(cached);
      const token = await tokenStore.getAccess();
      if (!token) {
        if (active) setLoading(false);
        return;
      }
      try {
        const { user: fresh } = await Auth.me();
        if (active) {
          setUser(fresh);
          await tokenStore.setUser(fresh);
        }
      } catch {
        await tokenStore.clear();
        if (active) setUser(null);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, []);

  const login = useCallback(async (email: string, password: string) => {
    const res = await Auth.login(email, password);
    await tokenStore.setSession(res.access_token, res.refresh_token, res.user);
    setUser(res.user);
    return res.user;
  }, []);

  const logout = useCallback(async () => {
    try {
      await Auth.logout();
    } catch {}
    await tokenStore.clear();
    setUser(null);
  }, []);

  const refreshUser = useCallback(async () => {
    const { user: fresh } = await Auth.me();
    setUser(fresh);
    await tokenStore.setUser(fresh);
  }, []);

  const setUserLocal = useCallback(async (next: User) => {
    setUser(next);
    await tokenStore.setUser(next);
  }, []);

  return (
    <AuthContext.Provider
      value={{ user, loading, login, logout, refreshUser, setUserLocal }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be used inside <AuthProvider>");
  return ctx;
}
