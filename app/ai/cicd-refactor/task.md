# Task: Refactor GitHub Actions CI/CD Workflows

Refactor the three existing GitHub Actions workflows into three clean, single-responsibility
workflows that match the current stack (Vitest + Playwright), fix known bugs, remove hardcoded
secrets, and implement a split staging/production deploy (Vercel + ghcr.io + Render + Aiven).

Reference: `ai/cicd-refactor/objective.md`, `ai/cicd-refactor/prompt.md`.

## What exists today (verified — do not assume the prompt matches reality)

- Current workflow files are **`.github/workflows/ci-pipeline.yml`, `release-push.yml`, `main-push.yml`**.
  The deliverable file names are **`ci.yml`, `release.yml`, `main.yml`** — new files are created and the
  three old files are deleted (Step 11). Do not leave both sets in place (the old ones still trigger).
- The repository slug is **`Arvln/ubereats_platform`**, so `${{ github.repository }}` →
  `Arvln/ubereats_platform` and the ghcr.io image is `ghcr.io/${{ github.repository }}` (lowercased
  automatically by ghcr). The `actions/delete-package-versions` `package-name` is **`ubereats_platform`**.
- The DB init SQL file is **`docker/mysql/data/data.sql`** (there is NO `init.sql` — the prompt's
  `init.sql` reference is wrong; use `docker/mysql/data/data.sql` everywhere).
- `docker-compose.yml` services: `database` (mysql:5.7, `container_name: database`,
  `MYSQL_ROOT_PASSWORD: root`, `MYSQL_DATABASE: ubereats_platform_local`), `database_tool` (phpMyAdmin),
  `server` (Express, `./server/Dockerfile`), `web` (Next.js, `./app/Dockerfile.dev`), `nginx`
  (publishes host port **80** → only nginx is published; the Next.js `web` container's port 3000 is
  **not** published to the host).
- `app/package.json` scripts: `"test": "vitest run"`, `"test:e2e": "playwright test"`. Package manager
  is pnpm v9; lockfile is `app/pnpm-lock.yaml`; app code is under `app/`.
- Current workflows push to Docker Hub (`arvin1995/...`) and deploy to GCP via `gcloud`. Both the Docker
  Hub push and the entire GCP deploy path are **replaced** by ghcr.io + Vercel/Render/Aiven in this refactor.

## Global constraints (apply to EVERY step)

- Produce exactly three workflow files: `.github/workflows/ci.yml`, `.github/workflows/release.yml`,
  `.github/workflows/main.yml`. Each must be valid YAML and independently maintainable.
- **No matrix variables.** Use a literal `node-version: 20`. Never reference `matrix.node-version`
  (the current `build-and-push` job references it without declaring a matrix — that bug must not reappear).
- **Always install with `pnpm i --frozen-lockfile`** in every job. Never plain `pnpm install`.
- **No hardcoded secrets or passwords.** No literal `-proot`, no Docker Hub usernames/passwords. All
  sensitive values come from GitHub Secrets (names below). ghcr.io login uses the built-in
  `${{ secrets.GITHUB_TOKEN }}` (no manual secret).
- Pin these exact action versions wherever used:
  - `actions/checkout@v4`
  - `pnpm/action-setup@v4` with `version: 9`
  - `actions/setup-node@v4` with `node-version: 20`, `cache: 'pnpm'`, `cache-dependency-path: app/pnpm-lock.yaml`
  - `docker/setup-buildx-action@v3`
  - `docker/build-push-action@v5`
  - `actions/upload-artifact@v4`, `actions/download-artifact@v4`
  - `docker/login-action@v3`
  - `actions/delete-package-versions@v5`
  - `amondnet/vercel-action@v25`
- Use the Docker Compose v2 plugin syntax (`docker compose ...`) — it is preinstalled on GitHub-hosted
  `ubuntu-latest` runners. Do NOT `apt-get install docker-compose` (the current workflows do this; it is
  obsolete and must be removed).
