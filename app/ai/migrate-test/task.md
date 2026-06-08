# Task: Migrate Jest + Cypress → Vitest + Playwright

This migration replaces Jest with Vitest for unit tests and Cypress with Playwright
for E2E tests. There are **5 unit test files** under `app/components/` and **3 E2E test
files** under `app/cypress/e2e/homepage/`.

## Global constraints (apply to EVERY step)

- Do NOT touch `server/`, `types/`, or `docker/`.
- Do NOT change component logic or props. Only test files, test config, and `package.json` may change.
- Do NOT add new test coverage. Keep test intent and assertions identical to what exists today.
- Playwright E2E tests must live under `app/e2e/`.
- Pin these exact dependency versions when installing:
  - `vitest@4.1.8`
  - `@vitejs/plugin-react@6.0.2`
  - `jsdom@29.1.1`
  - `@playwright/test@1.60.0`
- Package manager is `pnpm@9.15.0` (see `app/package.json`).
- Run all commands from the `app/` directory.

---

## Phase 1 — Jest → Vitest

### Step 1: Install Vitest dependencies

**What**: Add Vitest and its supporting packages as devDependencies in `app/package.json`.

**How**: From `app/`, run:
`pnpm add -D vitest@4.1.8 @vitejs/plugin-react@6.0.2 jsdom@29.1.1`
Do NOT reinstall, upgrade, or downgrade the existing `@testing-library/*` packages
(`@testing-library/react`, `@testing-library/user-event`, and especially
`@testing-library/jest-dom@^6.6.3`) — they already work with Vitest and Step 3 relies on
the existing `@testing-library/jest-dom/vitest` entry point. Do not remove Jest yet
(it is removed in a later step). Do not modify `server/`, `types/`, or `docker/`.

Note: installing Vitest 4 pulls in Vite 8, which emits a peer-dependency warning
`unmet peer sass@^1.70.0: found 1.43.x`. This is a warning, not a failure, and is
expected here. Because Step 2 relies on `sass` to compile SCSS modules under Vitest, if
SCSS processing later fails in Step 6, bumping `sass` to `^1.70.0` is the fix — but do
NOT change any `.scss` source files (only the `sass` package version, if needed).

**Done When**: `vitest`, `@vitejs/plugin-react`, and `jsdom` appear in `devDependencies`
of `app/package.json` at the exact versions above; `pnpm install` completes (peer-dependency
_warnings_ are acceptable; resolution _errors_ are not); and `pnpm ls vitest @vitejs/plugin-react jsdom --depth 0`
confirms the installed versions match the pinned versions exactly.

---

### Step 2: Create the shared Vitest config `app/vitest.config.ts`

**What**: Create a new file `app/vitest.config.ts` that replaces `app/jest.config.ts`. This is a **shared resource** named `app/vitest.config.ts` and is reused by all later unit-test steps.

**How**: The current `app/jest.config.ts` does three things that MUST be replicated exactly so test behavior is unchanged:

1. Uses the `jsdom` test environment with a setup file (`setupFilesAfterEnv: ['./jest.setup.ts']`). In Vitest this becomes `test.environment: 'jsdom'` and `test.setupFiles: ['./vitest.setup.ts']` (that setup file is created in Step 3 — its name is `app/vitest.setup.ts`).
2. Maps the TypeScript path aliases from `app/tsconfig.json` `compilerOptions.paths` (`components`, `locales`, `graphql`, `lib`, `styles`, `themes`, `types`). Note that bare imports like `import { Button } from 'components'` must resolve to `components/index.ts`, and `components/*` must resolve to `components/*` — mirror this for every alias.
3. Handles `.scss`/SCSS-module imports. Jest mapped `\.scss$` to `identity-obj-proxy`, which returns each class name verbatim (e.g. `styles.wrapper` → `"wrapper"`). Replicate this in Vitest with `css.modules.classNameStrategy: 'non-scoped'` so SCSS-module class names resolve to their original names. `sass` is already installed.

