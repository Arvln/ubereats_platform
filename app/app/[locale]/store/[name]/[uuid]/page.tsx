import { TPageData, TStoreSlug } from "types/pages/store";
import { Fields } from "enums/pages/store";
import { getStoreSlugs, getStoreBySlug } from "graphql/queries/pages/store";
import { Store } from "features";
import { fetchStaticSlugs, fetchPageDataSingle } from "lib/page-data";
import { getLocale, setRequestLocale } from "next-intl/server";
import { storePageDataSchema, storeSlugsSchema } from "./schema";

const { STORESLUGS, STORE } = Fields;

export const dynamicParams = true;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TStoreSlug>(
    getStoreSlugs,
    STORESLUGS,
    storeSlugsSchema
  );
  return slugs.map(({ name, uuid }) => ({ name, uuid }));
}

export default async function StorePage(
  props: {
    params: Promise<{ name: string; uuid: string }>;
  }
) {
  const params = await props.params;

  const {
    name,
    uuid
  } = params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const pageData = await fetchPageDataSingle<TPageData>(
    getStoreBySlug,
    { name: decodeURIComponent(name), uuid },
    STORE,
    storePageDataSchema
  );

  if (!pageData) {
    return <div>loading...</div>;
  }

  return <Store data={pageData} />;
}
