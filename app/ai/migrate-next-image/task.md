# Task: Upgrade Next.js Image usage to modern API

Reference: `ai/migrate-next-image/objective.md`, `.cursorrules`, `ai/migrate-next-image/prompt.md`.

**Constraints (do not violate):**

- Do not touch `server/`, `types/`, `docker/`
- Do not change component logic, props, or scss
- Do not touch images already using `width`/`height` for sizing — they are correct; only add blur placeholder props in the dedicated blur step
- Do not fetch blur data from external sources or generate blur at runtime
- Only update Image API usage and add the shared blur placeholder utility

**Stack (use this API surface — do not assume older Next.js Image props):**

| Package | Version |
| ------- | ------- |
| `next`  | ^16     |

**Image API rules:**

| Mode             | Rule                                                                                                                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `fill`           | Use boolean `fill` prop (not `layout="fill"`). Always pair with `sizes`. Parent wrapper must already have `position: relative` — confirm in co-located `.module.scss`; do not add positioning if absent (fix is out of scope). |
| `objectFit`      | Replace deprecated `objectFit="cover"` with `className='object-cover'`.                                                                                                                                                        |
| `width`/`height` | Already correct — do not change dimensions or layout props.                                                                                                                                                                    |
| Blur             | Import `blurDataURL` from `lib/image-placeholder`; add `placeholder="blur"` and `blurDataURL={blurDataURL}` to every `Image` component.                                                                                        |

**Grep patterns to use throughout:**

- `layout="fill"` / `layout='fill'` — deprecated fill usage to migrate
- `from ['"]next/image['"]` — all Image consumers
- `\bfill\b` — modern fill-mode images (verify `sizes` and blur)
- `objectFit=` — deprecated object-fit prop

**Routes to spot-check after each step:**

- Home: `/en-US`
- Category: `/en-US/{title}`
- Marketing: `/en-US/marketing/{uuid}`
- Store: `/en-US/store/{name}/{uuid}`

---

### Step 1: Baseline — confirm app before Image migration

**What**: Establish a known-good state before changing any `Image` usage.

**How**:

1. From repo root (where `docker-compose.yml` lives), run `docker-compose build --no-cache && docker-compose up -d`.
2. Spot-check all routes listed above; confirm images render on home carousel, channel cards, category title, store banner, menu items, and order form.
3. Grep all `.tsx` files for `layout="fill"` and note the count — expect roughly nine occurrences across home, category, and store co-located components under `app/`.
4. Confirm Cursor shows no pre-existing TypeScript or import errors in `app/` and `components/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Record pre-existing image or layout issues and optionally capture a baseline Lighthouse LCP score for later comparison.

---

### Step 2: Create shared blur placeholder utility

**What**: Add a static blur placeholder export reused by every `Image` component in later steps.

**How**:

1. Create `lib/image-placeholder.ts` at the app workspace root (alongside existing `lib/server-query-client.ts`).
2. Export a constant named `blurDataURL` containing a static SVG encoded as a base64 data URL.
3. Do not fetch from CDN, do not call Sharp or any runtime image API, and do not generate blur dynamically.
4. Do not modify any component files in this step.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 3: Replace deprecated `layout="fill"` with the `fill` prop

**What**: Migrate every deprecated fill declaration to the Next.js 16 `fill` boolean prop.

**How**:

1. Grep all `.tsx` files for `layout="fill"` (and single-quote variant). Do not rely on a fixed file list — update every match.
2. Remove the `layout="fill"` prop and add the boolean `fill` prop instead.
3. Where `objectFit="cover"` appears on the same `Image`, replace it with `style={{ objectFit: 'cover' }}` per Next.js 16 Image API.
4. Do not add `sizes` or blur props in this step.
5. Do not change `width`/`height` images.
6. Do not change scss or component logic.
7. Before editing each file, confirm the image's parent wrapper already has `position: relative` in its co-located `.module.scss` (often via `@apply relative`). Do not add positioning styles if missing.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 4: Add `sizes` to fill-mode images migrated from `layout="fill"`

**What**: Add responsive `sizes` to every `Image` that was converted from `layout="fill"` in Step 3.

**How**:

1. Grep all `.tsx` files for `Image` components using the `fill` prop that lack a `sizes` attribute among files under `app/` (home, category, and store co-located components).
2. For each match, inspect the parent wrapper dimensions in the co-located `.module.scss` (width, max-width, grid/flex context) and set `sizes` to reflect the image's actual display width at common breakpoints.
3. Typical patterns: full-bleed banners `(max-width: 768px) 100vw, 100vw`; grid/card thumbnails `(max-width: 768px) 50vw, 25vw`; small icon containers `(max-width: 768px) 20px, 20px` — adjust per component layout.
4. Do not add blur placeholder props in this step.
5. Do not change scss, component logic, or `width`/`height` images.
6. Do not touch `server/`, `types/`, or `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: `sizes` values must match real rendered layout; verify each updated image loads an appropriately sized asset in DevTools Network tab (not always the largest variant). If any sizes value looks incorrect after visual inspection, correct it manually before proceeding to Step 5.

