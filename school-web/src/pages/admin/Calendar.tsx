import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { CalendarDays, Plus, Pencil, Trash2 } from "lucide-react";
import { format } from "date-fns";

const TYPES = ["event", "holiday", "exam", "semester_start", "semester_end"] as const;
const EMPTY = { title: "", description: "", type: "event" as (typeof TYPES)[number], start_date: "", end_date: "" };

export default function AdminCalendar() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [form, setForm] = useState({ ...EMPTY });

  const { data, isLoading } = useQuery({ queryKey: ["admin", "calendar"], queryFn: Admin.calendar }) as any;
  const events = Array.isArray(data) ? data : data?.data ?? [];

  const reset = () => { setForm({ ...EMPTY }); setEditingId(null); };
  const invalidate = () => void qc.invalidateQueries({ queryKey: ["admin", "calendar"] });

  const save = useMutation({
    mutationFn: (body: any) => {
      const payload = {
        title: body.title,
        description: body.description || undefined,
        type: body.type,
        start_date: body.start_date,
        end_date: body.end_date || undefined,
      };
      return editingId ? Admin.updateCalendarEvent(editingId, payload) : Admin.createCalendarEvent(payload);
    },
    onSuccess: () => { invalidate(); toast({ title: editingId ? "Event updated" : "Event created" }); setOpen(false); reset(); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const remove = useMutation({
    mutationFn: (id: number) => Admin.deleteCalendarEvent(id),
    onSuccess: () => { invalidate(); toast({ title: "Event deleted" }); },
    onError: (e: any) => toast({ variant: "destructive", title: "Failed", description: e?.data?.message ?? e?.message }),
  });

  const openCreate = () => { reset(); setOpen(true); };
  const openEdit = (ev: any) => {
    setEditingId(ev.id);
    setForm({
      title: ev.title ?? "",
      description: ev.description ?? "",
      type: ev.type ?? "event",
      start_date: ev.start_date ? String(ev.start_date).slice(0, 10) : "",
      end_date: ev.end_date ? String(ev.end_date).slice(0, 10) : "",
    });
    setOpen(true);
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.calendar")}</h1>
        <BrandButton onClick={openCreate}><Plus className="me-2 h-4 w-4" />{t("common.create")} Event</BrandButton>
      </div>

      {isLoading ? (
        <div className="p-8 text-center">{t("common.loading")}</div>
      ) : events.length === 0 ? (
        <div className="p-8 text-center border rounded-md text-muted-foreground">{t("common.empty")}</div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {events.map((event: any) => (
            <BrandCard key={event.id}>
              <CardHeader className="pb-2">
                <CardTitle className="text-lg flex items-center gap-2">
                  <CalendarDays className="h-5 w-5 text-primary" />
                  <span className="flex-1">{event.title}</span>
                </CardTitle>
                <CardDescription>
                  {event.start_date ? format(new Date(event.start_date), "MMM d, yyyy") : ""}
                  {event.type ? ` · ${String(event.type).replace(/_/g, " ")}` : ""}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">{event.description}</p>
                <div className="flex gap-2 mt-3">
                  <BrandButton variant="ghost" size="sm" onClick={() => openEdit(event)}><Pencil className="h-3.5 w-3.5 me-1" />{t("common.edit")}</BrandButton>
                  <BrandButton variant="ghost" size="sm" onClick={() => { if (confirm("Delete this event?")) remove.mutate(event.id); }}><Trash2 className="h-3.5 w-3.5 me-1" />{t("common.delete")}</BrandButton>
                </div>
              </CardContent>
            </BrandCard>
          ))}
        </div>
      )}

      <Dialog open={open} onOpenChange={(v) => { setOpen(v); if (!v) reset(); }}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{editingId ? t("common.edit") : t("common.create")} Event</DialogTitle>
            <DialogDescription>Add a holiday, exam window, or school event.</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="cal-title">Title</Label>
              <Input id="cal-title" value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} placeholder="e.g. Mid-term break" />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="cal-type">Type</Label>
              <select id="cal-type" className="w-full rounded-md border bg-background px-3 py-2 text-sm" value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value as (typeof TYPES)[number] })}>
                {TYPES.map((ty) => <option key={ty} value={ty} className="capitalize">{ty.replace(/_/g, " ")}</option>)}
              </select>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-1.5">
                <Label htmlFor="cal-start">Start date</Label>
                <Input id="cal-start" type="date" value={form.start_date} onChange={(e) => setForm({ ...form, start_date: e.target.value })} />
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="cal-end">End date (optional)</Label>
                <Input id="cal-end" type="date" value={form.end_date} onChange={(e) => setForm({ ...form, end_date: e.target.value })} />
              </div>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="cal-desc">Description</Label>
              <Textarea id="cal-desc" rows={3} value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => { setOpen(false); reset(); }}>{t("common.cancel")}</BrandButton>
            <BrandButton onClick={() => save.mutate(form)} disabled={save.isPending || !form.title || !form.start_date}>
              {save.isPending ? t("common.loading") : editingId ? t("common.save") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
