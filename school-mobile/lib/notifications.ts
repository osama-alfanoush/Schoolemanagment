import { Platform } from "react-native";

import { Auth } from "./api";

/**
 * Register the Expo push token with the Laravel backend so server-side
 * absence/grade/homework notifications can reach this device.
 *
 * Uses lazy imports + try/catch so the call is a no-op in environments
 * where expo-notifications isn't available (e.g. early Expo Go versions
 * or web).
 */
export async function registerPushToken() {
  if (Platform.OS === "web") return;
  try {
    const Notifications = await import("expo-notifications").catch(
      () => null as any,
    );
    if (!Notifications) return;

    await Notifications.setNotificationHandler({
      handleNotification: async () => ({
        shouldShowAlert: true,
        shouldPlaySound: false,
        shouldSetBadge: false,
        shouldShowBanner: true,
        shouldShowList: true,
      }),
    });

    const settings = await Notifications.getPermissionsAsync();
    let granted = settings.granted;
    if (!granted) {
      const req = await Notifications.requestPermissionsAsync();
      granted = req.granted;
    }
    if (!granted) return;

    const token = await Notifications.getExpoPushTokenAsync().catch(
      () => null as any,
    );
    const value = token?.data;
    if (!value) return;

    const platform = Platform.OS === "ios" ? "ios" : "android";
    await Auth.registerPushToken(value, platform);
  } catch {
    // Notifications are best-effort — never block sign-in on failure.
  }
}
