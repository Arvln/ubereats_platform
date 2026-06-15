# Objective: Migrate Apollo Client to graphql-request + React Query

## Why

1. Apollo Client singleton on the server causes potential cache pollution between requests in App Router — different users may receive each other's cached data.
2. Apollo's normalized cache is designed for frequent updates to the same data across many components. Our app is primarily read-only — this advantage is never used.
3. graphql-request is a lightweight fetcher with no cache of its own, making it safe and predictable in Server Components.
4. React Query handles all caching on the client side with explicit staleTime / invalidation — cleaner separation of concerns than Apollo's combined approach.
5. Separates data concerns into three explicit layers:

   - **graphql-request** handles transport only — fetches server data in Server Components with no cache side effects
   - **React Query** owns client-side cache, staleTime, and invalidation for server-sourced data
   - **Zustand** manages UI-only state (carousel, channel, restrict_search) that has no server representation

   Apollo conflates all three — a single client handling transport, cache, and reactive UI state makes the data layer opaque and hard to reason about.

6. Zod validates GraphQL responses at runtime — catches schema drift between server and client
   without relying solely on TypeScript's static types, which cannot catch runtime shape mismatches.

## Goal

- Replace Apollo Client with graphql-request + React Query
- Replace Apollo Reactive Variables in graphql/cache/ with Zustand flat stores
- Keep all existing page functionality intact
- Zod schemas for runtime validation of graphql-request responses

## Success Conditions (verified by human)

- No TypeScript or import errors shown in Cursor editor
- Human runs `docker-compose build --no-cache && docker-compose up -d` to verify
- All pages render correctly with correct data
- Locale switching works (en-US / zh-TW)
- Apollo Client fully removed from codebase
- graphql/cache/ deleted entirely
- No changes to server/, types/, docker/

## Out of Scope

- features/ or components/ restructuring
- Tailwind or scss changes
- Cypress or Playwright
