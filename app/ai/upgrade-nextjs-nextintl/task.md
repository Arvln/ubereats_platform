# Task: Upgrade Next.js 14 → 16 and next-intl 3 → 4

Reference: `ai/upgrade-nextjs-nextintl/objective.md`, `.cursorrules`, `ai/upgrade-nextjs-nextintl/prompt.md`.

**Constraints (do not violate):**

- Do not touch `server/`, `types/`, `docker/`
- Do not restructure internals of `features/` or `components/`
- Do not upgrade Tailwind, Apollo, or any other dependencies unless required for the version bumps
- Do not add new features
- Only change what is necessary for the version upgrades (per `.cursorrules`: “Only change what is necessary to complete this task”)

**Prerequisites:**

- Node.js **18.17+** (Next.js 16 minimum) in local and Docker build environments

**Current versions:**

| Package               | Current  | Target            |
| --------------------- | -------- | ----------------- |
| `next`                | ^14.2.22 | 16.x (latest)     |
| `next-intl`           | ^3.26.3  | 4.x (latest)      |
| `eslint-config-next`  | 14.2.22  | 16.x (match Next) |
| `react` / `react-dom` | 19.0.0   | no change         |

**Files most likely to change:**

| Area                            | Files                                                                                                                                             |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dependencies                    | `package.json`, lockfile                                                                                                                          |
| Locale proxy (was middleware)   | `middleware.ts` → `proxy.ts`                                                                                                                      |
| Next config                     | `next.config.js`                                                                                                                                  |
| i18n                            | `i18n.ts`, `i18n/request.ts`, `i18n/navigation.ts`                                                                                                |
| App Router (async `params`)     | `app/[locale]/layout.tsx`, `app/[locale]/[title]/page.tsx`, `app/[locale]/marketing/[uuid]/page.tsx`, `app/[locale]/store/[name]/[uuid]/page.tsx` |
| Tests (only if ESM/Jest breaks) | `jest.config.ts`, navigation mocks in component tests                                                                                             |

**Unchanged by design (verify only):**

- Data layer uses Apollo (`lib/page-data.ts`, `graphql/apollo_client`) — no `fetch()` in app; Next 16 default fetch caching changes should not affect data loading
- Path aliases unchanged (`components/*`, `features/*`, `locales/*`, `lib/*`, etc. per `.cursorrules`)
- Locale consumers: `features/footer` (`useRouter` / `usePathname` from `i18n/navigation`), `features/header`, `components/shop`, `components/category_item`, `features/carousel`
- `next-intl` in features: `useTranslations()` with dot-path keys (per `.cursorrules` i18n convention)

---

### Step 1: Baseline — confirm app builds on current versions

**What**: Establish a known-good state before changing dependencies.

**How**:

