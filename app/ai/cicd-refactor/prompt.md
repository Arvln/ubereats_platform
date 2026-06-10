# Prompt: Refactor GitHub Actions CI/CD Workflows

## Project Context

Next.js Uber Eats clone (food delivery platform) with the following stack:

- pnpm v9, Node 20, app lives under `app/` directory
- Next.js App Router — serves UI and a GraphQL reverse proxy at `app/api/graphql/route.ts`
- Express GraphQL server — separate service, real backend + DB layer
- MySQL 5.7 (Docker Compose) / MySQL 8.x compatible (Aiven cloud)
- DB connection fully env-var driven (`MYSQL_HOST`, `MYSQL_USER`, `MYSQL_PASSWORD`, `DATABASE_NAME`)
- GraphQL server URL env-var driven (`GRAPHQL_SERVER_URL`)
  - Docker Compose: `http://server:<port>`
  - Vercel staging/production: `https://your-express.onrender.com`
- Init SQL: pure `CREATE TABLE` + `INSERT`, no stored procedures or triggers
- Vitest + Testing Library for unit tests (`pnpm test`)
- Playwright for E2E tests (`pnpm test:e2e`), working directory: `app/`
- Docker Compose for local/CI environment
- GitHub Container Registry (ghcr.io) for image registry
- `pnpm-lock.yaml` lives at `app/pnpm-lock.yaml`

## Deployment Architecture

### ci.yml (develop / feature/_ / bugfix/_ branches)

Single-machine Docker Compose — mirrors local dev environment exactly.
No image push, no cloud deploy.

### release.yml (release\* branches)

Partial deploy — staging:

| Service    | Platform     | Deploy method                  |
| ---------- | ------------ | ------------------------------ |
| Next.js    | Vercel       | Git-based via vercel-action    |
| Express    | Not deployed | Render reserved for production |
| MySQL      | Aiven        | Run init SQL (idempotent)      |
| nginx      | Not needed   | Vercel handles reverse proxy   |
| phpMyAdmin | Not needed   | Removed in cloud environment   |

### main.yml (main branch)

Full deploy — production:

| Service    | Platform   | Deploy method                      |
| ---------- | ---------- | ---------------------------------- |
| Next.js    | Vercel     | Git-based via vercel-action        |
| Express    | Render     | Pull prebuilt image from ghcr.io   |
| MySQL      | Aiven      | Run init SQL (idempotent)          |
| nginx      | Not needed | Vercel/Render handle reverse proxy |
| phpMyAdmin | Not needed | Removed in cloud environment       |

ghcr.io image is built and pushed in every release/main run as a portable
artifact and to demonstrate real-world CI/CD practice. Retention policy set
to keep latest 5 tags, older images deleted automatically.

## Existing Problems to Fix

1. `build-and-push` job mixes build, E2E, and push — split into separate jobs
2. `matrix.node-version` referenced in `build-and-push` job which declares no matrix
3. Cypress replaced by Playwright — E2E runs via `pnpm test:e2e` in ci.yml only
4. `sync_release` job causes potential infinite trigger loop — remove entirely
5. `pnpm install` used inconsistently — must always be `--frozen-lockfile` in CI
6. DB password hardcoded in workflow (`-proot`) — use GitHub Secrets

## Requirements per Workflow

### ci.yml

Jobs (in order with dependencies):

1. `linting`
2. `unit-tests`
3. `integration-tests` — `needs: [linting, unit-tests]`

`integration-tests` steps:

- Docker Compose build + up (`--no-cache`)
- Wait for DB ready (retry loop, password via secret)
- Wait for nginx ready (retry loop)
- Wait for Next.js app ready (`wait-on http://localhost:3000`)
- Run Playwright E2E: `pnpm test:e2e` in `app/`
- Tear down Docker Compose

### release.yml

Jobs (in order with dependencies):

