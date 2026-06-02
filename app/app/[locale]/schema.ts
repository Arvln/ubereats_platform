import { z } from "zod";

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
