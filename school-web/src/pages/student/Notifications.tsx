import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Messaging, apiFetch } from "@/lib/api";
import { renderDate } from "@/lib/tableHelpers";
import PageHeader from "@/components/ui/PageHeader";
import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import BrandEmptyState from "@/components/ui/BrandEmptyState";
import { useToast } from "@/hooks/use-toast";

type Filter = "all" | "unread" | "read";

const TYPE_STYLES: Record<string, { bg: string; icon: string }> = {
  grade: { bg: "bg-blue-100", icon: "G" },
  attendance: { bg: "bg-green-100", icon: "A" },
  payment: { bg: "bg-amber-100", icon: "P" },
  announcement: { bg: "bg-purple-100", icon: "N" },
  leave: { bg: "bg-red-100", icon: "L" },
};

function typeStyle(type?: string) {
  return TYPE_STYLES[type ?? ""] ?? { bg: "bg-muted/50", icon: "N" };
}

const FILTER_TABS: { key: Filter; label: string }[] = [
  { key: "all", label: "All" },
  { key: "unread", label: "Unread" },
  { key: "read", label: "Read" },
];

const EMPTY_MSG: Record<Filter, { title: string; subtitle: string }> = {
  all: { title: "No notifications", subtitle: "You're all caught up!" },
  unread: { title: "No unread notifications", subtitle: "You're all caught up!" },
  read: { title: "No read notifications yet", subtitle: "Mark some as read to see them here." },
};

export default function StudentNotifications() {
  const { toast } = useToast();
  const qc = useQueryClient();
  const [filter, setFilter] = useState<Filter>("all");

  const { data: list, isLoading } = useQuery({
    queryKey: ["notifications", filter],
    queryFn: () => {
      const params: Record<string, any> = {};
      if (filter !== "all") params.is_read = filter === "read";
      return apiFetch("/notifications", { query: params });
    },
  }) as any;
  const markAllRead = useMutation({
    mutationFn: () => Messaging.markAllRead(),
    onSuccess: () => {
      void qc.invalidateQueries({ queryKey: ["notifications"] });
      toast({ title: "All marked as read" });
    },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.message }),
  });

  const markRead = useMutation({
    mutationFn: (id: number) => Messaging.markRead(id),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["notifications"] }),
  });

  const notifications = Array.isArray(list) ? list : list?.data ?? [];

  if (isLoading) {
    return (
      <div className="space-y-6">
        <PageHeader icon="UI" title="Notifications" subtitle="Your alerts and updates" />
        <div className="space-y-3">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="flex items-start gap-4 p-4 animate-pulse">
              <div className="w-10 h-10 rounded-full bg-muted/50" />
              <div className="flex-1 space-y-2">
                <div className="w-48 h-4 bg-muted/50 rounded" />
                <div className="w-32 h-3 bg-muted/30 rounded" />
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <PageHeader
        icon="UI"
        title="Notifications"
        subtitle="Your alerts and updates"
        actions={
          <BrandButton variant="ghost" size="sm" onClick={() => markAllRead.mutate()}>
            Mark All Read
          </BrandButton>
        }
      />

      <div className="flex gap-2">
        {FILTER_TABS.map((tab) => (
          <button
            key={tab.key}
            onClick={() => setFilter(tab.key)}
            className={`px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all duration-150 ${
              filter === tab.key ? "text-white" : "bg-muted/50 text-muted-foreground hover:bg-gray-200"
            }`}
            style={filter === tab.key ? { background: "var(--gradient-main)" } : undefined}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {notifications.length === 0 ? (
        <BrandEmptyState icon="UI" title={EMPTY_MSG[filter].title} subtitle={EMPTY_MSG[filter].subtitle} />
      ) : (
        <div className="flex flex-col gap-2">
          {notifications.map((n: any) => {
            const ts = typeStyle(n.type);
            return (
              <BrandCard
                key={n.id}
                className={n.is_read ? "bg-muted/30/50" : ""}
                onClick={() => {
                  if (!n.is_read) markRead.mutate(n.id);
                  if (n.action_url) window.location.href = n.action_url;
                }}
              >
                <div className="flex items-start gap-4 p-4">
                  <div className={`w-10 h-10 rounded-full flex items-center justify-center text-lg flex-shrink-0 ${ts.bg}`}>
                    {ts.icon}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between gap-2">
                      <span className={`text-sm ${n.is_read ? "font-normal text-muted-foreground" : "font-semibold text-foreground"}`}>
                        {n.title}
                      </span>
                      <span className="text-xs text-muted-foreground/70 flex-shrink-0">{renderDate(n.created_at)}</span>
                    </div>
                    <p className="text-sm text-muted-foreground mt-1 line-clamp-2">{n.body ?? n.message}</p>
                    {n.action_url && (
                      <p className="text-xs font-medium mt-2" style={{ color: "var(--color-primary)" }}>View details</p>
                    )}
                  </div>
                  {!n.is_read && (
                    <div className="w-2 h-2 rounded-full flex-shrink-0 mt-1.5" style={{ background: "var(--color-primary)" }} />
                  )}
                </div>
              </BrandCard>
            );
          })}
        </div>
      )}
    </div>
  );
}

