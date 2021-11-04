import { Prop } from '../../types/pages';
import type { NextPage, GetStaticProps } from 'next';
import { ApolloQueryResult } from '@apollo/client';
import { getApolloClient } from 'graphql/apollo_client';
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
	const client = getApolloClient();
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
				<Channel channel={ channel } />
			</section>
		</main>
	)
}

export default Home;
