import { TStoreSlug, TPageData, Prop } from 'types/pages/store';
import type { NextPage } from 'next';
import { Fields } from 'enums/pages/store';
import { FallbackTypes } from 'enums/pages/common';
import { getStoreSlugs, getStoreBySlug } from 'graphql/queries/pages/store';
import {
	getPageStaticPaths,
	getPageStaticProps
} from "utils";

import classes from 'styles/pages/store/Store.module.scss';

const {
	wrapper
} = classes;
const {
	STORESLUGS,
	STORE
} = Fields;
const { SHOW_FALLBACK_PAGE } = FallbackTypes;

const Store: NextPage<Prop> = ({ pageData }) => {
	if (!pageData) return <div>loading...</div>;
	console.log(pageData);

	return (
		<div className={ wrapper }>
			
		</div>
	)
}

export const getStaticPaths = getPageStaticPaths<TStoreSlug>(
	getStoreSlugs,
	STORESLUGS,
	SHOW_FALLBACK_PAGE
);
export const getStaticProps = getPageStaticProps<TPageData>(
	getStoreBySlug,
	STORE
);

export default Store;
