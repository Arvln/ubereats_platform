import { ApolloClient, InMemoryCache } from "@apollo/client";

const SERVER_PORT = process.env.SERVER_PORT;

export function getApolloClient() {
  return new ApolloClient({
    uri: `http://server:${SERVER_PORT}`,
    cache: new InMemoryCache({}),
  });
}
