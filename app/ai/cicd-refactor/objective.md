# Objective: CI/CD Pipeline Refactor

Refactor the three existing GitHub Actions workflows (ci, release, main) to reflect
industry-standard practices, fix existing bugs, and align with the current tech stack
(Vitest + Playwright) and a split deployment architecture for staging/production.

## Architecture Decision

- ci.yml: single-machine Docker Compose (mirrors local dev, used for integration tests)
- release.yml: build image + push ghcr.io + Vercel preview + Aiven only
  (Render deploy skipped on release — staging Vercel preview reuses existing
  Render production service to stay within 750 free hours/month limit)
- main.yml: build image + push ghcr.io + Vercel production + trigger Render deploy + Aiven

## Deployment Strategy

- Next.js deploys to Vercel via Git-based vercel-action
- Vercel preview (staging) and production both point to the same Render Express service
- Express deploys to Render only on main push (production only)
- MySQL init SQL runs against Aiven on every deploy (idempotent)
- Staging and production share the same Render service and Aiven database
  (acceptable for portfolio; not suitable for production-grade isolation)
- ghcr.io image built and pushed in every release/main run as portable artifact
- Render 750 free hours reserved for single production service only
- Render free tier cold start mitigated by Uptime Robot pinging /health every 5 minutes

## Success Criteria

- All three workflows clean, non-duplicated, independently maintainable
- Each job has a single responsibility
- Vitest runs unit tests (`pnpm test`)
- Playwright replaces Cypress for E2E tests (`pnpm test:e2e`) in ci.yml only
- No matrix variable bugs
- No hardcoded secrets or passwords
- Consistent --frozen-lockfile across all jobs
- Staging deploys on release branch (Vercel preview + Aiven only)
- Production deploys on main branch (Vercel + Render + Aiven)
- DB init SQL is idempotent (safe to re-run)
