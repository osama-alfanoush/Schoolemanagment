export function toArray<T = any>(payload: any): T[] {
  if (Array.isArray(payload)) return payload as T[];
  if (Array.isArray(payload?.data)) return payload.data as T[];
  if (Array.isArray(payload?.data?.data)) return payload.data.data as T[];
  if (Array.isArray(payload?.students)) return payload.students as T[];
  if (Array.isArray(payload?.records)) return payload.records as T[];
  if (Array.isArray(payload?.records?.data)) return payload.records.data as T[];
  return [];
}
