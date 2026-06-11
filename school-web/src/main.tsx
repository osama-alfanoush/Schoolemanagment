import { createRoot } from "react-dom/client";
import { ThemeProvider } from "next-themes";
import { ThemeProvider as SchoolThemeProvider } from "@/lib/ThemeContext";
import App from "./App";
import "@/lib/i18n";
import "./index.css";
import "./styles/globals.css";

createRoot(document.getElementById("root")!).render(
  <SchoolThemeProvider>
    <ThemeProvider attribute="class" defaultTheme="dark" enableSystem={false}>
      <App />
    </ThemeProvider>
  </SchoolThemeProvider>,
);
