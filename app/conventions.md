# Next.js + React Query + TypeScript conventions

## Stack

- Next.js 15 App Router, React 19, TypeScript (strict)
- TanStack React Query v5 for server/async state
- Zustand for client UI state only (filters, pagination, ephemeral UI)
- graphql-request (`@/api/graphql`) for GraphQL HTTP; Zod for runtime validation
- react-hook-form + `@hookform/resolvers/zod` + shadcn/ui Form primitives
- Tailwind CSS 4, `cn()` from `@/lib/utils` (clsx + tailwind-merge)
- Path alias: `@/*` → project root

## Folder structure

```
app/
  layout.tsx
  (route-group)/
    feature/
      page.tsx
      layout.tsx
      components/
      hooks/
      schema/
      api/
      stores/
      types/
api/graphql.ts                  # Shared GraphQL client
components/ui/
components/custom-ui/
hooks/
providers/
schema/
types/
stores/
lib/
locales/
```

Colocate by feature first; promote to root only when reused across route groups.

## React patterns

- Add `'use client'` only when using hooks, browser APIs, or event handlers.
- Pages: `default export`. Everything else: **named exports**.
- Wrap `useSearchParams()` consumers in `<Suspense>`.
- Use `QueryBoundary` for query loading/error/data rendering:

```tsx
<QueryBoundary query={query} loadingFallback={...} errorFallback={...}>
  {(data) => <Child data={data} />}
</QueryBoundary>
```

- Auth-gated routes: wrap with `ProtectedPage` (redirects via `useUser` + `QueryBoundary`).
- Prefer composition; keep pages thin—delegate to `components/`, `hooks/`, `tab-contents.tsx`.
- Extend shadcn in `components/custom-ui/`—do not fork `components/ui/` unless adding primitives.

## State management

| Concern                               | Tool               |
| ------------------------------------- | ------------------ |
| Server data, mutations, cache         | React Query        |
| Table filters, pagination, UI toggles | Zustand (`create`) |
| Auth user snapshot                    | `useUser()` hook   |

**React Query conventions**

- `queryKey`: operation name tuples—`['GetEntity', variables]`.
- Define `queryFn` as named async function; validate responses with Zod inside `queryFn`.
- Set `staleTime` / `gcTime` intentionally.
- Pagination: `placeholderData: keepPreviousData`.
- Mutations: `useMutation({ mutationFn, onSuccess })` → `queryClient.invalidateQueries({ queryKey, exact: false })`.
- Prefer `setQueryData` for surgical cache updates; `invalidateQueries` for structural changes.
- Co-locate query + mutation hooks in `hooks/`.

**Zustand conventions**

- Small flat stores with `setX` actions; selector syntax: `useStore((s) => s.field)`.
- Never store server data in Zustand.

## API layer

- Import `gqlServerClient` (server-side) or `gqlClient` (client-side) from `@/api/graphql`.
- Keep query functions pure: `(variables) => gqlClient.request(query, variables)`.
- Validate every response with Zod—`.parse()` when failure should throw; `.safeParse()` + typed fallback when UI must degrade gracefully.
- Map API shapes → app shapes inside Zod (`.transform()`); expose `z.infer<typeof schema>` types.

### graphql.ts exports

- `gqlServerClient`: internal Docker network — use in Server Components and Route Handlers.
- `gqlClient`: browser via `/api/graphql` proxy — use in `useQuery` hooks.

### Interceptor defaults

| Method   | successToast        | errorToast      |
| -------- | ------------------- | --------------- |
| query    | —                   | —               |
| mutation | `response.data.msg` | `error.message` |

## Error handling

### graphql-request

- GraphQL errors throw `ClientError` automatically — let React Query handle retry.
- Toast feedback: handle in `onError` of `useMutation` or global `QueryCache` callbacks.

### React Query

- Set `retry: 1` globally in `QueryClient` default options.
- Per-query override: `useQuery({ ..., retry: false })`.

### QueryBoundary

- `errorFallback`: inline error UI for recoverable errors.
- Unrecoverable errors bubble to root `error.tsx`.

## Forms

- Schema: Zod `z.object(...)`; use factory `createXSchema(t)` when messages come from `useTranslations()`.
- Form: `useForm({ resolver: zodResolver(schema), defaultValues | values, mode: 'onChange' })`.
- UI: shadcn `<Form>` + `<FormField control={form.control} render={({ field }) => ...} />`.
- Submit: `form.handleSubmit(onSubmit)`; call `mutation.mutate(values)` in `onSubmit`.
- Reset server-driven lists: `useEffect(() => form.reset(buildDefaults(data)), [data, form])`.
- Complex forms: extract `useXForm(values, mutation)` hook.
- Disable submit with `form.formState.isValid` when using `mode: 'onChange'`.

## TypeScript

- Prefer `z.infer<typeof schema>` over hand-written duplicates.
- Shared domain types in `types/`; feature-only types in `feature/types/`.
- Barrel-export public modules via `index.ts`.

## Imports & style

- Order: external → `@/` absolute → relative.
- Use `cn()` for conditional classes; CVA for component variants.
- Toast feedback: `sonner` via `@/components/custom-ui/message` — don't duplicate in components.
- i18n: `const { t } = useTranslations()`; keys as dot-paths (`'feature.label'`).

## i18n (next-intl App Router)

### Supported locales

- `zh-TW` (default)
- `en-US`

### Folder structure

```
locales/
  zh-TW.json
  en-US.json
app/
  [locale]/
    layout.tsx
    page.tsx
middleware.ts
```

### Conventions

- All translation keys: dot-path (`'feature.label'`).
- Usage: `const { t } = useTranslations('feature')`.
- Never hardcode display strings — always go through `t()`.
- `createXSchema(t)` for Zod schemas with translated error messages.

## Do not

- Fetch in `useEffect` when React Query fits.
- Put API response data in Zustand or React state.
- Skip Zod validation on API responses.
- Use Apollo Client — use graphql-request + React Query instead.
- Add business-domain rules to shared `components/ui/` or root `schema/` without reuse justification.
- Create default-export utility modules (except Next.js pages).
- Duplicate toast logic in components.
- Hardcode display strings — always use `t()`.
