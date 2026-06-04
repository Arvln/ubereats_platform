import { z } from "zod";

export const marketingByUuidQueryDocument = `
  query($uuid: String!) {
    advertise(uuid: $uuid) {
      content
    }
  }
`;

export const marketingPageDataSchema = z.object({
  content: z.string(),
});
