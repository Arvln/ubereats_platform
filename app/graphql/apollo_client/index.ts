import { ApolloClient, InMemoryCache } from '@apollo/client';

const SERVER_PORT = process.env.SERVER_PORT;

export const client = new ApolloClient({
    uri: `http://localhost:${SERVER_PORT}`,
    cache: new InMemoryCache(),
});
