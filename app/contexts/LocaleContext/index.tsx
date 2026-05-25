'use client';

import { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { useCookies } from 'react-cookie';
import { locales } from '../../i18n';

interface LocaleContextType {
  locale: string;
  changeLocale: (newLocale: string) => void;
}

const LocaleContext = createContext<LocaleContextType | null>(null);

export const LocaleProvider = ({ pageLocale, children }: {
  pageLocale: 'zh-TW' | 'en-US';
  children: ReactNode;
}) => {
  const router = useRouter();
  const pathname = usePathname();
  const [cookies, setCookie] = useCookies<"NEXT_LOCALE", {
    NEXT_LOCALE?: string;
  }>(['NEXT_LOCALE']);
  const selectedLocale = cookies.NEXT_LOCALE || pageLocale || 'zh-TW';
  const [locale, setLocale] = useState(selectedLocale);

  useEffect(() => {
    setLocale(selectedLocale);
  }, [selectedLocale]);

  const changeLocale = (newLocale: string) => {
    setCookie('NEXT_LOCALE', newLocale, { path: '/', maxAge: 365 * 24 * 60 * 60 });
    setLocale(newLocale);
    const localePattern = new RegExp(`^/(${locales.join('|')})`);
    const pathnameWithoutLocale = (pathname ?? '').replace(localePattern, '') || '';
    router.push(`/${newLocale}${pathnameWithoutLocale}`);
  };

  return (
    <LocaleContext.Provider value={{ locale, changeLocale }}>
      {children}
    </LocaleContext.Provider>
  );
}

export const useLocale = (): LocaleContextType => {
  const context = useContext(LocaleContext);
  if (!context) {
    throw new Error('useLocale must be used within a LocaleProvider');
  }
  return context;
}
