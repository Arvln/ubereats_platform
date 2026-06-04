import { TUUID } from 'types/pages/marketing/advertise';
import { Fields } from 'enums/pages/marketing/advertise';
import { gqlServerClient } from 'api/graphql';
import { getLocale, setRequestLocale } from 'next-intl/server';
import { fetchStaticSlugs, redirectToHome } from 'lib/page-data';
import { z } from 'zod';
import {
  marketingByUuidQueryDocument,
  marketingPageDataSchema,
  marketingSlugsSchema,
  marketingUuidsQueryDocument,
} from './queries';

import classes from 'styles/pages/marketing/Advertise.module.scss';

const { wrapper, massage } = classes;
const { CAROUSEL } = Fields;

const marketingByUuidResponseSchema = z.object({
  advertise: z.array(marketingPageDataSchema),
});

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TUUID>(
    marketingUuidsQueryDocument,
    CAROUSEL,
    marketingSlugsSchema
  );
  return slugs.map(({ uuid }) => ({ uuid }));
}

export default async function AdvertisePage(props: {
  params: Promise<{ uuid: string }>;
}) {
  const { uuid } = await props.params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const raw = await gqlServerClient().request<unknown>(
    marketingByUuidQueryDocument,
    { uuid },
  );
  const parsed = marketingByUuidResponseSchema.safeParse(raw);
  const pageData = parsed.success ? parsed.data.advertise[0] : undefined;

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
