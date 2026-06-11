import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook } from '@testing-library/react';
import { useRequireRole } from '@/lib/auth';
import { AuthProvider } from '@/lib/auth';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

function makeClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

const localStorageMock = (() => {
  let store: Record<string, string> = {};
  return {
    getItem: (key: string) => store[key] ?? null,
    setItem: (key: string, value: string) => { store[key] = value; },
    removeItem: (key: string) => { delete store[key]; },
    clear: () => { store = {}; },
  };
})();
Object.defineProperty(window, 'localStorage', { value: localStorageMock });

function Wrapper({ children }: { children: React.ReactNode }) {
  return (
    <QueryClientProvider client={makeClient()}>
      <AuthProvider>{children}</AuthProvider>
    </QueryClientProvider>
  );
}

describe('useRequireRole', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.restoreAllMocks();
  });

  it('returns redirect to login when no user', () => {
    const { result } = renderHook(() => useRequireRole(['admin']), { wrapper: Wrapper });
    expect(result.current.ok).toBe(false);
    expect(result.current.redirectTo).toBe('/login');
  });

  it('returns redirect when user role not in allowed list', () => {
    const { result } = renderHook(() => useRequireRole(['admin', 'teacher']), { wrapper: Wrapper });
    expect(result.current.ok).toBe(false);
    expect(result.current.redirectTo).toBe('/login');
  });
});