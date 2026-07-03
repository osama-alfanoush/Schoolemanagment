import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { mediaUrl, Parent } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { useParams } from "wouter";
import { CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
function asArray(x: any): any[] {
  if (Array.isArray(x)) return x;
  if (!x || typeof x !== "object") return [];
  if (Array.isArray(x.data)) return x.data;
  if (Array.isArray(x.records)) return x.records;
  if (x.records && Array.isArray(x.records.data)) return x.records.data;
  if (Array.isArray(x.invoices)) return x.invoices;
  return [];
}
function EmptyRow({
  cols,
  t
}: {
  cols: number;
  t: (k: string) => string;
}) {
  return <TableRow>
      <TableCell colSpan={cols} className="text-center text-muted-foreground py-8">
        {t("common.empty")}
      </TableCell>
    </TableRow>;
}
export default function ParentChildDetail() {
  const {
    t
  } = useTranslation();
  const params = useParams();
  const id = parseInt(params.id || "0", 10);
  const {
    data: overview,
    isLoading
  } = useQuery({
    queryKey: ["parent", "child", id, "overview"],
    queryFn: () => Parent.childOverview(id),
    enabled: !!id
  }) as any;
  const {
    data: gradesData
  } = useQuery({
    queryKey: ["parent", "child", id, "grades"],
    queryFn: () => Parent.childGrades(id),
    enabled: !!id
  }) as any;
  const {
    data: assignmentsData
  } = useQuery({
    queryKey: ["parent", "child", id, "assignments"],
    queryFn: () => Parent.childAssignments(id),
    enabled: !!id
  }) as any;
  const {
    data: attendanceData
  } = useQuery({
    queryKey: ["parent", "child", id, "attendance"],
    queryFn: () => Parent.childAttendance(id),
    enabled: !!id
  }) as any;
  const {
    data: conductData
  } = useQuery({
    queryKey: ["parent", "child", id, "conduct"],
    queryFn: () => Parent.childConduct(id),
    enabled: !!id
  }) as any;
  const {
    data: invoicesData
  } = useQuery({
    queryKey: ["parent", "child", id, "invoices"],
    queryFn: () => Parent.childInvoices(id),
    enabled: !!id
  }) as any;
  if (isLoading) return <div className="p-8 text-center">{t("common.loading")}</div>;
  if (!overview) return <div className="p-8 text-center">{t("common.error")}</div>;
  const child = overview.student ?? overview;
  const grades = asArray(gradesData);
  const assignments = asArray(assignmentsData);
  const attendance = asArray(attendanceData);
  const conduct = asArray(conductData);
  const invoices = asArray(invoicesData);
  return <div className="space-y-6 max-w-5xl mx-auto">
      <div className="flex items-center space-x-4 rtl:space-x-reverse bg-card p-6 rounded-lg border">
        <Avatar className="h-20 w-20 border-2">
          <AvatarImage src={mediaUrl(child?.photo_path)} alt={child?.name} />
          <AvatarFallback className="text-xl">
            {child?.name?.substring(0, 2).toUpperCase()}
          </AvatarFallback>
        </Avatar>
        <div>
          <h1 className="text-2xl font-bold">{child?.name}</h1>
          <p className="text-muted-foreground">
            {child?.student_profile?.admission_no ? `Admission ${child.student_profile.admission_no} · ` : ""}
            Grade {child?.student_profile?.grade_level || child?.student_profile?.class_room_id || "?"}
          </p>
        </div>
      </div>

      <Tabs defaultValue="overview">
        <TabsList className="grid w-full grid-cols-3 md:grid-cols-6">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="grades">{t("nav.grades")}</TabsTrigger>
          <TabsTrigger value="assignments">{t("nav.assignments")}</TabsTrigger>
          <TabsTrigger value="attendance">{t("nav.attendance")}</TabsTrigger>
          <TabsTrigger value="conduct">{t("nav.conduct")}</TabsTrigger>
          <TabsTrigger value="financial">{t("nav.invoices")}</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="mt-6">
          <div className="grid gap-4 md:grid-cols-3">
            <BrandCard className="shadow-academic border-surface-border">
              <CardHeader className="pb-2">
                <CardTitle className="text-sm">Grades recorded</CardTitle>
              </CardHeader>
              <CardContent className="text-2xl font-semibold">
                {grades.length}
              </CardContent>
            </BrandCard>
            <BrandCard className="shadow-academic border-surface-border">
              <CardHeader className="pb-2">
                <CardTitle className="text-sm">Assignments</CardTitle>
              </CardHeader>
              <CardContent className="text-2xl font-semibold">
                {assignments.length}
              </CardContent>
            </BrandCard>
            <BrandCard className="shadow-academic border-surface-border">
              <CardHeader className="pb-2">
                <CardTitle className="text-sm">Attendance entries</CardTitle>
              </CardHeader>
              <CardContent className="text-2xl font-semibold">
                {attendance.length}
              </CardContent>
            </BrandCard>
          </div>
        </TabsContent>

        <TabsContent value="grades" className="mt-6">
          <BrandCard className="shadow-academic border-surface-border">
            <CardHeader>
              <CardTitle>{t("nav.grades")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Subject</TableHead>
                    <TableHead>Exam</TableHead>
                    <TableHead className="text-right">Score</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {grades.length === 0 ? <EmptyRow cols={3} t={t} /> : grades.map((g: any) => <TableRow key={g.id}>
                        <TableCell>{g.subject?.name ?? g.subject_name ?? "—"}</TableCell>
                        <TableCell>{g.exam?.name ?? g.exam_name ?? "—"}</TableCell>
                        <TableCell className="text-right font-mono">
                          {g.score ?? g.marks_obtained ?? 0}
                          {g.max_score ? ` / ${g.max_score}` : ""}
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </BrandCard>
        </TabsContent>

        <TabsContent value="assignments" className="mt-6">
          <BrandCard className="shadow-academic border-surface-border">
            <CardHeader>
              <CardTitle>{t("nav.assignments")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Title</TableHead>
                    <TableHead>Subject</TableHead>
                    <TableHead>Due</TableHead>
                    <TableHead>Status</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {assignments.length === 0 ? <EmptyRow cols={4} t={t} /> : assignments.map((a: any) => <TableRow key={a.id}>
                        <TableCell className="font-medium">{a.title}</TableCell>
                        <TableCell>{a.subject?.name ?? "—"}</TableCell>
                        <TableCell>
                          {a.due_date ? new Date(a.due_date).toLocaleDateString() : "—"}
                        </TableCell>
                        <TableCell>
                          <Badge variant={a.submitted ? "default" : "outline"}>
                            {a.submitted ? "Submitted" : t("common.pending")}
                          </Badge>
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </BrandCard>
        </TabsContent>

        <TabsContent value="attendance" className="mt-6">
          <BrandCard className="shadow-academic border-surface-border">
            <CardHeader>
              <CardTitle>{t("nav.attendance")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("common.date")}</TableHead>
                    <TableHead>{t("common.status")}</TableHead>
                    <TableHead>{t("common.notes")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {attendance.length === 0 ? <EmptyRow cols={3} t={t} /> : attendance.map((a: any) => <TableRow key={a.id}>
                        <TableCell>
                          {a.date ? new Date(a.date).toLocaleDateString() : "—"}
                        </TableCell>
                        <TableCell>
                          <Badge variant={a.status === "present" ? "default" : a.status === "absent" ? "destructive" : "secondary"} className="capitalize">
                            {t(`common.${a.status}`) || a.status}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-muted-foreground text-sm">
                          {a.notes ?? ""}
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </BrandCard>
        </TabsContent>

        <TabsContent value="conduct" className="mt-6">
          <BrandCard className="shadow-academic border-surface-border">
            <CardHeader>
              <CardTitle>{t("nav.conduct")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("common.date")}</TableHead>
                    <TableHead>Type</TableHead>
                    <TableHead>{t("common.notes")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {conduct.length === 0 ? <EmptyRow cols={3} t={t} /> : conduct.map((c: any) => <TableRow key={c.id}>
                        <TableCell>
                          {c.date ? new Date(c.date).toLocaleDateString() : "—"}
                        </TableCell>
                        <TableCell className="capitalize">{c.type ?? c.category ?? "—"}</TableCell>
                        <TableCell className="text-muted-foreground text-sm">
                          {c.notes ?? c.description ?? ""}
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </BrandCard>
        </TabsContent>

        <TabsContent value="financial" className="mt-6">
          <BrandCard className="shadow-academic border-surface-border">
            <CardHeader>
              <CardTitle>{t("nav.invoices")}</CardTitle>
            </CardHeader>
            <CardContent className="p-0">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Invoice</TableHead>
                    <TableHead>{t("common.date")}</TableHead>
                    <TableHead>{t("common.status")}</TableHead>
                    <TableHead className="text-right">{t("common.amount")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {invoices.length === 0 ? <EmptyRow cols={4} t={t} /> : invoices.map((i: any) => <TableRow key={i.id}>
                        <TableCell className="font-mono text-sm">
                          {i.invoice_no ?? `#${i.id}`}
                        </TableCell>
                        <TableCell>
                          {i.issue_date ? new Date(i.issue_date).toLocaleDateString() : "—"}
                        </TableCell>
                        <TableCell>
                          <Badge variant={i.status === "paid" ? "default" : i.status === "overdue" ? "destructive" : "secondary"} className="capitalize">
                            {t(`common.${i.status}`) || i.status}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-right font-mono">
                          {Number(i.total ?? i.amount ?? 0).toLocaleString()}{" "}
                          <button type="button" className="text-primary hover:underline ms-2 text-xs" onClick={() => {
                            void Parent.childInvoiceReceipt(id, i.id, i.invoice_no ?? String(i.id))
                          }}>
                            {t("common.download")}
                          </button>
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </BrandCard>
        </TabsContent>
      </Tabs>
    </div>;
}