- **Standard setup steps** (the canonical lint/unit/build prelude — reproduce these exact steps verbatim
  in every job that installs dependencies):
  ```yaml
  - uses: actions/checkout@v4
  - name: Install pnpm
    uses: pnpm/action-setup@v4
    with:
      version: 9
  - name: Set up Node.js
    uses: actions/setup-node@v4
    with:
      node-version: 20
      cache: 'pnpm'
      cache-dependency-path: app/pnpm-lock.yaml
  - name: Install dependencies
    run: pnpm i --frozen-lockfile
    working-directory: app
  ```
- **Secrets reference** (restated in every step that uses them — see prompt Secrets Reference):
  - DB (CI integration): `DB_ROOT_PASSWORD`
  - Vercel: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`
  - Render (production only): `RENDER_DEPLOY_HOOK_PRODUCTION`
  - Aiven: `AIVEN_HOST`, `AIVEN_USER`, `AIVEN_PASSWORD`, `AIVEN_DATABASE`
  - ghcr.io: built-in `GITHUB_TOKEN` (no manual secret)
- **Self-contained steps:** each step below is executed in isolation. Do not write "reuse from Step X"
  inside the generated YAML or rely on memory of earlier steps — every constraint a step needs is
  restated in that step. Shared files are always named by full path.

---

## Phase 1 — `ci.yml` (develop / feature/* / bugfix/* branches)

Single-machine Docker Compose that mirrors local dev. No image push, no cloud deploy.

### Step 1: Create `.github/workflows/ci.yml` with triggers, `linting`, and `unit-tests` jobs

**What**: Create the new file `.github/workflows/ci.yml` containing the workflow triggers and the first
two jobs: `linting` then `unit-tests`.

**How**:

- Triggers: `on.push.branches: [develop, 'feature/*', 'bugfix/*']` and `on.pull_request.branches: [develop]`.
- `linting` job (`runs-on: ubuntu-22.04`): run the **Standard setup steps** (checkout →
  `pnpm/action-setup@v4` version 9 → `actions/setup-node@v4` node 20, `cache: 'pnpm'`,
  `cache-dependency-path: app/pnpm-lock.yaml` → `pnpm i --frozen-lockfile` in `working-directory: app`),
  then `pnpm lint` in `working-directory: app`.
- `unit-tests` job (`runs-on: ubuntu-22.04`): run the **Standard setup steps** verbatim, then `pnpm test`
  in `working-directory: app` (this runs Vitest — `app/package.json` `"test": "vitest run"`).
- Do NOT use a `strategy.matrix`; use literal `node-version: 20`. Always `pnpm i --frozen-lockfile`,
  never `pnpm install`.

**Done When**: `.github/workflows/ci.yml` exists with the three triggers above and two jobs (`linting`,
`unit-tests`), no `matrix` anywhere, every install is `pnpm i --frozen-lockfile`, and each job uses
`actions/setup-node@v4` with `node-version: 20` + pnpm cache keyed on `app/pnpm-lock.yaml`.

---

### Step 2: Add the `integration-tests` job to `.github/workflows/ci.yml`

**What**: Add a third job `integration-tests` to `.github/workflows/ci.yml` that boots the full stack via
Docker Compose and runs the Playwright E2E suite.

**How**:

- `integration-tests` job: `runs-on: ubuntu-latest`, `needs: [linting, unit-tests]`.
- Steps in order:
  1. `actions/checkout@v4`.
  2. Bring the stack up with the DB password supplied from a secret (no hardcoded `root`):
     ```yaml
     - name: Build and start the stack
       env:
         MYSQL_ROOT_PASSWORD: ${{ secrets.DB_ROOT_PASSWORD }}
       run: |
         docker compose build --no-cache
         docker compose up -d
     ```
     Note: `docker-compose.yml` currently hardcodes `MYSQL_ROOT_PASSWORD: root` on the `database`
     service. For the secret to take effect, that line must read from the environment, e.g.
     `MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD:-root}`. Make that one-line change to
     `docker-compose.yml` (keeping `:-root` as the local-dev default so `docker compose up` still works
     locally without the env var). Do not change any other service.
  3. Wait for the DB (retry loop, password from `${{ secrets.DB_ROOT_PASSWORD }}`, never literal `root`):
     ```yaml
     - name: Wait for database
       run: |
         for i in $(seq 1 10); do
           if docker exec database mysql -uroot -p"${{ secrets.DB_ROOT_PASSWORD }}" -e "SHOW DATABASES;" >/dev/null 2>&1; then
             echo "database ready"; exit 0
           fi
           echo "waiting for database... ($i)"; sleep 5
         done
         echo "database not ready"; exit 1
     ```
  4. Wait for nginx / the app to actually serve. The Next.js `web` container's port 3000 is **not**
     published to the host — only nginx publishes host port **80** — so the readiness gate must target
     `http://localhost` (port 80), NOT `http://localhost:3000`:
     ```yaml
     - name: Wait for app via nginx
       run: |
         for i in $(seq 1 30); do
           if curl -sf -o /dev/null http://localhost; then echo "app ready"; exit 0; fi
           echo "waiting for app... ($i)"; sleep 5
         done
         echo "app not ready"; exit 1
     ```
  5. Install Playwright's Chromium browser, then run the E2E suite (Playwright replaces Cypress;
     `app/playwright.config.ts` is Chromium-only with `baseURL: 'http://localhost'`):
     ```yaml
     - name: Install Playwright browser
       run: pnpm exec playwright install --with-deps chromium
       working-directory: app
     - name: Run Playwright E2E
       run: pnpm test:e2e
       working-directory: app
     ```
     Because this job runs `pnpm exec playwright` / `pnpm test:e2e`, it must first run the **Standard
     setup steps** (pnpm + Node 20 + `pnpm i --frozen-lockfile` in `app`) before the Playwright steps —
     add them after checkout.
  6. Always tear the stack down, even on failure:
     ```yaml
     - name: Tear down
       if: always()
       run: docker compose down -v
     ```
