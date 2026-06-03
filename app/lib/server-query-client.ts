import { QueryClient } from '@tanstack/react-query';

/** Matches client provider — avoids immediate refetch after SSR hydration. */
const DEFAULT_STALE_TIME_MS = 60_000;

/**
 * Per-request QueryClient for Server Components.
 * Do not use a module-level singleton.
 */
export function createServerQueryClient(): QueryClient {
  return new QueryClient({
    defaultOptions: {
      queries: {
        retry: 1,
        staleTime: DEFAULT_STALE_TIME_MS,
      },
    },
  });
}
