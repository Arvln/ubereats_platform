import { redirect } from "next/navigation";
import { ApolloQueryResult, gql } from "@apollo/client";
import { getApolloClient } from "graphql/apollo_client";
import { TDynamicRoutesPageResult, TQueryResult } from "utils/types";
import type { Locale } from "../i18n";
import { ZodTypeAny } from "zod";

const client = getApolloClient();

export async function fetchPageDataByKey<T>(
  query: string,
  variables: Record<string, unknown>,
  key: string,
  schema?: ZodTypeAny
): Promise<T | null> {
  const { data }: ApolloQueryResult<TQueryResult<T>> = await client.query({
    query: gql(query),
    variables,
  });

  if (!data) return null;

  const { [key]: pageDataList } = data as TDynamicRoutesPageResult<T>;
  const pageData = pageDataList?.[0];
  if (!pageData) return null;
  if (!schema) return pageData;

  const parsed = schema.safeParse(pageData);
  return parsed.success ? parsed.data : null;
}

export async function fetchPageDataSingle<T>(
  query: string,
  variables: Record<string, unknown>,
  key: string,
  schema?: ZodTypeAny
): Promise<T | null> {
  const { data }: ApolloQueryResult<TQueryResult<T>> = await client.query({
    query: gql(query),
    variables,
  });

  if (!data) return null;

  const { [key]: pageDataList } = data as TDynamicRoutesPageResult<T>;
  const pageData = pageDataList?.[0];
  if (!pageData) return null;
  if (!schema) return pageData;

  const parsed = schema.safeParse(pageData);
  return parsed.success ? parsed.data : null;
}

export async function fetchStaticSlugs<T>(
  query: string,
  key: string,
  schema?: ZodTypeAny
): Promise<T[]> {
  const { data }: ApolloQueryResult<TDynamicRoutesPageResult<T>> =
    await client.query({
      query: gql(query),
    });

  if (!data) return [];

  const slugs = data[key] ?? [];
  if (!schema) return slugs;

  const parsed = schema.safeParse(slugs);
  return parsed.success ? parsed.data : [];
}

export function redirectToHome(): never {
  redirect("/");
}

export async function loadMessages(locale: Locale) {
  return (await import(`locales/${locale}.json`)).default;
}
