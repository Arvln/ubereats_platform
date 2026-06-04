import { gqlClient, gqlServerClient } from "api/graphql";
import { z } from "zod";

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

const storeBySlugResponseSchema = z.object({
  store: z.array(storePageDataSchema),
});

export type StorePageData = z.infer<typeof storePageDataSchema>;

export async function fetchStoreBySlugServer(
  name: string,
  uuid: string,
): Promise<StorePageData | null> {
  const raw = await gqlServerClient().request<unknown>(storeBySlugQueryDocument, {
    name,
    uuid,
  });
  const parsed = storeBySlugResponseSchema.safeParse(raw);
  return parsed.success ? (parsed.data.store[0] ?? null) : null;
}

export async function fetchStoreBySlugClient(
  name: string,
  uuid: string,
): Promise<StorePageData> {
  const raw = await gqlClient().request<unknown>(storeBySlugQueryDocument, {
    name,
    uuid,
  });
  const parsed = storeBySlugResponseSchema.safeParse(raw);
  const pageData = parsed.success ? parsed.data.store[0] : undefined;
  if (!pageData) {
    throw new Error("Invalid store page data");
  }
  return pageData;
}

export function storeBySlugQueryOptions(name: string, uuid: string) {
  return {
    queryKey: storeBySlugQueryKey(name, uuid),
    queryFn: () => fetchStoreBySlugClient(name, uuid),
  } as const;
}
