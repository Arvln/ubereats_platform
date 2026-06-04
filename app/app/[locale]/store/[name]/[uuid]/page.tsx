import { TStoreSlug } from "types/pages/store";
import { Fields } from "enums/pages/store";
import { Store } from "features";
import { fetchStaticSlugs } from "lib/page-data";
import { getLocale, setRequestLocale } from "next-intl/server";
import { dehydrate, HydrationBoundary } from "@tanstack/react-query";
import { createServerQueryClient } from "lib/server-query-client";
import {
  fetchStoreBySlugServer,
  storeBySlugQueryKey,
  storeSlugsQueryDocument,
  storeSlugsSchema,
} from "./queries";

const { STORESLUGS } = Fields;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TStoreSlug>(
    storeSlugsQueryDocument,
    STORESLUGS,
    storeSlugsSchema
  );
  return slugs.map(({ name, uuid }) => ({ name, uuid }));
}

export default async function StorePage(props: {
  params: Promise<{ name: string; uuid: string }>;
}) {
  const { name, uuid } = await props.params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const decodedName = decodeURIComponent(name);
  const queryClient = createServerQueryClient();

  await queryClient.prefetchQuery({
    queryKey: storeBySlugQueryKey(decodedName, uuid),
    queryFn: () => fetchStoreBySlugServer(decodedName, uuid),
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <Store />
    </HydrationBoundary>
  );
}
