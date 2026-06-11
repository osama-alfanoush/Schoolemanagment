import BrandButton from "@/components/ui/BrandButton";
import { useQuery } from "@tanstack/react-query";
import { Hr, mediaUrl } from "@/lib/api";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { toArray } from "@/lib/response";

export default function HrStaff() {
  const { t } = useTranslation();
  const { data, isLoading } = useQuery({
    queryKey: ["hr", "staff"],
    queryFn: () => Hr.staff()
  }) as any;
  const staff = toArray(data);

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("nav.staff")}</h1>
      </div>

      <div>
        <DataTable
          columns={[
            {
              key: "name",
              label: "Employee",
              sortable: true,
              render: (_, employee) => (
                <div className="flex items-center space-x-3 rtl:space-x-reverse">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={mediaUrl(employee.photo_path)} />
                    <AvatarFallback>{employee.name.substring(0, 2).toUpperCase()}</AvatarFallback>
                  </Avatar>
                  <div className="font-medium">{employee.name}</div>
                </div>
              ),
            },
            {
              key: "role",
              label: "Role",
              sortable: true,
              render: (val) => (
                <Badge variant="outline" className="capitalize">
                  {t(`roles.${val}`)}
                </Badge>
              ),
            },
            { key: "email", label: "Email", sortable: true },
            {
              key: "department",
              label: "Department",
              sortable: true,
              render: (_, employee) => employee.staffProfile?.department || "-",
            },
          ]}
          data={staff}
          isLoading={isLoading}
          emptyMessage={t("common.empty")}
          rowActions={[
            { label: t("common.edit"), onClick: () => {}, variant: "default" }
          ]}
        />
      </div>
    </div>
  );
}