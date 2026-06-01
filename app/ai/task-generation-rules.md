## Task Generation Rules

### 1. Write task.md steps general for file scope, explicit for shared resources

When describing which files to update, use general instructions
(grep, scan broadly) rather than listing specific filenames —
Cursor may miss affected files not listed.
e.g. "Grep for all hardcoded locale prefixes" instead of
"Update features/carousel/index.tsx".

Exception: when a specific shared resource is created and reused
across steps (e.g. lib/server-query-client.ts), always name it
explicitly in every step that uses it.

### 2. Always provide dependency versions in prompts

next-intl config setup differs between versions.
Cursor assumed the wrong config format because the version was not specified.
Always include the exact version in prompts (e.g. next-intl@3.26.3) so Cursor references the correct API.

### 3. task.md steps must be self-contained

Cursor executes each step in isolation — it does not remember
instructions from previous steps.
Do not use cross-step references like "reuse from Step X" or
"prepare for Step Y" — Cursor will ignore them during execution.
Instead: repeat critical constraints in every step that needs them,
and explicitly name shared resources in each step that uses them.
Fix: add self-contained requirement to prompt Output requirements.
