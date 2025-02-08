import type { AppProps } from 'next/app';
import { IntlProvider } from 'next-intl';

import 'styles/globals.scss';
import { Layout } from 'features';
import { LocaleProvider } from 'contexts';

function App({ Component, pageProps }: AppProps) {
  return (
    <LocaleProvider pageLocale={pageProps.locale}>
      <IntlProvider locale={pageProps.locale} messages={pageProps.messages}>
        <Layout>
          <Component {...pageProps} />
        </Layout>
      </IntlProvider>
    </LocaleProvider>
	);
};

export default App;
