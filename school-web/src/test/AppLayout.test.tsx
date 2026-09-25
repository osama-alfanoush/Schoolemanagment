import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { render, cleanup } from '@testing-library/react';
import AppLayout from '@/components/layout/AppLayout';
import { useAuth } from '@/lib/auth';
import i18n from '@/lib/i18n';
import { renderWithProviders } from './RenderProvider';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function renderLayout(path = '/admin', children = <div data-testid="content">Page Content</div>) {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user: { id: 1, name: 'Admin User', email: 'admin@test.com', role: 'admin', is_active: true },
    loading: false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return renderWithProviders(<AppLayout path={path}>{children}</AppLayout>);
}

describe('AppLayout', () => {
  beforeEach(() => {
    cleanup();
    vi.clearAllMocks();
  });

  afterEach(async () => {
    await i18n.changeLanguage('en');
  });

  it('renders children content', () => {
    const { getByTestId } = renderLayout('/admin');
    expect(getByTestId('content')).toBeInTheDocument();
  });

  // The sidebar names the same screens, so assert on the top bar's heading.
  const pageTitle = (container: HTMLElement) => container.querySelector('h1')?.textContent;

  it('titles the page from the menu rather than the URL', () => {
    const { container } = renderLayout('/admin/users');
    expect(pageTitle(container)).toBe('Users');
  });

  it('translates the page title with the rest of the UI', async () => {
    // The title used to be derived from the URL in English, so every portal
    // kept an English heading no matter which language was selected.
    await i18n.changeLanguage('ar');
    const { container } = renderLayout('/admin/users');
    expect(pageTitle(container)).toBe('المستخدمين');
  });

  it('falls back to the section title for a detail route', async () => {
    await i18n.changeLanguage('ar');
    (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
      user: { id: 2, name: 'Parent', email: 'p@test.com', role: 'parent', is_active: true },
      loading: false, login: vi.fn(), logout: vi.fn(), refreshUser: vi.fn(),
    });
    const { container } = renderWithProviders(
      <AppLayout path="/parent/children/7"><div /></AppLayout>
    );
    expect(pageTitle(container)).toBe('أبنائي');
  });

  it('renders sidebar when user is authenticated', () => {
    const { container } = renderLayout('/admin');
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
      <AppLayout path="/admin">
        <div>Content</div>
      </AppLayout>
    );
    expect(container.firstChild).toBeNull();
  });
});
