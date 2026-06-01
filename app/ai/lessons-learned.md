## Lessons Learned

### 1. Bug analysis ownership

Cursor wastes tokens trying to find bug root causes on its own.
Best workflow: Claude analyses the bug → gives Cursor a precise fix → Cursor executes.
For small and obvious fixes, just edit the file directly — faster than going through Cursor.

### 2. Review ported logic carefully

Cursor missed the conditional key check when porting getPageProps to lib/page-data.ts.
The original had: if (key) { pageData = pageDataList[0] }
Cursor dropped this condition and always did pageDataList[0].
Always review ported logic line by line — do not assume Cursor preserves all conditional branches.
