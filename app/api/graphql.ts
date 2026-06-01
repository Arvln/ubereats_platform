import { GraphQLClient, type RequestDocument, type Variables } from 'graphql-request';

function getServerGraphqlEndpoint(): string {
  const port = process.env.SERVER_PORT;
  return `http://server:${port}`;
}

/**
 * Server-side GraphQL client (Docker internal network).
 * Returns a new client per call — no module-level singleton or cross-request cache.
 */
export function gqlServerClient(): GraphQLClient {
  return new GraphQLClient(getServerGraphqlEndpoint());
}

/**
 * Browser GraphQL client via the Next.js `/api/graphql` proxy.
 * Do not use in Server Components or Route Handlers.
 */
export function gqlClient(): GraphQLClient {
  return new GraphQLClient('/api/graphql');
}

export async function gqlServerRequest<
  T,
  V extends Variables = Variables,
>(document: RequestDocument, variables?: V): Promise<T> {
  return gqlServerClient().request<T>(document, variables);
}

export async function gqlClientRequest<
  T,
  V extends Variables = Variables,
>(document: RequestDocument, variables?: V): Promise<T> {
  return gqlClient().request<T>(document, variables);
}