Use `@vitejs/plugin-react@6.0.2`. Before writing the `resolve.alias` block, open `app/tsconfig.json` and read `compilerOptions.paths`; derive every alias entry directly from those values — do NOT assume the mappings below are current. In particular, confirm the on-disk target of each alias (e.g. whether `types/*` points to `../types/*` outside the `app/` directory) and that the bare `components` → `components/index.ts` resolution matches how the app imports today. The block below is a template to adapt, not a source of truth:

```ts
import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";
import { resolve } from "path";

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: [
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
      { find: /^styles\/(.*)$/, replacement: resolve(__dirname, "styles/$1") },
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
        // next-intl lets Vite's resolver handle that import; Node's native
        // ESM resolver (used for externalized deps) does NOT probe extensions
        // and will fail with "Cannot find module .../next/navigation".
        inline: ["next-intl"],
      },
    },
    css: {
      modules: { classNameStrategy: "non-scoped" },
    },
  },
});
```

The `server.deps.inline: ['next-intl']` entry is required because the `components`
barrel (`components/index.ts`) transitively imports the real `i18n/navigation`
(`next-intl/navigation` → `next/navigation`); without inlining next-intl, every test that
imports from `components` (even ones that don't mock navigation) fails to resolve
`next/navigation`. Do not use a Babel transform. Do not modify `server/`, `types/`, or `docker/`.

**Done When**: `app/vitest.config.ts` exists, imports `@vitejs/plugin-react`, defines `jsdom` environment, references `./vitest.setup.ts`, sets `css.modules.classNameStrategy: 'non-scoped'`, and every `resolve.alias` entry was verified against `app/tsconfig.json` `compilerOptions.paths` (each target confirmed to match exactly, including the bare `components` → `components/index.ts` mapping and any aliases pointing outside `app/`).

---

### Step 3: Create the shared Vitest setup file `app/vitest.setup.ts` and update `tsconfig.test.json`

**What**: Create `app/vitest.setup.ts` (the Vitest equivalent of `app/jest.setup.ts`) and update `app/tsconfig.test.json` to reference Vitest types instead of Jest. `app/vitest.setup.ts` is a **shared resource** reused by all unit-test steps.

**How**: `app/jest.setup.ts` currently (a) imports `@testing-library/jest-dom` to register DOM matchers, and (b) sets three environment variables that tests depend on:

- `SHORTCUT_ICONS_SERVER_HOST: 'mockhost1'`
- `UTILS_ICONS_SERVER_HOST: 'mockhost2'`
- `STORE_IMAGE_SERVER_HOST: 'mockhost3'` (the Shop test asserts image `src` of `https://mockhost3/...`, so this value MUST be preserved exactly)

Create `app/vitest.setup.ts` that does both: `import '@testing-library/jest-dom/vitest';` and sets the same three env vars with the same values.

Then update `app/tsconfig.test.json`: it currently extends `tsconfig.json` and only overrides `jsx`. Add Vitest globals typing so `describe/test/expect/vi` type-check (e.g. add `"types": ["vitest/globals", "@testing-library/jest-dom"]` under `compilerOptions`, and keep the existing `"jsx": "react-jsx"`). Remove any `@types/jest`-specific references if present. Do not delete `app/jest.setup.ts` yet (removed in Step 7).

**Done When**: `app/vitest.setup.ts` exists, imports `@testing-library/jest-dom/vitest`, and sets `SHORTCUT_ICONS_SERVER_HOST=mockhost1`, `UTILS_ICONS_SERVER_HOST=mockhost2`, `STORE_IMAGE_SERVER_HOST=mockhost3`; and `app/tsconfig.test.json` references Vitest globals instead of Jest.

---

### Step 4: Point the `test` script at Vitest in `app/package.json`

**What**: Update the `test` npm script in `app/package.json` so it runs Vitest using the shared config `app/vitest.config.ts`.

**How**: Change `"test": "jest"` to `"test": "vitest run"` (use `vitest run` for a single non-watch CI-style run; `vitest` alone is watch mode). Leave the `test:e2e` script unchanged for now — it is migrated in Phase 2. Do not remove the Jest devDependencies yet. Do not modify `server/`, `types/`, or `docker/`.

**Done When**: The `test` script in `app/package.json` runs `vitest run`, and `pnpm test` invokes Vitest (it may still fail until test files are migrated in Step 5 — that is expected here).

---

### Step 5: Migrate the unit test files from Jest API to Vitest API

**What**: Convert every Jest-specific API call in the unit test files under `app/components/` to the Vitest equivalent. Do not change any assertion, mock data, or test description.

**How**: Scan all unit test files with `grep -rn "jest\." app/components` and `grep -rln "\.test\.tsx\?$" app/components` (there are 5 such files today). For each file:

- Replace `jest.mock(...)` with `vi.mock(...)`, `jest.fn(...)` with `vi.fn(...)`, and any other `jest.*` call with the `vi.*` equivalent.
- Add `import { vi } from 'vitest';` to any file that uses `vi.*`. (`describe`, `test`, `expect` are provided as globals by the shared config `app/vitest.config.ts`, so they do not need imports.)
- Do NOT change `render`/`screen`/`fireEvent` imports from `@testing-library/react` — they are unchanged.
- Keep all `data-testid` queries, mocked module paths (e.g. `next/image`, `../../i18n/navigation`), mock objects, and assertions byte-for-byte identical.

Several files mock `next/image` and/or `../../i18n/navigation` via `jest.mock` — those become `vi.mock` with identical factory bodies. One file (the Shop test) asserts image `src` values built from `STORE_IMAGE_SERVER_HOST` (`mockhost3`), which is supplied by the shared setup file `app/vitest.setup.ts`; do not inline that value into the test.

Do not change component logic or props. Do not modify `server/`, `types/`, or `docker/`.

**Done When**: `grep -rn "jest\." app/components` returns no matches, every file that uses `vi.*` imports `vi` from `vitest`, and all assertions/mock data are unchanged from the original.

---

### Step 6: Run the full Vitest unit suite and confirm it passes

**What**: Execute all migrated unit tests and verify they pass with no TypeScript or import errors.

**How**: From `app/`, run `pnpm test` (which runs `vitest run` against `app/vitest.config.ts`). Investigate any failures — known causes for this codebase:

- `[sass] sass.initAsyncCompiler is not a function`: the installed `sass` is older than Vite 8 requires. Fix by bumping the `sass` package to `^1.70.0` (`pnpm add -D sass@^1.70.0`). Do NOT edit any `.scss` source files.
- `Cannot find module '.../next/navigation'`: ensure `app/vitest.config.ts` has `test.server.deps.inline: ['next-intl']` (see Step 2). `next` has no `exports` map, so this inline is required for any test importing the `components` barrel.
- Missing path alias in `app/vitest.config.ts`, missing env var in `app/vitest.setup.ts`, or an un-migrated `jest.*` call.
  A benign jsdom log `Not implemented: navigation to another Document` may appear (from a click handler) and does NOT fail the run. Fix config/test issues only; do not change component logic or props, and do not modify `server/`, `types/`, or `docker/`.

**Done When**: All Vitest unit tests pass (every test file under `app/components/` is green), and no TypeScript or import errors are reported.

---

### Step 7: Remove Jest from the project

**What**: Remove Jest and its now-unused tooling from `app/package.json` and delete obsolete Jest files.

**How**: From `app/`, uninstall Jest-only packages:
`pnpm remove jest jest-environment-jsdom ts-jest @types/jest identity-obj-proxy`
(`identity-obj-proxy` was only used for the Jest `.scss` mapping, now replaced by `css.modules.classNameStrategy` in `app/vitest.config.ts`.) Delete `app/jest.config.ts` and `app/jest.setup.ts`. Verify no remaining references with `grep -rn "jest" app/package.json app/tsconfig.test.json` (the only acceptable remaining match is `@testing-library/jest-dom`, which Vitest uses). Do not modify `server/`, `types/`, or `docker/`.

**Done When**: `jest`, `jest-environment-jsdom`, `ts-jest`, `@types/jest`, and `identity-obj-proxy` no longer appear in `app/package.json`; `app/jest.config.ts` and `app/jest.setup.ts` are deleted; and `pnpm test` (Vitest) still passes.

---

## Phase 2 — Cypress → Playwright

### Step 8: Install Playwright

**What**: Add `@playwright/test@1.60.0` as a devDependency in `app/package.json` and install its browser binaries.

**How**: From `app/`, run `pnpm add -D @playwright/test@1.60.0` then `pnpm exec playwright install` to download browsers. Do not remove Cypress yet (removed in Step 12). Do not modify `server/`, `types/`, or `docker/`.

**Done When**: `@playwright/test@1.60.0` appears in `devDependencies` of `app/package.json`, and `pnpm exec playwright --version` runs successfully.

---

### Step 9: Create the shared Playwright config `app/playwright.config.ts`

**What**: Create `app/playwright.config.ts`. This is a **shared resource** named `app/playwright.config.ts`, reused by the E2E run step.

**How**: The current Cypress config (`app/cypress.config.ts`) uses `baseUrl: 'http://localhost'` — the app is served by the nginx container on port 80 from `docker-compose up -d` (see root `docker-compose.yml`). Create `app/playwright.config.ts` with:

- `testDir: './e2e'` (Playwright tests live under `app/e2e/`)
- `use.baseURL: 'http://localhost'`
- A reasonable `timeout`/`expect` timeout (Cypress used a 10s timeout for location assertions — preserve similar generosity).

Example:

```ts
import { defineConfig, devices } from "@playwright/test";

export default defineConfig({
  testDir: "./e2e",
  use: {
    baseURL: "http://localhost",
  },
  expect: { timeout: 10000 },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"] } }],
});
```

Do not configure Playwright to start its own server — tests run against `docker-compose up -d`. Use a single Chromium project: WebKit is not supported on macOS 12 (`playwright install` fails on `webkit`), so install only Chromium (`pnpm exec playwright install chromium`) and keep the config Chromium-only. Do not modify `server/`, `types/`, or `docker/`.

**Done When**: `app/playwright.config.ts` exists with `testDir: './e2e'` and `baseURL: 'http://localhost'`.

---

### Step 10: Migrate the 3 E2E tests from Cypress to Playwright under `app/e2e/`

**What**: Recreate the 3 Cypress E2E specs as Playwright tests under `app/e2e/`, preserving identical test intent, selectors, and assertions. Do not add new test cases.

**How**: The source specs live in `app/cypress/e2e/homepage/` (3 files: homepage sidebar, shop, and category flows). Create equivalent Playwright specs under `app/e2e/` (e.g. `app/e2e/homepage/`). The Playwright config `app/playwright.config.ts` sets `baseURL: 'http://localhost'`, so use relative paths in `page.goto('/')`. Translate Cypress APIs to Playwright equivalents, keeping every selector and asserted value identical:

- `cy.visit('/')` → `await page.goto('/')`
- `cy.get(sel)` → `page.locator(sel)`
- `.type('x')` → `.fill('x')` (or `.pressSequentially('x')` if the input needs keystroke events)
- `.should('have.value', 'x')` → `await expect(locator).toHaveValue('x')`
- `.should('be.checked')` / `.should('exist')` → `await expect(locator).toBeChecked()` / `await expect(locator).toBeVisible()`
- `.click()` → `await locator.click()`
- `cy.contains('text')` → `page.getByText('text')` and `await expect(...).toBeVisible()`
- `cy.location('pathname').should('eq', x)` → `await expect(page).toHaveURL(...)` matching the pathname
- `.each(...)` and `.first()` → Playwright `.first()` / loops over `locator.all()`
- Preserve the Chinese-language UI strings exactly (e.g. placeholder `美食、生鮮雜貨、飲料等`, price/delivery labels, store name `九湯屋日本拉麵`).

There are no custom Cypress commands to migrate — `app/cypress/support/commands.ts` contains only commented examples and `app/cypress/support/e2e.ts` only imports it. Do not modify `server/`, `types/`, or `docker/`.

**Done When**: 3 Playwright spec files exist under `app/e2e/`, each mirroring one Cypress spec's selectors and assertions exactly, with no added or removed test cases.

---

### Step 11: Run the Playwright E2E suite against the running stack and confirm it passes

**What**: Start the application via Docker and run the Playwright E2E suite to verify it passes.

**How**: From the repo root, run `docker-compose up -d`. Note that `docker-compose up -d` returns as soon as the containers are _started_, NOT when the app is actually serving — running Playwright immediately will fail with connection/timeout errors. Add an explicit readiness check that polls `http://localhost` until it returns HTTP 200 before running the suite, for example:

```bash
docker-compose up -d
# Wait for the app (nginx → web) to actually serve before running E2E
for i in $(seq 1 60); do
  if curl -sf -o /dev/null http://localhost; then echo "app is ready"; break; fi
  echo "waiting for app... ($i)"; sleep 5
done
```

(Alternatively, configure `webServer`/`use.baseURL` with Playwright's built-in wait, but since the app is started externally via Docker, the polling approach above is preferred. Do NOT have Playwright start its own server.) Only after the readiness check passes, from `app/` run `pnpm exec playwright test` (uses `app/playwright.config.ts`, `testDir: './e2e'`, `baseURL: 'http://localhost'`). Investigate failures (timing, selector translation, or URL assertions) and fix the E2E test files or `app/playwright.config.ts` only. Do not change application/component logic, and do not modify `server/`, `types/`, or `docker/`.

**Done When**: The readiness check confirms `http://localhost` returns HTTP 200, and all Playwright E2E tests under `app/e2e/` then pass against `docker-compose up -d`.

---

### Step 12: Remove Cypress from the project

**What**: Remove Cypress from `app/package.json` and delete the Cypress directory and config, then point the `test:e2e` script at Playwright.

**How**: From `app/`, run `pnpm remove cypress`. Delete `app/cypress.config.ts` and the entire `app/cypress/` directory (specs + `support/`). Remove `cypress` from the `onlyBuiltDependencies` array in `app/package.json`. Update the `test:e2e` script from `"cypress run"` to `"playwright test"`. Also remove the `cypress.config.ts` entry from the `exclude` array in `app/tsconfig.json` if present (this is config cleanup, not a `types/` change). Verify with `grep -rni "cypress" app/package.json app/tsconfig.json` returning no matches. Do not modify `server/`, `types/`, or `docker/`.

**Done When**: `cypress` no longer appears in `app/package.json` (neither dependencies nor `onlyBuiltDependencies`), `app/cypress.config.ts` and `app/cypress/` are deleted, the `test:e2e` script runs `playwright test`, and the Playwright suite still passes.

---

### Step 13: Final verification [HUMAN REVIEW]

**What**: Confirm all success conditions from `ai/migrate-test/objective.md` are met.

**How**: Verify:

- No TypeScript or import errors are shown in the Cursor editor for any test or config file.
- `pnpm test` (Vitest) passes for all 5 unit test files under `app/components/`.
- `pnpm exec playwright test` passes for all 3 E2E files under `app/e2e/` against `docker-compose up -d`.
- Jest and Cypress are fully removed from `app/package.json` (no `jest`, `ts-jest`, `jest-environment-jsdom`, `@types/jest`, `identity-obj-proxy`, or `cypress`).
- No changes were made to `server/`, `types/`, or `docker/`, and no component logic/props changed (review the diff).

**[HUMAN REVIEW]**: A human must visually confirm the editor shows no TS/import errors and that the diff contains no component logic, props, scss, or Tailwind changes — these require human judgment and cannot be fully verified by the test runners alone.

**Done When**: A human confirms every bullet above is satisfied.
