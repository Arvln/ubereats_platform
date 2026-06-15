import Category from "./components/category";
import { gqlServerClient } from "@/api/graphql-client";
import { createServerQueryClient } from "lib/server-query-client";
import { getLocale, setRequestLocale } from "next-intl/server";
import { dehydrate, HydrationBoundary } from "@tanstack/react-query";
import { z } from "zod";
import { categoryByTitleQueryKey, fetchCategoryByTitleServer } from "./queries";

const categoryTitlesQueryDocument = `
  query {
    shortcut {
      title
    }
  }
`;

const categorySlugSchema = z.object({
  title: z.string(),
});

const categorySlugsSchema = z.array(categorySlugSchema);

const categoryTitlesResponseSchema = z.object({
  shortcut: z.array(categorySlugSchema),
});

export async function generateStaticParams() {
  const raw = await gqlServerClient().request<unknown>(
    categoryTitlesQueryDocument,
  );
  const parsed = categoryTitlesResponseSchema.safeParse(raw);
  if (!parsed.success) return [];

  const slugs = categorySlugsSchema.safeParse(parsed.data.shortcut);
  return (slugs.success ? slugs.data : []).map(({ title }) => ({ title }));
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
