import { TStoreSlug, TPageData, Prop } from 'types/pages/store';
import type { NextPage } from 'next';
import { Fields } from 'enums/pages/store';
import { FallbackTypes } from 'enums/pages/common';
import { getStoreSlugs, getStoreBySlug } from 'graphql/queries/pages/store';
import {
	getPageStaticPaths,
	getPageProps
} from "utils";
import { Store } from 'features';

const {
	STORESLUGS,
	STORE
} = Fields;
const { SHOW_FALLBACK_PAGE } = FallbackTypes;

const Stores: NextPage<Prop> = ({ pageData }) => {
	if (!pageData) return <div>loading...</div>;

	return <Store data={pageData} />;
};

export const getStaticPaths = getPageStaticPaths<TStoreSlug>(
	getStoreSlugs,
	STORESLUGS,
	SHOW_FALLBACK_PAGE
);
export const getStaticProps = getPageProps<TPageData>(
	getStoreBySlug,
	STORE
);

export default Stores;
