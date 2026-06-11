import { useAuth } from "@/lib/auth";
import { mediaUrl, Role } from "@/lib/api";
import { useLocation } from "wouter";
import { useTranslation } from "react-i18next";
import { Search, LogOut, User, KeyRound } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import BrandAvatar from "@/components/ui/BrandAvatar";
import NotificationBell from "@/components/layout/NotificationBell";

interface TopBarProps {
  title: string;
}

export default function TopBar({ title }: TopBarProps) {
  const { t } = useTranslation();
  const { user, logout } = useAuth();
  const [, setLocation] = useLocation();

  if (!user) return null;

  return (
    <header className="h-16 bg-card border-b border-surface-border shadow-sm flex items-center justify-between px-6 shrink-0">
      <h1 className="font-display text-xl font-bold text-ink-dark">{title}</h1>

      <div className="flex items-center gap-2">
        <button className="w-9 h-9 rounded-xl flex items-center justify-center text-ink-muted hover:bg-surface-bg hover:text-brand-purple transition-colors">
          <Search className="h-5 w-5" />
        </button>

        <NotificationBell role={user.role as Role} className="rounded-xl text-ink-muted hover:bg-surface-bg hover:text-brand-purple" />

        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <button className="ml-1 rounded-full focus:outline-none focus:ring-2 focus:ring-brand-purple/30">
              <BrandAvatar src={mediaUrl(user.photo_path)} name={user.name} role={user.role} size="sm" />
            </button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-56">
            <DropdownMenuLabel className="font-normal">
              <div className="flex flex-col space-y-1">
                <p className="text-sm font-medium leading-none">{user.name}</p>
                <p className="text-xs leading-none text-ink-muted">{user.email}</p>
              </div>
            </DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem asChild>
              <a href={`/${user.role}/profile`} className="cursor-pointer flex items-center gap-2">
                <User className="h-4 w-4" />
                {t("common.profile")}
              </a>
            </DropdownMenuItem>
            <DropdownMenuItem className="cursor-pointer flex items-center gap-2">
              <KeyRound className="h-4 w-4" />
              {t("common.changePassword")}
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              onClick={() => {
                logout();
                setLocation("/login");
              }}
              className="cursor-pointer flex items-center gap-2 text-brand-red focus:text-brand-red"
            >
              <LogOut className="h-4 w-4" />
              {t("common.logout")}
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </header>
  );
}
