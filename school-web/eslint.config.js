import js from "@eslint/js";
import tseslint from "typescript-eslint";
import reactHooks from "eslint-plugin-react-hooks";
import jsxA11y from "eslint-plugin-jsx-a11y";
import globals from "globals";

// Flat config (ESLint 9). Type-aware linting is enabled via `projectService`
// so the @typescript-eslint/no-unsafe-* and no-explicit-any rules can flag
// untyped `any` flowing through the codebase. Plugins are registered explicitly
// as objects (flat-config requirement) rather than spreading preset configs.
export default tseslint.config(
  {
    ignores: [
      "dist/**",
      "coverage/**",
      "node_modules/**",
      "*.config.js",
      "*.config.ts",
    ],
  },

  js.configs.recommended,
  ...tseslint.configs.recommendedTypeChecked,

  {
    files: ["**/*.{ts,tsx}"],
    plugins: {
      "react-hooks": reactHooks,
      "jsx-a11y": jsxA11y,
    },
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
      globals: {
        ...globals.browser,
        ...globals.es2021,
      },
    },
    rules: {
      // Accessibility (recommended set).
      ...jsxA11y.flatConfigs.recommended.rules,

      // React hooks correctness + effect dependency completeness.
      "react-hooks/rules-of-hooks": "error",
      "react-hooks/exhaustive-deps": "warn",

      // Unused vars/args as warnings; allow intentional `_`-prefixed throwaways.
      "@typescript-eslint/no-unused-vars": [
        "warn",
        { argsIgnorePattern: "^_", varsIgnorePattern: "^_", caughtErrorsIgnorePattern: "^_" },
      ],
      // Surface explicit `any` so it can be tightened over time.
      "@typescript-eslint/no-explicit-any": "warn",

      // The no-unsafe-* family is driven almost entirely by untyped API
      // responses; keep them as warnings (visible, non-blocking) until the API
      // client is fully typed, rather than failing CI on ~1800 findings.
      "@typescript-eslint/no-unsafe-member-access": "warn",
      "@typescript-eslint/no-unsafe-assignment": "warn",
      "@typescript-eslint/no-unsafe-argument": "warn",
      "@typescript-eslint/no-unsafe-call": "warn",
      "@typescript-eslint/no-unsafe-return": "warn",
    },
  },

  // Tests: relax type-aware strictness — fixtures and mocks legitimately use `any`.
  {
    files: ["src/test/**", "**/*.test.{ts,tsx}"],
    rules: {
      "@typescript-eslint/no-explicit-any": "off",
      "@typescript-eslint/no-unsafe-assignment": "off",
      "@typescript-eslint/no-unsafe-member-access": "off",
      "@typescript-eslint/no-unsafe-call": "off",
      "@typescript-eslint/no-unsafe-argument": "off",
      "@typescript-eslint/no-unsafe-return": "off",
    },
  },
);
