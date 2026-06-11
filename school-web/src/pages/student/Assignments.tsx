import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Student } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Upload } from "lucide-react";
import { format } from "date-fns";
import { useToast } from "@/hooks/use-toast";
export default function StudentAssignments() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState<null | any>(null);
  const [body, setBody] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const {
    data: assignments,
    isLoading
  } = useQuery({
    queryKey: ["student", "assignments"],
    queryFn: Student.assignments
  }) as any;
  const list = Array.isArray(assignments) ? assignments : (assignments as any)?.data || [];
  const submit = useMutation({
    mutationFn: ({
      id,
      contentText,
      file
    }: {
      id: number;
      contentText: string;
      file: File | null;
    }) => Student.submitAssignment(id, contentText, file ?? undefined),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["student", "assignments"]
      });
      toast({
        title: "Submitted"
      });
      setOpen(null);
      setBody("");
      setFile(null);
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Submission failed",
      description: e?.message
    })
  });
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
          {t("nav.assignments")}
        </h1>
      </div>

      {isLoading ? <div className="p-8 text-center">{t("common.loading")}</div> : list.length === 0 ? <div className="p-8 text-center border rounded-md text-muted-foreground">
          {t("common.empty")}
        </div> : <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {list.map((a: any) => <BrandCard key={a.id} className="flex flex-col">
              <CardHeader>
                <div className="flex justify-between items-start mb-2">
                  <Badge variant="outline">{a.subject?.name}</Badge>
                  <Badge variant={a.status === "submitted" ? "default" : "secondary"}>
                    {a.status || t("common.pending")}
                  </Badge>
                </div>
                <CardTitle className="text-xl">{a.title}</CardTitle>
                <CardDescription className="line-clamp-2">
                  {a.instructions ?? a.description}
                </CardDescription>
              </CardHeader>
              <CardContent className="mt-auto pt-4 border-t bg-muted/20">
                <div className="flex items-center justify-between">
                  <div className="text-sm">
                    <span className="text-muted-foreground block text-xs">
                      Due Date
                    </span>
                    <span className="font-medium">
                      {a.due_at ? format(new Date(a.due_at), "MMM d, yyyy") : a.due_date ? format(new Date(a.due_date), "MMM d, yyyy") : "No Date"}
                    </span>
                  </div>
                  <BrandButton size="sm" variant={a.status === "submitted" ? "outline" : "primary"} onClick={() => setOpen(a)}>
                    <Upload className="me-2 h-4 w-4" />
                    {a.status === "submitted" ? "Resubmit" : "Submit"}
                  </BrandButton>
                </div>
              </CardContent>
            </BrandCard>)}
        </div>}

      <Dialog open={!!open} onOpenChange={o => !o && setOpen(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Submit assignment</DialogTitle>
            <DialogDescription>{open?.title}</DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="body">Notes</Label>
              <Textarea id="body" value={body} onChange={e => setBody(e.target.value)} rows={4} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="file">Attachment</Label>
              <Input id="file" type="file" onChange={e => setFile(e.target.files?.[0] ?? null)} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setOpen(null)}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton onClick={() => open && submit.mutate({
            id: open.id,
            contentText: body,
            file
          })} disabled={submit.isPending || !body && !file}>
              {submit.isPending ? t("common.loading") : "Submit"}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}