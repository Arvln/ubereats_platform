import { z } from "zod";

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