- Do NOT install or reference Cypress anywhere. Do NOT push any image or deploy in `ci.yml`.

**Done When**: `.github/workflows/ci.yml` has an `integration-tests` job with `needs: [linting, unit-tests]`
that builds + starts the stack with the DB password from `${{ secrets.DB_ROOT_PASSWORD }}`, waits for the
DB and for `http://localhost` (port 80), installs Chromium, runs `pnpm test:e2e` in `app/`, and tears the
stack down with `if: always()`; there is no Cypress reference, no image push, and no `apt-get install docker-compose`.

---

## Phase 2 — `release.yml` (release* branches → staging)

Staging deploy: build + push ghcr.io image, deploy Next.js to Vercel preview, run Aiven init SQL.
Render is NOT deployed on release (reserved for production to stay within the 750 free-hour limit).

### Step 3: Create `.github/workflows/release.yml` with triggers, `linting`, and `unit-tests` jobs

**What**: Create the new file `.github/workflows/release.yml` with triggers and the `linting` then
`unit-tests` jobs.

**How**:

- Triggers: `on.push.branches: ['release*']` and `on.pull_request.branches: ['release*']`.
- `linting` job (`runs-on: ubuntu-22.04`): **Standard setup steps** (checkout → `pnpm/action-setup@v4`
  version 9 → `actions/setup-node@v4` node 20, `cache: 'pnpm'`, `cache-dependency-path: app/pnpm-lock.yaml`
  → `pnpm i --frozen-lockfile` in `working-directory: app`), then `pnpm lint` in `working-directory: app`.
- `unit-tests` job (`runs-on: ubuntu-22.04`): **Standard setup steps** verbatim, then `pnpm test` in
  `working-directory: app`.
- No `matrix`; literal `node-version: 20`. Always `pnpm i --frozen-lockfile`.

**Done When**: `.github/workflows/release.yml` exists with `release*` push + PR triggers and `linting` +
`unit-tests` jobs, no `matrix`, every install `pnpm i --frozen-lockfile`.

