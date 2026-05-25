import { redirect } from "next/navigation";
import { ApolloQueryResult, DocumentNode } from "@apollo/client";
import { getApolloClient } from "graphql/apollo_client";
import { TDynamicRoutesPageResult, TQueryResult } from "utils/types";
import type { Locale } from "../i18n";

const client = getApolloClient();

export async function fetchPageData<T>(
  query: DocumentNode,
  variables?: Record<string, unknown>
): Promise<T | null> {
  const { data }: ApolloQueryResult<TQueryResult<T>> = await client.query({
    query,
    variables,
  });

  if (!data) return null;

  return data as T;
}

export async function fetchPageDataByKey<T>(
  query: DocumentNode,
  variables: Record<string, unknown>,
  key: string
): Promise<T | null> {
  const { data }: ApolloQueryResult<TQueryResult<T>> = await client.query({
    query,
    variables,
  });

  if (!data) return null;

  const { [key]: pageDataList } = data as TDynamicRoutesPageResult<T>;

  return pageDataList?.[0] ?? null;
}

export async function fetchPageDataSingle<T>(
  query: DocumentNode,
  variables: Record<string, unknown>,
  key: string
): Promise<T | null> {
  const { data }: ApolloQueryResult<TQueryResult<T>> = await client.query({
    query,
    variables,
  });

  if (!data) return null;

  const { [key]: pageDataList } = data as TDynamicRoutesPageResult<T>;

  return pageDataList?.[0] ?? null;
}

export async function fetchStaticSlugs<T>(
  query: DocumentNode,
  key: string
): Promise<T[]> {
  const { data }: ApolloQueryResult<TDynamicRoutesPageResult<T>> =
    await client.query({
      query,
    });

  if (!data) return [];

  return data[key] ?? [];
}

export function redirectToHome(): never {
  redirect("/");
}

export async function loadMessages(locale: Locale) {
  return (await import(`locales/${locale}.json`)).default;
}
