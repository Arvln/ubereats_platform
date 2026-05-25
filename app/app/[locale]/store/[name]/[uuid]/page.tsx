import { TPageData, TStoreSlug } from "types/pages/store";
import { Fields } from "enums/pages/store";
import { getStoreSlugs, getStoreBySlug } from "graphql/queries/pages/store";
import { Store } from "features";
import { fetchStaticSlugs, fetchPageDataSingle } from "lib/page-data";

const { STORESLUGS, STORE } = Fields;

export const dynamicParams = true;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TStoreSlug>(getStoreSlugs, STORESLUGS);
  return slugs.map(({ name, uuid }) => ({ name, uuid }));
}

export default async function StorePage({
  params: { name, uuid },
}: {
  params: { name: string; uuid: string };
}) {
  const pageData = await fetchPageDataSingle<TPageData>(
    getStoreBySlug,
    { name: decodeURIComponent(name), uuid },
    STORE
  );

  if (!pageData) {
    return <div>loading...</div>;
  }

  return <Store data={pageData} />;
}