1. `linting`
2. `unit-tests`
3. `build` — `needs: [linting, unit-tests]`
4. `push` — `needs: build`
5. `deploy` — `needs: push`

`build` steps:

- Set up Docker Buildx
- Generate tag `dev-v1.0.<timestamp>`, output as step output
- Build image (push: false)
- Save image as artifact `/tmp/image.tar`
- Upload artifact for next job

`push` steps:

- Download image artifact
- Load image
- Login to ghcr.io via `GITHUB_TOKEN`
- Push to ghcr.io
- Run retention policy (keep latest 5 tags)
- Output TAG for deploy job

`deploy` steps:

- Deploy Next.js to Vercel (preview)
- Run init SQL against Aiven (idempotent)

### main.yml

Same structure as release.yml but:

- Tag format: `prod-v1.0.<timestamp>`
- `deploy` steps:
  - Deploy Next.js to Vercel production
  - Trigger Render deploy hook (pulls new image from ghcr.io)
  - Run init SQL against Aiven (idempotent)

## Deploy Patterns

### build job

```yaml
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v3

- name: Generate tag
  id: tag
  run: echo "TAG=dev-v1.0.$(date +%Y%m%d%H%M%S)" >> "$GITHUB_OUTPUT"

- name: Build image
  uses: docker/build-push-action@v5
  with:
    push: false
    tags: ghcr.io/${{ github.repository }}:${{ steps.tag.outputs.TAG }}
    outputs: type=docker,dest=/tmp/image.tar

- name: Upload image artifact
  uses: actions/upload-artifact@v4
  with:
    name: docker-image
    path: /tmp/image.tar
```

### push job

```yaml
- name: Download image artifact
  uses: actions/download-artifact@v4
  with:
    name: docker-image
    path: /tmp

- name: Load image
  run: docker load --input /tmp/image.tar

- name: Log in to ghcr.io
  uses: docker/login-action@v3
  with:
    registry: ghcr.io
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}

- name: Push image
  run: docker push ghcr.io/${{ github.repository }}:${{ needs.build.outputs.TAG }}

- name: Delete old images
  uses: actions/delete-package-versions@v5
  with:
    package-name: <repo-name>
    package-type: container
    min-versions-to-keep: 5
    delete-only-untagged-versions: false
```

### Vercel

```yaml
- uses: amondnet/vercel-action@v25
  with:
    vercel-token: ${{ secrets.VERCEL_TOKEN }}
    vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
    vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
    working-directory: app
```

### Render (trigger deploy hook, main only)

```yaml
- name: Deploy Express to Render
  run: curl -X POST ${{ secrets.RENDER_DEPLOY_HOOK_PRODUCTION }}
```

### Aiven DB init (idempotent)

```yaml
- name: Run DB init
  run: |
    mysql -h ${{ secrets.AIVEN_HOST }} \
          -u ${{ secrets.AIVEN_USER }} \
          -p${{ secrets.AIVEN_PASSWORD }} \
          ${{ secrets.AIVEN_DATABASE }} \
          < ./docker/mysql/data/init.sql
```

## Secrets Reference

```
# DB (CI)
DB_ROOT_PASSWORD

# Vercel
VERCEL_TOKEN
VERCEL_ORG_ID
VERCEL_PROJECT_ID

# Render (production only)
RENDER_DEPLOY_HOOK_PRODUCTION

# Aiven
AIVEN_HOST
AIVEN_USER
AIVEN_PASSWORD
AIVEN_DATABASE
```

Note: ghcr.io login uses `GITHUB_TOKEN` which is automatically available
in all GitHub Actions — no manual secret needed.

## Output

Produce three complete workflow files:

- `.github/workflows/ci.yml`
- `.github/workflows/release.yml`
- `.github/workflows/main.yml`

Each file should be production-quality with inline comments on non-obvious steps.
No hardcoded values. All sensitive data via GitHub Secrets.
Always use `pnpm i --frozen-lockfile` for dependency installation.
