# Objective: Upgrade Next.js and next-intl

## Why

- Next.js 14 → 16 brings stable Turbopack, React Compiler, explicit caching with "use cache", and security patches
- next-intl 3 → 4 brings improved App Router support and cleaner API
- Upgrading now while the codebase is clean (post App Router migration) minimizes migration risk

## Goal

Upgrade Next.js from 14 to 16 and next-intl from 3 to 4 while keeping all existing functionality intact.

## Success Conditions (verified by human)

- No TypeScript or import errors shown in Cursor editor
- Human runs `docker-compose build --no-cache && docker-compose up -d` to verify
- All pages render correctly with correct data
- Locale switching works (en-US / zh-TW)
- No changes to server/, types/, docker/

## Out of Scope

- Tailwind 2 → 4 upgrade (separate migration)
- Apollo → graphql-request migration (separate migration)
- features/ restructuring (separate migration)
