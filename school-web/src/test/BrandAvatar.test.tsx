import { describe, it, expect } from 'vitest';
import { render } from '@testing-library/react';
import BrandAvatar from '@/components/ui/BrandAvatar';

describe('BrandAvatar', () => {
  it('renders initials from name', () => {
    const { getByText } = render(<BrandAvatar name="John Doe" />);
    expect(getByText('JD')).toBeInTheDocument();
  });

  it('renders single initial for single-word name', () => {
    const { getByText } = render(<BrandAvatar name="Alice" />);
    expect(getByText('AL')).toBeInTheDocument();
  });

  it('renders image when src is provided', () => {
    const { container } = render(
      <BrandAvatar name="John Doe" src="https://example.com/avatar.jpg" />
    );
    const img = container.querySelector('img');
    expect(img).toBeInTheDocument();
    expect(img?.getAttribute('src')).toBe('https://example.com/avatar.jpg');
  });

  it('renders initials fallback when no src', () => {
    const { getByText } = render(<BrandAvatar name="Jane Smith" />);
    expect(getByText('JS')).toBeInTheDocument();
  });

  it('renders with different sizes', () => {
    const { rerender } = render(<BrandAvatar name="John" size="sm" />);
    expect(document.querySelector('.h-8')).toBeInTheDocument();

    rerender(<BrandAvatar name="Jane" size="lg" />);
    expect(document.querySelector('.h-12')).toBeInTheDocument();
  });
});