---

### Step 4: Add the `build` job to `.github/workflows/release.yml`

**What**: Add a `build` job to `.github/workflows/release.yml` that builds the Express server image and
saves it as a workflow artifact (no push here — push is a separate job).

**How**:

- `build` job: `runs-on: ubuntu-latest`, `needs: [linting, unit-tests]`,
  `if: github.event_name == 'push'` (do not build/deploy on pull requests), and declare an output `TAG`.
- The ghcr.io image is the **Express server** image (Render pulls it in production; Next.js goes to Vercel
  from git, not as an image). So build with `context: .` and `file: ./server/Dockerfile`.
- Steps:
  ```yaml
  - uses: actions/checkout@v4
  - name: Set up Docker Buildx
    uses: docker/setup-buildx-action@v3
  - name: Generate tag
    id: tag
    run: echo "TAG=dev-v1.0.$(date +%Y%m%d%H%M%S)" >> "$GITHUB_OUTPUT"
  - name: Build image
    uses: docker/build-push-action@v5
    with:
      context: .
      file: ./server/Dockerfile
      push: false
      tags: ghcr.io/${{ github.repository }}:${{ steps.tag.outputs.TAG }}
      outputs: type=docker,dest=/tmp/image.tar
  - name: Upload image artifact
    uses: actions/upload-artifact@v4
    with:
      name: docker-image
      path: /tmp/image.tar
  ```
- Expose the tag at job level: `outputs: { TAG: ${{ steps.tag.outputs.TAG }} }`.
- Tag format for release/staging is `dev-v1.0.<timestamp>` (production uses `prod-v1.0.<timestamp>` in
  `main.yml` — do not use that here).

**Done When**: `.github/workflows/release.yml` has a `build` job with `needs: [linting, unit-tests]` and
`if: github.event_name == 'push'` that sets up Buildx, generates a `dev-v1.0.<timestamp>` tag as a step
output, builds `./server/Dockerfile` with `push: false` + `outputs: type=docker,dest=/tmp/image.tar`,
uploads `/tmp/image.tar` as the `docker-image` artifact, and exposes `TAG` as a job output.

---

### Step 5: Add the `push` job to `.github/workflows/release.yml`

**What**: Add a `push` job to `.github/workflows/release.yml` that loads the artifact image, pushes it to
ghcr.io using the built-in `GITHUB_TOKEN`, runs the retention policy, and re-exports the tag.

**How**:

- `push` job: `runs-on: ubuntu-latest`, `needs: build`, `if: github.event_name == 'push'`,
  `permissions: { contents: read, packages: write }` (required for ghcr.io push via `GITHUB_TOKEN`),
  and re-export the tag as a job output `TAG: ${{ needs.build.outputs.TAG }}`.
