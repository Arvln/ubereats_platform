import type { AppProps } from 'next/app';
import { IntlProvider } from 'next-intl';

import 'styles/globals.scss';
import { Layout } from 'features';

function App({ Component, pageProps }: AppProps) {
  return (
    <IntlProvider locale={pageProps.locale} messages={pageProps.messages}>
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </IntlProvider>
	);
};

export default App;
