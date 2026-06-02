import { z } from "zod";

export const categoryTitlesQueryDocument = `
  query {
    shortcut {
      title
    }
  }
`;

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

export const categoryTitlesQueryKey = ["category", "titles"] as const;
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

export const categorySlugSchema = z.object({
  title: z.string(),
});

export const categorySlugsSchema = z.array(categorySlugSchema);

export type CategoryPageData = z.infer<typeof categoryPageDataSchema>;
export type CategorySlug = z.infer<typeof categorySlugSchema>;
