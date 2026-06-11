import BrandButton from "@/components/ui/BrandButton";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Admin, mediaUrl, Role } from "@/lib/api";
import { useTranslation } from "react-i18next";
import DataTable from "@/components/ui/DataTable";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Search, Plus } from "lucide-react";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";
const ROLE_OPTIONS: Role[] = ["student", "parent", "teacher", "admin", "finance", "hr", "accounting", "warehouse"];
function usersFromResponse(payload: any): any[] {
  if (Array.isArray(payload)) return payload;
  if (Array.isArray(payload?.data)) return payload.data;
  if (Array.isArray(payload?.data?.data)) return payload.data.data;
  return [];
}
export default function AdminUsers() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const qc = useQueryClient();
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [form, setForm] = useState({
    name: "",
    email: "",
    password: "",
    role: "student" as Role,
    phone: ""
  });
  const {
    data,
    isLoading,
    error
  } = useQuery({
    queryKey: ["admin", "users", search],
    queryFn: () => Admin.users({
      q: search
    })
  }) as any;
  const users = usersFromResponse(data);
  const createUser = useMutation({
    mutationFn: (body: any) => Admin.createUser(body),
    onSuccess: () => {
      qc.invalidateQueries({
        queryKey: ["admin", "users"]
      });
      toast({
        title: "User created"
      });
      setCreateOpen(false);
      setForm({
        name: "",
        email: "",
        password: "",
        role: "student",
        phone: ""
      });
    },
    onError: (e: any) => toast({
      variant: "destructive",
      title: "Failed to create user",
      description: e?.message
    })
  });
  return <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">
          {t("nav.staff")} / Users
        </h1>
        <BrandButton onClick={() => setCreateOpen(true)}>
          <Plus className="me-2 h-4 w-4" />
          {t("common.create")} User
        </BrandButton>
      </div>

      <div className="flex items-center space-x-2 rtl:space-x-reverse max-w-sm">
        <div className="relative w-full">
          <Search className="absolute start-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input placeholder={t("common.search") + "..."} className="ps-9" value={search} onChange={e => setSearch(e.target.value)} />
        </div>
      </div>

      <div>
        <DataTable
          columns={[
            {
              key: "name",
              label: t("common.name"),
              sortable: true,
              render: (_, user) => (
                <div className="flex items-center space-x-3 rtl:space-x-reverse">
                  <Avatar className="h-8 w-8">
                    <AvatarImage src={mediaUrl(user.photo_path)} />
                    <AvatarFallback>
                      {user.name.substring(0, 2).toUpperCase()}
                    </AvatarFallback>
                  </Avatar>
                  <div className="font-medium">{user.name}</div>
                </div>
              ),
            },
            {
              key: "role",
              label: t("common.role"),
              sortable: true,
              render: (val) => (
                <Badge variant="outline" className="capitalize">
                  {t(`roles.${val}`)}
                </Badge>
              ),
            },
            { key: "email", label: t("common.email"), sortable: true },
            {
              key: "is_active",
              label: t("common.status"),
              sortable: true,
              render: (val) => (
                <Badge variant={val ? "default" : "secondary"}>
                  {val ? t("common.active", "Active") : t("common.inactive", "Inactive")}
                </Badge>
              ),
            },
          ]}
          data={users}
          isLoading={isLoading}
          error={(error as Error)?.message}
          emptyMessage={t("common.empty")}
          rowActions={[
            {
              label: t("common.edit"),
              onClick: () => {},
              variant: "default",
            },
          ]}
        />
      </div>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("common.create")} User</DialogTitle>
            <DialogDescription>
              {t("common.createUserDesc", "Create a new user account with a chosen role.")}
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-3">
            <div className="space-y-1.5">
              <Label htmlFor="name">{t("common.name")}</Label>
              <Input id="name" value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="email">{t("common.email")}</Label>
              <Input id="email" type="email" value={form.email} onChange={e => setForm({
              ...form,
              email: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="password">{t("login.password")}</Label>
              <Input id="password" type="password" value={form.password} onChange={e => setForm({
              ...form,
              password: e.target.value
            })} />
            </div>
            <div className="space-y-1.5">
              <Label>{t("common.role")}</Label>
              <div className="flex flex-wrap gap-2">
                {ROLE_OPTIONS.map(r => <Badge key={r} variant={form.role === r ? "default" : "outline"} className="cursor-pointer capitalize px-3 py-1" onClick={() => setForm({
                ...form,
                role: r
              })}>
                    {t(`roles.${r}`)}
                  </Badge>)}
              </div>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="phone">{t("profileSettings.phone")}</Label>
              <Input id="phone" value={form.phone} onChange={e => setForm({
              ...form,
              phone: e.target.value
            })} />
            </div>
          </div>
          <DialogFooter>
            <BrandButton variant="outline" onClick={() => setCreateOpen(false)}>
              {t("common.cancel")}
            </BrandButton>
            <BrandButton onClick={() => createUser.mutate(form)} disabled={!form.name || !form.email || !form.password || createUser.isPending}>
              {createUser.isPending ? t("common.loading") : t("common.create")}
            </BrandButton>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}