import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup, act } from '@testing-library/react';
import { RoleGuard } from '@/components/layout/RoleGuard';
import { useAuth } from '@/lib/auth';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function renderGuard(roles: string[], state?: { user?: any; loading?: boolean }) {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user: state?.user ?? null,
    loading: state?.loading ?? false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return render(
    <RoleGuard roles={roles as any}>
      <span data-testid="allowed">Allowed Content</span>
    </RoleGuard>
  );
}

describe('RoleGuard', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    cleanup();
  });

  it('renders children when user role matches allowed roles', () => {
    const adminUser = { id: 1, name: 'Admin', email: 'admin@test.com', role: 'admin', is_active: true };
    const { getByTestId } = renderGuard(['admin', 'teacher'], { user: adminUser, loading: false });
    expect(getByTestId('allowed')).toBeInTheDocument();
  });

  it('blocks access when user role is not in allowed roles list', () => {
    const studentUser = { id: 2, name: 'Student', email: 'student@test.com', role: 'student', is_active: true };
    const { queryByTestId } = renderGuard(['admin'], { user: studentUser, loading: false });
    expect(queryByTestId('allowed')).toBeNull();
  });

  it('shows loading state while auth is being checked', () => {
    const { getByText } = renderGuard(['admin'], { user: null, loading: true });
    expect(getByText(/loading/i)).toBeInTheDocument();
  });

  it('returns null when no user is logged in', () => {
    const { queryByTestId } = renderGuard(['admin'], { user: null, loading: false });
    expect(queryByTestId('allowed')).toBeNull();
  });

  it('allows multiple roles (admin OR teacher) when user is teacher', () => {
    const teacherUser = { id: 3, name: 'Teacher', email: 'teacher@test.com', role: 'teacher', is_active: true };
    const { getByTestId } = renderGuard(['admin', 'teacher'], { user: teacherUser, loading: false });
    expect(getByTestId('allowed')).toBeInTheDocument();
  });
});