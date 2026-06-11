import BrandCard from "@/components/ui/BrandCard";
import BrandButton from "@/components/ui/BrandButton";
import { useEffect, useRef, useState } from "react";
import type { ChangeEvent } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Camera, Loader2, Save, ShieldCheck } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Auth, ApiError, mediaUrl } from "@/lib/api";
import { useAuth } from "@/lib/auth";
import { setLocale } from "@/lib/i18n";
import { toast } from "@/hooks/use-toast";
import { CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
function errorMessage(error: unknown): string {
  if (error instanceof ApiError) {
    const data = error.data as {
      errors?: Record<string, string[]>;
      message?: string;
    } | undefined;
    const first = data?.errors ? Object.values(data.errors).flat()[0] : undefined;
    return first || data?.message || error.message;
  }
  return "Something went wrong. Please try again.";
}
export default function Profile() {
  const {
    t,
    i18n
  } = useTranslation();
  const queryClient = useQueryClient();
  const {
    user: authUser,
    refreshUser
  } = useAuth();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [photoPreview, setPhotoPreview] = useState("");
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const {
    data,
    isLoading
  } = useQuery({
    queryKey: ["auth", "me"],
    queryFn: Auth.me
  });
  const user = data?.user ?? authUser;
  useEffect(() => {
    if (!user) return;
    setName(user.name || "");
    setPhone(user.phone || "");
    setPhotoPreview(mediaUrl(user.photo_path));
  }, [user]);
  const refreshProfile = async () => {
    await refreshUser();
    await queryClient.invalidateQueries({
      queryKey: ["auth", "me"]
    });
  };
  const profileMutation = useMutation({
    mutationFn: () => Auth.updateProfile({
      name: name.trim(),
      phone: phone.trim() || undefined
    }),
    onSuccess: async () => {
      await refreshProfile();
      toast({
        title: "Profile saved"
      });
    },
    onError: error => {
      toast({
        title: "Failed to save profile",
        description: errorMessage(error),
        variant: "destructive"
      });
    }
  });
  const photoMutation = useMutation({
    mutationFn: (file: File) => Auth.uploadProfilePhoto(file),
    onSuccess: async result => {
      setPhotoPreview(mediaUrl(result.photo_url || result.user?.photo_path));
      await refreshProfile();
      toast({
        title: "Profile photo updated"
      });
    },
    onError: error => {
      toast({
        title: "Photo upload failed",
        description: errorMessage(error),
        variant: "destructive"
      });
    }
  });
  const passwordMutation = useMutation({
    mutationFn: () => Auth.changePassword({
      current_password: currentPassword,
      new_password: newPassword,
      new_password_confirmation: confirmPassword
    }),
    onSuccess: () => {
      setCurrentPassword("");
      setNewPassword("");
      setConfirmPassword("");
      toast({
        title: "Password updated"
      });
    },
    onError: error => {
      toast({
        title: "Failed to update password",
        description: errorMessage(error),
        variant: "destructive"
      });
    }
  });
  const handlePhoto = (event: ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;
    if (!["image/jpeg", "image/png", "image/webp"].includes(file.type)) {
      toast({
        title: "Unsupported file",
        description: "Use a JPG, PNG, or WebP image.",
        variant: "destructive"
      });
      event.target.value = "";
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      toast({
        title: "Photo too large",
        description: "Profile photo must be under 5MB.",
        variant: "destructive"
      });
      event.target.value = "";
      return;
    }
    setPhotoPreview(URL.createObjectURL(file));
    photoMutation.mutate(file);
  };
  const handleSaveProfile = () => {
    if (!name.trim()) {
      toast({
        title: "Name is required",
        variant: "destructive"
      });
      return;
    }
    profileMutation.mutate();
  };
  const handleChangePassword = () => {
    if (!currentPassword || !newPassword || !confirmPassword) {
      toast({
        title: "Fill all password fields",
        variant: "destructive"
      });
      return;
    }
    if (newPassword !== confirmPassword) {
      toast({
        title: "Passwords do not match",
        variant: "destructive"
      });
      return;
    }
    passwordMutation.mutate();
  };
  if (isLoading) return <div className="p-8">{t("common.loading")}</div>;
  if (!user) return <div className="p-8 text-center">{t("common.error")}</div>;
  const initials = user.name.substring(0, 2).toUpperCase();
  return <div className="mx-auto max-w-3xl space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">{t("common.profile")}</h1>

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader className="pb-4">
          <CardTitle>{t("profileSettings.personalInfo")}</CardTitle>
          <CardDescription>{t("profileSettings.personalInfoDesc")}</CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-center">
            <Avatar className="h-24 w-24 border-2">
              <AvatarImage src={photoPreview} alt={user.name} />
              <AvatarFallback className="text-2xl">{initials}</AvatarFallback>
            </Avatar>
            <div className="space-y-2">
              <BrandButton type="button" variant="outline" onClick={() => fileInputRef.current?.click()} disabled={photoMutation.isPending}>
                {photoMutation.isPending ? <Loader2 className="h-4 w-4 animate-spin" /> : <Camera className="h-4 w-4" />}
                {t("profileSettings.uploadPhoto")}
              </BrandButton>
              <input ref={fileInputRef} type="file" accept="image/jpeg,image/png,image/webp" onChange={handlePhoto} className="hidden" />
              <p className="text-xs text-muted-foreground">{t("profileSettings.photoRequirement")}</p>
            </div>
          </div>

          <div className="grid gap-4 md:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="name">{t("common.name")}</Label>
              <Input id="name" value={name} onChange={event => setName(event.target.value)} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="email">{t("common.email")}</Label>
              <Input id="email" value={user.email} disabled />
            </div>
            <div className="space-y-2">
              <Label htmlFor="phone">{t("profileSettings.phone")}</Label>
              <Input id="phone" value={phone} onChange={event => setPhone(event.target.value)} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="role">{t("common.role")}</Label>
              <Input id="role" value={t(`roles.${user.role}`)} disabled className="capitalize" />
            </div>
          </div>

          <div className="flex justify-end">
            <BrandButton type="button" onClick={handleSaveProfile} disabled={profileMutation.isPending}>
              {profileMutation.isPending ? <Loader2 className="h-4 w-4 animate-spin" /> : <Save className="h-4 w-4" />}
              {t("common.save")}
            </BrandButton>
          </div>
        </CardContent>
      </BrandCard>

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle>{t("common.changePassword")}</CardTitle>
          <CardDescription>{t("profileSettings.passwordDesc")}</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="current_password">{t("profileSettings.currentPassword")}</Label>
            <Input id="current_password" type="password" value={currentPassword} onChange={event => setCurrentPassword(event.target.value)} />
          </div>
          <div className="grid gap-4 md:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="new_password">{t("profileSettings.newPassword")}</Label>
              <Input id="new_password" type="password" value={newPassword} onChange={event => setNewPassword(event.target.value)} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="confirm_password">{t("profileSettings.confirmNewPassword")}</Label>
              <Input id="confirm_password" type="password" value={confirmPassword} onChange={event => setConfirmPassword(event.target.value)} />
            </div>
          </div>
          <div className="flex justify-end">
            <BrandButton type="button" variant="secondary" onClick={handleChangePassword} disabled={passwordMutation.isPending}>
              {passwordMutation.isPending ? <Loader2 className="h-4 w-4 animate-spin" /> : <ShieldCheck className="h-4 w-4" />}
              {t("profileSettings.updatePassword")}
            </BrandButton>
          </div>
        </CardContent>
      </BrandCard>

      <BrandCard className="shadow-academic border-surface-border">
        <CardHeader>
          <CardTitle>{t("profileSettings.preferences")}</CardTitle>
          <CardDescription>{t("profileSettings.preferencesDesc")}</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="space-y-2">
            <Label>{t("common.language")}</Label>
            <div className="flex gap-2">
              <BrandButton type="button" variant={i18n.language === "en" ? "primary" : "outline"} onClick={() => setLocale("en")}>
                English
              </BrandButton>
              <BrandButton type="button" variant={i18n.language === "ar" ? "primary" : "outline"} onClick={() => setLocale("ar")}>
                عربي (Arabic)
              </BrandButton>
            </div>
          </div>
        </CardContent>
      </BrandCard>
    </div>;
}