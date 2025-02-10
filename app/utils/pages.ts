import {
	TPath,
	TDynamicRoutesPageResult,
	TQueryResult
} from './types';
import type {
	GetStaticPaths,
	GetStaticProps,
	GetServerSideProps
} from 'next';
import { ApolloQueryResult, DocumentNode } from '@apollo/client';
import { getApolloClient } from 'graphql/apollo_client';

const client = getApolloClient();

export function getPageStaticPaths<T>(
	query: DocumentNode,
	key: string,
	fallback: boolean | 'blocking'
): GetStaticPaths {
	return async () => {
		const {
			data: {
				[key]: slugs
			}
		}: ApolloQueryResult<TDynamicRoutesPageResult<T>> = await client.query({
			query
    });
    
    const paths = ['zh-TW', 'en-US'].flatMap(locale => 
      slugs.map(slug => ({
        params: slug,
        locale
      } as TPath<T>))
    );

		return {
			paths,
			fallback
		};
	};
}

export function getPageProps<T>(
	query: DocumentNode,
	key?: string
): GetServerSideProps & GetStaticProps {
	return async ({
    params: variables,
    locale,
    ...res
	}) => {
		let {
			data: pageData
		}: ApolloQueryResult<TQueryResult<T>> = await client.query({
			query,
			variables
    });

    if ('req' in res) locale = res.req?.cookies?.NEXT_LOCALE ?? 'zh-TW';

		if (key) {
			const {
				[key]: pageDataList
			} = pageData as TDynamicRoutesPageResult<T>;
	
			pageData = pageDataList[0];
		};

    if (pageData) {
			return {
				props: {
          pageData,
          locale,
          messages: (await import(`locales/${locale}.json`)).default,
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
