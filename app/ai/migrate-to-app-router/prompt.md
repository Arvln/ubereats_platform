# Prompt: Generate task.md for App Router Migration

You are a senior frontend engineer.

Read this entire codebase and `ai/migrate-to-app-router/objective.md` first,
then generate a task.md for migrating the Next.js Pages Router to App Router.

## Output requirements

- Break down into small, verifiable steps
- Every step must have a "Done When" condition
- Mark [HUMAN REVIEW] on any step requiring human judgment
- Migrate one page at a time
- Reference .cursorrules conventions throughout

## Constraints

- Do NOT touch: server/, types/, docker/
- Do NOT restructure internals of features/ or components/
- Keep Apollo Client in place — data layer migration is out of scope
- Remove utils/pages.ts only after all pages are migrated
- Do NOT change any component APIs
- Remove LocaleContext entirely after next-intl middleware is in place
- Do NOT upgrade Next.js, next-intl, or Tailwind versions — version upgrades are out of scope
- Remove react-cookie dependency once LocaleContext is deleted
- Remove `i18n` block from `next.config.js` — conflicts with next-intl App Router middleware
- Update `images.domains` to `images.remotePatterns` in `next.config.js` — deprecated in Next.js 13+
- Do NOT remove `webpack` config in `next.config.js` — mark as [HUMAN REVIEW]

## Target architecture

- Next.js 15 App Router
- next-intl App Router (middleware.ts + app/[locale]/layout.tsx)
  - locale state → useLocale() from next-intl
  - changeLocale → useRouter().replace() from next-intl
  - NEXT_LOCALE cookie → handled by next-intl middleware automatically
- LocaleContext → delete entirely (next-intl covers all its functionality)
- pages/ → app/[locale]/
- \_app.tsx → app/layout.tsx
- pages/404.tsx → app/not-found.tsx
- getStaticPaths → generateStaticParams
- getServerSideProps → Server Component with Apollo Client

## Current pages structure

```
pages/
  404.tsx
  [title].tsx
  _app.tsx
  index.tsx
  marketing/
    [uuid].tsx
  store/
    [name]/
      [uuid].tsx
```

## Expected app router output structure

```
app/
  not-found.tsx
  layout.tsx
  [locale]/
    page.tsx                        # from index.tsx
    [title]/
      page.tsx                      # from [title].tsx
    marketing/
      [uuid]/
        page.tsx                    # from marketing/[uuid].tsx
    store/
      [name]/
        [uuid]/
          page.tsx                  # from store/[name]/[uuid].tsx
middleware.ts
```

## Output format

Save the result as ai/migrate-to-app-router/task.md

## task.md structure per step

### Step N: [title]

**What**: what to do
**How**: how to do it
**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`
**[HUMAN REVIEW]**: reason (if applicable)
