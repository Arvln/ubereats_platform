import type { NextPage, GetStaticProps } from 'next';
import { Prop } from '../../types/pages';
import { ApolloQueryResult } from '@apollo/client';
import { getClient } from 'graphql/apollo_client';
import {
	HOME_URL
} from 'graphql/route';
import {
	Shortcut,
	Carousel,
	RestrictSearch,
	Channel
} from 'features';
import { query } from 'graphql/queries/pages';

import {
	wrapper,
	storesWrapper
} from 'styles/pages/Home.module.scss';

export const getStaticProps: GetStaticProps<Prop> = async () => {
	const client = getClient(HOME_URL);
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
	carousel,
	channel
}) => {
	console.log(channel);
	
	return (
		<main className={ wrapper }>
			<Shortcut shortcut={ shortcut } />
			<hr />
			<Carousel carousel={ carousel } />
			<section className={ storesWrapper }>
				<RestrictSearch />
				<Channel />
			</section>
		</main>
	)
}

export default Home;
