import { ApolloClient, InMemoryCache } from '@apollo/client';

const SERVER_PORT = process.env.SERVER_PORT;

export function getClient(path: string) {
	return new ApolloClient({
			uri: `http://localhost:${SERVER_PORT}${path}`,
			cache: new InMemoryCache(),
	})
};
