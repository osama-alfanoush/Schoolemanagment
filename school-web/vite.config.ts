import { defineConfig, type Plugin } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";
import path from "path";

const rawPort = process.env.PORT ?? "5173";
const port = Number(rawPort);

if (Number.isNaN(port) || port <= 0) {
  throw new Error(`Invalid PORT value: "${rawPort}"`);
}

const basePath = process.env.BASE_PATH ?? "/";

// Host binding for the dev/preview servers. Defaults to localhost so neither
// server is exposed on the LAN by default. Set VITE_HOST=0.0.0.0 for Docker /
// mobile-device testing, and VITE_ALLOW_ALL_HOSTS=true only if you also need to
// reach it via a non-localhost hostname (disables Vite's anti-DNS-rebinding
// host check, so leave it off unless required).
const devHost = process.env.VITE_HOST ?? "localhost";
const allowAllHosts = process.env.VITE_ALLOW_ALL_HOSTS === "true";

/**
 * Injects the Content-Security-Policy <meta> into index.html.
 * Production keeps script-src locked to 'self' (the build emits only external
 * module scripts, so no inline/eval is needed). The dev server needs
 * 'unsafe-inline'/'unsafe-eval' for the React-refresh preamble and HMR over a
 * websocket, so it gets a relaxed policy that never ships to production.
 */
function cspPlugin(isDev: boolean): Plugin {
  const csp = isDev
    ? "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; " +
      "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; " +
      "font-src 'self' https://fonts.gstatic.com data:; " +
      "img-src 'self' data: blob: http: https:; " +
      "connect-src 'self' ws: wss: http: https:; object-src 'none'; base-uri 'self'"
    : "default-src 'self'; script-src 'self'; " +
      "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; " +
      "font-src 'self' https://fonts.gstatic.com; " +
      "img-src 'self' data: blob: https:; " +
      "connect-src 'self' https:; object-src 'none'; base-uri 'self'; form-action 'self'";

  return {
    name: "inject-csp",
    transformIndexHtml(html) {
      return html.replace(
        "<!-- CSP -->",
        `<meta http-equiv="Content-Security-Policy" content="${csp}" />`,
      );
    },
  };
}

export default defineConfig(({ command }) => ({
  base: basePath,
  plugins: [
    react(),
    tailwindcss(),
    cspPlugin(command === "serve"),
  ],
  resolve: {
    alias: {
      "@": path.resolve(import.meta.dirname, "src"),
      "@assets": path.resolve(import.meta.dirname, "..", "..", "attached_assets"),
    },
    dedupe: ["react", "react-dom"],
  },
  root: path.resolve(import.meta.dirname),
  build: {
    outDir: path.resolve(import.meta.dirname, "dist/public"),
    emptyOutDir: true,
    chunkSizeWarningLimit: 600,
    sourcemap: 'hidden',
    rollupOptions: {
      output: {
        manualChunks: (id: string) => {
          if (id.includes('node_modules/react') ||
              id.includes('node_modules/react-dom') ||
              id.includes('node_modules/scheduler')) {
            return 'vendor-react';
          }
          if (id.includes('@tanstack/react-query')) {
            return 'vendor-query';
          }
          if (id.includes('framer-motion')) {
            return 'vendor-motion';
          }
          if (id.includes('recharts') || id.includes('d3-')) {
            return 'vendor-charts';
          }
          if (id.includes('@radix-ui') ||
              id.includes('lucide-react') ||
              id.includes('clsx') ||
              id.includes('tailwind-merge') ||
              id.includes('class-variance-authority') ||
              id.includes('cmdk') ||
              id.includes('vaul') ||
              id.includes('sonner') ||
              id.includes('embla-carousel')) {
            return 'vendor-ui';
          }
          if (id.includes('react-hook-form') ||
              id.includes('@hookform') ||
              id.includes('zod') ||
              id.includes('react-day-picker') ||
              id.includes('input-otp')) {
            return 'vendor-forms';
          }
          if (id.includes('react-icons') ||
              id.includes('date-fns') ||
              id.includes('i18next') ||
              id.includes('react-i18next')) {
            return 'vendor-utils';
          }
        },
      },
    },
  },
  server: {
    port,
    host: devHost,
    ...(allowAllHosts ? { allowedHosts: true as const } : {}),
    proxy: {
      "/api": {
        target: "http://127.0.0.1:8000",
        changeOrigin: true,
        // Do NOT rewrite the path — Laravel serves routes under the /api prefix.
      },
    },
    fs: {
      strict: true,
      deny: ["**/.*"],
    },
  },
  preview: {
    port,
    host: devHost,
    ...(allowAllHosts ? { allowedHosts: true as const } : {}),
  },
}));