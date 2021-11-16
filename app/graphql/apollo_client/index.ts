import { ApolloClient, InMemoryCache } from '@apollo/client';

const SERVER_HOST = process.env.SERVER_HOST || 'localhost';
const SERVER_PORT = process.env.SERVER_PORT;

export function getApolloClient() {
	return new ApolloClient({
		uri: `http://${SERVER_HOST}:${SERVER_PORT}`,
		cache: new InMemoryCache({}),
	});
}
