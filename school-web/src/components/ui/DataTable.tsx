import { useState, useMemo, useRef, useEffect, useCallback } from "react"
import { cn } from "@/lib/utils"
import {
  ChevronUp,
  ChevronDown,
  ChevronsUpDown,
  ChevronLeft,
  ChevronRight,
  AlertTriangle,
  MoreHorizontal,
} from "lucide-react"
import type { ReactNode } from "react"
import { motion } from "framer-motion"

export interface TableColumn<T = any> {
  key: string
  label: string
  render?: (value: any, row: T, index: number) => ReactNode
  sortable?: boolean
  searchable?: boolean
  width?: string
  align?: "left" | "center" | "right"
  sticky?: boolean
  hide?: "sm" | "md" | "lg"
}

export interface TableAction<T = any> {
  label: string
  icon?: ReactNode
  onClick: (row: T) => void
  variant?: "default" | "danger"
  show?: (row: T) => boolean
}

export interface DataTableProps<T = any> {
  columns: TableColumn<T>[]
  data: T[]
  isLoading?: boolean
  error?: string
  emptyMessage?: string
  emptyIcon?: string
  emptyAction?: { label: string; onClick: () => void }
  onRowClick?: (row: T) => void
  rowActions?: TableAction<T>[]
  selectable?: boolean
  onSelectionChange?: (selected: T[]) => void
  pagination?: {
    currentPage: number
    lastPage: number
    total: number
    perPage: number
    onPageChange: (page: number) => void
    onPerPageChange?: (perPage: number) => void
  }
  toolbar?: ReactNode
  title?: string
  subtitle?: string
  headerActions?: ReactNode
  striped?: boolean
  compact?: boolean
  stickyHeader?: boolean
}

const PER_PAGE_OPTIONS = [10, 25, 50, 100]

const skeletonWidths = ["60%", "80%", "40%", "70%", "55%"]

function getNestedValue(obj: any, path: string): any {
  return path.split(".").reduce((acc, key) => acc?.[key], obj)
}

function getPageNumbers(current: number, last: number): (number | "...")[] {
  const pages: (number | "...")[] = []
  if (last <= 5) {
    for (let i = 1; i <= last; i++) pages.push(i)
    return pages
  }
  pages.push(1)
  const start = Math.max(2, current - 1)
  const end = Math.min(last - 1, current + 1)
  if (start > 2) pages.push("...")
  for (let i = start; i <= end; i++) pages.push(i)
  if (end < last - 1) pages.push("...")
  pages.push(last)
  return pages
}

function SortIcon({ colKey, sortKey, sortDir }: { colKey: string; sortKey: string | null; sortDir: "asc" | "desc" }) {
  if (sortKey !== colKey) return <ChevronsUpDown className="h-3.5 w-3.5 text-muted-foreground/50" />
  return sortDir === "asc" ? (
    <ChevronUp className="h-3.5 w-3.5" style={{ color: "var(--color-primary, #6C63FF)" }} />
  ) : (
    <ChevronDown className="h-3.5 w-3.5" style={{ color: "var(--color-primary, #6C63FF)" }} />
  )
}

function LoadingRow({ columns, isCompact }: { columns: TableColumn[]; isCompact: boolean }) {
  return (
    <tr className="border-b border-gray-50 last:border-0">
      {columns.map((col, i) => (
        <td key={col.key || i} className={cn("px-4", isCompact ? "py-2.5" : "py-3.5")}>
          <div
            className="h-4 bg-muted/50 rounded animate-pulse"
            style={{ width: skeletonWidths[i % skeletonWidths.length] }}
          />
        </td>
      ))}
    </tr>
  )
}

function RowActionDropdown({ actions, row, onClose }: { actions: TableAction[]; row: any; onClose: () => void }) {
  const ref = useRef<HTMLDivElement>(null)
  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) onClose()
    }
    document.addEventListener("mousedown", handleClick)
    return () => document.removeEventListener("mousedown", handleClick)
  }, [onClose])

  return (
    <div
      ref={ref}
      className="absolute right-0 top-full mt-1 bg-card rounded-xl shadow-lg border border-border/50 z-10 min-w-[140px] py-1"
    >
      {actions.map((action, ai) => {
        const isDanger = action.variant === "danger"
        return (
          <button
            key={ai}
            onClick={() => {
              action.onClick(row)
              onClose()
            }}
            className={cn(
              "w-full flex items-center gap-2 px-3 py-2 text-sm transition-colors",
              isDanger ? "text-red-600 hover:bg-red-50" : "text-foreground hover:bg-muted/30",
            )}
          >
            {action.icon}
            {action.label}
          </button>
        )
      })}
    </div>
  )
}

