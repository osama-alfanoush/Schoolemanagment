import { useState, type ReactNode } from "react";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/lib/auth";
import Sidebar, { navTitleKey } from "./Sidebar";
import TopBar from "./TopBar";
import PageTransition from "./PageTransition";

interface AppLayoutProps {
  children: ReactNode;
  /** Route path — the title is looked up from it, so it translates with the UI. */
  path: string;
}

/** "/admin/academic-years" → "academicYears", for a `nav.*` lookup. */
function segmentKey(path: string): string {
  const last = path.split("/").filter(Boolean).pop() ?? "";
  return last.replace(/[-_](\w)/g, (_, c: string) => c.toUpperCase());
}

/** Last resort for a route no menu covers: "/x/fee-structures" → "Fee Structures". */
function prettify(path: string): string {
  const segments = path.split("/").filter(Boolean);
  if (segments.length <= 1) return "";
  return segments
    .slice(1)
    .map((s) => s.replace(/[-_]/g, " ").replace(/\b\w/g, (c) => c.toUpperCase()))
    .join(" — ");
}

export default function AppLayout({ children, path }: AppLayoutProps) {
  const { user } = useAuth();
  const { t, i18n } = useTranslation();
  const [collapsed, setCollapsed] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

  if (!user) return null;

  // Prefer the menu's own wording, then a matching nav/common key, then the raw
  // path. Building the title from the URL was why every top bar stayed English.
  // Routes with no menu entry (profile, messages) resolve through `common.*`.
  const menuKey = navTitleKey(user.role, path);
  const segment = segmentKey(path);
  const fallbackKey = [`nav.${segment}`, `common.${segment}`].find((key) => i18n.exists(key));
  const title = menuKey
    ? t(menuKey)
    : fallbackKey
      ? t(fallbackKey)
      : path.split("/").filter(Boolean).length <= 1
        ? t("nav.dashboard")
        : prettify(path);

  return (
    <div className="flex h-screen overflow-hidden bg-surface-bg">
      {/* Mobile overlay */}
      {mobileOpen && (
        <div
          className="fixed inset-0 z-40 bg-black/50 backdrop-blur-sm md:hidden"
          onClick={() => setMobileOpen(false)}
          aria-hidden
        />
      )}

      <Sidebar
        collapsed={collapsed}
        onToggle={() => setCollapsed(!collapsed)}
        mobileOpen={mobileOpen}
        onClose={() => setMobileOpen(false)}
      />

      <div className="flex flex-1 flex-col min-w-0">
        <TopBar title={title} onMenuClick={() => setMobileOpen(true)} />
        <main className="flex-1 overflow-y-auto">
          <div className="mx-auto w-full max-w-[1600px] p-4 sm:p-6 lg:p-8">
            <PageTransition>{children}</PageTransition>
          </div>
        </main>
      </div>
    </div>
  );
}
