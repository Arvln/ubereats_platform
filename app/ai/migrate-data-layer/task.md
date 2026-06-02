# Task: Migrate Apollo Client → graphql-request + React Query

Reference: `ai/migrate-data-layer/objective.md`, `.cursorrules`, `conventions.md`, `ai/migrate-data-layer/prompt.md`.

**Constraints (do not violate):**

- Do not touch `server/`, `types/`, `docker/`
- Do not restructure internals of `features/` or `components/` beyond what this migration requires
- Do not change component props/APIs **except** removing server `data` props when migrating to hydrated `useQuery` (allowed in prompt)
- `graphql/queries/` field selections unchanged **except** channel `__typename` (Step 7)
- Only change what is necessary for the data layer migration (per `.cursorrules`)

**Architecture rules (from prompt — apply in every relevant step):**

| Rule                 | Requirement                                                                                                                                                                    |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Server GraphQL       | `gqlServerClient` only in Server Components, Route Handlers, server `queryFn`                                                                                                  |
| Client GraphQL       | `gqlClient` only in client `useQuery` fetchers → `/api/graphql`                                                                                                                |
| SSR flow             | Server: `prefetchQuery` → `dehydrate` → `HydrationBoundary` → client `useQuery` (matching `queryKey`)                                                                          |
| Query ownership      | Centralize `queryKey` + schema only. Implement transport-specific `queryFn` separately for server and client (do not unify). Avoid duplicate SSR requests and query splitting. |
| Cache                | `QueryClient` via `useState(() => new QueryClient())`; intentional `staleTime` on hydrated queries to avoid immediate client refetch                                           |
| Zustand              | UI-only (carousel, channel, restrict_search); never GraphQL response data                                                                                                      |
| Zod                  | Parse at network/trust boundary inside `queryFn`; do not re-parse hydrated cache in components                                                                                 |
| No `useEffect` fetch | Initial page data prefetched on server only (`.cursorrules`)                                                                                                                   |

**Current stack:**

| Area            | Today                                                                                    |
| --------------- | ---------------------------------------------------------------------------------------- |
| Server fetch    | `lib/page-data.ts` → Apollo singleton (`graphql/apollo_client/`)                         |
| Queries         | `graphql/queries/pages/*` use `gql` from `@apollo/client`; feature fragments are strings |
| Client UI state | Apollo Reactive Variables in `graphql/cache/features/` + `utils/variables.ts`            |
| Client GraphQL  | None — Server Components pass `data` props                                               |
| Validation      | TypeScript only                                                                          |

**Target stack:** `graphql-request` + `@tanstack/react-query` v5 + Zod + Zustand (`stores/`).

**Pages using `lib/page-data.ts`:** home, `[title]`, `marketing/[uuid]`, `store/[name]/[uuid]`.

**`__typename`:** Add only in `graphql/queries/features/channel/index.ts` for `features/channel/utils.ts`.

---

### Step 1: Baseline — confirm app on Apollo stack

**What**: Known-good state before migration.

**How**:

1. `docker-compose build --no-cache && docker-compose up -d` from repo root.
2. Verify `/en-US` home, category, marketing, store; locale en-US ↔ zh-TW.
3. Exercise carousel, channel pagination, restrict-search filters.
4. No pre-existing TypeScript/import errors in `app/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Record pre-existing issues.

---

### Step 2: Add graphql-request, React Query, Zod, and Zustand

**What**: Install target dependencies; keep Apollo until Step 22.

**How**:

1. Add dependencies: `graphql-request`, `@tanstack/react-query`, `zod`, `zustand`.
2. Do not remove `@apollo/client` yet.
3. Do not upgrade unrelated packages.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 3: Create `api/graphql.ts` (server + browser clients)

**What**: Transport layer with strict server/client separation.

**How**:

1. Create `api/graphql.ts` at app root.
2. `gqlServerClient` → `http://server:${process.env.SERVER_PORT}` (same as `graphql/apollo_client/index.ts`).
3. No module-level singleton that caches across requests — factory or per-call client.
4. `gqlClient` → `/api/graphql` for browser only.
5. Do not export server endpoint helpers for client import.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 4: Create `app/api/graphql/route.ts`

**What**: Proxy browser requests to internal GraphQL server.

**How**:

