import '@testing-library/jest-dom';
import { afterEach, beforeAll, afterAll } from 'vitest';
import { cleanup } from '@testing-library/react';
import { server } from './msw-handlers';

// Initialise the real i18next instance (English, synchronous resources) so
// `useTranslation()` resolves actual labels in tests. Previously this file
// mocked react-i18next with `t: key => key`, which made components render raw
// translation keys (e.g. "login.signIn") and broke every test asserting on
// human-readable text.
import '@/lib/i18n';

beforeAll(() => server.listen({ onUnhandledRequest: 'warn' }));
afterEach(() => {
  cleanup();
  server.resetHandlers();
});
afterAll(() => server.close());