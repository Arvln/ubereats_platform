import { z } from "zod";

export const marketingUuidsQueryDocument = `
  query {
    carousel {
      uuid
    }
  }
`;

export const marketingByUuidQueryDocument = `
  query($uuid: String!) {
    advertise(uuid: $uuid) {
      content
    }
  }
`;

export const marketingUuidsQueryKey = ["marketing", "uuids"] as const;
export const marketingByUuidQueryKey = (uuid: string) =>
  ["marketing", "by-uuid", uuid] as const;

export const marketingPageDataSchema = z.object({
  content: z.string(),
});

export const marketingSlugSchema = z.object({
  uuid: z.string(),
});

export const marketingSlugsSchema = z.array(marketingSlugSchema);

export type MarketingPageData = z.infer<typeof marketingPageDataSchema>;
export type MarketingSlug = z.infer<typeof marketingSlugSchema>;
