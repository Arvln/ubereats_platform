# Task: Co-locate enums and features with App Router consumers

Reference: `ai/migrate-folder-structure/objective.md`, `.cursorrules`, `conventions.md`, `ai/migrate-folder-structure/prompt.md`.

**Constraints (do not violate):**

- Do not touch `server/`, `types/`, `docker/`
- Do not change component logic, props, or APIs
- Do not change scss or Tailwind class names
- Do not add new features
- Only move files and update imports — do not refactor internals

**Naming convention:**

- Use `components/` (no leading underscore) for co-located component directories inside route segments under `app/`
- Apply this convention at every level of the `app/` directory tree

**Current inventory:**

| Area             | Location today                                                                                    | Consumers                                                                             |
| ---------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| Enums            | `enums/features/channel/`                                                                         | `features/channel/utils.ts` (1 caller)                                                |
| Enums            | `enums/features/restrict_search/`                                                                 | `features/restrict_search/index.tsx` (1 caller)                                       |
| Enums            | `enums/features/category/`                                                                        | `features/category/index.tsx`, `features/category/title/index.tsx` (2 callers)        |
| Layout shell     | `features/layout`, `header`, `footer`, `popups`, `entry_options`                                  | `app/[locale]/locale-layout-client.tsx` (all routes)                                  |
| Home features    | `features/shortcut`, `carousel`, `restrict_search`, `channel`, `channel_shop`, `channel_category` | `app/[locale]/page.tsx`                                                               |
| Category feature | `features/category` (+ `title/` subfolder)                                                        | `app/[locale]/[title]/page.tsx`; imports `restrict_search` from home-shared set       |
| Store feature    | `features/store` (+ `title/`, `sidebar/`, `order_form/`, `menu/` subfolders)                      | `app/[locale]/store/[name]/[uuid]/page.tsx`; `menu` imports `FormContext` from layout |
| Barrel           | `features/index.ts`                                                                               | Home, category, and store pages                                                       |

**Target locations:**

| Resource                                    | Target directory                                                   |
| ------------------------------------------- | ------------------------------------------------------------------ |
| Layout shell components                     | `app/[locale]/components/`                                         |
| Home-only + home/category-shared components | `app/[locale]/components/`                                         |
| Category page components                    | `app/[locale]/[title]/components/`                                 |
| Store page components                       | `app/[locale]/store/[name]/[uuid]/components/`                     |
| Multi-caller `RecommandCategories` enum     | `app/[locale]/[title]/components/category/recommand-categories.ts` |

**Note:** Root `components/` (button, form, shop, etc.) is unchanged. Co-located route components live under `app/<route-segment>/components/` — not the root `components/` alias.

**Path aliases to remove when migration completes:** `features/*`, `enums/*` in `tsconfig.json`

**Grep patterns to use throughout:** `enums/`, `features/`, `from "features"`, `from 'features'`

---

### Step 1: Baseline — confirm app before folder migration

**What**: Establish a known-good state before moving any files.

**How**:

1. From repo root (where `docker-compose.yml` lives), run `docker-compose build --no-cache && docker-compose up -d`.
2. Spot-check all routes: home (`/en-US`), category (`/en-US/{title}`), marketing (`/en-US/marketing/{uuid}`), store (`/en-US/store/{name}/{uuid}`), locale switch (en-US ↔ zh-TW).
3. Exercise home UI: shortcut links, carousel, restrict-search filters, channel shop/category pagination.
4. Confirm Cursor shows no pre-existing TypeScript or import errors in `app/`, `features/`, or `enums/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Record any pre-existing UI or build issues so they are not blamed on this migration.

---

### Step 2: Inline single-caller enums

**What**: Move enum definitions into their sole consuming file; delete the standalone enum files.

**How**:

1. Grep for imports from `enums/features/channel` and `enums/features/restrict_search` across the codebase.
2. **`ContentTypes`** (`enums/features/channel/index.ts`): inline the enum into `features/channel/utils.ts`; remove the `enums/features/channel` import.
3. **All enums in `enums/features/restrict_search/index.ts`** (`ConditionsTypes`, `ClassificationTypes`, `ClassificationsTypes`, `PriceLevelTypes`, `DeliveryCostLimitTypes`, `DeliveryRestrictionTypes`, `DeliveryRestrictionsTypes`): inline into `features/restrict_search/index.tsx`; remove the `enums/features/restrict_search` import.
4. Delete `enums/features/channel/index.ts` and `enums/features/restrict_search/index.ts` after confirming zero remaining imports.
5. Remove empty directories under `enums/features/` if any remain.
6. Do not change enum member values, names, or any logic that uses them.
7. Do not touch `enums/features/category/` in this step.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 3: Relocate multi-caller `RecommandCategories` enum

**What**: Move `RecommandCategories` from `enums/features/category/` to `app/[locale]/[title]/components/category/recommand-categories.ts`.

**How**:

1. Grep for `RecommandCategories` and `enums/features/category` across the codebase; confirm callers are only `features/category/index.tsx` and `features/category/title/index.tsx`.
2. Create `app/[locale]/[title]/components/category/recommand-categories.ts` and move the `RecommandCategories` enum there unchanged.
3. Update imports in `features/category/index.tsx` and `features/category/title/index.tsx` to import from `app/[locale]/[title]/components/category/recommand-categories.ts` (use a relative path from each file's current location under `features/category/`).
4. Delete `enums/features/category/index.ts` after confirming zero remaining imports from `enums/features/category`.
5. Do not change enum member values or consuming logic.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Confirm `recommand-categories.ts` exists at `app/[locale]/[title]/components/category/recommand-categories.ts`, both callers under `features/category/` resolve the import without errors, and no unrelated routes reference the file. Callers are not yet co-located with the enum — that happens in Step 7.

---

### Step 4: Delete `enums/` directory

**What**: Remove the top-level `enums/` directory after all enums are inlined or relocated.

**How**:

1. Grep the codebase for `enums/` — confirm zero imports remain.
2. Delete any remaining files and directories under `enums/`.
3. Remove the `enums/*` path alias from `tsconfig.json`.
4. Do not touch `server/`, `types/`, or `docker/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

---

### Step 5: Move layout shell features to `app/[locale]/components/`

**What**: Co-locate the all-route layout shell with the locale layout consumer.

**How**:

1. Create `app/[locale]/components/`.
2. Move these directories from `features/` into `app/[locale]/components/` unchanged (preserve each folder's `index.tsx`, `types/`, and any other files):
   - `layout`
   - `header`
   - `footer`
   - `popups`
   - `entry_options`
3. Update internal imports among these five moved components so they reference each other via relative paths within `app/[locale]/components/` (replace any `features/...` imports).
4. Update `app/[locale]/locale-layout-client.tsx` to import `Layout` from the new location under `app/[locale]/components/layout`.
5. Grep for any remaining imports of `features/layout`, `features/header`, `features/footer`, `features/popups`, or `features/entry_options`; update each to the new path.
6. Do not change component logic, props, scss imports (`styles/features/...` paths stay the same), or theme files under `themes/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW: approved]**: Header, footer, entry-options popup, and form overlay work on every route.

---

### Step 6: Move home page features to `app/[locale]/components/`

**What**: Co-locate home-only and home/category-shared features with `app/[locale]/page.tsx`.

**How**:

1. Move these directories from `features/` into `app/[locale]/components/` unchanged (preserve `index.tsx`, `types/`, `utils.ts`, and subfolders):
   - `shortcut`
   - `carousel`
   - `restrict_search`
   - `channel`
   - `channel_shop`
   - `channel_category`
2. Update internal imports among these moved components (e.g. `channel` importing `channel_shop` and `channel_category`) to relative paths within `app/[locale]/components/`.
3. Update `app/[locale]/page.tsx` to import `Shortcut`, `Carousel`, `RestrictSearch`, and `Channel` from their new locations under `app/[locale]/components/` (replace the `from "features"` barrel import).
4. Grep for any remaining imports of `features/shortcut`, `features/carousel`, `features/restrict_search`, `features/channel`, `features/channel_shop`, or `features/channel_category`; update each.
5. Do not change component logic, props, or scss import paths.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Home page shortcut, carousel, restrict-search filters, and channel pagination behave as before.

---

### Step 7: Move category feature to `app/[locale]/[title]/components/`

**What**: Co-locate the category page feature with its route.

**How**:

1. Create `app/[locale]/[title]/components/` if it does not already exist (Step 3 may have created `components/category/`).
2. Move `features/category/` (including the `title/` subfolder) into `app/[locale]/[title]/components/category/` unchanged. Do not overwrite `recommand-categories.ts` created in Step 3.
3. Update imports inside the moved category components:
   - `RecommandCategories` from `./recommand-categories` in `category/index.tsx` and `../recommand-categories` in `category/title/index.tsx`.
   - `RestrictSearch` from `app/[locale]/components/restrict_search`.
4. Update `app/[locale]/[title]/page.tsx` to import `Category` from `./components/category` (or equivalent relative path).
5. Grep for any remaining imports of `features/category`; update each.
6. Do not change component logic, props, or scss import paths.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Category page title, restrict-search, and shop list render correctly for multiple category slugs.

---

### Step 8: Move store feature to `app/[locale]/store/[name]/[uuid]/components/`

**What**: Co-locate the store page feature with its route.

**How**:

1. Create `app/[locale]/store/[name]/[uuid]/components/`.
2. Move `features/store/` (including `title/`, `sidebar/`, `order_form/`, and `menu/` subfolders) into `app/[locale]/store/[name]/[uuid]/components/store/` unchanged.
3. Update imports inside the moved store components:
   - In `app/[locale]/store/[name]/[uuid]/components/store/menu/index.tsx`, replace `import { FormContext } from 'features/layout'` with `import { FormContext } from '../../../../../../components/layout'` (resolves to `app/[locale]/components/layout/index.tsx`, moved in Step 5).
   - Confirm `FormContext` is exported as a named export from `app/[locale]/components/layout/index.tsx` before updating the import.
4. Update `app/[locale]/store/[name]/[uuid]/page.tsx` to import `Store` from `./components/store` (or equivalent relative path).
5. Grep for any remaining imports of `features/store`; update each.
6. Do not change component logic, props, or scss import paths.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Store page menu, sidebar, order form, and title render correctly; form overlay still works via `FormContext`.

---

### Step 9: Remove `features/` barrel and delete `features/` directory

**What**: Delete the dissolved `features/` top-level directory and its barrel export.

**How**:

1. Grep the entire codebase for `features/` and `from "features"` / `from 'features'` — confirm zero imports remain.
2. Delete `features/index.ts` and any remaining files or directories under `features/`.
3. Remove the `features/*` path alias from `tsconfig.json`.
4. In `tailwind.config.js`, replace the entire purge array with `['./app/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}']` — do not change any other Tailwind config values.
5. Do not touch `server/`, `types/`, `docker/`, or root `components/`.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: Confirm `features/` and `enums/` directories are fully deleted from the repo root.

---

### Step 10: Final verification across all routes

**What**: End-to-end check that the co-located structure works and success conditions are met.

**How**:

1. Grep the codebase — confirm zero references to top-level `features/` or `enums/` directories and zero `features/*` / `enums/*` path-alias imports.
2. Confirm directory layout:
   - `app/[locale]/components/` contains layout shell and home features
   - `app/[locale]/[title]/components/` contains category feature
   - `app/[locale]/store/[name]/[uuid]/components/` contains store feature
   - No `features/` or `enums/` directories at repo root
3. From repo root, run `docker-compose build --no-cache && docker-compose up -d`.
4. Verify all pages: home, category, marketing, store; locale switch en-US ↔ zh-TW.
5. Exercise interactive UI: carousel, channel pagination, restrict-search filters, entry-options popup, store order form.

**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`

**[HUMAN REVIEW]**: All success conditions in `ai/migrate-folder-structure/objective.md` are met.

---

## Out of scope

- Tailwind or scss refactors (class names and `styles/features/...` import paths stay as-is)
- Component logic, props, or API changes
- Route or data layer changes (`queries.ts`, React Query, GraphQL)
- Root `components/` shared primitives (button, form, shop, etc.)
- `server/`, `types/`, `docker/`
- `themes/` directory (uses its own `themes/features/` — separate from dissolved top-level `features/`)

## References

- `ai/migrate-folder-structure/objective.md`
- `ai/migrate-folder-structure/prompt.md`
- `ai/task-generation-rules.md`
- `.cursorrules`, `conventions.md`
