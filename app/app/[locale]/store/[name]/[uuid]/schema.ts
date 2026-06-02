import { z } from "zod";

const goodSchema = z.object({
  name: z.string(),
  price: z.number(),
  discription: z.string(),
  imageSuffix: z.string(),
  spicyLevel: z.string(),
  isEmphasis: z.boolean(),
  uuid: z.string(),
});

const goodChannelSchema = z.object({
  label: z.string(),
  items: z.array(goodSchema),
});

export const storePageDataSchema = z.object({
  __typename: z.string().default("Store"),
  name: z.string(),
  deliveryCost: z.number(),
  shortestDeliveryTime: z.number(),
  score: z.number(),
  discountLabel: z.string().default(""),
  bannerSuffix: z.string(),
  address: z.string(),
  goodChannels: z.array(goodChannelSchema),
});

export const storeSlugSchema = z.object({
  name: z.string(),
  uuid: z.string(),
});

export const storeSlugsSchema = z.array(storeSlugSchema);

export type StorePageData = z.infer<typeof storePageDataSchema>;
export type StoreSlug = z.infer<typeof storeSlugSchema>;
