function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null;
}

function nestedRecord(value: unknown, key: string): Record<string, unknown> | null {
  if (!isRecord(value)) return null;
  const nested = value[key];
  return isRecord(nested) ? nested : null;
}

export function toArray<T = unknown>(payload: unknown): T[] {
  if (Array.isArray(payload)) return payload as T[];
  if (!isRecord(payload)) return [];

  if (Array.isArray(payload.data)) return payload.data as T[];
  const data = nestedRecord(payload, "data");
  if (data && Array.isArray(data.data)) return data.data as T[];
  if (Array.isArray(payload.items)) return payload.items as T[];
  const items = nestedRecord(payload, "items");
  if (items && Array.isArray(items.data)) return items.data as T[];
  if (Array.isArray(payload.records)) return payload.records as T[];
  const records = nestedRecord(payload, "records");
  if (records && Array.isArray(records.data)) return records.data as T[];
  if (Array.isArray(payload.requests)) return payload.requests as T[];
  const requests = nestedRecord(payload, "requests");
  if (requests && Array.isArray(requests.data)) return requests.data as T[];

  return [];
}

export interface PaginationMeta {
  current_page?: number;
  last_page?: number;
  per_page?: number;
  total?: number;
}

export function paginationMeta(payload: unknown): PaginationMeta {
  if (!isRecord(payload)) return { last_page: 1 };

  if (isRecord(payload.meta)) return payload.meta;
  const data = nestedRecord(payload, "data");
  if (data && isRecord(data.meta)) return data.meta;
  if (data && !Array.isArray(payload.data)) return data;

  return payload;
}