---

### Step 5: Add `sizes` to fill-mode images already using the modern `fill` prop

**What**: Ensure every pre-existing `fill` image (not migrated from `layout="fill"`) also has a `sizes` attribute.

**How**:

1. Grep all `.tsx` files for `Image` components with the `fill` prop but no `sizes` attribute — include root `components/` (e.g. shared shop list) as well as `app/`.
2. Apply the same `sizes` derivation approach as Step 4: read co-located `.module.scss` for wrapper dimensions and breakpoint behavior.
3. Do not add blur placeholder props in this step.
4. Do not change scss, component logic, or `width`/`height` images.
5. Do not touch `server/`, `types/`, or `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Confirm shop/card thumbnails and small badge icons request reasonably sized images in DevTools Network tab.

---

### Step 6: Add blur placeholder to all fill-mode `Image` components

**What**: Apply the shared blur placeholder to every `Image` using the `fill` prop.

**How**:

1. Grep all `.tsx` files for `Image` components with the `fill` prop across `app/` and `components/`.
2. In each file, add `import { blurDataURL } from 'lib/image-placeholder'` (use the project's existing path alias for `lib/*`).
3. On each fill-mode `Image`, add `placeholder="blur"` and `blurDataURL={blurDataURL}`.
4. Do not remove or alter existing `fill`, `sizes`, or `style` props added in earlier steps.
5. Do not change scss, component logic, or `width`/`height` images in this step.
6. Do not touch `server/`, `types/`, or `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 7: Add blur placeholder to all `width`/`height` `Image` components

**What**: Apply the shared blur placeholder to every `Image` sized with explicit `width` and `height`.

**How**:

1. Grep all `.tsx` files importing from `next/image` across `app/` and `components/`.
2. For each `Image` using `width` and/or `height` (and not `fill`), add `import { blurDataURL } from 'lib/image-placeholder'` if not already imported in that file.
3. Add `placeholder="blur"` and `blurDataURL={blurDataURL}` to each matching `Image`.
4. Do not change `width`, `height`, `src`, `alt`, or any other existing props — sizing is already correct.
5. Do not change scss or component logic.
6. Do not touch `server/`, `types/`, or `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 8: Final verification — no deprecated props remain

**What**: Confirm the migration is complete across the entire codebase.

**How**:

1. Grep all `.tsx` files — expect zero matches for `layout="fill"`, `layout='fill'`, and `objectFit=`.
2. Grep for `Image` components with `fill` — every match must include both `sizes` and `placeholder="blur"` except components with width and height both under 40px.
3. Grep for imports from `next/image` — every `Image` usage must include `placeholder="blur"` (fill and width/height modes).
4. Run `docker-compose build --no-cache && docker-compose up -d` from repo root.
5. Visually verify images on home, category, marketing, and store routes; confirm no layout regressions or broken images.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Compare Lighthouse LCP score to Step 1 baseline; confirm improved or unchanged image load behavior with no console warnings about deprecated `layout` or missing `sizes`.
