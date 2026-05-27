import { NextIntlClientProvider } from 'next-intl';
import { notFound } from 'next/navigation';
import { locales, type Locale } from '../../i18n';
import { loadMessages } from 'lib/page-data';
import LocaleLayoutClient from './locale-layout-client';

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export default async function LocaleLayout(
  props: {
    children: React.ReactNode;
    params: Promise<{ locale: string }>;
  }
) {
  const params = await props.params;

  const {
    locale
  } = params;

  const {
    children
  } = props;

  if (!locales.includes(locale as Locale)) {
    notFound();
  }

  const messages = await loadMessages(locale as Locale);

  return (
    <NextIntlClientProvider locale={locale} messages={messages}>
      <LocaleLayoutClient>
        {children}
      </LocaleLayoutClient>
    </NextIntlClientProvider>
  );
}
