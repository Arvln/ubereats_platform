# Prompt: Generate task.md for Next.js and next-intl Upgrade

You are a senior frontend engineer.

Read this entire codebase and `ai/upgrade-nextjs-nextintl/objective.md` first,
then generate a task.md for upgrading Next.js from 14 to 16 and next-intl from 3 to 4.

## Output requirements

- Break down into small, verifiable steps
- Every step must have a "Done When" condition
- Mark [HUMAN REVIEW] on any step requiring human judgment
- Reference .cursorrules conventions throughout

## Constraints

- Do NOT touch: server/, types/, docker/
- Do NOT restructure internals of features/ or components/
- Do NOT upgrade Tailwind or any other dependencies in this task
- Do NOT add new features
- Only change what is necessary for the version upgrades

## Current versions

- next@14.2.22
- next-intl@3.26.3
- react@19.0.0 (already latest, no change needed)

## Known breaking changes to handle

### Next.js 14 → 16

- async params — params and searchParams in pages and layouts are now async (must await params)
- next/headers — cookies() and headers() are now async
- middleware.ts → proxy.ts — rename file and exported function to proxy
- Caching defaults changed — fetch requests are no longer cached by default
- Minimum Node.js version: 18.17+
- Use codemod where possible: `npx @next/codemod@canary upgrade latest`

### next-intl 3 → 4

- Check next-intl v4 migration guide for API changes
- i18n/request.ts and middleware.ts (proxy.ts) may need updates
- Navigation APIs (useRouter, usePathname, Link) may have changes

## Done When (per step)

No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running
`docker-compose build --no-cache && docker-compose up -d`

## Output format

Save the result as ai/upgrade-nextjs-nextintl/task.md

## task.md structure per step

### Step N: [title]

**What**: what to do
**How**: how to do it
**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`
**[HUMAN REVIEW]**: reason (if applicable)
