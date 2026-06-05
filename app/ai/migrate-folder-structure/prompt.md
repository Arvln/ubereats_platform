# Prompt: Generate task.md for enums + features co-location migration

You are a senior frontend engineer.

Read this entire codebase and `ai/migrate-folder-structure/objective.md` first,
then generate a task.md for co-locating enums and features with their App Router consumers.

## Output requirements

- Break down into small, verifiable steps
- Every step must have a "Done When" condition
- Mark [HUMAN REVIEW] on any step requiring human judgment
- One concern per step
- Each step must be self-contained — do not reference future steps or assume prior step context is remembered
- When a shared resource is created in one step and reused in later steps, explicitly state the resource name and location in each step that uses it

## Constraints

- Do NOT touch: server/, types/, docker/
- Do NOT change component logic, props, or APIs
- Do NOT change scss or Tailwind
- Do NOT add new features
- Only move files — do not refactor internals

## Naming Convention

- Use `components/` (no leading underscore) for co-located component directories inside route segments
- Apply this convention consistently at every level of the `app/` directory tree

## Migration Rules

### Enum Co-location

- Grep each enum for its callers before deciding placement
- Single caller → inline enum into that file; delete the enum file
- Multiple callers → move to closest shared parent directory under `app/`; update all imports
- Delete `enums/` directory after all enums are relocated

### Feature Co-location

- Each component in `features/` maps to a consuming route in `app/[locale]/`
- Move to the `components/` subdirectory of the closest consuming route
- If shared across multiple routes, move to `components/` of the closest common parent
- Update all imports across the codebase
- Delete `features/` directory after all components are relocated

## Done When (per step)

No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running
`docker-compose build --no-cache && docker-compose up -d`

## Output format

Save the result as `ai/migrate-folder-structure/task.md`

## task.md structure per step

### Step N: [title]

**What**: what to do
**How**: how to do it
**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`
**[HUMAN REVIEW]**: reason (if applicable)
