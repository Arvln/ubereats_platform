import { defineConfig, devices } from '@playwright/test';

// E2E tests run against the app started by `docker-compose up -d`
// (nginx serves the web container on http://localhost:80). Playwright does
// NOT start its own server. WebKit is intentionally omitted because it is not
// supported on macOS 12; Chromium covers the migrated Cypress specs.
export default defineConfig({
  testDir: './e2e',
  use: {
    baseURL: 'http://localhost',
  },
  expect: { timeout: 10000 },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
  ],
});
