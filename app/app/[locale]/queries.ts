import { gqlClient, gqlServerClient } from "api/graphql";
import { redirectToHome } from "lib/page-data";
import { z } from "zod";

export const homeQueryDocument = `
  query {
    shortcut {
      title
      imageSuffix
      isCuisines
      uuid
    }
    carousel {
      imageSuffix
      uuid
    }
    channel {
      id
      title
      subtitle
      imageSuffix
      uuid
      channelItems {
        ... on ChannelShop {
          __typename
          name
          deliveryCost
          shortestDeliveryTime
          score
          discountLabel
          imageSuffix
          uuid
          channelId
        }
        ... on ChannelCategory {
          __typename
          title
          name
          uuid
        }
      }
    }
  }
`;

export const homeQueryKey = ["home-page"] as const;

const shortcutSchema = z.object({
  title: z.string(),
  imageSuffix: z.string(),
  isCuisines: z.number(),
  uuid: z.string(),
});

const carouselSchema = z.object({
  imageSuffix: z.string(),
  uuid: z.string(),
});

const channelShopItemSchema = z.object({
  __typename: z.literal("ChannelShop"),
  name: z.string(),
  deliveryCost: z.number(),
  shortestDeliveryTime: z.number(),
  score: z.number(),
  discountLabel: z.string(),
  imageSuffix: z.string(),
  uuid: z.string(),
  channelId: z.string(),
});

const channelCategoryItemSchema = z.object({
  __typename: z.literal("ChannelCategory"),
  title: z.string(),
  name: z.string(),
  uuid: z.string(),
});

const channelItemSchema = z.union([
  channelShopItemSchema,
  channelCategoryItemSchema,
]);

const channelSchema = z.object({
  id: z.string(),
  title: z.string(),
  subtitle: z.string(),
  imageSuffix: z.string(),
  uuid: z.string(),
  channelItems: z.array(channelItemSchema),
});

export const homePageDataSchema = z.object({
  shortcut: z.array(shortcutSchema),
  carousel: z.array(carouselSchema),
  channel: z.array(channelSchema),
});

export type HomePageData = z.infer<typeof homePageDataSchema>;

export async function fetchHomePageDataServer(): Promise<HomePageData> {
  const raw = await gqlServerClient().request<unknown>(homeQueryDocument);
  const parsed = homePageDataSchema.safeParse(raw);
  if (!parsed.success) {
    redirectToHome();
  }
  return parsed.data;
}

export async function fetchHomePageDataClient(): Promise<HomePageData> {
  const raw = await gqlClient().request<unknown>(homeQueryDocument);
  const parsed = homePageDataSchema.safeParse(raw);
  if (!parsed.success) {
    throw new Error("Invalid home page data");
  }
  return parsed.data;
}

export const homePageQueryOptions = {
  queryKey: homeQueryKey,
  queryFn: fetchHomePageDataClient,
} as const;