1. From repo root (where `docker-compose.yml` lives), run `docker-compose build --no-cache && docker-compose up -d`.
2. Spot-check: home (`/en-US`), category (`/en-US/{title}`), marketing, store, locale switch (en-US ↔ zh-TW).
3. Confirm Cursor shows no existing TypeScript/import errors in `app/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Record any pre-existing UI or build issues so they are not blamed on the upgrade.

---

### Step 2: Bump `next`, `next-intl`, and `eslint-config-next`

**What**: Update only the packages required for this migration.

**How**:

1. In `package.json` (app workspace):
   - `next` → `^16` (latest 16.x)
   - `next-intl` → `^4` (latest 4.x)
   - `eslint-config-next` → same major as `next` (16.x)
2. Leave `react`, `react-dom`, Tailwind, Apollo, and all other dependencies unchanged.
3. Run `pnpm install` in `app/`.
4. Resolve peer-dependency warnings only if they block install or build — do not opportunistically upgrade unrelated packages.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 3: Run the Next.js 16 upgrade codemods

**What**: Automate breaking-change migrations where possible.

**How**:

1. From `app/`, run:
   ```bash
   npx @next/codemod@canary upgrade latest
   ```
2. Run the async request API codemod if not included above:
   ```bash
   npx @next/codemod@canary next-async-request-api .
   ```
3. Run the middleware → proxy codemod:
   ```bash
   npx @next/codemod@canary middleware-to-proxy .
   ```
4. Review every file the codemods touch; remove `@next/codemod` comments and `UnsafeUnwrapped` casts only after fixing the underlying code.
5. This codebase has **no** `cookies()`, `headers()`, or `searchParams` usage today — expect changes mainly in `app/**` for `params`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 4: Rename `middleware.ts` → `proxy.ts` (Next.js 16)

**What**: Next.js 16 replaces the `middleware.ts` convention with `proxy.ts` at the network boundary. next-intl locale routing will not run if this file is missing or misnamed.

**How**:

1. Rename `middleware.ts` to `proxy.ts` at the app project root (same level as `app/`).
2. Current setup uses a **default export** from `createMiddleware(routing)` — file contents can stay the same; keep importing from `next-intl/middleware` (no import path change required for default `createMiddleware` usage).
3. Keep the existing `config.matcher`: `['/((?!api|_next|_vercel|.*\\..*).*)']` (matches next-intl v4 recommendation).
4. **Only if** you use a custom named `middleware` wrapper (not the case today), rename the export to `proxy` per [Next.js proxy docs](https://nextjs.org/docs/messages/middleware-to-proxy).
5. Delete `middleware.ts` after `proxy.ts` is in place — do not keep both files.
6. Grep the repo for references to `middleware.ts` in docs/comments only; do not change `identity-obj-proxy` or unrelated “middleware” strings.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Confirm `/` redirects to `/en-US` and locale-prefixed routes load (proxy must run on each request).

---

### Step 5: Migrate App Router `params` to async

**What**: Next.js 15+ (required in 16) makes `params` in layouts and pages asynchronous — must `await params`.

**How**:

Update each file that destructures `params` synchronously. Preferred pattern (per [Next.js upgrade guide](https://nextjs.org/docs/app/guides/upgrading/version-15)):

```tsx
type PageProps = {
  params: Promise<{ title: string }>;
};

export default async function CategoryPage({ params }: PageProps) {
  const { title } = await params;
  // ...
}
```

Files to update (current sync destructuring):

1. `app/[locale]/layout.tsx` — `params: { locale }`
2. `app/[locale]/[title]/page.tsx` — `params: { title }`
3. `app/[locale]/marketing/[uuid]/page.tsx` — `params: { uuid }`
4. `app/[locale]/store/[name]/[uuid]/page.tsx` — `params: { name, uuid }`

Rules (per `.cursorrules`):

- Keep changes minimal — only async/await and type updates; no refactors.
- Do not change component props/APIs in `features/` or `components/`.
- If `generateMetadata` / `generateViewport` are added later, they must also `await params`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 6: Add `setRequestLocale` for locale-based static rendering (next-intl)

**What**: next-intl requires `setRequestLocale` so locale routes and SSG pages render correctly with Next.js 16.

**How**:

1. In `app/[locale]/layout.tsx`, after resolving `locale` from `await params`, call:
   ```tsx
   import { setRequestLocale } from "next-intl/server";
   setRequestLocale(locale);
   ```
2. In each static/SSG page under `[locale]` that uses `generateStaticParams`, call `setRequestLocale` at the top of the default export:
   - `app/[locale]/page.tsx` — use `getLocale()` from `next-intl/server` if `locale` is not in page `params`
   - `app/[locale]/[title]/page.tsx`
   - `app/[locale]/marketing/[uuid]/page.tsx`
   - `app/[locale]/store/[name]/[uuid]/page.tsx`
3. Do not add `setRequestLocale` to client components (`locale-layout-client.tsx`).

Reference: [next-intl 4.0 blog](https://next-intl.dev/blog/next-intl-4-0).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 7: Update `i18n/request.ts` for next-intl v4

**What**: Align request config with v4 requirements (explicit `locale`, `hasLocale` helper).

**How**:

1. File already returns `locale` and awaits `requestLocale` — keep that behavior (required in v4).
2. Replace manual `locales.includes(...)` check with `hasLocale` from `next-intl`:
   ```tsx
   import { hasLocale } from "next-intl";
   const locale = hasLocale(routing.locales, requested)
     ? requested
     : routing.defaultLocale;
   ```
3. Keep dynamic import path `../locales/${locale}.json` (matches existing `locales/` alias per `.cursorrules`).
4. Do not move `i18n.ts` or restructure the `i18n/` folder.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 8: Update `i18n.ts` routing config for v4 cookie behavior

**What**: next-intl v4 changes locale cookie defaults (GDPR); `localeDetection: false` no longer implies “no cookie.”

**How**:

1. Current config: `localeDetection: false` (manual locale switch in footer).
2. If the app should **not** set a locale cookie (rely on URL prefix only), add explicitly:
   ```tsx
   localeCookie: false,
   ```
   in `defineRouting({ ... })` in `i18n.ts`.
3. If a persistent cookie is desired (previous long-lived behavior), use `localeCookie: { maxAge: ... }` instead.
4. Do not change `locales`, `defaultLocale`, or `localePrefix: 'always'` — URLs must stay `/en-US/...` and `/zh-TW/...`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Confirm locale switching in the footer still works and cookie/session behavior matches product expectations after v4 GDPR defaults.

---

### Step 9: Simplify `NextIntlClientProvider` in locale layout (v4 inheritance)

**What**: next-intl v4 inherits `messages` (and `formats`) from `i18n/request.ts` into `NextIntlClientProvider`.

**How**:

1. In `app/[locale]/layout.tsx`, the provider currently passes `locale` and `messages` from `loadMessages()`.
2. Try removing the `messages={messages}` prop (and `loadMessages` call) if client components still receive translations — v4 inherits from request config.
3. If removing `messages` breaks client `useTranslations()` in tests or runtime, keep passing `messages` — minimal fix wins.
4. Always keep `locale` on the provider (or ensure layout still validates locale against `locales` from `i18n.ts`).
5. Do not change `LocaleLayoutClient` or `features/layout` structure.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Verify all `useTranslations()` strings render on client-heavy pages (footer, header, modals).

---

### Step 10: Verify locale proxy and navigation APIs

**What**: Ensure locale routing (`proxy.ts`) and programmatic navigation still work with next-intl v4.

**How**:

1. `proxy.ts` — `createMiddleware(routing)` with existing matcher (Step 4).
2. `i18n/navigation.ts` — `createNavigation(routing)` should remain; fix only if TypeScript or runtime errors appear.
3. `features/footer/index.tsx` — `router.replace(pathname, { locale: language })` must still switch locale.
4. `components/shop`, `components/category_item`, `features/header`, `features/carousel` — `Link` from `i18n/navigation` must preserve locale prefix in hrefs.
5. Do not change footer/header component structure (per constraints).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Switch en-US ↔ zh-TW on home, a category page, marketing, and store; confirm URL prefix and content language update.

---

### Step 11: Update `next.config.js` for Next 16 + next-intl plugin

**What**: Ensure Next config and next-intl plugin remain valid after upgrades.

**How**:

1. Keep `createNextIntlPlugin` from `next-intl/plugin` — if the default path fails, pass explicitly:
   ```js
   createNextIntlPlugin("./i18n/request.ts");
   ```
2. Leave `reactStrictMode`, `env`, `images.remotePatterns`, and `webpack` (Sass / `resolve-url-loader`) unchanged unless build fails.
3. If build logs mention deprecated `skipMiddlewareUrlNormalize`, rename to `skipProxyUrlNormalize` in `next.config.js` only if present.
4. Do not edit files under `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Confirm Sass/styles still compile (webpack `resolve-url-loader` override).

---

### Step 12: Fix TypeScript and ESLint issues from upgrades

**What**: Clear editor and CI type/lint errors introduced by new package versions.

**How**:

1. Run `pnpm exec tsc --noEmit` in `app/` (matches `dev` script check).
2. Run `pnpm lint` — fix only errors caused by this upgrade.
3. Regenerate `next-env.d.ts` via `pnpm build` if Next types changed.
4. **Optional** (only if TS errors on `React` types): bump `@types/react` to match React 19 — do not upgrade other `@types/*` packages opportunistically.
5. **Optional** (only if Jest fails on ESM `next-intl`): follow [next-intl testing docs](https://next-intl.dev/docs/environments/testing) — e.g. `next/jest` in `jest.config.ts`. Update mocks in `components/shop/index.test.tsx` and `components/category_item/index.test.tsx` only if needed.
6. Skip optional next-intl v4 features unless required: strict ICU argument types, `AppConfig` augmentation in a new `global.ts`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 13: Full regression verification

**What**: Confirm success conditions from `objective.md`.

**How**:

1. Human runs from repo root:
   ```bash
   docker-compose build --no-cache && docker-compose up -d
   ```
2. Verify pages (with correct GraphQL data):
   - `/en-US` (home — shortcut, carousel, channel)
   - `/en-US/{title}` (category)
   - `/en-US/marketing/{uuid}` (advertise)
   - `/en-US/store/{name}/{uuid}` (store; includes `dynamicParams: true` fallback)
   - `/zh-TW` equivalents
3. Locale switch via footer modal on multiple page types.
4. Confirm no edits were made under `server/`, `types/`, `docker/`.
5. Run `pnpm test` — fix only failures caused by this upgrade.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Sign off on objective success conditions — all pages render with correct data, locale switching works, no regressions in Docker build.

---

## Out of scope (do not do in this task)

- Tailwind 2 → 4
- Apollo → graphql-request
- `features/` or `components/` internal restructure
- `generateMetadata` migration for `features/store` `next/head` usage
- React Compiler, `"use cache"`, or Turbopack adoption (optional Next 16 features — not required for parity)
- Enabling Next 16 Cache Components / PPR unless build requires it

## References

- [Next.js 16 blog](https://nextjs.org/blog/next-16)
- [Middleware → Proxy migration](https://nextjs.org/docs/messages/middleware-to-proxy)
- [Next.js async request APIs (15+)](https://nextjs.org/docs/app/guides/upgrading/version-15)
- [next-intl 4.0 release notes](https://next-intl.dev/blog/next-intl-4-0)
- [next-intl routing setup (proxy.ts)](https://next-intl.dev/docs/routing/setup)
- `.cursorrules` — path aliases, i18n (`useTranslations`, no hardcoded strings), do-not-touch paths
