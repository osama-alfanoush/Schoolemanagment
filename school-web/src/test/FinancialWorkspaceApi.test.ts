import { beforeEach, describe, expect, it } from 'vitest';
import { http, HttpResponse } from 'msw';
import { server } from './msw-handlers';
import { FinanceWorkspace, authStore } from '@/lib/api';

beforeEach(() => {
  localStorage.clear();
  authStore.setSession({ id: 9, name: 'Finance', email: 'finance@test.com', role: 'finance', is_active: true });
});

describe('FinanceWorkspace API', () => {
  it('sends an idempotency key when creating a receipt', async () => {
    let key = '';
    server.use(http.post('/api/finance/receipts', async ({ request }) => {
      key = request.headers.get('Idempotency-Key') ?? '';
      const body = await request.json() as Record<string, unknown>;
      return HttpResponse.json({ id: 1, receipt_no: 'RCPT-1', status: 'draft', ...body }, { status: 201 });
    }));

    const receipt = await FinanceWorkspace.createReceipt({
      student_user_id: 2, amount: 125, method: 'cash', receipt_date: '2026-08-02',
    });
    expect(key).toMatch(/^[0-9a-f-]{36}$/i);
    expect(receipt.status).toBe('draft');
  });

  it('uses explicit approval, posting and reversal endpoints', async () => {
    const calls: string[] = [];
    server.use(
      http.post('/api/finance/receipts/4/approve', () => { calls.push('approve'); return HttpResponse.json({ id: 4, status: 'approved' }); }),
      http.post('/api/finance/receipts/4/post', () => { calls.push('post'); return HttpResponse.json({ id: 4, status: 'posted' }); }),
      http.post('/api/finance/receipts/4/reverse', async ({ request }) => { calls.push((await request.json() as { reason: string }).reason); return HttpResponse.json({ id: 4, status: 'reversed' }); }),
    );
    await FinanceWorkspace.approveReceipt(4);
    await FinanceWorkspace.postReceipt(4);
    await FinanceWorkspace.reverseReceipt(4, 'correction');
    expect(calls).toEqual(['approve', 'post', 'correction']);
  });

  it('returns backend-paginated statement totals', async () => {
    const statement = await FinanceWorkspace.studentStatement(1, { page: 1 });
    expect(statement.closing_balance).toBe(0);
    expect(statement.last_page).toBe(1);
  });
});
