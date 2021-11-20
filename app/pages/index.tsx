import { Prop } from 'types/pages';
import type { NextPage } from 'next';
import {
	Shortcut,
	Carousel,
	RestrictSearch,
	Channel
} from 'features';
import { query } from 'graphql/queries/pages';

import classes from 'styles/pages/Home.module.scss';
import { getPageStaticProps } from 'utils';

const {
	wrapper,
	storesWrapper
} = classes;

const Home: NextPage<Prop> = ({
	shortcut,
	carousel,
	channel
}) => {
	return (
		<main className={ wrapper }>
			<Shortcut data={ shortcut } />
			<hr />
			<Carousel data={ carousel } />
			<section className={ storesWrapper }>
				<RestrictSearch isCuisines />
				<Channel data={ channel } />
			</section>
		</main>
	)
}

export const getStaticProps = getPageStaticProps<Prop>(query);

export default Home;
