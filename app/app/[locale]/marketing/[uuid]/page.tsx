import { TPageData, TUUID } from 'types/pages/marketing/advertise';
import { Fields } from 'enums/pages/marketing/advertise';
import { getUUID, getAdvertiseByUUID } from 'graphql/queries/pages/marketing/advertise';
import { getLocale, setRequestLocale } from 'next-intl/server';
import {
  fetchStaticSlugs,
  fetchPageDataByKey,
  redirectToHome,
} from 'lib/page-data';
import { marketingPageDataSchema, marketingSlugsSchema } from './schema';

import classes from 'styles/pages/marketing/Advertise.module.scss';

const { wrapper, massage } = classes;
const { CAROUSEL, ADVERTISE } = Fields;

export const dynamicParams = false;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TUUID>(
    getUUID,
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
    getAdvertiseByUUID,
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
