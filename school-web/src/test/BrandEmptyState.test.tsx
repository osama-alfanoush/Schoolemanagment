import { describe, it, expect, vi } from 'vitest';
import { render, fireEvent } from '@testing-library/react';
import BrandEmptyState from '@/components/ui/BrandEmptyState';

describe('BrandEmptyState', () => {
  it('renders title text', () => {
    const { getByText } = render(
      <BrandEmptyState icon="📭" title="No Data Available" />
    );
    expect(getByText('No Data Available')).toBeInTheDocument();
  });

  it('renders icon', () => {
    const { getByText } = render(
      <BrandEmptyState icon="📭" title="No Items" />
    );
    expect(getByText('📭')).toBeInTheDocument();
  });

  it('renders description when provided', () => {
    const { getByText } = render(
      <BrandEmptyState
        icon="📭"
        title="No Students"
        subtitle="Add your first student to get started"
      />
    );
    expect(getByText('Add your first student to get started')).toBeInTheDocument();
  });

  it('renders action button when provided', () => {
    const handleAction = vi.fn();
    const { getByText } = render(
      <BrandEmptyState
        icon="📭"
        title="No Invoices"
        action={{ label: 'Create Invoice', onClick: handleAction }}
      />
    );

    fireEvent.click(getByText('Create Invoice'));
    expect(handleAction).toHaveBeenCalledTimes(1);
  });

  it('renders different sizes', () => {
    const { rerender } = render(
      <BrandEmptyState icon="📭" title="Small" />
    );
    expect(document.querySelector('.h-16')).toBeInTheDocument();

    rerender(<BrandEmptyState icon="📭" title="Large" />);
    expect(document.querySelector('.h-28')).toBeInTheDocument();
  });
});