- Steps:
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
  - name: Delete old images (keep latest 5)
    uses: actions/delete-package-versions@v5
    with:
      package-name: ubereats_platform
      package-type: container
      min-versions-to-keep: 5
      delete-only-untagged-versions: false
  ```
- Use the built-in `${{ secrets.GITHUB_TOKEN }}` for ghcr.io — no manual Docker Hub secret. Do NOT log in
  to Docker Hub (the old workflow's `DOCKER_USERNAME`/`DOCKER_PASSWORD` must not appear).
- `package-name` is `ubereats_platform` (the repo is `Arvln/ubereats_platform`).

**Done When**: `.github/workflows/release.yml` has a `push` job with `needs: build`,
`if: github.event_name == 'push'`, `permissions.packages: write`, that downloads the `docker-image`
artifact, `docker load`s it, logs in to ghcr.io with `GITHUB_TOKEN`, pushes
`ghcr.io/${{ github.repository }}:${{ needs.build.outputs.TAG }}`, runs `delete-package-versions@v5`
(`package-name: ubereats_platform`, `min-versions-to-keep: 5`), and outputs `TAG`. No Docker Hub login anywhere.

---

### Step 6: Add the `deploy` job (staging) to `.github/workflows/release.yml`

**What**: Add a `deploy` job to `.github/workflows/release.yml` that deploys Next.js to a Vercel preview
and runs the idempotent init SQL against Aiven. Render is NOT deployed on release.

**How**:

- `deploy` job: `runs-on: ubuntu-latest`, `needs: push`, `if: github.event_name == 'push'`.
- Steps:
  1. `actions/checkout@v4` (needed to read `docker/mysql/data/data.sql`).
  2. Deploy Next.js to Vercel **preview** (no `--prod` for staging), `working-directory: app`:
     ```yaml
     - name: Deploy Next.js to Vercel (preview)
       uses: amondnet/vercel-action@v25
       with:
         vercel-token: ${{ secrets.VERCEL_TOKEN }}
         vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
         vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
         working-directory: app
     ```
  3. Run the idempotent init SQL against Aiven. The real file is **`docker/mysql/data/data.sql`** (there
     is no `init.sql`). The `mysql` client is not guaranteed on the runner, and Aiven requires TLS:
     ```yaml
     - name: Run DB init against Aiven
       run: |
         sudo apt-get update && sudo apt-get install -y default-mysql-client
         mysql -h ${{ secrets.AIVEN_HOST }} \
               -u ${{ secrets.AIVEN_USER }} \
               -p${{ secrets.AIVEN_PASSWORD }} \
               --ssl-mode=REQUIRED \
               ${{ secrets.AIVEN_DATABASE }} \
               < docker/mysql/data/data.sql
     ```
- Do NOT trigger Render here (Render is production-only). Do NOT use GCP/`gcloud`.

**Done When**: `.github/workflows/release.yml` has a `deploy` job with `needs: push` and
`if: github.event_name == 'push'` that deploys to Vercel **preview** via `amondnet/vercel-action@v25`
(`working-directory: app`, no `--prod`) and runs `docker/mysql/data/data.sql` against Aiven using the
`AIVEN_*` secrets; there is no Render trigger and no `gcloud`/GCP usage.

---

## Phase 3 — `main.yml` (main branch → production)

Production deploy: same build/push structure as release, but Vercel **production**, plus a Render deploy
hook, plus Aiven init SQL. Tag format is `prod-v1.0.<timestamp>`.

### Step 7: Create `.github/workflows/main.yml` with triggers, `linting`, and `unit-tests` jobs

**What**: Create the new file `.github/workflows/main.yml` with triggers and the `linting` then
`unit-tests` jobs.

**How**:

- Triggers: `on.push.branches: [main]` and `on.pull_request.branches: [main]`.
- `linting` job (`runs-on: ubuntu-22.04`): **Standard setup steps** (checkout → `pnpm/action-setup@v4`
  version 9 → `actions/setup-node@v4` node 20, `cache: 'pnpm'`, `cache-dependency-path: app/pnpm-lock.yaml`
  → `pnpm i --frozen-lockfile` in `working-directory: app`), then `pnpm lint` in `working-directory: app`.
- `unit-tests` job (`runs-on: ubuntu-22.04`): **Standard setup steps** verbatim, then `pnpm test` in
  `working-directory: app`.
- No `matrix`; literal `node-version: 20`. Always `pnpm i --frozen-lockfile` (the current `main-push.yml`
  unit-tests job uses bare `pnpm install` — that bug must not reappear).

**Done When**: `.github/workflows/main.yml` exists with `main` push + PR triggers and `linting` +
`unit-tests` jobs, no `matrix`, every install `pnpm i --frozen-lockfile`.

---

### Step 8: Add the `build` job to `.github/workflows/main.yml`

**What**: Add a `build` job to `.github/workflows/main.yml` that builds the Express server image and saves
it as a workflow artifact. Identical to the release build job except the tag prefix is `prod`.

**How**:

- `build` job: `runs-on: ubuntu-latest`, `needs: [linting, unit-tests]`,
  `if: github.event_name == 'push'`, with job output `TAG`.
- The ghcr.io image is the **Express server** image (Render pulls it in production; Next.js goes to Vercel
  from git). Build with `context: .` and `file: ./server/Dockerfile`.
- Steps:
  ```yaml
  - uses: actions/checkout@v4
  - name: Set up Docker Buildx
    uses: docker/setup-buildx-action@v3
  - name: Generate tag
    id: tag
    run: echo "TAG=prod-v1.0.$(date +%Y%m%d%H%M%S)" >> "$GITHUB_OUTPUT"
  - name: Build image
    uses: docker/build-push-action@v5
    with:
      context: .
      file: ./server/Dockerfile
      push: false
      tags: ghcr.io/${{ github.repository }}:${{ steps.tag.outputs.TAG }}
      outputs: type=docker,dest=/tmp/image.tar
  - name: Upload image artifact
    uses: actions/upload-artifact@v4
    with:
      name: docker-image
      path: /tmp/image.tar
  ```
- Expose `outputs: { TAG: ${{ steps.tag.outputs.TAG }} }`. Tag prefix MUST be `prod-v1.0.<timestamp>`
  (not `dev-`).

**Done When**: `.github/workflows/main.yml` has a `build` job with `needs: [linting, unit-tests]` and
`if: github.event_name == 'push'` that sets up Buildx, generates a `prod-v1.0.<timestamp>` tag, builds
`./server/Dockerfile` with `push: false` + `outputs: type=docker,dest=/tmp/image.tar`, uploads the
`docker-image` artifact, and exposes `TAG`.

---

### Step 9: Add the `push` job to `.github/workflows/main.yml`

**What**: Add a `push` job to `.github/workflows/main.yml` that loads the artifact image, pushes it to
ghcr.io using `GITHUB_TOKEN`, runs the retention policy, and re-exports the tag.

**How**:

- `push` job: `runs-on: ubuntu-latest`, `needs: build`, `if: github.event_name == 'push'`,
  `permissions: { contents: read, packages: write }`, and output `TAG: ${{ needs.build.outputs.TAG }}`.
- Steps:
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
  - name: Delete old images (keep latest 5)
    uses: actions/delete-package-versions@v5
    with:
      package-name: ubereats_platform
      package-type: container
      min-versions-to-keep: 5
      delete-only-untagged-versions: false
  ```
