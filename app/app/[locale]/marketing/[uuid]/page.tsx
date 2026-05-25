import { TPageData, TUUID } from 'types/pages/marketing/advertise';
import { Fields } from 'enums/pages/marketing/advertise';
import { getUUID, getAdvertiseByUUID } from 'graphql/queries/pages/marketing/advertise';
import {
  fetchStaticSlugs,
  fetchPageDataByKey,
  redirectToHome,
} from 'lib/page-data';

import classes from 'styles/pages/marketing/Advertise.module.scss';

const { wrapper, massage } = classes;
const { CAROUSEL, ADVERTISE } = Fields;

export const dynamicParams = false;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TUUID>(getUUID, CAROUSEL);
  return slugs.map(({ uuid }) => ({ uuid }));
}

export default async function AdvertisePage({
  params: { uuid },
}: {
  params: { uuid: string };
}) {
  const pageData = await fetchPageDataByKey<TPageData>(
    getAdvertiseByUUID,
    { uuid },
    ADVERTISE
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
