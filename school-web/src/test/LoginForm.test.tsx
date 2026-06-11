import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderWithProviders } from './RenderProvider';
import LoginPage from '@/pages/auth/LoginPage';
import { useAuth } from '@/lib/auth';
import { act } from 'react';
import userEvent from '@testing-library/user-event';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

const mockLogin = vi.fn();

function setup() {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user: null,
    loading: false,
    login: mockLogin,
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return renderWithProviders(<LoginPage />, { initialRoute: '/login' });
}

describe('LoginPage', () => {
  beforeEach(() => {
    mockLogin.mockReset();
    vi.clearAllMocks();
  });

  it('renders email and password inputs', () => {
    const {} = setup();
    const inputs = document.querySelectorAll('input[type=text], input[type=email], input[type=password]');
    expect(inputs.length).toBeGreaterThanOrEqual(2);
  });

  it('renders submit button', () => {
    const { getByRole } = setup();
    expect(getByRole('button', { name: /sign in/i })).toBeInTheDocument();
  });

  it('shows error when submitted with empty fields', async () => {
    const user = userEvent.setup();
    const { getByRole } = setup();
    const inputs = document.querySelectorAll('input');

    await user.click(getByRole('button', { name: /sign in/i }));

    expect((inputs[0] as HTMLInputElement).validity.valid).toBe(false);
  });

  it('shows error for invalid email format', async () => {
    const user = userEvent.setup();
    const { getByRole } = setup();
    const inputs = document.querySelectorAll('input');

    await user.type(inputs[0] as HTMLInputElement, 'not-an-email');
    await user.click(getByRole('button', { name: /sign in/i }));

    expect((inputs[0] as HTMLInputElement).validity.valid).toBe(false);
  });

  it('submits form with valid credentials', async () => {
    const user = userEvent.setup();
    mockLogin.mockResolvedValue({ id: 1, name: 'Test User', role: 'admin' });

    const { getByRole } = setup();
    const inputs = document.querySelectorAll('input');

    await user.type(inputs[0] as HTMLInputElement, 'admin@school.test');
    await user.type(inputs[1] as HTMLInputElement, 'password123');
    await user.click(getByRole('button', { name: /sign in/i }));

    expect(mockLogin).toHaveBeenCalledWith('admin@school.test', 'password123');
  });

  it('shows error message when login fails', async () => {
    const user = userEvent.setup();
    mockLogin.mockRejectedValue(new Error('Invalid credentials. Please try again.'));

    const { getByRole, getByText } = setup();
    const inputs = document.querySelectorAll('input');

    await user.type(inputs[0] as HTMLInputElement, 'admin@school.test');
    await user.type(inputs[1] as HTMLInputElement, 'wrongpassword');
    await user.click(getByRole('button', { name: /sign in/i }));

    await vi.waitFor(() => {
      expect(getByText(/invalid credentials/i)).toBeInTheDocument();
    });
  });

  it('disables submit button while loading', async () => {
    let resolveLogin: (value: unknown) => void;
    mockLogin.mockImplementation(
      () => new Promise((res) => { resolveLogin = res; })
    );

    setup();
    const inputs = document.querySelectorAll('input');
    const buttons = document.querySelectorAll('button[type=submit]');

    await userEvent.type(inputs[0] as HTMLInputElement, 'admin@school.test');
    await userEvent.type(inputs[1] as HTMLInputElement, 'password');

    // userEvent.click triggers React state update; wrap in act to satisfy React 19
    await act(async () => {
      await userEvent.click(buttons[0] as HTMLButtonElement);
    });

    // React has updated the button disabled state; this is the intended behavior
    expect((buttons[0] as HTMLButtonElement).disabled).toBe(true);

    resolveLogin!({ id: 1, name: 'Test', role: 'admin' });
  });

  it('password input has type password', () => {
    setup();
    const inputs = document.querySelectorAll('input[type=password]');
    expect(inputs.length).toBeGreaterThan(0);
  });
});