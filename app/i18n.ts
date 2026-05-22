import { defineRouting } from 'next-intl/routing';

export const locales = ['en-US', 'zh-TW'] as const;
export type Locale = (typeof locales)[number];

export const routing = defineRouting({
  locales,
  defaultLocale: 'en-US',
  localePrefix: 'always',
  localeDetection: false,
});
