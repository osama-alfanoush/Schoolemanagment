function isRecord(value: unknown): value is Record<string, any> {
  return typeof value === "object" && value !== null;
}

export function toArray<T = any>(payload: unknown): T[] {
  if (Array.isArray(payload)) return payload as T[];
  if (!isRecord(payload)) return [];

  if (Array.isArray(payload.data)) return payload.data as T[];
  if (Array.isArray(payload.data?.data)) return payload.data.data as T[];
  if (Array.isArray(payload.items)) return payload.items as T[];
  if (Array.isArray(payload.items?.data)) return payload.items.data as T[];
  if (Array.isArray(payload.records)) return payload.records as T[];
  if (Array.isArray(payload.records?.data)) return payload.records.data as T[];
  if (Array.isArray(payload.requests)) return payload.requests as T[];
  if (Array.isArray(payload.requests?.data)) return payload.requests.data as T[];

  return [];
}

export function paginationMeta(payload: unknown): Record<string, any> {
  if (!isRecord(payload)) return { last_page: 1 };

  if (isRecord(payload.meta)) return payload.meta;
  if (isRecord(payload.data?.meta)) return payload.data.meta;
  if (isRecord(payload.data) && !Array.isArray(payload.data)) return payload.data;

  return payload;
}
