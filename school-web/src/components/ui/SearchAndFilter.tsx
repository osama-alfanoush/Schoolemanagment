import { useState, useRef, useEffect } from "react";
import { cn } from "@/lib/utils";
import { Search, X, ChevronDown } from "lucide-react";

/* ─── Types ─── */
export interface FilterOption {
  value: string;
  label: string;
}

export interface FilterConfig {
  key: string;
  label: string;
  options: FilterOption[];
}

export interface SearchAndFilterProps {
  placeholder?: string;
  value?: string;
  onChange?: (value: string) => void;
  search?: string;
  onSearchChange?: (value: string) => void;
  filters?: FilterConfig[];
  activeFilters?: Record<string, string>;
  onFilterChange?: (key: string, value: string) => void;
  onClearFilters?: () => void;
}

/* ─── Filter Dropdown ─── */
function FilterDropdown({
  config,
  activeValue,
  onSelect,
}: {
  config: FilterConfig;
  activeValue?: string;
  onSelect: (value: string) => void;
}) {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handler = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    document.addEventListener("mousedown", handler);
    return () => document.removeEventListener("mousedown", handler);
  }, []);

  const active = activeValue && activeValue !== "__all__";
  const activeLabel = active
    ? config.options.find((o) => o.value === activeValue)?.label ?? activeValue
    : null;

  return (
    <div ref={ref} className="relative">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className={cn(
          "flex items-center gap-1.5 px-3 py-2.5 bg-card text-sm transition-all duration-200",
          active
            ? "border-[var(--color-primary)] text-[var(--color-primary)] bg-[var(--color-primary-subtle)]"
            : "border-border text-muted-foreground hover:border-[var(--color-primary)] hover:text-[var(--color-primary)]"
        )}
        style={{ borderRadius: "var(--radius-base, 0.75rem)", borderWidth: "1px", borderStyle: "solid" }}
      >
        <span>{config.label}</span>
        {active && <span className="font-semibold">: {activeLabel}</span>}
        <ChevronDown className="h-3.5 w-3.5" />
      </button>

      {open && (
        <div
          className="absolute top-full mt-1 left-0 z-50 bg-card shadow-[var(--shadow-hover)] border border-border min-w-[160px] py-1 overflow-hidden"
          style={{ borderRadius: "var(--radius-base, 0.75rem)" }}
        >
          <button
            type="button"
            onClick={() => { onSelect("__all__"); setOpen(false); }}
            className={cn(
              "w-full px-3 py-2 text-sm text-left hover:bg-[var(--color-primary-subtle)] transition-colors",
              !active && "text-[var(--color-primary)] font-medium bg-[var(--color-primary-subtle)]"
            )}
          >
            All
          </button>
          {config.options.map((opt) => (
            <button
              key={opt.value}
              type="button"
              onClick={() => { onSelect(opt.value); setOpen(false); }}
              className={cn(
                "w-full px-3 py-2 text-sm text-left hover:bg-[var(--color-primary-subtle)] transition-colors",
                activeValue === opt.value && "text-[var(--color-primary)] font-medium bg-[var(--color-primary-subtle)]"
              )}
            >
              {opt.label}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

/* ─── Main Component ─── */
export default function SearchAndFilter({
  placeholder = "Search...",
  value,
  onChange,
  search,
  onSearchChange,
  filters = [],
  activeFilters = {},
  onFilterChange,
  onClearFilters,
}: SearchAndFilterProps) {
  const activeEntries = Object.entries(activeFilters).filter(([, v]) => v && v !== "__all__");
  const searchValue = value ?? search ?? "";
  const handleChange = (val: string) => {
    onChange?.(val);
    onSearchChange?.(val);
  };

  return (
    <div>
      <div className="flex items-center gap-3 flex-wrap">
        {/* Search input */}
        <div
          className="flex-1 min-w-[200px] flex items-center gap-2 bg-card border border-border px-3 py-2.5 shadow-sm focus-within:border-[var(--color-primary)] focus-within:ring-2 focus-within:ring-[var(--color-primary)]/20 transition-all duration-200"
          style={{ borderRadius: "var(--radius-base, 0.75rem)" }}
        >
          <Search className="h-4 w-4 text-muted-foreground shrink-0" />
          <input
            type="text"
            value={searchValue}
            onChange={(e) => handleChange(e.target.value)}
            placeholder={placeholder}
            className="flex-1 text-sm outline-none bg-transparent text-foreground placeholder:text-muted-foreground"
          />
          {searchValue && (
            <button
              type="button"
              onClick={() => handleChange("")}
              className="text-muted-foreground hover:text-foreground transition-colors"
            >
              <X className="h-4 w-4" />
            </button>
          )}
        </div>

        {/* Filter dropdowns */}
        {filters.map((f) => (
          <FilterDropdown
            key={f.key}
            config={f}
            activeValue={activeFilters[f.key]}
            onSelect={(v) => onFilterChange?.(f.key, v)}
          />
        ))}
      </div>

      {/* Active filter pills */}
      {activeEntries.length > 0 && (
        <div className="flex flex-wrap gap-2 mt-2">
          {activeEntries.map(([key, val]) => {
            const config = filters.find((f) => f.key === key);
            const optLabel = config?.options.find((o) => o.value === val)?.label ?? val;
            return (
              <span
                key={key}
                className="flex items-center gap-1 bg-[var(--color-primary-light)] text-[var(--color-primary)] rounded-full px-3 py-1 text-xs font-medium"
              >
                {config?.label}: {optLabel}
                <button
                  type="button"
                  onClick={() => onFilterChange?.(key, "__all__")}
                  className="ml-0.5 hover:text-destructive transition-colors"
                >
                  <X className="h-3 w-3" />
                </button>
              </span>
            );
          })}
          {activeEntries.length > 1 && (
            <button
              type="button"
              onClick={onClearFilters}
              className="text-xs text-[var(--color-primary)] hover:underline font-medium"
            >
              Clear all
            </button>
          )}
        </div>
      )}
    </div>
  );
}
