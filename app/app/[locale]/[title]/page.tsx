import { TPageData, TTitles } from 'types/pages/categories';
import { Fields } from 'enums/pages/categories';
import { getTitles, getCategoryByTitle } from 'graphql/queries/pages/categories';
import { Category } from 'features';
import {
  fetchStaticSlugs,
  fetchPageDataByKey,
  redirectToHome,
} from 'lib/page-data';

const { SHORTCUT, CATEGORY } = Fields;

export const dynamicParams = false;

export async function generateStaticParams() {
  const slugs = await fetchStaticSlugs<TTitles>(getTitles, SHORTCUT);
  return slugs.map(({ title }) => ({ title }));
}

export default async function CategoryPage(
  props: {
    params: Promise<{ title: string }>;
  }
) {
  const params = await props.params;

  const {
    title
  } = params;

  const pageData = await fetchPageDataByKey<TPageData>(
    getCategoryByTitle,
    { title },
    CATEGORY
  );

  if (!pageData) {
    return redirectToHome();
  }

  return <Category data={pageData} />;
}
