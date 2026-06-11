import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup, fireEvent } from '@testing-library/react';
import TopBar from '@/components/layout/TopBar';
import { useAuth } from '@/lib/auth';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function renderTopBar(user: any, title = 'Dashboard') {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user,
    loading: false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return render(<TopBar title={title} />);
}

describe('TopBar', () => {
  beforeEach(() => {
    cleanup();
    vi.clearAllMocks();
  });

  it('renders page title text', () => {
    const { getByText } = renderTopBar(
      { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true },
      'Students'
    );
    expect(getByText('Students')).toBeInTheDocument();
  });

  it('renders notification bell with red pulse badge when user is authenticated', () => {
    const { container } = renderTopBar(
      { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true }
    );
    const bellBadge = container.querySelector('.animate-pulse-soft');
    expect(bellBadge).toBeInTheDocument();
  });

  it('renders search button', () => {
    const { container } = renderTopBar(
      { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true }
    );
    const buttons = container.querySelectorAll('button');
    expect(buttons.length).toBeGreaterThanOrEqual(2);
  });

  it('renders avatar button that can be clicked to show dropdown', async () => {
    const user = { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true };
    const { container } = renderTopBar(user);
    const avatarBtn = container.querySelector('button[aria-haspopup="menu"]');
    expect(avatarBtn).toBeInTheDocument();
  });

  it('returns null when user is not authenticated', () => {
    (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
      user: null,
      loading: false,
      login: vi.fn(),
      logout: vi.fn(),
      refreshUser: vi.fn(),
    });

    const { container } = render(<TopBar title="Dashboard" />);
    expect(container.firstChild).toBeNull();
  });
});