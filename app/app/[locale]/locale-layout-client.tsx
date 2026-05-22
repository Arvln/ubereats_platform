'use client';

import type { Locale } from '../../i18n';
import Layout from 'features/layout';
import { LocaleProvider } from 'contexts';

export default function LocaleLayoutClient({
  children,
  pageLocale,
}: {
  children: React.ReactNode;
  pageLocale: Locale;
}) {
  return (
    <LocaleProvider pageLocale={pageLocale}>
      <Layout>{children as JSX.Element}</Layout>
    </LocaleProvider>
  );
}
