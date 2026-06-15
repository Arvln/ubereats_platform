# Prompt: Generate task.md for Apollo → graphql-request + React Query Migration

You are a senior frontend engineer.

Read this entire codebase and `ai/migrate-data-layer/objective.md` first,
then generate a task.md for migrating from Apollo Client to graphql-request + React Query.

## Output requirements

- Break down into small, verifiable steps
- Every step must have a "Done When" condition
- Mark [HUMAN REVIEW] on any step requiring human judgment
- One concern per step
- Reference .cursorrules conventions throughout
- Each step must be self-contained — do not reference
  future steps or assume prior step context is remembered.
  Repeat critical constraints in every step that needs them.
- When a shared resource is created in one step and reused
  in later steps, explicitly state the resource name and
  location in each step that uses it.
- For each step, explicitly state which Architecture Rules
  apply and how they are enforced in that step.

## Constraints

- Do NOT touch: server/, types/, docker/
- Do NOT restructure internals of features/ or components/
- Do NOT add new features
- Do NOT change component props/APIs (Removing server page data props in order to migrate to hydrated React Query `useQuery` consumption is allowed)
- graphql/queries/ files stay unchanged — only the client changes
- Only change what is necessary for the data layer migration

## Current stack

- Apollo Client @3.4.17 (server-side only, in lib/page-data.ts)
- No client-side Apollo usage
- Next.js 16, React 19, TypeScript strict

## Target Stack

- `graphql-request` for GraphQL HTTP transport
- `@tanstack/react-query` v5 for async server-state caching
- `HydrationBoundary` + `prefetchQuery` for Server → Client data hydration
- `QueryClientProvider` using `useState` (no global singleton)
- Zustand flat stores replacing Apollo Reactive Variables in `graphql/cache/features/`
- Zod runtime validation at network/trust boundaries

## Architecture Rules

### Server vs Client GraphQL Access

- Server-side query functions must use `gqlServerClient`.
- Client-side `useQuery` fetchers must use `gqlClient` through `/api/graphql`.
- Do not expose internal Docker/server GraphQL endpoints to browser code.
- Do not import `gqlServerClient` into client components.

### React Query Data Flow

Use the standard SSR hydration flow:

Server Component
→ `prefetchQuery`
→ `dehydrate`
→ `HydrationBoundary`
→ Client Component `useQuery`

- Client components should consume hydrated cache using matching `queryKey`s.
- Avoid client-only loading waterfalls.
- Initial page data must continue to be prefetched on the server.
- Do not fetch initial page data in `useEffect`.

### Query Ownership

- Reuse the same `queryKey` and Zod schema validation between:
  - server `prefetchQuery`
  - client `useQuery`
- DO NOT share or unify `queryFn` between server and client.
- Server and client must implement their own transport-specific `queryFn`
- Avoid duplicate GraphQL requests during SSR.
- Do not split existing page-level queries into multiple feature-level network requests unless required for correctness.

### React Query Cache Behavior

- Set an intentional default `staleTime` for SSR-hydrated queries to avoid immediate client refetch after hydration.
- `QueryClientProvider` must create `QueryClient` using `useState(() => new QueryClient())`.
- Do not create module-level `QueryClient` singletons.

### Zustand Ownership

- Zustand stores are for UI-only local state.
- Never store GraphQL/server response data in Zustand.
- Use one flat store per feature:
  - carousel
  - channel
  - restrict_search
- Use selector syntax:
  - `useStore((s) => s.field)`
- Use simple `setX` actions.

### Validation Rules

- Validate GraphQL responses with Zod at network/trust boundaries.
- Avoid duplicate parsing of already validated hydrated data.
- Do not re-parse React Query cache data inside components.

### Migration Rules

- Remove Apollo Client completely after migration.
- Delete `graphql/cache/` entirely after Zustand migration.
- Do not recreate Apollo-style normalized cache abstractions.
- Preserve existing feature behavior and business logic as much as possible.

## Important: \_\_typename handling

Apollo Client auto-injects **typename in every query response.
graphql-request does NOT — **typename must be explicitly requested in the query.

graphql/queries/ does not include **typename manually.
features/channel/utils.ts has two helper functions that depend on **typename.

Action required:

1. Add \_\_typename to the relevant channel query field selections in graphql/queries/
2. Do not change any other query files

## Done When (per step)

No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running
`docker-compose build --no-cache && docker-compose up -d`

## Output format

Save the result as ai/migrate-data-layer/task.md

## task.md structure per step

### Step N: [title]

**What**: what to do
**How**: how to do it
**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`
**[HUMAN REVIEW]**: reason (if applicable)
