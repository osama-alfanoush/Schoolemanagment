import BrandButton from "@/components/ui/BrandButton";
import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { format } from "date-fns";
import { useToast } from "@/hooks/use-toast";
export default function AdminHrRequests() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [open, setOpen] = useState<null | any>(null);
  const [response, setResponse] = useState("");
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["admin", "hr-requests"],
    queryFn: Admin.hrRequests
  }) as any;
  const requests = Array.isArray(data) ? data : (data as any)?.data || [];
  const review = useMutation({
    mutationFn: ({
      id,
      status
    }: {
      id: number;
      status: "approved" | "rejected";
    }) => Admin.reviewHrRequest(id, status, response),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["admin", "hr-requests"]
      });
      toast({
        title: "Request reviewed"
      });
      setOpen(null);
      setResponse("");
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Review failed",
      description: e?.message
    })
  });
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
        {t("nav.hrRequests")}
      </h1>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Staff Member</TableHead>
              <TableHead>Type</TableHead>
              <TableHead>Dates</TableHead>
              <TableHead>Reason</TableHead>
              <TableHead>{t("common.status")}</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? <TableRow>
                <TableCell colSpan={6} className="text-center p-8">
                  {t("common.loading")}
                </TableCell>
              </TableRow> : requests.length === 0 ? <TableRow>
                <TableCell colSpan={6} className="text-center p-8 text-muted-foreground">
                  {t("common.empty")}
                </TableCell>
              </TableRow> : requests.map((req: any) => {
            const startDate = req.start_date ?? req.from_date;
            const endDate = req.end_date ?? req.to_date;
            const days = req.days ?? (startDate && endDate ? Math.max(1, Math.round((new Date(endDate).getTime() - new Date(startDate).getTime()) / (1000 * 60 * 60 * 24)) + 1) : null);
            return <TableRow key={req.id}>
                  <TableCell className="font-medium">
                    {req.teacher?.name ?? req.staff?.name ?? "Unknown"}
                  </TableCell>
                  <TableCell className="capitalize">{req.type}</TableCell>
                  <TableCell>
                    {startDate ? format(new Date(startDate), "MMM d") : ""}{" "}
                    -{" "}
                    {endDate ? format(new Date(endDate), "MMM d, yyyy") : ""}
                    {days !== null && <span className="text-muted-foreground text-xs block">
                        {days} days
                      </span>}
                  </TableCell>
                  <TableCell className="max-w-[200px] truncate" title={req.reason}>
                    {req.subject ? <span className="font-medium">{req.subject}: </span> : null}
                    {req.reason}
                  </TableCell>
                  <TableCell>
                    <Badge variant={req.status === "approved" ? "default" : req.status === "rejected" ? "destructive" : "secondary"} className="capitalize">
                      {req.status}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-right">
                    <BrandButton variant="outline" size="sm" disabled={req.status !== "pending"} onClick={() => setOpen(req)}>
                      Review
                    </BrandButton>
                  </TableCell>
                </TableRow>;
          })}
          </TableBody>
        </Table>
      </div>

      <Dialog open={!!open} onOpenChange={o => !o && setOpen(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Review HR request</DialogTitle>
            <DialogDescription>
              {open ? `${open.teacher?.name ?? open.staff?.name ?? ""} · ${open.type}${open.subject ? " · " + open.subject : ""}` : ""}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="resp">Response (optional)</Label>
              <Textarea id="resp" value={response} onChange={e => setResponse(e.target.value)} rows={3} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="destructive" onClick={() => open && review.mutate({
            id: open.id,
            status: "rejected"
          })} disabled={review.isPending}>
              Reject
            </BrandButton>
            <BrandButton onClick={() => open && review.mutate({
            id: open.id,
            status: "approved"
          })} disabled={review.isPending}>
              Approve
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}
