import {
	TPath,
	TDynamicRoutesPageResult,
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
	key: string,
	fallback: boolean
): GetStaticPaths {
	return async () => {
		const {
			data: {
				[key]: slugs
			}
		}: ApolloQueryResult<TDynamicRoutesPageResult<T>> = await client.query({
			query
		});
		const paths = slugs.map(slug => ({
			params: slug
		} as TPath<T>));
	
		return {
			paths,
			fallback
		};
	};
}

export function getPageStaticProps<T>(
	query: DocumentNode,
	key?: string
): GetStaticProps {
	return async ({
		params: variables
	}) => {
		let {
			data: pageData
		}: ApolloQueryResult<TQueryResult<T>> = await client.query({
			query,
			variables
		});

		if (key) {
			const {
				[key]: pageDataList
			} = pageData as TDynamicRoutesPageResult<T>;
	
			pageData = pageDataList[0];
		};

		if (pageData) {
			return {
				props: {
					pageData
				}
			}
		};

		return {
			redirect: {
				destination: '/',
				permanent: false,
			}
		};
	}
}
