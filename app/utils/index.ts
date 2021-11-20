import {
	TPath,
	TQueryResult
} from './types';
import type {
	GetStaticPaths,
	GetStaticProps
} from 'next';
import { ApolloQueryResult, DocumentNode } from '@apollo/client';
import { getApolloClient } from 'graphql/apollo_client';

const client = getApolloClient();

export function getPageStaticPaths<T>(
	query: DocumentNode,
	key: string
): GetStaticPaths {
	return async () => {
		const {
			data: {
				[key]: slugs
			}
		}: ApolloQueryResult<TQueryResult<T>> = await client.query({
			query
		});
		const paths = slugs.map(slug => ({
			params: slug
		} as TPath<T>));
	
		return {
			paths,
			fallback: true
		};
	};
}

export function getPageStaticProps<T>(
	query: DocumentNode,
	key?: string
): GetStaticProps {
	if (!key) {
		return async () => {
			const {
				data: props
			}: ApolloQueryResult<T> = await client.query({
				query
			});

			return {
				props
			}
		}
	}

	return async ({
		params: variables
	}) => {
		const {
			data: {
				[key]: pageDataList
			}
		}: ApolloQueryResult<TQueryResult<T>> = await client.query({
			query,
			variables,
		});
		const pageData = pageDataList[0];
	
		if (!pageData) {
			return {
				redirect: {
					destination: '/',
					permanent: false,
				},
			}
		}
		
		return {
			props: {
				pageData
			}
		}
	}
}
