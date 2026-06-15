'use client';

import {
  QueryClient,
  QueryClientProvider as TanStackQueryClientProvider,
} from '@tanstack/react-query';
import { useState, type ReactNode } from 'react';

/** Default staleTime for SSR-hydrated queries — avoids immediate client refetch after hydration. */
const DEFAULT_STALE_TIME_MS = 60_000;

export function QueryClientProvider({ children }: { children: ReactNode }) {
  const [queryClient] = useState(
    () =>
      new QueryClient({
        defaultOptions: {
          queries: {
            retry: 1,
            staleTime: DEFAULT_STALE_TIME_MS,
          },
        },
      }),
  );

  return (
    <TanStackQueryClientProvider client={queryClient}>
      {children}
    </TanStackQueryClientProvider>
  );
}
