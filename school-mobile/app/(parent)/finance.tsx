import { Feather } from "@expo/vector-icons";
import { useQuery } from "@tanstack/react-query";
import * as WebBrowser from "expo-web-browser";
import React, { useState } from "react";
import { Alert, Pressable, RefreshControl, View } from "react-native";

import { ChildSwitcher } from "@/components/ChildSwitcher";
import {
  Body,
  Btn,
  Card,
  EmptyState,
  H1,
  H2,
  LoadingView,
  Pill,
  Row,
  Screen,
} from "@/components/ui";
import { useColors } from "@/hooks/useColors";
import { Parent, asArray, authedDownloadUrl } from "@/lib/api";
import { useI18n } from "@/lib/i18n";

import { useChild } from "@/lib/parentChild";

export default function ParentFinance() {
  const { t } = useI18n();
  const colors = useColors();
  const { selected } = useChild();
  const [refreshing, setRefreshing] = useState(false);
  const [busy, setBusy] = useState<number | null>(null);

  const inv = useQuery({
    queryKey: ["parent", "invoices", selected?.id],
    queryFn: () => Parent.childInvoices(selected!.id),
    enabled: !!selected,
  });
  const pay = useQuery({
    queryKey: ["parent", "payments", selected?.id],
    queryFn: () => Parent.childPayments(selected!.id),
    enabled: !!selected,
  });

  const onRefresh = async () => {
    setRefreshing(true);
    await Promise.all([inv.refetch(), pay.refetch()]);
    setRefreshing(false);
  };

  const openReceipt = async (invoiceId: number) => {
    if (!selected) return;
    setBusy(invoiceId);
    try {
      const { url, headers } = await authedDownloadUrl(
        `/parent/children/${selected.id}/invoices/${invoiceId}/receipt-pdf`,
      );
      const sep = url.includes("?") ? "&" : "?";
      const tokenized = headers.Authorization
        ? `${url}${sep}_token=${encodeURIComponent(
            headers.Authorization.replace(/^Bearer\s+/i, ""),
          )}`
        : url;
      await WebBrowser.openBrowserAsync(tokenized).catch(async () => {
        // Fallback: try a plain fetch + alert
        const r = await fetch(url, { headers });
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
      });
    } catch (e: any) {
      Alert.alert(t("common.error"), e?.message ?? "Failed");
    } finally {
      setBusy(null);
    }
  };

  if (!selected) return <LoadingView />;
  const invoices = asArray(inv.data);
  const payments = asArray(pay.data);

  return (
    <Screen
      scroll
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <H1 style={{ marginBottom: 12 }}>{t("tabs.finance")}</H1>
      <ChildSwitcher />

      <Card>
        <H2>{t("parent.invoices")}</H2>
        <View style={{ height: 8 }} />
        {invoices.length === 0 ? (
          <EmptyState icon="check-circle" title={t("parent.nothingDue")} />
        ) : (
          invoices.map((iv: any) => (
            <View
              key={iv.id}
              style={{
                paddingVertical: 12,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                gap: 8,
              }}
            >
              <Row style={{ justifyContent: "space-between" }}>
                <View style={{ flex: 1 }}>
                  <Body style={{ fontFamily: "Inter_600SemiBold" }}>
                    {iv.invoice_no ?? `#${iv.id}`}
                  </Body>
                  <Body muted style={{ fontSize: 12 }}>
                    {iv.due_date
                      ? `${t("parent.due")}: ${new Date(iv.due_date).toLocaleDateString()}`
                      : ""}
                  </Body>
                </View>
                <StatusPill status={iv.status} />
              </Row>
              <Row style={{ justifyContent: "space-between" }}>
                <Body>
                  {Number(iv.total ?? 0).toFixed(2)}{" "}
                  {iv.currency ?? ""}
                </Body>
                <Body muted style={{ fontSize: 12 }}>
                  {t("parent.balance")}:{" "}
                  {Number(
                    iv.balance ?? Number(iv.total ?? 0) - Number(iv.paid ?? 0),
                  ).toFixed(2)}
                </Body>
              </Row>
              {(iv.status === "paid" || iv.status === "partial") && (
                <Pressable
                  onPress={() => openReceipt(iv.id)}
                  disabled={busy === iv.id}
                  style={({ pressed }) => ({
                    flexDirection: "row",
                    alignItems: "center",
                    gap: 6,
                    opacity: busy === iv.id ? 0.5 : pressed ? 0.6 : 1,
                  })}
                >
                  <Feather name="download" size={14} color={colors.primary} />
                  <Body
                    style={{
                      color: colors.primary,
                      fontFamily: "Inter_600SemiBold",
                    }}
                  >
                    {t("common.receipt")}
                  </Body>
                </Pressable>
              )}
            </View>
          ))
        )}
      </Card>

      <Card>
        <H2>{t("parent.payments")}</H2>
        <View style={{ height: 8 }} />
        {payments.length === 0 ? (
          <EmptyState icon="credit-card" title={t("common.empty")} />
        ) : (
          payments.slice(0, 12).map((p: any) => (
            <Row
              key={p.id}
              style={{
                paddingVertical: 10,
                borderTopWidth: 1,
                borderTopColor: colors.border,
                justifyContent: "space-between",
              }}
            >
              <View>
                <Body style={{ fontFamily: "Inter_500Medium" }}>
                  {p.method ?? "—"}
                </Body>
                <Body muted style={{ fontSize: 12 }}>
                  {p.paid_at
                    ? new Date(p.paid_at).toLocaleDateString()
                    : ""}
                </Body>
              </View>
              <Body style={{ fontFamily: "Inter_700Bold" }}>
                {Number(p.amount ?? 0).toFixed(2)}
              </Body>
            </Row>
          ))
        )}
      </Card>
    </Screen>
  );
}

function StatusPill({ status }: { status?: string }) {
  const { t } = useI18n();
  const tone =
    status === "paid"
      ? "success"
      : status === "overdue"
        ? "danger"
        : status === "partial"
          ? "info"
          : "warning";
  const label =
    status === "paid"
      ? t("status.paid")
      : status === "overdue"
        ? t("status.overdue")
        : status === "partial"
          ? t("status.partial")
          : t("status.unpaid");
  return <Pill label={label} tone={tone as any} />;
}
