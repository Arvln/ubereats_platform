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

const marketingSlugSchema = z.object({
  uuid: z.string(),
});

export const marketingPageDataSchema = z.object({
  content: z.string(),
});

export const marketingSlugsSchema = z.array(marketingSlugSchema);
