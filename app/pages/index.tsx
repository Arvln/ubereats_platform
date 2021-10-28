import type { NextPage, GetStaticProps } from 'next';
import { ApolloQueryResult } from '@apollo/client';
import { Prop } from 'graphql/types/pages';
import { client } from 'graphql/apollo_client';
import Shortcut from 'features/shortcut';
import { query } from 'graphql/queries/pages';

import {
	wrapper,
} from 'styles/pages/Home.module.scss';

export const getStaticProps: GetStaticProps<Prop> = async () => {
	const {
		data: props
	}: ApolloQueryResult<Prop> = await client.query({
		query
	});

	return {
		props
	}
}

const Home: NextPage<Prop> = ({
	shortcut,
	carousel
}) => {
	console.log(carousel);

	return (
		<main className={wrapper}>
			<Shortcut shortcut={ shortcut } />
		</main>
	)
}

export default Home;
