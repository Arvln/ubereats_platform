# Prompt: Generate task.md for Next.js Image modernisation

You are a senior frontend engineer.

Read this entire codebase and `ai/migrate-next-image/objective.md` first,
then generate a task.md for upgrading all Next.js Image usage to the modern API.

## Output requirements

- Break down into small, verifiable steps
- Every step must have a "Done When" condition
- Mark [HUMAN REVIEW] on any step requiring human judgment
- One concern per step
- Each step must be self-contained — do not reference future steps or assume prior step context is remembered
- When a shared resource is created in one step and reused in later steps, explicitly state the resource name and location in each step that uses it

## Constraints

- Do NOT touch: server/, types/, docker/
- Do NOT change component logic, props, or scss
- Do NOT touch images already using width/height — they are correct
- Do NOT fetch blur data from external sources
- Only update Image API usage and add shared blur placeholder

## Image API Rules

### fill mode

- Replace `layout="fill"` with `fill` prop
- Always add `sizes` reflecting the image's actual display size at different breakpoints
- Parent element must have `position: relative` — confirm before changing, do not add if already present

### width/height mode

- Already correct — do not touch

### Blur placeholder

- Create a shared utility at `lib/image-placeholder.ts` exporting `blurDataURL`
- Use a static SVG base64 — do not fetch or generate at runtime
- Apply `placeholder="blur"` and `blurDataURL={blurDataURL}` to every `Image` component

## Done When (per step)

No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running
`docker-compose build --no-cache && docker-compose up -d`

## Output format

Save the result as `ai/migrate-next-image/task.md`

## task.md structure per step

### Step N: [title]

**What**: what to do
**How**: how to do it
**Done When**: No TypeScript or import errors shown in Cursor editor, and human verifies in browser after running `docker-compose build --no-cache && docker-compose up -d`
**[HUMAN REVIEW]**: reason (if applicable)
