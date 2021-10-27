import type { NextPage, GetStaticProps } from 'next';
import { TShortcut } from 'graphql/types';
import { client } from 'graphql/apollo_client';
import Shortcut from 'features/shortcut';
import { getShortcutQuery } from 'graphql/queries';

import {
	wrapper,
} from 'styles/pages/Home.module.scss';

export const getStaticProps: GetStaticProps = async () => {
	const {
		data: {
			shortcut
		}
	} = await client.query({
		query: getShortcutQuery,
	});

	return {
		props: {
			shortcut
		}
	}
}

type Prop = {
	shortcut: TShortcut[];
}

const Home: NextPage<Prop> = ({ shortcut }) => {	
	return (
		<div className={ wrapper }>
			<Shortcut shortcut={ shortcut } />
		</div>
	)
}

export default Home;
