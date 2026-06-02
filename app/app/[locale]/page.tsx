import { TPageData } from 'types/pages';
import {
  Shortcut,
  Carousel,
  RestrictSearch,
  Channel,
} from 'features';
import { fetchPageData, redirectToHome } from 'lib/page-data';
import { getLocale, setRequestLocale } from 'next-intl/server';
import { homePageDataSchema, homeQueryDocument } from './queries';

import classes from 'styles/pages/Home.module.scss';

const { wrapper, storesWrapper } = classes;

export default async function HomePage() {
  const locale = await getLocale();
  setRequestLocale(locale);

  const pageData = await fetchPageData<TPageData>(
    homeQueryDocument,
    undefined,
    homePageDataSchema
  );

  if (!pageData) {
    return redirectToHome();
  }

  const { shortcut, carousel, channel } = pageData;

  return (
    <main className={wrapper}>
      <Shortcut data={shortcut} />
      <hr />
      <Carousel data={carousel} />
      <section className={storesWrapper}>
        <RestrictSearch isCuisines />
        <Channel data={channel} />
      </section>
    </main>
  );
}
