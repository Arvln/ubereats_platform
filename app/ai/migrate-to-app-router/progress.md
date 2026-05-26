# Progress: Migrate Pages Router → App Router

## Status

In progress — Step 14 next.

## Lessons Learned

### 1. Bug analysis ownership

Cursor wastes tokens trying to find bug root causes on its own.
Best workflow: Claude analyses the bug → gives Cursor a precise fix → Cursor executes.
For small and obvious fixes, just edit the file directly — faster than going through Cursor.

### 2. Write task.md steps general, not specific

Listing specific filenames causes Cursor to miss other affected files.
e.g. "Update features/carousel link" missed the Logo link in features/header.
Better: "Grep for all hardcoded locale prefixes across the codebase and update to next-intl Link."
General instructions let Cursor scan broadly and cover more ground.

### 3. URL decoding

App Router does not auto-decode URL params. Pages Router did.
Always use decodeURIComponent for dynamic params that may contain non-ASCII characters.

### 4. Review ported logic carefully

Cursor missed the conditional key check when porting getPageProps to lib/page-data.ts.
The original had: if (key) { pageData = pageDataList[0] }
Cursor dropped this condition and always did pageDataList[0].
Always review ported logic line by line — do not assume Cursor preserves all conditional branches.

### 5. Always provide dependency versions in prompts

next-intl config setup differs between versions.
Cursor assumed the wrong config format because the version was not specified.
Always include the exact version in prompts (e.g. next-intl@3.26.3) so Cursor references the correct API.