- Use the built-in `${{ secrets.GITHUB_TOKEN }}`. Do NOT log in to Docker Hub.

**Done When**: `.github/workflows/main.yml` has a `push` job with `needs: build`,
`if: github.event_name == 'push'`, `permissions.packages: write` that downloads + loads the artifact, logs
in to ghcr.io with `GITHUB_TOKEN`, pushes `ghcr.io/${{ github.repository }}:${{ needs.build.outputs.TAG }}`,
runs `delete-package-versions@v5` (`package-name: ubereats_platform`, keep 5), and outputs `TAG`. No Docker
Hub login.

---

### Step 10: Add the `deploy` job (production) to `.github/workflows/main.yml`

**What**: Add a `deploy` job to `.github/workflows/main.yml` that deploys Next.js to Vercel production,
triggers the Render deploy hook (Render pulls the new ghcr.io image), and runs the idempotent init SQL
against Aiven.

**How**:

- `deploy` job: `runs-on: ubuntu-latest`, `needs: push`, `if: github.event_name == 'push'`.
- Steps:
  1. `actions/checkout@v4` (needed to read `docker/mysql/data/data.sql`).
  2. Deploy Next.js to Vercel **production** (add `vercel-args: '--prod'`), `working-directory: app`:
     ```yaml
     - name: Deploy Next.js to Vercel (production)
       uses: amondnet/vercel-action@v25
       with:
         vercel-token: ${{ secrets.VERCEL_TOKEN }}
         vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
         vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
         vercel-args: '--prod'
         working-directory: app
     ```
  3. Trigger the Render production deploy hook (Render then pulls the new image from ghcr.io):
     ```yaml
     - name: Deploy Express to Render
       run: curl -X POST ${{ secrets.RENDER_DEPLOY_HOOK_PRODUCTION }}
     ```
  4. Run the idempotent init SQL against Aiven (real file is **`docker/mysql/data/data.sql`**; install the
     client; Aiven needs TLS):
     ```yaml
     - name: Run DB init against Aiven
       run: |
         sudo apt-get update && sudo apt-get install -y default-mysql-client
         mysql -h ${{ secrets.AIVEN_HOST }} \
               -u ${{ secrets.AIVEN_USER }} \
               -p${{ secrets.AIVEN_PASSWORD }} \
               --ssl-mode=REQUIRED \
               ${{ secrets.AIVEN_DATABASE }} \
               < docker/mysql/data/data.sql
     ```
