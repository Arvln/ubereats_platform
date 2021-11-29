import { TUUID, TPageData, Prop } from 'types/pages/marketing/advertise';
import type { NextPage } from 'next';
import { Fields } from 'enums/pages/marketing/advertise';
import { FallbackTypes } from 'enums/pages/common';
import { getUUID, getAdvertiseByUUID } from 'graphql/queries/pages/marketing/advertise';
import {
	getPageStaticPaths,
	getPageProps
} from "utils";

import classes from 'styles/pages/marketing/Advertise.module.scss';

const {
	wrapper,
	massage
} = classes;
const {
	CAROUSEL,
	ADVERTISE
} = Fields;
const { SHOW_ERROR_PAGE } = FallbackTypes;

const Advertise: NextPage<Prop> = ({ pageData }) => {
	const { content } = pageData;

	return (
		<main className={wrapper}>
			<div className={massage}>{content}</div>
		</main>
	);
};

export const getStaticPaths = getPageStaticPaths<TUUID>(
	getUUID,
	CAROUSEL,
	SHOW_ERROR_PAGE
);
export const getStaticProps = getPageProps<TPageData>(
	getAdvertiseByUUID,
	ADVERTISE
);

export default Advertise;
