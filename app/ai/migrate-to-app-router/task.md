# Task: Migrate Pages Router → App Router

Reference: `ai/migrate-to-app-router/objective.md`, `.cursorrules`, `conventions.md` (target architecture).

**Constraints (do not violate):**

- Do not touch `server/`, `types/`, `docker/`
- Do not restructure internals of `features/` or `components/`
- Keep Apollo Client — no graphql-request / React Query migration
- Do not change component props/APIs
- Do not upgrade Next.js, next-intl, or Tailwind versions
- Remove `utils/pages.ts` only after every page is migrated
- Remove `LocaleContext` only after next-intl middleware is working

**Current inventory:**

| Pages Router file               | App Router target                            | Data strategy                          |
| ------------------------------- | -------------------------------------------- | -------------------------------------- |
| `pages/_app.tsx`                | `app/layout.tsx` + `app/[locale]/layout.tsx` | Providers + Layout shell               |
| `pages/index.tsx`               | `app/[locale]/page.tsx`                      | SSR (Apollo, was `getServerSideProps`) |
| `pages/[title].tsx`             | `app/[locale]/[title]/page.tsx`              | SSG + `fallback: false`                |
| `pages/marketing/[uuid].tsx`    | `app/[locale]/marketing/[uuid]/page.tsx`     | SSG + `fallback: false`                |
| `pages/store/[name]/[uuid].tsx` | `app/[locale]/store/[name]/[uuid]/page.tsx`  | SSG + `fallback: true`                 |
| `pages/404.tsx`                 | `app/not-found.tsx`                          | Static                                 |

**Locale consumers to migrate off `contexts/`:**

- `features/footer/index.tsx` — `locale`, `changeLocale`
- `components/shop/index.tsx` — `locale` in `Link` href
- `components/category_item/index.tsx` — `locale` in `Link` href
- Tests: `components/shop/index.test.tsx`, `components/category_item/index.test.tsx`

---

### Step 1: Update `next.config.js` for App Router i18n

**What**: Prepare Next config for App Router + next-intl middleware.

**How**:

1. Remove the `i18n` block (conflicts with next-intl App Router middleware per `.cursorrules` / prompt).
2. Replace `images.domains` with `images.remotePatterns` — one entry per host env var, `protocol: 'https'`, `hostname` from env (same hosts as today).
3. Leave `reactStrictMode`, `env`, and `webpack` config unchanged.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Confirm `webpack` `resolve-url-loader` override still behaves correctly after App Router build (Sass pipeline).

---

### Step 2: Add next-intl routing config

**What**: Centralize locale settings for middleware and layouts (per `conventions.md` i18n section).

**How**:

1. Create `i18n.ts` at project root with:
   - `locales: ['en-US', 'zh-TW']`
   - `defaultLocale: 'en-US'`
   - `localePrefix: 'always'` (matches current `/${locale}/...` URL pattern in `components/shop` and `components/category_item`)
2. Export types/helpers next-intl v3 expects (`Locale`, etc.).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 3: Add `middleware.ts` for locale detection

**What**: Replace Pages Router built-in i18n + manual `NEXT_LOCALE` cookie handling with next-intl middleware.

**How**:

1. Create `middleware.ts` at project root using `createMiddleware` from `next-intl/middleware` with config from `i18n.ts`.
2. Set `matcher` to exclude static assets: `['/((?!api|_next|_vercel|.*\\..*).*)']`.
3. Do not add `LocaleProvider` yet — Pages Router still serves traffic until pages migrate.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: After first page lands under `app/[locale]/`, confirm middleware redirects `/` → `/zh-TW` and sets `NEXT_LOCALE` cookie as expected.

---

### Step 4: Add server-side Apollo page-data helpers

**What**: Replace `getPageProps` / `getPageStaticPaths` from `utils/pages.ts` with App Router-compatible async functions (keep Apollo Client per objective).

**How**:

