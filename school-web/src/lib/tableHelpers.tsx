const statusMap: Record<string, { bg: string; text: string; dot: string; label: string }> = {
  paid: { bg: "#dcfce7", text: "#166534", dot: "#22c55e", label: "Paid" },
  unpaid: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Unpaid" },
  partial: { bg: "#fef9c3", text: "#854d0e", dot: "#eab308", label: "Partial" },
  overdue: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Overdue" },
  refunded: { bg: "#f3e8ff", text: "#6b21a8", dot: "#a855f7", label: "Refunded" },
  pending: { bg: "#fef9c3", text: "#854d0e", dot: "#eab308", label: "Pending" },
  submitted: { bg: "#dbeafe", text: "#1e40af", dot: "#3b82f6", label: "Submitted" },
  graded: { bg: "#dcfce7", text: "#166534", dot: "#22c55e", label: "Graded" },
  late: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Late" },
  missing: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Missing" },
  draft: { bg: "#f3f4f6", text: "#4b5563", dot: "#9ca3af", label: "Draft" },
  present: { bg: "#dcfce7", text: "#166534", dot: "#22c55e", label: "Present" },
  absent: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Absent" },
  excused: { bg: "#f0fdf4", text: "#166534", dot: "#86efac", label: "Excused" },
  approved: { bg: "#dcfce7", text: "#166534", dot: "#22c55e", label: "Approved" },
  rejected: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Rejected" },
  reviewing: { bg: "#dbeafe", text: "#1e40af", dot: "#3b82f6", label: "Reviewing" },
  cancelled: { bg: "#f3f4f6", text: "#4b5563", dot: "#9ca3af", label: "Cancelled" },
  active: { bg: "#dcfce7", text: "#166534", dot: "#22c55e", label: "Active" },
  inactive: { bg: "#f3f4f6", text: "#4b5563", dot: "#9ca3af", label: "Inactive" },
  suspended: { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Suspended" },
  "in-stock": { bg: "#dcfce7", text: "#166534", dot: "#22c55e", label: "In Stock" },
  "low-stock": { bg: "#fef9c3", text: "#854d0e", dot: "#eab308", label: "Low Stock" },
  "out-stock": { bg: "#fee2e2", text: "#991b1b", dot: "#ef4444", label: "Out of Stock" },
}

export function renderStatus(status?: string) {
  const key = status?.toLowerCase() ?? ""
  const cfg = statusMap[key] ?? {
    bg: "#f3f4f6",
    text: "#4b5563",
    dot: "#9ca3af",
    label: status ? status.charAt(0).toUpperCase() + status.slice(1) : "\u2014",
  }
  return (
    <span
      style={{
        backgroundColor: cfg.bg,
        color: cfg.text,
        display: "inline-flex",
        alignItems: "center",
        gap: "6px",
        padding: "3px 10px",
        borderRadius: "9999px",
        fontSize: "11px",
        fontWeight: 500,
        whiteSpace: "nowrap",
      }}
    >
      <span
        style={{
          width: "6px",
          height: "6px",
          borderRadius: "50%",
          backgroundColor: cfg.dot,
          flexShrink: 0,
        }}
      />
      {cfg.label}
    </span>
  )
}

const roleColors: Record<string, string> = {
  student: "var(--color-primary)",
  teacher: "#43D9A2",
  parent: "#FF6584",
  admin: "#4DC9F6",
  finance: "#FFB347",
  hr: "#A78BFA",
  warehouse: "#FB923C",
}

export function renderRole(role?: string) {
  const color = roleColors[role?.toLowerCase() ?? ""] ?? "#9ca3af"
  return (
    <span
      style={{
        backgroundColor: color + "18",
        color,
        border: `1px solid ${color}30`,
        padding: "3px 10px",
        borderRadius: "9999px",
        fontSize: "11px",
        fontWeight: 600,
        textTransform: "capitalize",
      }}
    >
      {role ?? "\u2014"}
    </span>
  )
}

export function renderGrade(score?: number | null) {
  if (score == null) {
    return <span style={{ color: "#e5e7eb", fontSize: "12px" }}>{"\u2014"}</span>
  }
  const color = score >= 80 ? "#22c55e" : score >= 60 ? "#eab308" : "#ef4444"
  const letterMap = [
    { min: 90, letter: "A", bg: "#dcfce7", text: "#166534" },
    { min: 80, letter: "B", bg: "#dbeafe", text: "#1e40af" },
    { min: 70, letter: "C", bg: "#fef9c3", text: "#854d0e" },
    { min: 60, letter: "D", bg: "#fee2e2", text: "#991b1b" },
    { min: 0, letter: "F", bg: "#f3f4f6", text: "#6b7280" },
  ]
  const grade = letterMap.find((g) => score >= g.min) ?? letterMap[letterMap.length - 1]
  return (
    <div style={{ display: "flex", alignItems: "center", gap: "8px" }}>
      <div
        style={{
          width: "64px",
          height: "6px",
          backgroundColor: "#f1f5f9",
          borderRadius: "9999px",
          overflow: "hidden",
        }}
      >
        <div
          style={{
            width: score + "%",
            height: "100%",
            backgroundColor: color,
            borderRadius: "9999px",
            transition: "width 700ms ease",
          }}
        />
      </div>
      <span style={{ color, fontSize: "11px", fontWeight: 700, width: "32px", textAlign: "right" }}>
        {score}%
      </span>
      <span
        style={{
          backgroundColor: grade.bg,
          color: grade.text,
          fontSize: "10px",
          fontWeight: 700,
          padding: "2px 6px",
          borderRadius: "4px",
        }}
      >
        {grade.letter}
      </span>
    </div>
  )
}

export function renderUser(name?: string, subtitle?: string) {
  const initials = (name ?? "?").charAt(0).toUpperCase()
  return (
    <div style={{ display: "flex", alignItems: "center", gap: "10px" }}>
      <div
        style={{
          width: "32px",
          height: "32px",
          borderRadius: "50%",
          background: "var(--gradient-main)",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          color: "var(--color-primary-fg, white)",
          fontSize: "12px",
          fontWeight: 700,
          flexShrink: 0,
        }}
      >
        {initials}
      </div>
      <div>
        <div style={{ fontSize: "13px", fontWeight: 500, color: "var(--color-ink-dark, hsl(var(--foreground)))", lineHeight: 1.3 }}>
          {name ?? "\u2014"}
        </div>
        {subtitle && (
          <div style={{ fontSize: "11px", color: "var(--color-ink-muted, hsl(var(--muted-foreground)))", marginTop: "1px" }}>{subtitle}</div>
        )}
      </div>
    </div>
  )
}

export function renderCurrency(amount?: number, currency = "USD") {
  return (
    <span
      style={{
        fontSize: "13px",
        fontWeight: 600,
        color: "var(--color-ink-dark, hsl(var(--foreground)))",
        fontVariantNumeric: "tabular-nums",
        fontFamily: "ui-monospace, monospace",
      }}
    >
      {new Intl.NumberFormat("en-US", { style: "currency", currency }).format(amount ?? 0)}
    </span>
  )
}

export function renderDate(dateStr?: string) {
  if (!dateStr) return <span style={{ color: "#d1d5db", fontSize: "12px" }}>{"\u2014"}</span>
  const date = new Date(dateStr)
  const now = new Date()
  const diffMs = now.getTime() - date.getTime()
  const diffDays = Math.floor(diffMs / 86400000)

  let label: string
  let textColor: string

  if (diffDays === 0) {
    label = "Today"
    textColor = "#2563eb"
  } else if (diffDays === 1) {
    label = "Yesterday"
    textColor = "#6b7280"
  } else if (diffDays < 0 && diffDays > -7) {
    label = date.toLocaleDateString("en-US", { weekday: "long" })
    textColor = "#059669"
  } else if (diffDays > 0 && diffDays < 7) {
    label = date.toLocaleDateString("en-US", { weekday: "long" })
    textColor = "#6b7280"
  } else {
    label = date.toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })
    textColor = "#9ca3af"
  }

  return (
    <span style={{ fontSize: "12px", color: textColor, fontWeight: diffDays === 0 ? 600 : 400 }}>
      {label}
    </span>
  )
}

export function renderProgress(value: number, max = 100, label?: string) {
  const pct = Math.min(100, Math.round((value / max) * 100))
  return (
    <div style={{ display: "flex", flexDirection: "column", gap: "4px" }}>
      <div style={{ display: "flex", justifyContent: "space-between" }}>
        {label && <span style={{ fontSize: "11px", color: "var(--color-ink-muted, hsl(var(--muted-foreground)))" }}>{label}</span>}
        <span style={{ fontSize: "11px", fontWeight: 500, color: "var(--color-ink-dark, hsl(var(--foreground)))" }}>
          {value}/{max}
        </span>
      </div>
      <div
        style={{
          height: "6px",
          backgroundColor: "#f1f5f9",
          borderRadius: "9999px",
          overflow: "hidden",
          width: "80px",
        }}
      >
        <div
          style={{
            width: pct + "%",
            height: "100%",
            background: "var(--color-primary)",
            borderRadius: "9999px",
            transition: "width 500ms ease",
          }}
        />
      </div>
    </div>
  )
}
