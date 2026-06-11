import { gqlClient, gqlServerClient } from "@/api/graphql-client";
import { redirect } from "next/navigation";
import { z } from "zod";

export const categoryByTitleQueryDocument = `
  query($title: String!) {
    category(title: $title) {
      title
      imageSuffix
      isCuisines
      categoryShopItems {
        __typename
        name
        deliveryCost
        shortestDeliveryTime
        score
        discountLabel
        imageSuffix
        uuid
      }
    }
  }
`;

export const categoryByTitleQueryKey = (title: string) =>
  ["category", "by-title", title] as const;

const categoryShopItemSchema = z.object({
  __typename: z.string(),
  name: z.string(),
  deliveryCost: z.number(),
  shortestDeliveryTime: z.number(),
  score: z.number(),
  discountLabel: z.string(),
  imageSuffix: z.string(),
  uuid: z.string(),
});

export const categoryPageDataSchema = z.object({
  title: z.string(),
  imageSuffix: z.string(),
  isCuisines: z.union([z.boolean(), z.number()]).transform(Boolean),
  categoryShopItems: z.array(categoryShopItemSchema),
});

const categoryByTitleResponseSchema = z.object({
  category: z.array(categoryPageDataSchema),
});

export type CategoryPageData = z.infer<typeof categoryPageDataSchema>;

export async function fetchCategoryByTitleServer(
  title: string,
): Promise<CategoryPageData> {
  const raw = await gqlServerClient().request<unknown>(
    categoryByTitleQueryDocument,
    { title },
  );
  const parsed = categoryByTitleResponseSchema.safeParse(raw);
  const pageData = parsed.success ? parsed.data.category[0] : undefined;
  if (!pageData) {
    redirect("/");
  }
  return pageData;
}

export async function fetchCategoryByTitleClient(
  title: string,
): Promise<CategoryPageData> {
  const raw = await gqlClient().request<unknown>(categoryByTitleQueryDocument, {
    title,
  });
  const parsed = categoryByTitleResponseSchema.safeParse(raw);
  const pageData = parsed.success ? parsed.data.category[0] : undefined;
  if (!pageData) {
    throw new Error("Invalid category page data");
  }
  return pageData;
}

export function categoryByTitleQueryOptions(title: string) {
  return {
    queryKey: categoryByTitleQueryKey(title),
    queryFn: () => fetchCategoryByTitleClient(title),
  } as const;
}
