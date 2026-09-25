import { FormEvent, useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Teacher } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { toArray } from "./response";

export default function TeacherAnnouncements() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const qc = useQueryClient();

  const { data: classesData } = useQuery({ queryKey: ["teacher-classes"], queryFn: Teacher.classes });
  const { data: announcements, isLoading } = useQuery({
    queryKey: ["teacher-announcements"],
    queryFn: () => Teacher.getAnnouncements(),
  });

  const [classRoomId, setClassRoomId] = useState<number | "">("");
  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");
  const [showForm, setShowForm] = useState(false);

  const mutation = useMutation({
    mutationFn: (data: { class_room_id: number; title: string; body: string }) => Teacher.announce(data),
    onSuccess: () => {
      toast({ title: t("teacherPages.success"), description: t("teacherPages.announcementPosted") });
      setTitle("");
      setBody("");
      setClassRoomId("");
      setShowForm(false);
      void qc.invalidateQueries({ queryKey: ["teacher-announcements"] });
    },
    onError: () => toast({ title: t("teacherPages.error"), description: t("teacherPages.announcementFailed"), variant: "destructive" }),
  });

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    if (!classRoomId || !title.trim() || !body.trim()) return;
    mutation.mutate({ class_room_id: classRoomId, title: title.trim(), body: body.trim() });
  };

  const classes = toArray(classesData);
  const items = toArray(announcements);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.announcements")}</h1>
        <button
          onClick={() => setShowForm(!showForm)}
          className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
        >
          {showForm ? t("teacherPages.cancel") : "+ New Announcement"}
        </button>
      </div>

      {showForm && (
        <form onSubmit={handleSubmit} className="space-y-4 rounded-lg border p-6 bg-card max-w-xl">
          <h2 className="text-lg font-semibold">{t("teacherPages.createAnnouncement")}</h2>

          <div className="space-y-2">
            <label htmlFor="announcement-class" className="text-sm font-medium">{t("teacherPages.class")}</label>
            <select
              id="announcement-class"
              className="w-full rounded-md border bg-background px-3 py-2 text-sm"
              value={classRoomId}
              onChange={(e) => setClassRoomId(Number(e.target.value) || "")}
            >
              <option value="">{t("teacherPages.selectClass")}</option>
              {classes.map((c: any) => (
                <option key={c.id} value={c.id}>{c.name} - {c.grade}{c.section ? ` ${c.section}` : ""}</option>
              ))}
            </select>
          </div>

          <div className="space-y-2">
            <label htmlFor="announcement-title" className="text-sm font-medium">{t("teacherPages.title")}</label>
            <input
              id="announcement-title"
              className="w-full rounded-md border bg-background px-3 py-2 text-sm"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder={t("teacherPages.announcementTitlePlaceholder")}
            />
          </div>

          <div className="space-y-2">
            <label htmlFor="announcement-body" className="text-sm font-medium">Body</label>
            <textarea
              id="announcement-body"
              className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[100px]"
              value={body}
              onChange={(e) => setBody(e.target.value)}
              placeholder={t("teacherPages.announcementBodyPlaceholder")}
            />
          </div>

          <button
            type="submit"
            disabled={mutation.isPending || !classRoomId || !title.trim() || !body.trim()}
            className="w-full rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
          >
            {mutation.isPending ? t("teacherPages.posting") : t("teacherPages.postAnnouncement")}
          </button>
        </form>
      )}

      <div className="space-y-3">
        {isLoading ? (
          <div className="p-8 text-center text-muted-foreground">{t("teacherPages.loadingAnnouncements")}</div>
        ) : items.length === 0 ? (
          <div className="p-8 text-center border rounded-md text-muted-foreground">No announcements yet. Create one above!</div>
        ) : (
          items.map((a: any) => (
            <div key={a.id} className="rounded-lg border p-4 bg-card space-y-1">
              <div className="flex items-center justify-between">
                <h3 className="font-semibold">{a.title}</h3>
                <span className="text-xs text-muted-foreground">{new Date(a.created_at).toLocaleDateString()}</span>
              </div>
              <p className="text-sm text-muted-foreground">{a.body}</p>
              {a.audience && <span className="inline-block text-xs bg-secondary text-secondary-foreground px-2 py-0.5 rounded-full">{a.audience}</span>}
            </div>
          ))
        )}
      </div>
    </div>
  );
}