1. POST `{ query, variables }` → forward with `gqlServerClient`.
2. Return JSON; appropriate error status on failure.
3. Do not touch `server/` or `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 5: Create `providers/query-client-provider.tsx`

**What**: React Query provider without global singleton; SSR-friendly defaults.

**How**:

1. `'use client'`; named export wrapper.
2. `useState(() => new QueryClient({ defaultOptions: { queries: { retry: 1, staleTime: … } } }))` — set intentional default `staleTime` for hydrated queries (per prompt Architecture Rules).
3. No module-level `QueryClient` singleton.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 6: Wire `QueryClientProvider` into app shell

**What**: App-wide React Query access.

**How**:

1. Wrap client tree in `app/[locale]/locale-layout-client.tsx` (or minimal layout wrapper).
2. Keep `NextIntlClientProvider` and layout behavior unchanged.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 7: Add `__typename` to channel query only

**What**: graphql-request does not auto-inject `__typename`.

**How**:

1. Edit **only** `graphql/queries/features/channel/index.ts`.
2. Add `__typename` to `ChannelShop` and `ChannelCategory` fragment selections.
3. Do not change other query files’ field selections.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Channel shop vs category pagination on home.

---

### Step 8: Remove Apollo `gql` from page query modules

**What**: Drop `@apollo/client` from query files; keep query text (client transport change only).

**How**:

1. In `graphql/queries/pages/` only: replace `import { gql } from '@apollo/client'` with plain strings or `graphql` tag — same document text.
2. Keep exports (`query`, `getTitles`, etc.) and selections unchanged.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 9: Add Zod schemas for page GraphQL responses

**What**: Runtime validation at trust boundaries.

**How**:

1. Schemas for home, category, marketing, store (align with `types/pages/*` — do not move root `types/`).
2. Prefer `z.infer<typeof schema>` per `.cursorrules`.
3. Co-locate in `app/schema/` or feature-level `schema/` — do not add to root `types/` (shared with server).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 10: Centralize query keys and schemas (not queryFn)

**What**: Single source for shared query metadata while keeping server/client transport logic separate.

**How**:

1. Rename existing `schema.ts` files to `queries.ts` and expand their responsibility.
2. Each `queries.ts` must contain all GraphQL-related concerns for that feature:
   - GraphQL query document
   - queryKey definition (React Query key)
   - Zod schema for runtime validation
3. Remove any previously centralized or duplicated definitions:
   - queryKey factories in separate files
   - GraphQL document-only modules

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 11: Rewrite `lib/page-data.ts` to use graphql-request

**What**: Remove Apollo from server helpers (interim until pages use RQ only).

**How**:

1. Keep **separate** transport-specific query functions:
   - Server queryFns use `gqlServerClient`
   - Client queryFns use `gqlClient`
2. Do not share or unify queryFn implementations between server and client.
3. Avoid duplicate GraphQL calls during SSR (server prefetch satisfies hydrated client query).
4. Replace Apollo with `gqlServerClient` + Zod in `fetchPageData`, `fetchPageDataByKey`, `fetchPageDataSingle`, `fetchStaticSlugs`.
5. Keep signatures stable until Steps 12–16 migrate pages.
6. Keep `redirectToHome`, `loadMessages`.
7. Accept string query documents if Apollo `DocumentNode` is removed.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: All four page types still return correct data.

---

### Step 12: Migrate home page to SSR hydration pattern

**What**: `prefetchQuery` → `dehydrate` → `HydrationBoundary` for home.

**How**:

1. In `app/[locale]/page.tsx`:
   - Create a shared per-request QueryClient factory function in lib/server-query-client.ts.Use it in this step.
   - `prefetchQuery` with home `queryKey` / **server-specific** `queryFn` (`gqlServerClient`)
   - `dehydrate` + wrap children in `HydrationBoundary`
2. Keep `setRequestLocale`.
3. Do not fetch initial data in `useEffect`.
4. Do not remove fetchPageData or data props in this step.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 13: Migrate home client features to `useQuery`

**What**: Client components read hydrated cache; remove server `data` props where migrated.

**How**:

1. Remove fetchPageData and data props migrated in this step.
2. `features/shortcut`, `features/carousel`, `features/channel`: `useQuery` with **same** `queryKey` as Step 12 and **client-specific** `queryFn` (`gqlClient`) for refetches.
3. Do not import `gqlServerClient` in these client components.
4. Validate in client queryFn at trust boundary only when network request occurs; do not re-parse cache data in components.
5. `RestrictSearch`: UI-only (`isCuisines`); no server data in Zustand.
6. Minimal changes; no scss refactors.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: No client loading flash/refetch right after hydration; home content correct.

---

### Step 14: Migrate category page to SSR hydration + `useQuery`

**What**: Same pattern for `app/[locale]/[title]/page.tsx`.

**How**:

1. Use the shared QueryClient factory from lib/server-query-client.ts created in Step 12
2. Remove fetchPageData and data props migrated in this step.
3. `prefetchQuery` + `HydrationBoundary`; `generateStaticSlugs` via graphql-request.
4. Category UI consumes `useQuery` with `['GetCategoryByTitle', { title }]`.
5. One page-level query — do not add separate feature-level requests.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 15: Migrate marketing page to SSR hydration + `useQuery`

**What**: Same pattern for `app/[locale]/marketing/[uuid]/page.tsx`.

**How**:

1. Use the shared QueryClient factory from lib/server-query-client.ts created in Step 12.
2. Remove fetchPageData and data props migrated in this step.
3. Prefetch advertise query; `HydrationBoundary`.
4. Client child / page section uses matching `useQuery`.
5. Keep advertise scss/UI unchanged.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 16: Migrate store page to SSR hydration + `useQuery`

**What**: Same pattern for `app/[locale]/store/[name]/[uuid]/page.tsx`.

**How**:

1. Use the shared QueryClient factory from lib/server-query-client.ts created in Step 12.
2. Remove fetchPageData and data props migrated in this step.
3. Prefetch store query; `HydrationBoundary`; keep `dynamicParams: true`.
4. `features/store` uses `useQuery` with store `queryKey`; remove `data` prop when migrated.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Store SSR/ISR fallback behavior unchanged.

---

### Step 17: Create Zustand stores (carousel, channel, restrict_search)

**What**: Replace Apollo Reactive Variables.

**How**:

1. `stores/carousel.ts` — `horizontalOffset`, `setHorizontalOffset` (initial `-100`).
2. `stores/channel.ts` — `TPagesState` + setters.
3. `stores/restrict-search.ts` — `TConditionsState` + setters.
4. `useStore((s) => s.field)`; never store GraphQL data.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 18: Migrate `features/carousel` to Zustand

**What**: Remove `horizontalOffsetVar` / `useVar`.

**How**: Use `stores/carousel.ts`; no scss refactors.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Carousel behavior unchanged.

---

### Step 19: Migrate `features/channel` to Zustand

**What**: Remove `pagesStateVar` / `useVar`.

**How**: Use `stores/channel.ts`; keep `utils.ts` logic; Step 7 `__typename` required.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Channel pagination unchanged.

---

### Step 20: Migrate `features/restrict_search` to Zustand

**What**: Remove `conditionsStateVar` / `useVar`.

**How**: Use `stores/restrict-search.ts`; keep `isCuisines` and filter UI.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 21: Delete `graphql/cache/` and Apollo reactive utilities

**What**: Remove deprecated cache layer.

**How**:

1. Delete `graphql/cache/`.
2. Delete `utils/variables.ts`; update `utils/index.ts`.
3. Grep: no `graphql/cache`, `makeVar`, `useReactiveVar`, `useVar`, `getVar`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 22: Remove Apollo Client completely

**What**: Objective: Apollo fully removed.

**How**:

1. Delete `graphql/apollo_client/`.
2. Remove `@apollo/client` from `package.json`.
3. Remove dead `lib/page-data.ts` Apollo paths if all helpers have been replaced by centralized queries in lib/graphql-definitions.ts.
4. Grep: zero Apollo references.
5. `pnpm install`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 23: Full regression verification

**What**: All objective success conditions.

**How**:

1. `docker-compose build --no-cache && docker-compose up -d`.
2. All pages + data; locale switching.
3. Apollo gone; `graphql/cache/` gone; no `server/`, `types/`, `docker/` edits.
4. `pnpm test` — migration-related fixes only.
5. Confirm no `gqlServerClient` in client bundles (spot-check imports).

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Sign off on objective success conditions.

---

## Out of scope

- `features/` / `components/` restructuring (beyond `data` → `useQuery` and Zustand)
- Tailwind / scss
- Cypress / Playwright
- Root `types/` changes
- Apollo-style normalized cache re-implementation
- Splitting page queries into per-feature network requests without cause

## References

- `ai/migrate-data-layer/objective.md`
- `ai/migrate-data-layer/prompt.md` (Architecture Rules)
- `conventions.md`, `.cursorrules`
- [TanStack Query SSR](https://tanstack.com/query/latest/docs/framework/react/guides/advanced-ssr)
- [graphql-request](https://github.com/graffle-js/graffle/tree/graphql-request)
