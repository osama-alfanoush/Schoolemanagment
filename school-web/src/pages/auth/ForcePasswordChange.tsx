import { useState } from "react";
import { Redirect, useLocation } from "wouter";
import { useTranslation } from "react-i18next";
import { ApiError, Auth } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import BrandButton from "@/components/ui/BrandButton";
import BrandCard from "@/components/ui/BrandCard";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

/**
 * Blocking screen for accounts flagged with must_change_password.
 * RoleGuard bounces every portal route here until the flag is cleared,
 * so the only ways forward are a new password or logging out.
 */
export default function ForcePasswordChange() {
  const { t } = useTranslation();
  const { user, refreshUser, logout } = useAuth();
  const [, setLocation] = useLocation();
  const [current, setCurrent] = useState("");
  const [next, setNext] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  if (!user) return <Redirect to="/login" />;
  if (!user.must_change_password) return <Redirect to={`/${user.role}`} />;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    if (next !== confirm) {
      setError(t("profileSettings.passwordMismatch", "New passwords do not match."));
      return;
    }
    setSaving(true);
    try {
      await Auth.changePassword({
        current_password: current,
        new_password: next,
        new_password_confirmation: confirm,
      });
      await refreshUser(); // clears must_change_password on the user object
      setLocation(`/${user.role}`);
    } catch (err: unknown) {
      let message = err instanceof Error ? err.message : "Could not update the password.";
      if (err instanceof ApiError && typeof err.data === "object" && err.data !== null && "errors" in err.data) {
        const errors = (err.data as { errors?: unknown }).errors;
        if (typeof errors === "object" && errors !== null) {
          const first = Object.values(errors).flatMap(value => Array.isArray(value) ? value : [value])[0];
          if (typeof first === "string") message = first;
        }
      }
      setError(message);
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background p-6">
      <BrandCard className="w-full max-w-md space-y-5">
        <div className="space-y-1 text-center">
          <div className="text-3xl">🔒</div>
          <h1 className="font-display text-xl font-bold text-foreground">
            {t("profileSettings.updatePassword")}
          </h1>
          <p className="text-sm text-muted-foreground">
            {t(
              "profileSettings.forceChangeDesc",
              "Your account requires a new password before you can continue."
            )}
          </p>
        </div>

        <form onSubmit={(event) => void handleSubmit(event)} className="space-y-4">
          <div className="space-y-1.5">
            <Label htmlFor="current-password">{t("profileSettings.currentPassword")}</Label>
            <Input
              id="current-password"
              type="password"
              autoComplete="current-password"
              value={current}
              onChange={(e) => setCurrent(e.target.value)}
              required
            />
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="new-password">{t("profileSettings.newPassword")}</Label>
            <Input
              id="new-password"
              type="password"
              autoComplete="new-password"
              value={next}
              onChange={(e) => setNext(e.target.value)}
              required
            />
            <p className="text-xs text-muted-foreground">{t("profileSettings.passwordDesc")}</p>
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="confirm-password">{t("profileSettings.confirmNewPassword")}</Label>
            <Input
              id="confirm-password"
              type="password"
              autoComplete="new-password"
              value={confirm}
              onChange={(e) => setConfirm(e.target.value)}
              required
            />
          </div>

          {error && (
            <p role="alert" className="text-sm text-red-600">
              {error}
            </p>
          )}

          <div className="flex items-center justify-between gap-3">
            <BrandButton type="button" variant="ghost" onClick={() => void logout()}>
              {t("common.logout")}
            </BrandButton>
            <BrandButton type="submit" isLoading={saving} disabled={!current || !next || !confirm}>
              {t("profileSettings.updatePassword")}
            </BrandButton>
          </div>
        </form>
      </BrandCard>
    </div>
  );
}
