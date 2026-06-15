import { defineConfig, devices } from '@playwright/test';

// E2E tests run against the app started by `docker-compose up -d`
// (nginx serves the web container on http://localhost:80). Playwright does
// NOT start its own server. WebKit is intentionally omitted because it is not
// supported on macOS 12; Chromium covers the migrated Cypress specs.
export default defineConfig({
  testDir: './e2e',
  // Run serially (like Cypress) against the single dockerized app instance.
  // Parallel workers overload the one app container, slowing React hydration
  // enough to trigger Next.js <Link> hydration-race no-op clicks and slow page loads.
  workers: 1,
  // Generous timeouts: the dockerized app can be slow to fully load/hydrate.
  timeout: 60000,
  expect: { timeout: 15000 },
  use: {
    baseURL: 'http://localhost',
    actionTimeout: 15000,
    navigationTimeout: 30000,
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
  ],
});
