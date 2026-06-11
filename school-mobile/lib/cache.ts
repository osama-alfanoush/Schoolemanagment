import AsyncStorage from "@react-native-async-storage/async-storage";

/**
 * Lightweight offline cache for read-only React Query payloads.
 * Each entry stores `{ data, savedAt }`. Components show a badge if the
 * displayed payload came from the cache rather than a fresh fetch.
 */

interface Entry<T> {
  data: T;
  savedAt: number;
}

const PREFIX = "sm_cache_";

export async function readCache<T>(key: string): Promise<T | null> {
  try {
    const raw = await AsyncStorage.getItem(PREFIX + key);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as Entry<T>;
    return parsed.data;
  } catch {
    return null;
  }
}

export async function writeCache<T>(key: string, data: T) {
  try {
    const entry: Entry<T> = { data, savedAt: Date.now() };
    await AsyncStorage.setItem(PREFIX + key, JSON.stringify(entry));
  } catch {
    // ignore
  }
}

/**
 * useCachedQuery — wraps a React Query key/fn pair with persistence.
 *
 * On mount we hydrate state from AsyncStorage if available, then call the
 * fetcher. On success we re-persist. The hook returns the data plus an
 * `isOffline` flag so screens can show an offline badge when only cached
 * data is available.
 */
import { useEffect, useRef, useState } from "react";

export function useOfflineCache<T>(
  key: string,
  query: { data: T | undefined; isLoading: boolean; isError: boolean },
) {
  const [cached, setCached] = useState<T | null>(null);
  const persisted = useRef(false);

  useEffect(() => {
    let active = true;
    readCache<T>(key).then((value) => {
      if (active && value != null) setCached(value);
    });
    return () => {
      active = false;
    };
  }, [key]);

  useEffect(() => {
    if (query.data !== undefined && !persisted.current) {
      persisted.current = true;
      writeCache(key, query.data);
    }
  }, [key, query.data]);

  const usingCache =
    (query.isError || query.isLoading) && cached != null && query.data === undefined;
  const data = (query.data ?? cached) as T | null | undefined;

  return { data, usingCache, fresh: query.data !== undefined };
}
