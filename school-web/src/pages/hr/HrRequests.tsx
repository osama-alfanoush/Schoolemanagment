import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { format } from "date-fns";
import { Badge } from "@/components/ui/badge";
import BrandButton from "@/components/ui/BrandButton";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import { Hr } from "@/lib/api";
import { toArray } from "@/lib/response";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";

function formatDate(value?: string | null) {
  if (!value) return "";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "";
  return format(date, "MMM d, yyyy");
}

function daysBetween(start?: string | null, end?: string | null) {
  if (!start || !end) return null;
  const startTime = new Date(start).getTime();
  const endTime = new Date(end).getTime();
  if (Number.isNaN(startTime) || Number.isNaN(endTime)) return null;
  return Math.max(1, Math.round((endTime - startTime) / (1000 * 60 * 60 * 24)) + 1);
}

export default function HrRequests() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [open, setOpen] = useState<any>(null);
  const [response, setResponse] = useState("");

  const { data, isLoading } = useQuery({
    queryKey: ["hr", "requests"],
    queryFn: () => Hr.requests(),
  }) as any;

  const review = useMutation({
    mutationFn: ({ id, status }: { id: number; status: "approved" | "rejected" }) =>
      Hr.reviewRequest(id, status, response.trim() || undefined),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ["hr", "requests"] });
      void queryClient.invalidateQueries({ queryKey: ["hr", "leave-requests"] });
      toast({ title: t("hrPages.requestReviewed") });
      setOpen(null);
      setResponse("");
    },
    onError: (error: any) => {
      toast({
        title: t("hrPages.reviewFailed"),
        description: error?.message || t("hrPages.tryAgain"),
        variant: "destructive",
      });
    },
  });

  const requests = toArray(data);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
          {t("nav.hrRequests")}
        </h1>
      </div>

      <div>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>{t("hrPages.requester")}</TableHead>
              <TableHead>{t("warehouse.type")}</TableHead>
              <TableHead>{t("teacherPages.subject")}</TableHead>
              <TableHead>{t("hrPages.duration")}</TableHead>
              <TableHead>{t("hrPages.reason")}</TableHead>
              <TableHead>{t("common.status")}</TableHead>
              <TableHead className="text-right">{t("common.actions")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {isLoading ? (
              <TableRow>
                <TableCell colSpan={7} className="p-8 text-center">
                  {t("common.loading")}
                </TableCell>
              </TableRow>
            ) : requests.length === 0 ? (
              <TableRow>
                <TableCell colSpan={7} className="p-8 text-center text-muted-foreground">
                  {t("common.empty")}
                </TableCell>
              </TableRow>
            ) : (
              requests.map((req: any) => {
                const requester = req.requester ?? req.teacher ?? req.staff;
                const startDate = req.start_date ?? req.from_date;
                const endDate = req.end_date ?? req.to_date;
                const days = req.days ?? daysBetween(startDate, endDate);

                return (
                  <TableRow key={req.id}>
                    <TableCell>
                      <div className="font-medium">{requester?.name ?? t("hrPages.unknown")}</div>
                      {requester?.role && (
                        <div className="text-xs capitalize text-muted-foreground">
                          {requester.role}
                        </div>
                      )}
                    </TableCell>
                    <TableCell className="capitalize">
                      {String(req.type || "").replaceAll("_", " ")}
                    </TableCell>
                    <TableCell className="max-w-[160px] truncate" title={req.subject}>
                      {req.subject || "—"}
                    </TableCell>
                    <TableCell>
                      {startDate || endDate ? (
                        <>
                          {formatDate(startDate)} - {formatDate(endDate)}
                          {days !== null && (
                            <span className="ms-2 text-xs text-muted-foreground">
                              ({days} days)
                            </span>
                          )}
                        </>
                      ) : (
                        <span className="text-muted-foreground">—</span>
                      )}
                    </TableCell>
                    <TableCell className="max-w-[200px] truncate" title={req.reason}>
                      {req.reason || "—"}
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant={
                          req.status === "approved"
                            ? "default"
                            : req.status === "rejected"
                              ? "destructive"
                              : "secondary"
                        }
                        className="capitalize"
                      >
                        {req.status}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      <BrandButton
                        variant="outline"
                        size="sm"
                        disabled={req.status !== "pending"}
                        onClick={() => setOpen(req)}
                      >
                        Review
                      </BrandButton>
                    </TableCell>
                  </TableRow>
                );
              })
            )}
          </TableBody>
        </Table>
      </div>

      <Dialog open={!!open} onOpenChange={(isOpen) => !isOpen && setOpen(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("hrPages.reviewRequest")}</DialogTitle>
            <DialogDescription>
              {open
                ? `${open.requester?.name ?? open.teacher?.name ?? open.staff?.name ?? t("hrPages.requester")} — ${String(open.type || "").replaceAll("_", " ")}${open.subject ? " · " + open.subject : ""}`
                : ""}
            </DialogDescription>
          </DialogHeader>
          {open && (
            <div className="space-y-3 text-sm">
              {open.subject && (
                <div>
                  <span className="font-medium">Subject:</span> {open.subject}
                </div>
              )}
              <div>
                <span className="font-medium">Reason:</span> {open.reason || "—"}
              </div>
              {(open.start_date || open.from_date) && (
                <div>
                  <span className="font-medium">Duration:</span>{" "}
                  {formatDate(open.start_date ?? open.from_date)} -{" "}
                  {formatDate(open.end_date ?? open.to_date)}
                </div>
              )}
              {open.amount != null && (
                <div>
                  <span className="font-medium">Amount:</span> {open.amount}
                </div>
              )}
              <div className="space-y-1.5">
                <Label htmlFor="hr-review-response">{t("hrPages.responseToRequester")}</Label>
                <Textarea
                  id="hr-review-response"
                  value={response}
                  onChange={(event) => setResponse(event.target.value)}
                  rows={3}
                  placeholder={t("hrPages.optionalNote")}
                />
              </div>
            </div>
          )}
          <DialogFooter>
            <BrandButton
              variant="destructive"
              disabled={review.isPending}
              onClick={() => open && review.mutate({ id: open.id, status: "rejected" })}
            >
              Reject
            </BrandButton>
            <BrandButton
              disabled={review.isPending}
              onClick={() => open && review.mutate({ id: open.id, status: "approved" })}
            >
              Approve
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
