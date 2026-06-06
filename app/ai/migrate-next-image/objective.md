# Objective: Upgrade Next.js Image usage to modern API

## Why

1. `layout="fill"` was deprecated in Next.js 13 — the new `fill` prop is the correct replacement and avoids console warnings.
2. Without `sizes`, Next.js Image in `fill` mode downloads the largest available image regardless of actual display size, wasting bandwidth and hurting LCP.
3. A shared blur placeholder improves perceived performance during image load without requiring backend changes or external CDN control.

## Goal

- Replace all `layout="fill"` with the `fill` prop across 9 components
- Add `sizes` to all `fill` mode images
- Create a shared blur placeholder utility and apply it to all `Image` components

## Success Conditions (verified by human)

- No TypeScript or import errors shown in Cursor editor
- Human runs `docker-compose build --no-cache && docker-compose up -d` to verify
- All images render correctly across home, category, marketing, and store routes
- No `layout=` props remain in any `.tsx` file
- Lighthouse LCP score measured before and after for comparison

## Out of Scope

- Images already using `width`/`height` — correct pattern, do not touch
- scss or Tailwind changes
- Component logic or props changes
- Fetching blur data from UberEats CDN — not controllable
- `placeholder` or any runtime blur generation
