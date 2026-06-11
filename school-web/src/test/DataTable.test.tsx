import { describe, it, expect, vi } from 'vitest';
import { render, cleanup, fireEvent } from '@testing-library/react';
import DataTable from '@/components/ui/DataTable';

const baseColumns = [
  { key: 'name', label: 'Name' },
  { key: 'email', label: 'Email' },
  { key: 'role', label: 'Role' },
];

const baseData = [
  { id: 1, name: 'John Doe', email: 'john@test.com', role: 'admin' },
  { id: 2, name: 'Jane Smith', email: 'jane@test.com', role: 'teacher' },
];

describe('DataTable', () => {
  afterEach(() => cleanup());

  it('renders data rows correctly', () => {
    const { getByText } = render(<DataTable columns={baseColumns} data={baseData} />);
    expect(getByText('John Doe')).toBeInTheDocument();
    expect(getByText('jane@test.com')).toBeInTheDocument();
    expect(getByText('teacher')).toBeInTheDocument();
  });

  it('renders empty state when no data', () => {
    const { getByText } = render(
      <DataTable columns={baseColumns} data={[]} emptyMessage="No users found" />
    );
    expect(getByText('No users found')).toBeInTheDocument();
  });

  it('renders column headers', () => {
    const { getByText } = render(<DataTable columns={baseColumns} data={baseData} />);
    expect(getByText('Name')).toBeInTheDocument();
    expect(getByText('Email')).toBeInTheDocument();
    expect(getByText('Role')).toBeInTheDocument();
  });

  it('calls onRowClick when row is clicked', () => {
    const handleRowClick = vi.fn();
    const { getByText } = render(
      <DataTable columns={baseColumns} data={baseData} onRowClick={handleRowClick} />
    );

    fireEvent.click(getByText('John Doe'));
    expect(handleRowClick).toHaveBeenCalledWith(baseData[0]);
  });

  it('renders loading skeleton rows', () => {
    const { container } = render(
      <DataTable columns={baseColumns} data={[]} isLoading={true} />
    );
    const skeletons = container.querySelectorAll('.animate-pulse');
    expect(skeletons.length).toBeGreaterThan(0);
  });

  it('renders custom cell with render function', () => {
    const columns = [
      { key: 'name', label: 'Name' },
      {
        key: 'role',
        label: 'Role',
        render: (val: string) => <span data-testid="role-badge">{val.toUpperCase()}</span>,
      },
    ];
    const { container } = render(<DataTable columns={columns} data={baseData} />);
    expect(container.querySelector('[data-testid="role-badge"]')).toBeInTheDocument();
  });

  it('renders pagination when provided', () => {
    const { getByText } = render(
      <DataTable
        columns={baseColumns}
        data={baseData}
        pagination={{
          currentPage: 1,
          lastPage: 3,
          total: 30,
          perPage: 10,
          onPageChange: vi.fn(),
        }}
      />
    );
    expect(getByText('Showing 1–10 of 30 entries')).toBeInTheDocument();
  });
});