import BrandCard from "@/components/ui/BrandCard";
import { useEffect, useMemo, useRef, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { format } from "date-fns";
import { Inbox, MessageSquare, Plus, Search, Send } from "lucide-react";
import { useTranslation } from "react-i18next";
import { mediaUrl, Messaging } from "@/lib/api";
import { toast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import BrandButton from "@/components/ui/BrandButton";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
type MessageUser = {
  id: number;
  name: string;
  email?: string;
  role?: string;
  photo_path?: string | null;
};
type Thread = {
  id: number;
  other_user?: MessageUser | null;
  last_message?: {
    body: string;
    created_at?: string;
  };
  unread_count?: number;
};
type MessageItem = {
  id: number;
  body: string;
  created_at?: string;
  is_mine?: boolean;
};
function asArray<T>(payload: unknown): T[] {
  if (Array.isArray(payload)) return payload as T[];
  if (Array.isArray((payload as any)?.data)) return (payload as any).data as T[];
  return [];
}
function initials(name?: string) {
  return (name || "?").split(" ").filter(Boolean).slice(0, 2).map(part => part[0]?.toUpperCase()).join("") || "?";
}
function formatDate(value?: string) {
  if (!value) return "";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "";
  return format(date, "MMM d");
}
function UserAvatar({
  user,
  className
}: {
  user?: MessageUser | null;
  className?: string;
}) {
  return <Avatar className={cn("h-10 w-10", className)}>
      <AvatarImage src={mediaUrl(user?.photo_path)} />
      <AvatarFallback>{initials(user?.name)}</AvatarFallback>
    </Avatar>;
}
export default function Messages() {
  const {
    t
  } = useTranslation();
  const queryClient = useQueryClient();
  const bottomRef = useRef<HTMLDivElement | null>(null);
  const [activeUser, setActiveUser] = useState<MessageUser | null>(null);
  const [recipientSearch, setRecipientSearch] = useState("");
  const [body, setBody] = useState("");
  const [showRecipients, setShowRecipients] = useState(false);
  const {
    data: threadsData,
    isLoading: threadsLoading
  } = useQuery({
    queryKey: ["messages", "threads"],
    queryFn: Messaging.threads
  });
  const {
    data: recipientsData,
    isLoading: recipientsLoading
  } = useQuery({
    queryKey: ["messages", "recipients", recipientSearch],
    queryFn: () => Messaging.recipients(recipientSearch)
  });
  const threads = asArray<Thread>(threadsData);
  const recipients = asArray<MessageUser>(recipientsData);
  const {
    data: conversationData,
    isLoading: conversationLoading
  } = useQuery({
    queryKey: ["messages", "conversation", activeUser?.id],
    queryFn: () => Messaging.conversation(activeUser!.id),
    enabled: !!activeUser?.id
  });
  const conversation = asArray<MessageItem>(conversationData);
  const sendMessage = useMutation({
    mutationFn: () => {
      if (!activeUser) throw new Error("Choose a recipient first.");
      const trimmed = body.trim();
      if (!trimmed) throw new Error("Message cannot be empty.");
      return Messaging.send({
        recipient_user_id: activeUser.id,
        body: trimmed
      });
    },
    onSuccess: async () => {
      setBody("");
      setShowRecipients(false);
      await Promise.all([queryClient.invalidateQueries({
        queryKey: ["messages", "threads"]
      }), queryClient.invalidateQueries({
        queryKey: ["messages", "conversation", activeUser?.id]
      }), queryClient.invalidateQueries({
        queryKey: ["unread-count"]
      })]);
    },
    onError: (error: any) => {
      toast({
        title: "Message not sent",
        description: error?.message || "Please check the recipient and try again.",
        variant: "destructive"
      });
    }
  });
  const activeThreadId = activeUser?.id;
  const sortedRecipients = useMemo(() => {
    const threadUserIds = new Set(threads.map(thread => thread.other_user?.id).filter(Boolean));
    return recipients.filter(recipient => !threadUserIds.has(recipient.id));
  }, [recipients, threads]);
  useEffect(() => {
    bottomRef.current?.scrollIntoView({
      behavior: "smooth",
      block: "end"
    });
  }, [conversation.length, activeUser?.id]);
  const chooseUser = (user?: MessageUser | null) => {
    if (!user) return;
    setActiveUser(user);
    setShowRecipients(false);
  };
  return <div className="space-y-6">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.messages")}</h1>
        <BrandButton leftIcon={<Plus className="h-4 w-4" />} onClick={() => setShowRecipients(value => !value)}>
          New message
        </BrandButton>
      </div>

      <div className="grid gap-6 lg:grid-cols-[340px_minmax(0,1fr)]">
        <BrandCard className="flex min-h-[640px] flex-col overflow-hidden shadow-academic border-surface-border">
          <div className="border-b bg-muted/30 p-4">
            <div className="mb-3 flex items-center gap-2 font-semibold">
              <Inbox className="h-4 w-4" />
              Inbox
            </div>
            <div className="relative">
              <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
              <Input value={recipientSearch} onChange={event => {
              setRecipientSearch(event.target.value);
              setShowRecipients(true);
            }} placeholder="Search people" className="pl-9" />
            </div>
          </div>

          {showRecipients && <div className="max-h-60 overflow-auto border-b bg-background">
              <div className="px-4 py-2 text-xs font-semibold uppercase tracking-wide text-muted-foreground">
                Start conversation
              </div>
              {recipientsLoading ? <div className="p-4 text-sm text-muted-foreground">{t("common.loading")}</div> : sortedRecipients.length === 0 ? <div className="p-4 text-sm text-muted-foreground">No available recipients</div> : sortedRecipients.map(recipient => <button key={recipient.id} type="button" onClick={() => chooseUser(recipient)} className="flex w-full items-center gap-3 px-4 py-3 text-left transition-colors hover:bg-muted/60">
                    <UserAvatar user={recipient} />
                    <div className="min-w-0">
                      <div className="truncate text-sm font-medium">{recipient.name}</div>
                      <div className="truncate text-xs capitalize text-muted-foreground">{recipient.role}</div>
                    </div>
                  </button>)}
            </div>}

          <div className="flex-1 overflow-auto">
            {threadsLoading ? <div className="p-8 text-center text-sm">{t("common.loading")}</div> : threads.length === 0 ? <div className="p-8 text-center text-sm text-muted-foreground">
                No conversations yet. Start a new message.
              </div> : threads.map(thread => {
            const user = thread.other_user;
            const active = user?.id === activeThreadId;
            return <button key={thread.id} type="button" onClick={() => chooseUser(user)} className={cn("flex w-full cursor-pointer gap-3 border-b p-4 text-left transition-colors hover:bg-muted/50", active && "bg-muted")}>
                    <UserAvatar user={user} />
                    <div className="min-w-0 flex-1">
                      <div className="mb-1 flex items-baseline justify-between">
                        <div className="truncate text-sm font-medium">{user?.name || "Unknown User"}</div>
                        <div className="ms-2 whitespace-nowrap text-xs text-muted-foreground">
                          {formatDate(thread.last_message?.created_at)}
                        </div>
                      </div>
                      <div className="truncate text-xs text-muted-foreground">
                        {thread.last_message?.body || "No messages"}
                      </div>
                    </div>
                    {!!thread.unread_count && <span className="mt-1 rounded-full bg-brand-purple px-2 py-0.5 text-xs font-semibold text-white">
                        {thread.unread_count}
                      </span>}
                  </button>;
          })}
          </div>
        </BrandCard>

        <BrandCard className="flex min-h-[640px] flex-col overflow-hidden shadow-academic border-surface-border">
          {activeUser ? <>
              <div className="flex items-center gap-3 border-b bg-muted/30 p-4">
                <UserAvatar user={activeUser} />
                <div className="min-w-0">
                  <div className="truncate font-semibold">{activeUser.name}</div>
                  <div className="truncate text-xs capitalize text-muted-foreground">{activeUser.role}</div>
                </div>
              </div>

              <div className="flex-1 overflow-auto bg-muted/10 p-4">
                {conversationLoading ? <div className="p-8 text-center text-sm text-muted-foreground">{t("common.loading")}</div> : conversation.length === 0 ? <div className="flex h-full items-center justify-center text-sm text-muted-foreground">
                    Send the first message to {activeUser.name}.
                  </div> : <div className="space-y-3">
                    {conversation.map(message => <div key={message.id} className={cn("flex", message.is_mine ? "justify-end" : "justify-start")}>
                        <div className={cn("max-w-[80%] rounded-2xl px-4 py-2 text-sm shadow-sm", message.is_mine ? "bg-brand-purple text-white" : "border border-surface-border bg-background text-foreground")}>
                          <div className="whitespace-pre-wrap break-words">{message.body}</div>
                          <div className={cn("mt-1 text-[11px]", message.is_mine ? "text-white/70" : "text-muted-foreground")}>
                            {formatDate(message.created_at)}
                          </div>
                        </div>
                      </div>)}
                    <div ref={bottomRef} />
                  </div>}
              </div>

              <form className="border-t bg-background p-4" onSubmit={event => {
            event.preventDefault();
            sendMessage.mutate();
          }}>
                <div className="flex flex-col gap-3 sm:flex-row sm:items-end">
                  <Textarea value={body} onChange={event => setBody(event.target.value)} placeholder="Type your message" className="min-h-[76px] flex-1 resize-none" onKeyDown={event => {
                if (event.key === "Enter" && (event.ctrlKey || event.metaKey)) {
                  event.preventDefault();
                  sendMessage.mutate();
                }
              }} />
                  <BrandButton type="submit" isLoading={sendMessage.isPending} disabled={!body.trim()} leftIcon={<Send className="h-4 w-4" />} className="sm:h-[76px]">
                    Send
                  </BrandButton>
                </div>
              </form>
            </> : <div className="flex h-full flex-col items-center justify-center gap-4 p-8 text-center text-muted-foreground">
              <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-muted">
                <MessageSquare className="h-7 w-7" />
              </div>
              <div>
                <div className="font-semibold text-foreground">Select a conversation</div>
                <div className="mt-1 text-sm">Choose a thread or start a new message.</div>
              </div>
              <BrandButton variant="secondary" leftIcon={<Plus className="h-4 w-4" />} onClick={() => setShowRecipients(true)}>
                New message
              </BrandButton>
            </div>}
        </BrandCard>
      </div>
    </div>;
}