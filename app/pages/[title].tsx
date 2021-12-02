import {
	TTitles,
	TPageData,
	Prop
} from 'types/pages/categories';
import type { NextPage } from 'next';
import { Fields } from 'enums/pages/categories';
import { FallbackTypes } from 'enums/pages/common';
import {
	getTitles,
	getCategoryByTitle
} from 'graphql/queries/pages/categories';
import { Category } from 'features';
import {
	getPageStaticPaths,
	getPageProps
} from 'utils';

const {
	SHORTCUT,
	CATEGORY
} = Fields;
const { SHOW_ERROR_PAGE } = FallbackTypes;

const Categories: NextPage<Prop> = ({ pageData }) => {
	return <Category data={pageData} />;
};

export const getStaticPaths = getPageStaticPaths<TTitles>(
	getTitles,
	SHORTCUT,
	SHOW_ERROR_PAGE
);
export const getStaticProps = getPageProps<TPageData>(
	getCategoryByTitle,
	CATEGORY
);

export default Categories;
