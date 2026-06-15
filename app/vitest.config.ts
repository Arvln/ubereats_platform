import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";
import { resolve } from "path";

// Aliases derived directly from app/tsconfig.json compilerOptions.paths.
// The bare `components` entry mirrors how the app imports its barrel
// (e.g. `import { Button } from 'components'` -> components/index.ts).
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: [
      { find: /^@\/(.*)$/, replacement: resolve(__dirname, "$1") },
      {
        find: /^components$/,
        replacement: resolve(__dirname, "components/index.ts"),
      },
      {
        find: /^components\/(.*)$/,
        replacement: resolve(__dirname, "components/$1"),
      },
      {
        find: /^locales\/(.*)$/,
        replacement: resolve(__dirname, "locales/$1"),
      },
      {
        find: /^graphql\/(.*)$/,
        replacement: resolve(__dirname, "graphql/$1"),
      },
      { find: /^lib\/(.*)$/, replacement: resolve(__dirname, "lib/$1") },
      { find: /^themes\/(.*)$/, replacement: resolve(__dirname, "themes/$1") },
      { find: /^types\/(.*)$/, replacement: resolve(__dirname, "../types/$1") },
    ],
  },
  test: {
    globals: true,
    environment: "jsdom",
    setupFiles: ["./vitest.setup.ts"],
    include: ["components/**/*.test.{ts,tsx}"],
    server: {
      deps: {
        // `next` ships no package "exports" map, so subpaths like
        // `next/navigation` only resolve via extension probing. Inlining
        // next-intl lets Vite's resolver handle that import (Node's native
        // ESM resolver, used for externalized deps, does not probe extensions).
        inline: ["next-intl"],
      },
    },
    css: {
      // Replicates the Jest identity-obj-proxy behavior: SCSS-module class
      // names resolve to their original (non-hashed) names so existing
      // toHaveClass(...) assertions keep passing.
      modules: { classNameStrategy: "non-scoped" },
    },
  },
});
