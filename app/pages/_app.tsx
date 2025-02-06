import type { AppProps } from 'next/app';
import { IntlProvider } from 'next-intl';
import { useCookies } from 'react-cookie';

import 'styles/globals.scss';
import { Layout } from 'features';
import { LocaleProvider } from 'contexts';

function App({ Component, pageProps }: AppProps) {
  const [cookies] = useCookies<"NEXT_LOCALE", {
    NEXT_LOCALE?: string;
  }>(['NEXT_LOCALE']);
  const locale = cookies.NEXT_LOCALE || 'zh-TW';

  return (
    <LocaleProvider>
      <IntlProvider locale={locale} messages={pageProps.messages}>
        <Layout>
          <Component {...pageProps} />
        </Layout>
      </IntlProvider>
    </LocaleProvider>
	);
};

export default App;
