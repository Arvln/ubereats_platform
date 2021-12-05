import { TPageData, Prop } from 'types/pages';
import type { NextPage } from 'next';
import {
	Shortcut,
	Carousel,
	RestrictSearch,
	Channel
} from 'features';
import { query } from 'graphql/queries/pages';
import { getPageProps } from 'utils';

import classes from 'styles/pages/Home.module.scss';

const {
	wrapper,
	storesWrapper
} = classes;

const Home: NextPage<Prop> = ({ pageData }) => {
	const {
		shortcut,
		carousel,
		channel
	} = pageData;

	return (
		<main className={wrapper}>
			<Shortcut data={shortcut} />
			<hr />
			<Carousel data={carousel} />
			<section className={storesWrapper}>
				<RestrictSearch isCuisines />
				<Channel data={channel} />
			</section>
		</main>
	);
};

export const getServerSideProps = getPageProps<TPageData>(query);

export default Home;