export default function DataTable<T extends Record<string, any>>({
  columns,
  data,
  isLoading,
  error,
  emptyMessage = "No data found",
  emptyIcon = "📭",
  emptyAction,
  onRowClick,
  rowActions,
  selectable,
  onSelectionChange,
  pagination,
  toolbar,
  title,
  subtitle,
  headerActions,
  striped = false,
  compact = false,
  stickyHeader = false,
}: DataTableProps<T>) {
  const [sortKey, setSortKey] = useState<string | null>(null)
  const [sortDir, setSortDir] = useState<"asc" | "desc">("asc")
  const [selected, setSelected] = useState<T[]>([])
  const [openDropdownIndex, setOpenDropdownIndex] = useState<number | null>(null)

  const visibleActions = useCallback(
    (row: T) =>
      rowActions?.filter((a) => (a.show ? a.show(row) : true)) ?? [],
    [rowActions],
  )

  const handleSort = (key: string) => {
    if (sortKey === key) {
      setSortDir((d) => (d === "asc" ? "desc" : "asc"))
    } else {
      setSortKey(key)
      setSortDir("asc")
    }
  }

  const sorted = useMemo(() => {
    const safeData = Array.isArray(data) ? data : [];
    if (!sortKey) return safeData
    const copy = [...safeData]
    copy.sort((a, b) => {
      const va = getNestedValue(a, sortKey)
      const vb = getNestedValue(b, sortKey)
      if (va == null) return 1
      if (vb == null) return -1
      if (va instanceof Date && vb instanceof Date) return va.getTime() - vb.getTime()
      const cmp =
        typeof va === "number" && typeof vb === "number"
          ? va - vb
          : String(va).localeCompare(String(vb))
      return sortDir === "asc" ? cmp : -cmp
    })
    return copy
  }, [data, sortKey, sortDir])

  const handleSelectAll = () => {
    if (selected.length === sorted.length) {
      setSelected([])
      onSelectionChange?.([])
    } else {
      setSelected([...sorted])
      onSelectionChange?.([...sorted])
    }
  }

  const handleSelectRow = (row: T) => {
    const idx = selected.findIndex((s) => s === row)
    let next: T[]
    if (idx >= 0) {
      next = selected.filter((_, i) => i !== idx)
    } else {
      next = [...selected, row]
    }
    setSelected(next)
    onSelectionChange?.(next)
  }

  const isAllSelected = sorted.length > 0 && selected.length === sorted.length

  const scrollRef = useRef<HTMLDivElement>(null)

  const hideClass = (col: TableColumn): string => {
    if (col.hide === "sm") return "hidden sm:table-cell"
    if (col.hide === "md") return "hidden md:table-cell"
    if (col.hide === "lg") return "hidden lg:table-cell"
    return ""
  }

  return (
    <div className="rounded-xl border border-border bg-card overflow-hidden shadow-sm">
      {/* Header */}
      {(title || headerActions) && (
        <div className="flex items-center justify-between px-6 py-4 border-b border-border bg-muted/50">
          <div>
            {title && <h3 className="font-display text-base font-bold text-foreground">{title}</h3>}
            {subtitle && <p className="text-xs text-muted-foreground mt-0.5">{subtitle}</p>}
          </div>
          {headerActions && <div>{headerActions}</div>}
        </div>
      )}

      {/* Toolbar */}
      {toolbar && (
        <div className="px-6 py-3 border-b border-border bg-muted/30">{toolbar}</div>
      )}

      {/* Scrollable table */}
      <div ref={scrollRef} className="overflow-x-auto">
        <table className="w-full">
          <thead>
            <tr className="bg-muted/50 border-b border-border">
              {/* Checkbox column */}
              {selectable && (
                <th className="w-10 px-4 py-3 border-b border-border/50">
                  <input
                    type="checkbox"
                    checked={isAllSelected}
                    onChange={handleSelectAll}
                    className="w-4 h-4 rounded cursor-pointer"
                    style={{ accentColor: "var(--color-primary, #6C63FF)" }}
                  />
                </th>
              )}
              {/* Data columns */}
              {columns.map((col) => {
                const hc = hideClass(col)
                return (
                  <th
                    key={col.key}
                    className={cn(
                      "px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground",
                      col.align === "center" && "text-center",
                      col.align === "right" && "text-right",
                      col.sortable && "cursor-pointer select-none hover:bg-muted/50 transition-colors",
                      sortKey === col.key && "text-[var(--color-primary)]",
                      col.sticky && "sticky left-0 bg-muted/50 z-10",
                      hc,
                    )}
                    style={{
                      ...(col.width ? { width: col.width } : {}),
                      ...(col.sticky ? { boxShadow: "2px 0 4px rgba(0,0,0,0.04)" } : {}),
                    }}
                    onClick={col.sortable ? () => handleSort(col.key) : undefined}
                  >
                    <span className="inline-flex items-center gap-1.5">
                      {col.label}
                      {col.sortable && <SortIcon colKey={col.key} sortKey={sortKey} sortDir={sortDir} />}
                    </span>
                  </th>
                )
              })}
              {/* Actions column header */}
              {rowActions && rowActions.length > 0 && (
                <th className="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-muted-foreground w-14" />
              )}
            </tr>
          </thead>
          <tbody>
            {isLoading ? (
              Array.from({ length: 5 }).map((_, i) => (
                <LoadingRow key={i} columns={selectable ? [{ key: "_checkbox", label: "" }, ...columns] : columns} isCompact={compact} />
              ))
            ) : error ? (
              <tr>
                <td colSpan={columns.length + (selectable ? 1 : 0) + (rowActions?.length ? 1 : 0)} className="py-12 text-center px-6">
                  <div className="flex flex-col items-center gap-3">
                    <div className="w-14 h-14 rounded-full bg-orange-100 flex items-center justify-center">
                      <AlertTriangle className="h-7 w-7 text-orange-500" />
                    </div>
                    <div>
                      <p className="text-base font-semibold text-foreground">Failed to load data</p>
                      <p className="text-sm text-muted-foreground mt-1">{error}</p>
                    </div>
                    <button
                      onClick={() => window.location.reload()}
                      className="px-4 py-2 rounded-lg text-sm font-medium text-white"
                      style={{ backgroundColor: "var(--color-primary, #6C63FF)" }}
                    >
                      Try Again
                    </button>
                  </div>
                </td>
              </tr>
            ) : sorted.length === 0 ? (
              <tr>
                <td colSpan={columns.length + (selectable ? 1 : 0) + (rowActions?.length ? 1 : 0)} className="py-16 text-center text-muted-foreground">
                  <motion.div 
                    initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.3 }}
                    className="flex flex-col items-center gap-3"
                  >
                    <motion.div
                      animate={{ y: [0, -8, 0] }}
                      transition={{ duration: 3, repeat: Infinity, ease: "easeInOut" }}
                      className="w-20 h-20 rounded-full flex items-center justify-center mx-auto bg-[var(--color-primary-light)] text-[var(--color-primary)]"
                    >
                      <span className="text-5xl">{emptyIcon}</span>
                    </motion.div>
                    <p className="text-muted-foreground text-sm">{emptyMessage}</p>
                    {emptyAction && (
                      <button
                        onClick={emptyAction.onClick}
                        className="px-4 py-2 rounded-lg text-sm font-medium text-white"
                        style={{ backgroundColor: "var(--color-primary, #6C63FF)" }}
                      >
                        {emptyAction.label}
                      </button>
                    )}
                  </motion.div>
                </td>
              </tr>
            ) : (
              sorted.map((row, ri) => {
                const isSelected = selected.includes(row)
                const rowActionsList = visibleActions(row)
                return (
                  <tr
                    key={ri}
                    className={cn(
                      "bg-card border-b border-border/50 transition-colors duration-100",
                      isSelected && "bg-[var(--color-primary-light)] border-l-[3px] border-l-[var(--color-primary)]",
                      !isSelected && "border-l-[3px] border-l-transparent",
                      onRowClick && "cursor-pointer hover:bg-muted/30",
                    )}
                    onClick={onRowClick ? () => onRowClick(row) : undefined}
                  >
                    {/* Checkbox cell */}
                    {selectable && (
                      <td className="px-4 py-3.5" onClick={(e) => e.stopPropagation()}>
                        <input
                          type="checkbox"
                          checked={isSelected}
                          onChange={() => handleSelectRow(row)}
                          className="w-4 h-4 rounded cursor-pointer"
                          style={{ accentColor: "var(--color-primary, #6C63FF)" }}
                        />
                      </td>
                    )}
                    {/* Data cells */}
                    {columns.map((col) => {
                      const val = getNestedValue(row, col.key)
                      const hc = hideClass(col)
                      return (
                        <td
                          key={col.key}
                          className={cn(
                            "px-4 py-3.5 text-sm text-foreground align-middle",
                            col.align === "center" && "text-center",
                            col.align === "right" && "text-right",
                            col.sticky && "sticky left-0 z-10",
                            col.sticky && (isSelected ? "bg-[var(--color-primary-light)]" : "bg-card"),
                            hc,
                          )}
                          style={{
                            ...(col.sticky ? { boxShadow: "2px 0 4px rgba(0,0,0,0.04)" } : {}),
                          }}
                        >
                          {col.render ? col.render(val, row, ri) : (val ?? "\u2014")}
                        </td>
                      )
                    })}
                    {/* Actions cell */}
                    {rowActionsList.length > 0 && (
                      <td className="px-4 py-3.5 text-right border-b border-gray-50" onClick={(e) => e.stopPropagation()}>
                        <div className="relative inline-flex items-center gap-1">
                          {rowActionsList.length <= 2 ? (
                            rowActionsList.map((action, ai) => {
                              const isDanger = action.variant === "danger"
                              return (
                                <button
                                  key={ai}
                                  onClick={() => action.onClick(row)}
                                  title={action.label}
                                  className={cn(
                                    "w-8 h-8 rounded-lg flex items-center justify-center transition-colors",
                                    isDanger
                                      ? "text-muted-foreground/70 hover:text-red-500 hover:bg-red-50"
                                      : "text-muted-foreground hover:text-foreground hover:bg-muted/50",
                                  )}
                                >
                                  {action.icon}
                                </button>
                              )
                            })
                          ) : (
                            <>
                              <button
                                onClick={() =>
                                  setOpenDropdownIndex(openDropdownIndex === ri ? null : ri)
                                }
                                className="w-8 h-8 rounded-lg flex items-center justify-center text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-colors"
                              >
                                <MoreHorizontal className="h-4 w-4" />
                              </button>
                              {openDropdownIndex === ri && (
                                <RowActionDropdown
                                  actions={rowActionsList}
                                  row={row}
                                  onClose={() => setOpenDropdownIndex(null)}
                                />
                              )}
                            </>
                          )}
                        </div>
                      </td>
                    )}
                  </tr>
                )
              })
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      {pagination && pagination.total > 0 && (
        <div className="flex items-center justify-between border-t border-border bg-muted/30 px-4 py-3">
          <div className="flex items-center gap-3">
            <p className="text-sm text-muted-foreground">
              Showing{" "}
              {(pagination.currentPage - 1) * pagination.perPage + 1}
              {"\u2013"}
              {Math.min(pagination.currentPage * pagination.perPage, pagination.total)} of{" "}
              {pagination.total} entries
            </p>
            {pagination.onPerPageChange && (
              <div className="flex items-center gap-1.5 text-xs text-muted-foreground">
                Show:
                <select
                  value={pagination.perPage}
                  onChange={(e) => pagination.onPerPageChange?.(Number(e.target.value))}
                  className="border border-border rounded-lg px-2 py-1 text-xs bg-card outline-none"
                >
                  {PER_PAGE_OPTIONS.map((n) => (
                    <option key={n} value={n}>
                      {n}
                    </option>
                  ))}
                </select>
              </div>
            )}
          </div>
          <div className="flex items-center gap-1">
            <button
              disabled={pagination.currentPage <= 1}
              onClick={() => pagination.onPageChange(pagination.currentPage - 1)}
              className="h-8 w-8 rounded-md border border-border bg-card text-sm text-foreground hover:bg-muted/60 disabled:opacity-50 flex items-center justify-center p-0"
            >
              <ChevronLeft className="h-4 w-4" />
            </button>
            {getPageNumbers(pagination.currentPage, pagination.lastPage).map((p, i) =>
              p === "..." ? (
                <span key={`e${i}`} className="px-2 py-1.5 text-sm text-muted-foreground/70 select-none">
                  ...
                </span>
              ) : (
                <button
                  key={p}
                  onClick={() => pagination.onPageChange(p as number)}
                  className={cn(
                    "h-8 w-8 flex items-center justify-center rounded-md text-sm transition-colors",
                    p === pagination.currentPage
                      ? "bg-[var(--color-primary)] font-semibold text-white"
                      : "border border-border bg-card text-foreground hover:bg-muted/60"
                  )}
                >
                  {p}
                </button>
              ),
            )}
            <button
              disabled={pagination.currentPage >= pagination.lastPage}
              onClick={() => pagination.onPageChange(pagination.currentPage + 1)}
              className="h-8 w-8 rounded-md border border-border bg-card text-sm text-foreground hover:bg-muted/60 disabled:opacity-50 flex items-center justify-center p-0"
            >
              <ChevronRight className="h-4 w-4" />
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
