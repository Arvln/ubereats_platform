import Shortcut from "./components/shortcut";
import Carousel from "./components/carousel";
import RestrictSearch from "./components/restrict_search";
import Channel from "./components/channel";
import { createServerQueryClient } from "lib/server-query-client";
import { getLocale, setRequestLocale } from "next-intl/server";
import { dehydrate, HydrationBoundary } from "@tanstack/react-query";
import { fetchHomePageDataServer, homeQueryKey } from "./queries";

import classes from "styles/pages/Home.module.scss";

const { wrapper, storesWrapper } = classes;

export default async function HomePage() {
  const locale = await getLocale();
  setRequestLocale(locale);

  const queryClient = createServerQueryClient();

  await queryClient.prefetchQuery({
    queryKey: homeQueryKey,
    queryFn: fetchHomePageDataServer,
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <main className={wrapper}>
        <Shortcut />
        <hr />
        <Carousel />
        <section className={storesWrapper}>
          <RestrictSearch isCuisines />
          <Channel />
        </section>
      </main>
    </HydrationBoundary>
  );
}
