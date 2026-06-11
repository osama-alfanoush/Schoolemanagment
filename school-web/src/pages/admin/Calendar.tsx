import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Admin } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { CalendarDays } from "lucide-react";
import { format } from "date-fns";
export default function AdminCalendar() {
  const {
    t
  } = useTranslation();
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["admin", "calendar"],
    queryFn: Admin.calendar
  }) as any;
  const events = data ?? [];
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.calendar")}</h1>
      </div>

      {isLoading ? <div className="p-8 text-center">{t("common.loading")}</div> : events.length === 0 ? <div className="p-8 text-center border rounded-md text-muted-foreground">{t("common.empty")}</div> : <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {events.map((event: any) => <BrandCard key={event.id}>
              <CardHeader className="pb-2">
                <CardTitle className="text-lg flex items-center gap-2">
                  <CalendarDays className="h-5 w-5 text-primary" />
                  {event.title}
                </CardTitle>
                <CardDescription>
                  {event.start_date ? format(new Date(event.start_date), 'MMM d, yyyy') : ''}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">{event.description}</p>
              </CardContent>
            </BrandCard>)}
        </div>}
    </div>;
}