1. Create `lib/page-data.ts` (new file — do not delete `utils/pages.ts` yet).
2. Port logic from `utils/pages.ts`:
   - `fetchPageData<T>(query, variables?)` — Apollo `client.query`, return `pageData` or `null`
   - `fetchPageDataByKey<T>(query, variables, key)` — unwrap first item from list field
   - `fetchStaticSlugs<T>(query, key)` — return slug array for `generateStaticParams`
   - `redirectToHome()` — use `redirect('/')` from `next/navigation` when data is missing
3. Reuse `getApolloClient()` from `graphql/apollo_client` — no API changes.
4. Load messages via `import(\`locales/${locale}.json\`)` for layouts (same as today).
5. Do not import `lib/page-data.ts` from existing `pages/*` files yet.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 5: Create root `app/layout.tsx`

**What**: Replace global concerns from `pages/_app.tsx` at the root layout level.

**How**:

1. Create `app/layout.tsx` with `<html>` and `<body>`, import `styles/globals.scss`.
2. No `IntlProvider` or `LocaleProvider` here — those move to `app/[locale]/layout.tsx`.
3. Keep minimal; no feature layout yet.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 6: Create `app/[locale]/layout.tsx` (app shell)

**What**: Replace `_app.tsx` provider tree and `features/layout` wrapper for all locale routes.

**How**:

1. Create `app/[locale]/layout.tsx` as a Server Component:
   - `generateStaticParams` → `[{ locale: 'zh-TW' }, { locale: 'en-US' }]`
   - Validate `params.locale` against `i18n.ts`; call `notFound()` if invalid
   - Load `messages` from `locales/${locale}.json`
   - Wrap children with `NextIntlClientProvider` from `next-intl` (pass `locale`, `messages`)
2. Create `app/[locale]/locale-layout-client.tsx` with `'use client'`:
   - Move current `features/layout` usage here (import default `Layout` from `features/layout`)
   - Render `<Layout>{children}</Layout>`
   - Do not change `features/layout` API — only wrap it
3. Server layout renders: `<NextIntlClientProvider><LocaleLayoutClient>{children}</LocaleLayoutClient></NextIntlClientProvider>`
4. Keep `LocaleProvider` from `contexts` temporarily in the client wrapper until Step 14 — required for `useLocale` in footer/shop/category_item during transition.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: `features/layout` uses `next/head` for `<title>` and meta tags. App Router prefers the Metadata API. Decide whether to (a) leave `next/head` inside the client layout for now, or (b) move metadata to `export const metadata` in `app/[locale]/layout.tsx`. Option (a) is lower risk for this migration.

**Note**: LocaleProvider from contexts will temporarily coexist with next-intl's useLocale between Step 6 and Step 14. Ensure there is no naming conflict — components should import useLocale from next-intl, not from contexts, after Step 12.

---

### Step 7: Migrate `pages/404.tsx` → `app/not-found.tsx`

**What**: First page migration — global 404, no data fetching.

**How**:

1. Create `app/not-found.tsx` by copying JSX from `pages/404.tsx`.
2. Replace `next/head` `<title>` with `metadata` export **or** keep `next/head` inside a small client wrapper — match decision from Step 6.
3. Leave `pages/404.tsx` in place until Step 15 (Next.js uses `app/not-found.tsx` once `app/` exists; having both briefly is OK during transition).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human visits a non-existent path and sees the 404 UI.

---

### Step 8: Migrate `pages/index.tsx` → `app/[locale]/page.tsx` (home)

**What**: Home page — SSR via Server Component + Apollo.

**How**:

1. Create `app/[locale]/page.tsx` as async Server Component.
2. Fetch data with `fetchPageData` from `lib/page-data.ts` using `graphql/queries/pages` query (no variables).
3. If null, call `redirectToHome()` or render fallback consistent with current behavior.
4. Copy the JSX from `pages/index.tsx` (`Shortcut`, `Carousel`, `RestrictSearch`, `Channel`) — pass `pageData` the same way; do not change feature component APIs.
5. Keep scss import `styles/pages/Home.module.scss` unchanged.
6. Page is dynamic by default (matches former `getServerSideProps`); do not add `force-static`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human checks `/zh-TW` and `/en-US`: shortcuts, carousel, and channel render with data.

