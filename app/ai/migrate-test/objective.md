# Objective: Migrate Jest + Cypress to Vitest + Playwright

## Why

1. Vitest is built for ESM and Vite's module resolution — no Babel transform or CommonJS compatibility workarounds needed. Jest carries historical baggage from the pre-ESM era, requiring complex config to work with modern Next.js tooling. Vitest is faster and integrates naturally with the existing tool chain.
2. Playwright has better cross-browser support and more reliable CI/CD compatibility than Cypress. Running E2E tests in Docker/GitHub Actions is more stable with Playwright's built-in browser management.

## Goal

- Replace Jest with Vitest for 5 unit test files under `app/components/`
- Replace Cypress with Playwright for 3 E2E test files under `app/cypress/e2e/homepage/`
- Keep test coverage and intent identical to existing tests
- Playwright tests live under `app/e2e/`

## Success Conditions (verified by human)

- No TypeScript or import errors shown in Cursor editor
- All Vitest unit tests pass
- All Playwright E2E tests pass against `docker-compose up -d`
- Jest and Cypress fully removed from `package.json`

## Out of Scope

- Adding new test coverage beyond what exists today
- Component logic or props changes
- scss or Tailwind changes
- `server/`, `types/`, `docker/`
