import BrandCard from "@/components/ui/BrandCard";
import { useQuery } from "@tanstack/react-query";
import { Parent } from "@/lib/api";
import { useTranslation } from "react-i18next";
import { CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { format } from "date-fns";
function announcementsFromResponse(payload: any): any[] {
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload?.data)) return payload.data;
  if (Array.isArray(payload?.data?.data)) return payload.data.data;
  return [];
}
export default function ParentAnnouncements() {
  const {
    t
  } = useTranslation();
  const {
    data,
    isLoading,
    error
  } = useQuery({
    queryKey: ["parent", "announcements"],
    queryFn: Parent.announcements
  }) as any;
  const list = announcementsFromResponse(data);
  return <div className="space-y-6 max-w-4xl mx-auto">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.announcements")}</h1>
      
      {isLoading ? <div className="p-8 text-center">{t("common.loading")}</div> : error ? <div className="p-8 text-center border rounded-md text-destructive">
          {(error as Error)?.message || t("common.error")}
        </div> : list.length === 0 ? <div className="p-8 text-center border rounded-md text-muted-foreground">{t("common.empty")}</div> : <div className="space-y-4">
          {list.map((item: any) => <BrandCard key={item.id}>
              <CardHeader className="pb-2">
                <div className="flex justify-between items-start">
                  <CardTitle className="text-lg">{item.title}</CardTitle>
                  <Badge variant="outline" className="text-xs">
                    {item.created_at ? format(new Date(item.created_at), 'MMM d, yyyy') : ''}
                  </Badge>
                </div>
                <CardDescription>
                  From: {item.author?.name || 'Administration'}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <p className="whitespace-pre-wrap text-sm">{item.body}</p>
              </CardContent>
            </BrandCard>)}
        </div>}
    </div>;
}