- Do NOT use GCP/`gcloud`. Do NOT add a `sync_release` / branch-sync job (the old infinite-loop job is
  removed entirely — see Step 11).

**Done When**: `.github/workflows/main.yml` has a `deploy` job with `needs: push` and
`if: github.event_name == 'push'` that deploys to Vercel **production** (`vercel-args: '--prod'`,
`working-directory: app`), POSTs the `RENDER_DEPLOY_HOOK_PRODUCTION` hook, and runs
`docker/mysql/data/data.sql` against Aiven; there is no `gcloud`/GCP usage and no `sync_release` job.

---

## Phase 4 — Supporting changes & cleanup

### Step 11: Delete the obsolete workflow files and remove the infinite-loop sync job

**What**: Delete the three old workflow files so only the new `ci.yml`, `release.yml`, `main.yml` remain.
This also removes the Docker Hub push, the GCP `gcloud` deploy path, and the `sync_release` job (which
caused a potential infinite trigger loop).

**How**:

- Delete `.github/workflows/ci-pipeline.yml`, `.github/workflows/release-push.yml`, and
  `.github/workflows/main-push.yml`.
- After deletion, grep the `.github/workflows/` directory to confirm none of the following remain anywhere:
  `DOCKER_USERNAME`, `DOCKER_PASSWORD`, `docker-compose push`, `gcloud`, `GCP_CREDENTIALS`,
  `sync_release`, `apt-get install -y docker-compose`, `matrix.node-version`, and the literal `-proot`.
- Confirm `.github/workflows/` contains exactly three files: `ci.yml`, `release.yml`, `main.yml`.

**Done When**: `.github/workflows/` contains only `ci.yml`, `release.yml`, `main.yml`; grepping the folder
for `DOCKER_USERNAME`, `DOCKER_PASSWORD`, `docker-compose push`, `gcloud`, `GCP_CREDENTIALS`,
`sync_release`, `apt-get install -y docker-compose`, `matrix.node-version`, and `-proot` returns no matches.

---

### Step 12: Make `docker/mysql/data/data.sql` idempotent (safe to re-run)

**What**: The `deploy` jobs in `release.yml` and `main.yml` run `docker/mysql/data/data.sql` against Aiven
on **every** deploy, so it must be safe to re-run. Make the SQL idempotent without changing any data values
or table definitions.

**How**:

- Edit `docker/mysql/data/data.sql` (this is the exact, named shared file the deploy jobs run; there is no
  `init.sql`).
- It already starts with `CREATE DATABASE IF NOT EXISTS ... ; use ...;` — keep that.
- Convert every `CREATE TABLE \`X\` (` to `CREATE TABLE IF NOT EXISTS \`X\` (` so re-runs do not error on
  existing tables. Do not alter any column definitions, types, defaults, keys, or `ENGINE`/`COLLATE`.
- Make every `INSERT INTO` idempotent so re-runs do not create duplicate rows or fail on duplicate primary
  keys: change `INSERT INTO` to `INSERT IGNORE INTO` (do not change the inserted values/rows). Do not use
  stored procedures or triggers (the schema must stay pure `CREATE TABLE` + `INSERT`).
