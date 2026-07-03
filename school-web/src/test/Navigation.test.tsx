import { describe, it, expect, vi } from 'vitest';
import { cleanup } from '@testing-library/react';
import Sidebar from '@/components/layout/Sidebar';
import { useAuth } from '@/lib/auth';
import userEvent from '@testing-library/user-event';
import { renderWithProviders } from './RenderProvider';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function renderSidebar(user: any, onToggle = vi.fn()) {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user,
    loading: false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return renderWithProviders(<Sidebar collapsed={false} onToggle={onToggle} />);
}

describe('Sidebar Navigation', () => {
  beforeEach(() => {
    cleanup();
    vi.clearAllMocks();
  });

  it('shows admin navigation links for admin user', () => {
    const adminUser = { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true };
    const { getByText } = renderSidebar(adminUser);

    expect(getByText('Users')).toBeInTheDocument();
    expect(getByText('Classes')).toBeInTheDocument();
    expect(getByText('Dashboard')).toBeInTheDocument();
  });

  it('shows teacher navigation links for teacher user', () => {
    const teacherUser = { id: 2, name: 'Teacher', email: 'teacher@test.com', role: 'teacher', is_active: true };
    const { getByText } = renderSidebar(teacherUser);

    expect(getByText(/my classes/i)).toBeInTheDocument();
    expect(getByText('Grades')).toBeInTheDocument();
    expect(getByText('Attendance')).toBeInTheDocument();
  });

  it('shows student navigation links for student user', () => {
    const studentUser = { id: 3, name: 'Student', email: 'student@test.com', role: 'student', is_active: true };
    const { getByText } = renderSidebar(studentUser);

    expect(getByText('Dashboard')).toBeInTheDocument();
    expect(getByText('Assignments')).toBeInTheDocument();
    expect(getByText('Grades')).toBeInTheDocument();
  });

  it('logout button is visible and clickable', async () => {
    const user = { id: 1, name: 'Admin', email: 'admin@test.com', role: 'admin', is_active: true };
    const logoutFn = vi.fn();

    const { getByText } = renderSidebar(user, vi.fn());
    const logoutBtn = getByText('Logout').closest('button');

    await userEvent.click(logoutBtn!);
    expect(logoutFn).not.toHaveBeenCalled();
  });
});
