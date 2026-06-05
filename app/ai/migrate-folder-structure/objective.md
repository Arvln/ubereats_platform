# Objective: Co-locate enums and features with App Router consumers

## Why

1. `features/` was necessary in Page Router because any file inside `pages/` became a route — UI logic had to live outside. App Router removes this constraint: only reserved filenames (`page.tsx`, `layout.tsx`, etc.) are treated as routes, so components can be co-located directly inside `app/`.
2. `enums/` and `features/` are flat directories decoupled from the routes that consume them — this makes it hard to trace which code belongs to which route.
3. App Router encourages co-location: route-specific code lives alongside the route, not in a separate top-level directory.
4. Enums used by a single component have no reason to be extracted — inline is simpler and more readable.
5. Dissolving `features/` into `app/` makes the codebase structure self-documenting — the route tree becomes the source of truth for what each page does.

## Goal

- Inline single-caller enums directly into their consuming component
- Move multi-caller enums to the closest shared parent directory under `app/`
- Move all `features/` components to their corresponding route under `app/[locale]/`
- Delete `enums/` and `features/` directories entirely

## Success Conditions (verified by human)

- No TypeScript or import errors shown in Cursor editor
- Human runs `docker-compose build --no-cache && docker-compose up -d` to verify
- All pages render correctly
- `enums/` deleted entirely
- `features/` deleted entirely

## Out of Scope

- Tailwind or scss changes
- Component logic or props changes
- Any route or data layer changes
