import { TPageData, TTitles } from "types/pages/categories";
import { Fields } from "enums/pages/categories";
import {
  categoryByTitleQueryDocument,
  categoryPageDataSchema,
  categorySlugsSchema,
  categoryTitlesQueryDocument,
} from "./queries";
import { Category } from "features";
import { getLocale, setRequestLocale } from "next-intl/server";
import {
  fetchStaticSlugs,
  fetchPageDataByKey,
  redirectToHome,
} from "lib/page-data";

const { SHORTCUT, CATEGORY } = Fields;

export const dynamicParams = false;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TTitles>(
    categoryTitlesQueryDocument,
    SHORTCUT,
    categorySlugsSchema
  );
  return slugs.map(({ title }) => ({ title }));
}

export default async function CategoryPage(props: {
  params: Promise<{ title: string }>;
}) {
  const params = await props.params;

  const { title } = params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const pageData = await fetchPageDataByKey<TPageData>(
    categoryByTitleQueryDocument,
    { title },
    CATEGORY,
    categoryPageDataSchema
  );

  if (!pageData) {
    return redirectToHome();
  }

  return <Category data={pageData} />;
}
