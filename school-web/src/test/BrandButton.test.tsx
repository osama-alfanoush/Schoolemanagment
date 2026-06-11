import { describe, it, expect, vi } from 'vitest';
import { render, fireEvent } from '@testing-library/react';
import BrandButton from '@/components/ui/BrandButton';

describe('BrandButton', () => {
  it('renders children text', () => {
    const { getByText } = render(<BrandButton>Click Me</BrandButton>);
    expect(getByText('Click Me')).toBeInTheDocument();
  });

  it('renders with primary variant by default', () => {
    const { container } = render(<BrandButton>Submit</BrandButton>);
    expect(container.querySelector('button')).toBeInTheDocument();
  });

  it('renders ghost variant correctly', () => {
    const { container } = render(<BrandButton variant="ghost">Cancel</BrandButton>);
    expect(container.querySelector('button')).toBeInTheDocument();
  });

  it('renders danger variant correctly', () => {
    const { container } = render(<BrandButton variant="destructive">Delete</BrandButton>);
    expect(container.querySelector('button')).toBeInTheDocument();
  });

  it('calls onClick handler when clicked', async () => {
    const handleClick = vi.fn();
    const { getByText } = render(<BrandButton onClick={handleClick}>Click Me</BrandButton>);

    fireEvent.click(getByText('Click Me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('is disabled when isLoading is true', () => {
    const { getByText } = render(<BrandButton isLoading>Loading...</BrandButton>);
    expect((getByText('Loading...').closest('button') as HTMLButtonElement).disabled).toBe(true);
  });

  it('is disabled when disabled prop is true', () => {
    const { getByText } = render(<BrandButton disabled>Disabled</BrandButton>);
    expect((getByText('Disabled').closest('button') as HTMLButtonElement).disabled).toBe(true);
  });

  it('renders leftIcon when provided', () => {
    const { container } = render(
      <BrandButton leftIcon={<span data-testid="left-icon">Icon</span>}>With Icon</BrandButton>
    );
    expect(container.querySelector('[data-testid="left-icon"]')).toBeInTheDocument();
  });

  it('renders rightIcon when provided', () => {
    const { container } = render(
      <BrandButton rightIcon={<span data-testid="right-icon">Icon</span>}>With Icon</BrandButton>
    );
    expect(container.querySelector('[data-testid="right-icon"]')).toBeInTheDocument();
  });
});