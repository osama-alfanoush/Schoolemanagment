// Dark mode init — runs before React renders to prevent a flash of the wrong
// theme. Must use the SAME storage key + default as the next-themes provider
// below ("ui-mode", default light) so the two never disagree on refresh.
const savedMode = localStorage.getItem("ui-mode")
if (savedMode === "dark") {
  document.documentElement.classList.add("dark")
} else {
  document.documentElement.classList.remove("dark")
}

import { createRoot } from "react-dom/client";
import { ThemeProvider } from "next-themes";
import { ThemeProvider as SchoolThemeProvider } from "@/lib/ThemeContext";
import App from "./App";
import "@/lib/i18n";
import "./index.css";
import "./styles/globals.css";

createRoot(document.getElementById("root")!).render(
  <SchoolThemeProvider>
    <ThemeProvider attribute="class" defaultTheme="light" enableSystem={false} storageKey="ui-mode">
      <App />
    </ThemeProvider>
  </SchoolThemeProvider>,
);
