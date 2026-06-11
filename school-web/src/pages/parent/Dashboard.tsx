import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useQuery } from "@tanstack/react-query";
import { mediaUrl, Parent } from "@/lib/api";
import { CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Link } from "wouter";
import { ChevronRight } from "lucide-react";
function toArray<T = any>(payload: any): T[] {
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload?.data)) return payload.data;
  if (Array.isArray(payload?.data?.data)) return payload.data.data;
  return [];
}
export default function ParentDashboard() {
  const {
    t
  } = useTranslation();
  const {
    data: children,
    isLoading,
    error
  } = useQuery({
    queryKey: ["parent", "children"],
    queryFn: Parent.children
  }) as any;
  if (isLoading) return <div className="p-8">{t("common.loading")}</div>;
  const childList = toArray(children);
  return <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.children")}</h1>
      
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {error && <div className="col-span-full p-8 text-center text-destructive border rounded-md">
            {(error as Error)?.message || t("common.error")}
          </div>}

        {!error && childList.length === 0 && <div className="col-span-full p-8 text-center text-muted-foreground border rounded-md">
            {t("common.empty")}
          </div>}
        
        {!error && childList.map((child: any) => {
        const childName = child.name ?? "Student";
        const className = child.studentProfile?.classRoom?.name ?? child.student_profile?.class_room?.name ?? "Not assigned";
        const initials = child.name ? child.name.substring(0, 2).toUpperCase() : "ST";
        return <BrandCard key={child.id} className="overflow-hidden:border-primary/50 transition-colors">
              <CardHeader className="pb-4">
                <div className="flex items-center space-x-4 rtl:space-x-reverse">
                  <Avatar className="h-12 w-12 border">
                    <AvatarImage src={mediaUrl(child.photo_path)} alt={childName} />
                    <AvatarFallback>{initials}</AvatarFallback>
                  </Avatar>
                  <div>
                    <CardTitle className="text-lg">{childName}</CardTitle>
                    <CardDescription>
                      {t("parentDashboard.grade")} {className}
                    </CardDescription>
                  </div>
                </div>
              </CardHeader>
              <CardContent className="bg-muted/30 pt-4 border-t flex justify-between items-center">
                <div className="text-sm text-muted-foreground">
                  {t("parentDashboard.viewProgress")}
                </div>
                <Link href={`/parent/children/${child.id}`}>
                  <BrandButton variant="ghost" size="sm">
                    <ChevronRight className="h-4 w-4 rtl:rotate-180" />
                  </BrandButton>
                </Link>
              </CardContent>
            </BrandCard>;
      })}
      </div>
    </div>;
}