**[HUMAN REVIEW]**: While both `pages/index.tsx` and `app/[locale]/page.tsx` exist, confirm which route Next 14 serves (App Router takes precedence for matching paths). Delete `pages/index.tsx` in Step 15.

---

### Step 9: Migrate `pages/[title].tsx` → `app/[locale]/[title]/page.tsx` (categories)

**What**: Category pages — SSG with `fallback: false` (`SHOW_ERROR_PAGE`).

**How**:

1. Create `app/[locale]/[title]/page.tsx` as async Server Component.
2. `generateStaticParams`: call `fetchStaticSlugs` with `getTitles` query, `shortcut` key; map to `{ title }`.
3. `export const dynamicParams = false` (replaces `fallback: false`).
4. Fetch with `fetchPageDataByKey` using `getCategoryByTitle`, `Fields.CATEGORY`, pass `{ title: params.title }`.
5. If no data, `redirect('/')`.
6. Render `<Category data={pageData} />` — unchanged.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human opens a shortcut category URL (e.g. `/zh-TW/<title>`) and sees category content.

---

### Step 10: Migrate `pages/marketing/[uuid].tsx` → `app/[locale]/marketing/[uuid]/page.tsx`

**What**: Advertise/marketing pages — SSG with `fallback: false`.

**How**:

1. Create `app/[locale]/marketing/[uuid]/page.tsx` as async Server Component.
2. `generateStaticParams` from `getUUID` / `Fields.CAROUSEL`.
3. `export const dynamicParams = false`.
4. Fetch with `getAdvertiseByUUID` / `Fields.ADVERTISE`.
5. Copy JSX from `pages/marketing/[uuid].tsx` unchanged.
6. Update `features/carousel/index.tsx` link: change `/marketing/${uuid}` to use `Link` from `next-intl/navigation` (locale-aware). This is a minimal href fix, not an API change.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human clicks a carousel item and lands on the advertise page with content.

**Note**: Modifying `features/carousel/index.tsx` link is the only permitted change inside `features/` in this migration. All other `features/` internals remain untouched.

---

### Step 11: Migrate `pages/store/[name]/[uuid].tsx` → `app/[locale]/store/[name]/[uuid]/page.tsx`

**What**: Store pages — SSG with `fallback: true` (`SHOW_FALLBACK_PAGE`).

**How**:

1. Create `app/[locale]/store/[name]/[uuid]/page.tsx` as async Server Component.
2. `generateStaticParams` from `getStoreSlugs` / `Fields.STORESLUGS`; map to `{ name, uuid }`.
3. Keep `export const dynamicParams = true` (default — replaces `fallback: true`).
4. Fetch with `getStoreBySlug` / `Fields.STORE`.
5. Preserve loading UI: when `pageData` is null/undefined, render `<div>loading...</div>` as today.
6. Render `<Store data={pageData} />` when data exists — do not change `features/store` API.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human opens a store from the home channel list (`/zh-TW/store/<name>/<uuid>`) and sees the store page.

**[HUMAN REVIEW]**: `features/store/index.tsx` uses `next/head` for store-specific title — confirm acceptable for now or migrate to `generateMetadata` in this `page.tsx`.

---

### Step 12: Switch locale-aware links to next-intl navigation

**What**: Remove manual `/${locale}` prefix from client components (prepare for LocaleContext deletion).

**How**:

1. `components/category_item/index.tsx`:
   - Replace `useLocale` from `contexts` with `useLocale` from `next-intl`
   - Replace `next/link` with `Link` from `next-intl/navigation`
   - Change `href={/${locale}${pageUrl}}` to `href={pageUrl}` (next-intl adds locale prefix)
2. `components/shop/index.tsx`:
   - Same `useLocale` import swap
   - Change `href={/${locale}/store/${name}/${uuid}}` to `href={/store/${name}/${uuid}}` with `Link` from `next-intl/navigation`
