import { useAuth } from "@/lib/auth";
import { mediaUrl } from "@/lib/api";
import { useLocation } from "wouter";
import { useTranslation } from "react-i18next";
import { LogOut, User, KeyRound, Menu } from "lucide-react";
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
  onMenuClick?: () => void;
}

export default function TopBar({ title, onMenuClick }: TopBarProps) {
  const { t } = useTranslation();
  const { user, logout } = useAuth();
  const [, setLocation] = useLocation();

  if (!user) return null;

  return (
    <header className="h-16 bg-card/90 backdrop-blur-md border-b border-surface-border shadow-academic flex items-center justify-between gap-3 px-4 sm:px-6 shrink-0 z-20">
      <div className="flex items-center gap-2 min-w-0">
        <button
          type="button"
          onClick={onMenuClick}
          aria-label={t("common.menu", "Menu")}
          className="md:hidden -ms-1 inline-flex h-9 w-9 items-center justify-center rounded-xl text-muted-foreground hover:bg-[var(--color-primary-subtle)] hover:text-[var(--color-primary)] transition-colors"
        >
          <Menu className="h-5 w-5" />
        </button>
        <h1 className="font-display text-lg sm:text-xl font-bold text-ink-dark truncate">{title}</h1>
      </div>

      <div className="flex items-center gap-1.5">
        <NotificationBell role={user.role} className="rounded-xl text-muted-foreground hover:bg-[var(--color-primary-subtle)] hover:text-[var(--color-primary)]" />

        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <button className="ml-1 rounded-full focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)]/30">
              <BrandAvatar src={mediaUrl(user.photo_path)} name={user.name} variant={user.role} size="sm" />
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
              <button
                type="button"
                onClick={() => setLocation(`/${user.role}/profile`)}
                className="w-full cursor-pointer flex items-center gap-2"
              >
                <User className="h-4 w-4" />
                {t("common.profile")}
              </button>
            </DropdownMenuItem>
            <DropdownMenuItem asChild>
              <button
                type="button"
                onClick={() => setLocation(`/${user.role}/profile`)}
                className="w-full cursor-pointer flex items-center gap-2"
              >
                <KeyRound className="h-4 w-4" />
                {t("common.changePassword")}
              </button>
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              onClick={() => {
                void logout();
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
