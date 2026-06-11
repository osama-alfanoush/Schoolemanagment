import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query"
import { formatDistanceToNow } from "date-fns"
import { Bell, CheckCheck, Loader2 } from "lucide-react"
import { useLocation } from "wouter"
import { Button } from "@/components/ui/button"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { Messaging, Role, apiFetch } from "@/lib/api"
import { toArray } from "@/lib/response"
import { cn } from "@/lib/utils"

interface NotificationItem {
  id: number
  title?: string | null
  body?: string | null
  message?: string | null
  type?: string | null
  priority?: string | null
  action_url?: string | null
  read_at?: string | null
  is_read?: boolean
  created_at?: string | null
}

interface UnreadCount {
  total_unread?: number
  high_priority_unread?: number
  notifications?: number
  messages?: number
}

interface NotificationBellProps {
  role: Role
  className?: string
}

function unreadTotal(data?: UnreadCount): number {
  return data?.total_unread ?? data?.notifications ?? 0
}

function notificationPath(role: Role): string {
  return `/${role}/notifications`
}

function isRead(notification: NotificationItem): boolean {
  return notification.is_read ?? Boolean(notification.read_at)
}

function relativeTime(value?: string | null): string {
  if (!value) return ""
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return ""
  return formatDistanceToNow(date, { addSuffix: true })
}

export default function NotificationBell({ role, className }: NotificationBellProps) {
  const [, setLocation] = useLocation()
  const queryClient = useQueryClient()

  const unreadQuery = useQuery({
    queryKey: ["unread-count"],
    queryFn: Messaging.unreadCount,
    refetchInterval: 30000,
  }) as { data?: UnreadCount }

  const notificationsQuery = useQuery({
    queryKey: ["notifications", "preview"],
    queryFn: () => apiFetch("/notifications", { query: { per_page: 6 } }),
    staleTime: 15000,
  })

  const markRead = useMutation({
    mutationFn: (id: number) => Messaging.markRead(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["notifications"] })
      queryClient.invalidateQueries({ queryKey: ["unread-count"] })
    },
  })

  const markClicked = useMutation({
    mutationFn: (id: number) => Messaging.markAsClicked(id),
  })

  const markAllRead = useMutation({
    mutationFn: Messaging.markAllRead,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["notifications"] })
      queryClient.invalidateQueries({ queryKey: ["unread-count"] })
    },
  })

  const notifications = toArray<NotificationItem>(notificationsQuery.data)
  const count = unreadTotal(unreadQuery.data)

  const openNotification = async (notification: NotificationItem) => {
    if (!isRead(notification)) {
      markRead.mutate(notification.id)
    }
    markClicked.mutate(notification.id)

    const actionUrl = notification.action_url
    if (!actionUrl) return

    if (actionUrl.startsWith("/")) {
      setLocation(actionUrl)
    } else {
      window.location.href = actionUrl
    }
  }

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" size="icon" className={cn("relative", className)} aria-label="Notifications">
          <Bell className="h-5 w-5" />
          {count > 0 && (
            <span className="absolute -top-0.5 -end-0.5 flex min-h-4 min-w-4 items-center justify-center rounded-full bg-destructive px-1 text-[10px] font-bold leading-none text-destructive-foreground">
              {count > 99 ? "99+" : count}
            </span>
          )}
        </Button>
      </DropdownMenuTrigger>

      <DropdownMenuContent align="end" className="w-80 p-0">
        <div className="flex items-center justify-between px-4 py-3">
          <div>
            <p className="text-sm font-semibold">Notifications</p>
            <p className="text-xs text-muted-foreground">
              {count > 0 ? `${count} unread` : "You're all caught up"}
            </p>
          </div>
          <Button
            type="button"
            variant="ghost"
            size="sm"
            onClick={() => markAllRead.mutate()}
            disabled={count === 0 || markAllRead.isPending}
            className="h-8 px-2 text-xs"
          >
            {markAllRead.isPending ? <Loader2 className="h-3.5 w-3.5 animate-spin" /> : <CheckCheck className="h-3.5 w-3.5" />}
            Mark all
          </Button>
        </div>

        <DropdownMenuSeparator className="m-0" />

        <div className="max-h-80 overflow-y-auto p-1">
          {notificationsQuery.isLoading ? (
            <div className="flex items-center justify-center gap-2 px-4 py-8 text-sm text-muted-foreground">
              <Loader2 className="h-4 w-4 animate-spin" />
              Loading notifications
            </div>
          ) : notifications.length === 0 ? (
            <div className="px-4 py-8 text-center">
              <p className="text-sm font-medium">No notifications</p>
              <p className="mt-1 text-xs text-muted-foreground">New updates will appear here.</p>
            </div>
          ) : (
            notifications.map((notification) => {
              const read = isRead(notification)
              return (
                <button
                  key={notification.id}
                  type="button"
                  onClick={() => openNotification(notification)}
                  className={cn(
                    "flex w-full gap-3 rounded-md px-3 py-2.5 text-left transition-colors hover:bg-muted",
                    !read && "bg-primary/5",
                  )}
                >
                  <span
                    className={cn(
                      "mt-1 h-2.5 w-2.5 shrink-0 rounded-full",
                      read ? "bg-muted-foreground/30" : "bg-primary",
                    )}
                  />
                  <span className="min-w-0 flex-1">
                    <span className={cn("block truncate text-sm", read ? "font-medium" : "font-semibold")}>
                      {notification.title || "Notification"}
                    </span>
                    <span className="mt-0.5 block line-clamp-2 text-xs text-muted-foreground">
                      {notification.body || notification.message || "No details provided."}
                    </span>
                    <span className="mt-1 block text-[11px] text-muted-foreground">
                      {relativeTime(notification.created_at)}
                    </span>
                  </span>
                </button>
              )
            })
          )}
        </div>

        <DropdownMenuSeparator className="m-0" />

        <button
          type="button"
          onClick={() => setLocation(notificationPath(role))}
          className="w-full px-4 py-3 text-center text-sm font-medium text-primary transition-colors hover:bg-muted"
        >
          View all notifications
        </button>
      </DropdownMenuContent>
    </DropdownMenu>
  )
}
