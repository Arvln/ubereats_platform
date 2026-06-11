import { gqlServerClient } from 'api/graphql';
import { getLocale, setRequestLocale } from 'next-intl/server';
import { redirect } from 'next/navigation';
import { z } from 'zod';
import {
  marketingByUuidQueryDocument,
  marketingPageDataSchema,
} from './queries';

import classes from '@/styles/pages/marketing/Advertise.module.scss';

const { wrapper, massage } = classes;

const marketingSlugSchema = z.object({
  uuid: z.string(),
});

const marketingSlugsSchema = z.array(marketingSlugSchema);

const marketingUuidsQueryDocument = `
  query {
    carousel {
      uuid
    }
  }
`;

const marketingUuidsResponseSchema = z.object({
  carousel: z.array(marketingSlugSchema),
});

const marketingByUuidResponseSchema = z.object({
  advertise: z.array(marketingPageDataSchema),
});

export async function generateStaticParams() {
  const raw = await gqlServerClient().request<unknown>(
    marketingUuidsQueryDocument,
  );
  const parsed = marketingUuidsResponseSchema.safeParse(raw);
  if (!parsed.success) return [];

  const slugs = marketingSlugsSchema.safeParse(parsed.data.carousel);
  return (slugs.success ? slugs.data : []).map(({ uuid }) => ({ uuid }));
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
    redirect('/');
  }

  const { content } = pageData;

  return (
    <main className={wrapper}>
      <div className={massage}>{content}</div>
    </main>
  );
}
