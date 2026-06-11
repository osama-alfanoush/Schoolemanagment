import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useMutation } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Plus, Megaphone, Send } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
const AUDIENCES = ["all", "students", "parents", "teachers", "staff"] as const;
export default function AdminAnnouncements() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [open, setOpen] = useState(false);
  const [form, setForm] = useState({
    title: "",
    body: "",
    audience: "all" as (typeof AUDIENCES)[number]
  });
  const announce = useMutation({
    mutationFn: (data: any) => Admin.announce(data),
    onSuccess: () => {
      toast({
        title: "Announcement sent"
      });
      setForm({
        title: "",
        body: "",
        audience: "all"
      });
      setOpen(false);
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed to send",
      description: e?.message ?? "Please try again."
    })
  });
  return <div className="space-y-6 max-w-4xl mx-auto">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.announcements")}</h1>
        <BrandButton onClick={() => setOpen(v => !v)}>
          <Plus className="me-2 h-4 w-4" />
          {open ? t("common.cancel") : t("common.create")}
        </BrandButton>
      </div>

      {open && <BrandCard className="shadow-academic border-surface-border">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Megaphone className="h-5 w-5" /> New announcement
            </CardTitle>
            <CardDescription>
              Broadcast a message to a chosen audience across the school.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="title">Title</Label>
              <Input id="title" value={form.title} onChange={e => setForm({
            ...form,
            title: e.target.value
          })} placeholder="e.g. Parent–teacher meeting on Friday" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="body">Message</Label>
              <Textarea id="body" rows={5} value={form.body} onChange={e => setForm({
            ...form,
            body: e.target.value
          })} placeholder="Write the announcement…" />
            </div>
            <div className="space-y-2">
              <Label>Audience</Label>
              <div className="flex flex-wrap gap-2">
                {AUDIENCES.map(a => <Badge key={a} variant={form.audience === a ? "default" : "outline"} className="cursor-pointer capitalize px-3 py-1" onClick={() => setForm({
              ...form,
              audience: a
            })}>
                    {a}
                  </Badge>)}
              </div>
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <BrandButton variant="outline" onClick={() => setOpen(false)}>
                {t("common.cancel")}
              </BrandButton>
              <BrandButton onClick={() => announce.mutate(form)} disabled={!form.title.trim() || !form.body.trim() || announce.isPending}>
                <Send className="h-4 w-4 me-2" />
                {announce.isPending ? t("common.loading") : "Send"}
              </BrandButton>
            </div>
          </CardContent>
        </BrandCard>}

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle className="text-base">Recent broadcasts</CardTitle>
          <CardDescription>
            Sent announcements appear in each recipient's portal under
            Announcements. Use the form above to publish a new one.
          </CardDescription>
        </CardHeader>
      </BrandCard>
    </div>;
}