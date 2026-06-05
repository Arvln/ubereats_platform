"use client";

import Layout from "./components/layout";
import { QueryClientProvider } from "providers/query-client-provider";

export default function LocaleLayoutClient({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <QueryClientProvider>
      <Layout>{children}</Layout>
    </QueryClientProvider>
  );
}
