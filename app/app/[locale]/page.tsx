import { Shortcut, Carousel, RestrictSearch, Channel } from "features";
import { gqlServerClient } from "api/graphql";
import { createServerQueryClient } from "lib/server-query-client";
import { redirectToHome } from "lib/page-data";
import { getLocale, setRequestLocale } from "next-intl/server";
import { dehydrate, HydrationBoundary } from "@tanstack/react-query";
import {
  homePageDataSchema,
  homeQueryDocument,
  homeQueryKey,
  type HomePageData,
} from "./queries";

import classes from "styles/pages/Home.module.scss";

const { wrapper, storesWrapper } = classes;

async function fetchHomePageDataServer(): Promise<HomePageData | null> {
  const raw = await gqlServerClient().request<unknown>(homeQueryDocument);
  const parsed = homePageDataSchema.safeParse(raw);
  return parsed.success ? parsed.data : null;
}

export default async function HomePage() {
  const locale = await getLocale();
  setRequestLocale(locale);

  const queryClient = createServerQueryClient();

  await queryClient.prefetchQuery({
    queryKey: homeQueryKey,
    queryFn: fetchHomePageDataServer,
  });

  const pageData = queryClient.getQueryData<HomePageData | null>(homeQueryKey);

  if (!pageData) {
    return redirectToHome();
  }

  const { shortcut, carousel, channel } = pageData;
  const dehydratedState = dehydrate(queryClient);

  return (
    <HydrationBoundary state={dehydratedState}>
      <main className={wrapper}>
        <Shortcut data={shortcut} />
        <hr />
        <Carousel data={carousel} />
        <section className={storesWrapper}>
          <RestrictSearch isCuisines />
          <Channel data={channel} />
        </section>
      </main>
    </HydrationBoundary>
  );
}
