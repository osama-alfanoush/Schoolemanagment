import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup } from '@testing-library/react';
import AppLayout from '@/components/layout/AppLayout';
import { useAuth } from '@/lib/auth';
import { renderWithProviders } from './RenderProvider';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function renderLayout(title = 'Dashboard', children = <div data-testid="content">Page Content</div>) {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user: { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true },
    loading: false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return renderWithProviders(<AppLayout title={title}>{children}</AppLayout>);
}

describe('AppLayout', () => {
  beforeEach(() => {
    cleanup();
    vi.clearAllMocks();
  });

  it('renders children content', () => {
    const { getByTestId } = renderLayout('Dashboard');
    expect(getByTestId('content')).toBeInTheDocument();
  });

  it('renders page title in TopBar', () => {
    const { getByText } = renderLayout('Students');
    expect(getByText('Students')).toBeInTheDocument();
  });

  it('renders sidebar when user is authenticated', () => {
    const { container } = renderLayout('Dashboard');
    const aside = container.querySelector('aside');
    expect(aside).toBeInTheDocument();
  });

  it('returns null when user is not authenticated', () => {
    (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
      user: null,
      loading: false,
      login: vi.fn(),
      logout: vi.fn(),
      refreshUser: vi.fn(),
    });

    const { container } = render(
      <AppLayout title="Dashboard">
        <div>Content</div>
      </AppLayout>
    );
    expect(container.firstChild).toBeNull();
  });
});