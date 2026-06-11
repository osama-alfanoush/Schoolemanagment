import { useQuery } from "@tanstack/react-query";
import React, {
  createContext,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";

import { Parent, asArray } from "@/lib/api";

export interface Child {
  id: number;
  name: string;
  email?: string;
  studentProfile?: any;
}

interface Ctx {
  children: Child[];
  selected: Child | null;
  selectedId: number | null;
  setSelectedId: (id: number) => void;
  loading: boolean;
  isError: boolean;
  refetch: () => void;
}

const ChildCtx = createContext<Ctx | undefined>(undefined);

export function ChildProvider({ children }: { children: React.ReactNode }) {
  const q = useQuery({ queryKey: ["parent", "children"], queryFn: Parent.children });
  const list = asArray<Child>(q.data);
  const [selectedId, setSelectedId] = useState<number | null>(null);

  useEffect(() => {
    if (selectedId == null && list.length > 0) {
      setSelectedId(list[0].id);
    }
  }, [list, selectedId]);

  const value = useMemo<Ctx>(
    () => ({
      children: list,
      selected: list.find((c) => c.id === selectedId) ?? null,
      selectedId,
      setSelectedId,
      loading: q.isLoading,
      isError: q.isError,
      refetch: q.refetch,
    }),
    [list, selectedId, q.isLoading, q.isError, q.refetch],
  );

  return <ChildCtx.Provider value={value}>{children}</ChildCtx.Provider>;
}

export function useChild() {
  const ctx = useContext(ChildCtx);
  if (!ctx) throw new Error("useChild must be inside ChildProvider");
  return ctx;
}
