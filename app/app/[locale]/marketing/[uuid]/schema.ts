import { z } from "zod";

export const marketingPageDataSchema = z.object({
  content: z.string(),
});

export const marketingSlugSchema = z.object({
  uuid: z.string(),
});

export const marketingSlugsSchema = z.array(marketingSlugSchema);

export type MarketingPageData = z.infer<typeof marketingPageDataSchema>;
export type MarketingSlug = z.infer<typeof marketingSlugSchema>;
