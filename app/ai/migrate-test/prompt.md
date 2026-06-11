# Prompt: Generate task.md for Jest + Cypress → Vitest + Playwright migration

You are a senior frontend engineer.

Read this entire codebase and `ai/migrate-test/objective.md` first,
then generate a task.md for migrating from Jest + Cypress to Vitest + Playwright.

## Output requirements

- Break down into small, verifiable steps
- Every step must have a "Done When" condition
- Mark [HUMAN REVIEW] on any step requiring human judgment
- One concern per step
- Each step must be self-contained — do not reference future steps or assume prior step context is remembered
- When a shared resource is created in one step and reused in later steps, explicitly state the resource name and location in each step that uses it

## Constraints

- Do NOT touch: `server/`, `types/`, `docker/`
- Do NOT change component logic or props
- Do NOT add new test coverage beyond what exists today
- Keep test intent and coverage identical to existing tests
- Playwright tests must live under `app/e2e/`

## Migration Rules

### Jest → Vitest

- Replace `jest.config.js` with `vitest.config.ts`
- Replace `app/tsconfig.test.json` Jest references with Vitest equivalents
- Migrate each test file under `app/components/` — API is nearly identical; update imports from `@jest/*` to `vitest` where needed
- Remove Jest from `package.json` after all tests pass
- Do not use Babel transform — Vitest uses Vite's native ESM resolution

### Cypress → Playwright

- Install Playwright and configure `playwright.config.ts`
- Migrate the 3 E2E test files from `app/cypress/e2e/homepage/` to `app/e2e/`
- Playwright tests run against the app started by `docker-compose up -d`
- Remove Cypress from `package.json` after all tests pass

## Done When (per step)

All Vitest unit tests pass, or all Playwright E2E tests pass (depending on step scope).

## Output format

Save the result as `ai/migrate-test/task.md`

## task.md structure per step

### Step N: [title]

**What**: what to do
**How**: how to do it
**Done When**: condition specific to this step
**[HUMAN REVIEW]**: reason (if applicable)
