import { TPageData, TUUID } from 'types/pages/marketing/advertise';
import { Fields } from 'enums/pages/marketing/advertise';
import { getLocale, setRequestLocale } from 'next-intl/server';
import {
  fetchStaticSlugs,
  fetchPageDataByKey,
  redirectToHome,
} from 'lib/page-data';
import {
  marketingByUuidQueryDocument,
  marketingPageDataSchema,
  marketingSlugsSchema,
  marketingUuidsQueryDocument,
} from './queries';

import classes from 'styles/pages/marketing/Advertise.module.scss';

const { wrapper, massage } = classes;
const { CAROUSEL, ADVERTISE } = Fields;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TUUID>(
    marketingUuidsQueryDocument,
    CAROUSEL,
    marketingSlugsSchema
  );
  return slugs.map(({ uuid }) => ({ uuid }));
}

export default async function AdvertisePage(
  props: {
    params: Promise<{ uuid: string }>;
  }
) {
  const params = await props.params;

  const {
    uuid
  } = params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const pageData = await fetchPageDataByKey<TPageData>(
    marketingByUuidQueryDocument,
    { uuid },
    ADVERTISE,
    marketingPageDataSchema
  );

  if (!pageData) {
    return redirectToHome();
  }

  const { content } = pageData;

  return (
    <main className={wrapper}>
      <div className={massage}>{content}</div>
    </main>
  );
}
