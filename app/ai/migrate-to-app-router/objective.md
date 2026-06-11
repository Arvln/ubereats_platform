# Objective: Migrate to App Router

## Why

We manually implemented patterns in Pages Router that App Router now supports natively:

1. **Server data fetching**: We abstracted `getServerSideProps` into a shared function to handle server-side data fetching. App Router makes every component a Server Component by default — no need to call this function at all.

2. **Layout system**: Pages Router had no native layout mechanism. We had to hard-code `if` conditions to decide which layout to render per page. App Router's Route Groups allow per-section layouts without any conditional logic.

3. **Component colocation**: Pages Router rendered every file inside `pages/` as a route, forcing us to keep components in a separate `features/` folder. App Router only treats `page.tsx` as a route — components can live next to the page without being rendered as routes.

4. **i18n routing**: We built `LocaleContext` manually to manage locale state and switching. App Router with next-intl handles this natively via `[locale]` URL segments and middleware.

Migrating reduces manual maintenance cost and aligns the codebase with the target conventions.

## Goal

Migrate the frontend from Pages Router to App Router while keeping all existing functionality intact.

## Success Conditions (verified by human)

- No TypeScript or import errors shown in Cursor editor
- Human runs `docker-compose build --no-cache && docker-compose up -d` to verify
- All pages render correctly with correct data
- Locale switching works (zh-TW / en-US)
- Apollo Client continues to function (data layer migration is out of scope)
- No changes to server/, types/, docker/

## Out of Scope

- Next.js 14 → 15 upgrade (separate migration after App Router is stable)
- next-intl 3 → 4 upgrade (separate migration after App Router is stable)
- Tailwind 2 → 4 upgrade (separate migration)
- Apollo → graphql-request migration (separate migration)
- Cypress → Playwright migration (separate migration)
- GCP CI/CD (separate migration)
- styles/ restructuring (separate migration)
- features/ internal restructuring (separate migration)
