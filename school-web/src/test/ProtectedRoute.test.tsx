import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { RoleGuard } from '@/components/layout/RoleGuard';
import { useAuth } from '@/lib/auth';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function makeQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

function renderGuard(roles: string[], state?: { user?: any; loading?: boolean }) {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user: state?.user ?? null,
    loading: state?.loading ?? false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return render(
    <QueryClientProvider client={makeQueryClient()}>
      <RoleGuard roles={roles as any}>
        <span data-testid="allowed">Allowed Content</span>
      </RoleGuard>
    </QueryClientProvider>
  );
}

describe('RoleGuard', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    cleanup();
  });

  it('shows loading indicator while auth is loading', () => {
    const { getByText } = renderGuard(['admin'], { loading: true });
    expect(getByText(/loading/i)).toBeInTheDocument();
  });

  it('returns null (blocks content) when user is not authenticated', () => {
    const { queryByTestId } = renderGuard(['admin'], { user: null, loading: false });
    expect(queryByTestId('allowed')).toBeNull();
  });

  it('allows access when user has a matching role', () => {
    const adminUser = { id: 1, name: 'Admin', email: 'admin@test.com', role: 'admin', is_active: true };
    const { getByTestId } = renderGuard(['admin'], { user: adminUser, loading: false });
    expect(getByTestId('allowed')).toBeInTheDocument();
  });

  it('blocks non-admin from admin-only route', () => {
    const teacherUser = { id: 2, name: 'Teacher', email: 'teacher@test.com', role: 'teacher', is_active: true };
    const { queryByTestId } = renderGuard(['admin'], { user: teacherUser, loading: false });
    expect(queryByTestId('allowed')).toBeNull();
  });

  it('allows teacher to access teacher routes', () => {
    const teacherUser = { id: 2, name: 'Teacher', email: 'teacher@test.com', role: 'teacher', is_active: true };
    const { getByTestId } = renderGuard(['teacher'], { user: teacherUser, loading: false });
    expect(getByTestId('allowed')).toBeInTheDocument();
  });
});