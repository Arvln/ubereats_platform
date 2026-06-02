import { z } from "zod";

export const storeSlugsQueryDocument = `
  query {
    storeSlugs {
      name
      uuid
    }
  }
`;

export const storeBySlugQueryDocument = `
  query($name: String!, $uuid: String!) {
    store(name: $name, uuid: $uuid) {
      name
      deliveryCost
      shortestDeliveryTime
      score
      bannerSuffix
      address
      goodChannels {
        label
        items {
          name
          price
          discription
          spicyLevel
          imageSuffix
          isEmphasis
          uuid
        }
      }
    }
  }
`;

export const storeSlugsQueryKey = ["store", "slugs"] as const;
export const storeBySlugQueryKey = (name: string, uuid: string) =>
  ["store", "by-slug", name, uuid] as const;

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
