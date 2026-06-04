import { Category } from "features";
import { createServerQueryClient } from "lib/server-query-client";
import { getLocale, setRequestLocale } from "next-intl/server";
import { dehydrate, HydrationBoundary } from "@tanstack/react-query";
import {
  categoryByTitleQueryKey,
  fetchCategoryByTitleServer,
  fetchCategoryTitlesServer,
} from "./queries";

export async function generateStaticParams() {
  const slugs = await fetchCategoryTitlesServer();
  return slugs.map(({ title }) => ({ title }));
}

export default async function CategoryPage(props: {
  params: Promise<{ title: string }>;
}) {
  const { title } = await props.params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const queryClient = createServerQueryClient();

  await queryClient.prefetchQuery({
    queryKey: categoryByTitleQueryKey(title),
    queryFn: () => fetchCategoryByTitleServer(title),
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <Category />
    </HydrationBoundary>
  );
}
