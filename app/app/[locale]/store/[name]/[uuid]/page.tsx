import { Store } from "features";
import { gqlServerClient } from "api/graphql";
import { getLocale, setRequestLocale } from "next-intl/server";
import { dehydrate, HydrationBoundary } from "@tanstack/react-query";
import { createServerQueryClient } from "lib/server-query-client";
import { z } from "zod";
import {
  fetchStoreBySlugServer,
  storeBySlugQueryKey,
} from "./queries";

const storeSlugsQueryDocument = `
  query {
    storeSlugs {
      name
      uuid
    }
  }
`;

const storeSlugSchema = z.object({
  name: z.string(),
  uuid: z.string(),
});

const storeSlugsSchema = z.array(storeSlugSchema);

const storeSlugsResponseSchema = z.object({
  storeSlugs: z.array(storeSlugSchema),
});

export async function generateStaticParams() {
  const raw = await gqlServerClient().request<unknown>(storeSlugsQueryDocument);
  const parsed = storeSlugsResponseSchema.safeParse(raw);
  if (!parsed.success) return [];

  const slugs = storeSlugsSchema.safeParse(parsed.data.storeSlugs);
  return (slugs.success ? slugs.data : []).map(({ name, uuid }) => ({
    name,
    uuid,
  }));
}

export default async function StorePage(props: {
  params: Promise<{ name: string; uuid: string }>;
}) {
  const { name, uuid } = await props.params;

  const locale = await getLocale();
  setRequestLocale(locale);

  const decodedName = decodeURIComponent(name);
  const queryClient = createServerQueryClient();

  await queryClient.prefetchQuery({
    queryKey: storeBySlugQueryKey(decodedName, uuid),
    queryFn: () => fetchStoreBySlugServer(decodedName, uuid),
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <Store />
    </HydrationBoundary>
  );
}
