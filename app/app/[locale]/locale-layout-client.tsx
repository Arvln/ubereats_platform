"use client";

import Layout from "features/layout";

export default function LocaleLayoutClient({
  children,
}: {
  children: React.ReactNode;
}) {
  return <Layout>{children}</Layout>;
}