- Do not reorder statements and do not remove any table or row.

**Done When**: Every `CREATE TABLE` in `docker/mysql/data/data.sql` uses `CREATE TABLE IF NOT EXISTS`,
every `INSERT INTO` uses `INSERT IGNORE INTO`, no stored procedures/triggers were added, no column
definitions or inserted values were changed, and running the file twice against a fresh MySQL would
succeed both times.

---

### Step 13: Final verification [HUMAN REVIEW]

**What**: Confirm all success criteria from `ai/cicd-refactor/objective.md` are met across the three new
workflows and the init SQL.

**How**: Verify:

- `.github/workflows/` contains exactly `ci.yml`, `release.yml`, `main.yml`; all three are valid YAML
  (e.g. open in editor / run a YAML lint) with no parse errors.
- Each job has a single responsibility; jobs are wired with the correct `needs` order:
  - `ci.yml`: `linting` → `unit-tests` → `integration-tests (needs: [linting, unit-tests])`.
  - `release.yml`: `linting`, `unit-tests` → `build (needs both)` → `push (needs build)` → `deploy (needs push)`.
  - `main.yml`: same chain as release.
- Unit tests run Vitest via `pnpm test`; Playwright E2E runs via `pnpm test:e2e` in `ci.yml` **only**; no
  Cypress reference anywhere.
- No `matrix` / `matrix.node-version` anywhere; every dependency install is `pnpm i --frozen-lockfile`.
- No hardcoded secrets/passwords: no `-proot`, no Docker Hub creds; ghcr.io uses `GITHUB_TOKEN`; the DB
  password and all Vercel/Render/Aiven values come from the secrets listed in Global constraints.
- Staging (`release.yml`) deploys Vercel preview + Aiven only (no Render). Production (`main.yml`) deploys
  Vercel production + Render hook + Aiven.
- ghcr.io image built from `./server/Dockerfile`, pushed as `ghcr.io/${{ github.repository }}:<tag>`
  (`dev-v1.0.*` for release, `prod-v1.0.*` for main), with `delete-package-versions@v5` keeping the latest 5.
- `docker/mysql/data/data.sql` is idempotent (all `CREATE TABLE IF NOT EXISTS`, all `INSERT IGNORE`).
- The old `ci-pipeline.yml`, `release-push.yml`, `main-push.yml` are deleted, and the `sync_release` /
  GCP deploy path is gone.

**[HUMAN REVIEW: approved]**: A human must confirm the GitHub repository has the required secrets
configured (`DB_ROOT_PASSWORD`, `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`,
`RENDER_DEPLOY_HOOK_PRODUCTION`, `AIVEN_HOST`, `AIVEN_USER`, `AIVEN_PASSWORD`, `AIVEN_DATABASE`) and that
the Vercel project, Render service, and Aiven database actually exist — these cannot be verified from the
repo alone and require human judgment before the workflows can succeed on a real push.

**Done When**: A human confirms every bullet above is satisfied.

---

## Out of scope

- Application/component logic, GraphQL schema, or test assertions (no test content changes).
- Restructuring `server/`, `app/` source, or `docker/` beyond the single `docker-compose.yml`
  `MYSQL_ROOT_PASSWORD` env line (Step 2) and the `data.sql` idempotency edits (Step 12).
- Migrating Jest→Vitest or Cypress→Playwright (already done — see `ai/migrate-test/`).
- Creating Vercel/Render/Aiven accounts or provisioning infrastructure.
- Multi-environment isolation (staging and production intentionally share one Render service + one Aiven
  DB for this portfolio, per `ai/cicd-refactor/objective.md`).

## References

- `ai/cicd-refactor/objective.md`
- `ai/cicd-refactor/prompt.md`
- `ai/task-generation-rules.md`
- Current workflows: `.github/workflows/ci-pipeline.yml`, `release-push.yml`, `main-push.yml`
- `docker-compose.yml`, `docker/mysql/data/data.sql`, `app/package.json`