3. Update jest mocks in `components/category_item/index.test.tsx` and `components/shop/index.test.tsx` to mock `next-intl` instead of `contexts`.
4. Do not delete `contexts/` yet.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human clicks category shortcuts and store cards — URLs include locale prefix and load correct pages. Run `pnpm test` — unit tests pass.

---

### Step 13: Switch footer locale switching to next-intl

**What**: Replace `changeLocale` / cookie / `next/router` logic with next-intl navigation.

**How**:

1. In `features/footer/index.tsx`:
   - Remove `import { useLocale } from 'contexts'`
   - `const locale = useLocale()` from `next-intl`
   - `import { usePathname, useRouter } from 'next-intl/navigation'`
   - Replace `changeLocale(language)` with `router.replace(pathname, { locale: language })`
2. Keep modal UI and `t()` usage unchanged.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Human switches zh-TW ↔ en-US in footer; URL prefix updates and page content stays correct.

---

### Step 14: Remove `LocaleContext` and `react-cookie`

**What**: Delete manual locale state now covered by next-intl.

**How**:

1. Remove `LocaleProvider` from `app/[locale]/locale-layout-client.tsx`.
2. Delete `contexts/LocaleContext/` and update `contexts/index.ts`; delete `contexts/` entirely if empty.
3. Remove `react-cookie` from `package.json` dependencies; run `pnpm install`.
4. Grep for `contexts`, `LocaleProvider`, `react-cookie` — no remaining imports.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. Locale switching still works via footer.

---

### Step 15: Delete Pages Router files and `utils/pages.ts`

**What**: Remove legacy routing layer.

**How**:

1. Delete entire `pages/` directory.
2. Delete `utils/pages.ts`.
3. Update `utils/index.ts` — remove `getPageStaticPaths` and `getPageProps` exports; keep `getVar` / `useVar`.
4. Update `tsconfig.json` paths — remove `pages/*` and `contexts/*` aliases.
5. Update `.cursorrules` path alias notes for `pages/*` and `contexts/*` (mark both removed).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. All routes in the expected structure work; no `pages/` directory remains.

---

### Step 16: Final verification and cleanup

**What**: Confirm success conditions from `objective.md`.

**How**:

1. Grep for stale imports: `next/router`, `next/head` in new `app/` files, `getServerSideProps`, `getStaticProps`, `getStaticPaths`, `utils/pages`, `LocaleContext`, `react-cookie`.
2. Run `pnpm test`.
3. Human runs full route checklist:
   - `/zh-TW` — home
   - `/en-US` — home (English messages)
   - `/zh-TW/<category-title>` — category
   - `/zh-TW/marketing/<uuid>` — advertise (via carousel)
   - `/zh-TW/store/<name>/<uuid>` — store
   - Unknown path — `app/not-found.tsx`
   - Footer locale switch — zh-TW ↔ en-US
4. Confirm Apollo still fetches (network or rendered data on each page).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`. All objective success conditions met.

**[HUMAN REVIEW]**: Sign off that webpack Sass config, metadata/head strategy, and Cypress e2e paths are acceptable post-migration.

---

## Expected final structure

```
app/
  layout.tsx
  not-found.tsx
  [locale]/
    layout.tsx
    locale-layout-client.tsx    # 'use client' — Layout + providers
    page.tsx                    # home
    [title]/
      page.tsx
    marketing/
      [uuid]/
        page.tsx
    store/
      [name]/
        [uuid]/
          page.tsx
i18n.ts
middleware.ts
lib/
  page-data.ts                  # Apollo server helpers (replaces utils/pages.ts)
```

## Out of scope (do not do in this migration)

- Next.js 14 → 15, next-intl 3 → 4, Tailwind 2 → 4
- Apollo → graphql-request
- `features/` or `components/` internal restructuring
- `styles/` restructuring
- `server/`, `types/`, `docker/` changes
- Cypress → Playwright
