import { TUUID, TPageData, Prop } from 'types/pages/marketing/advertise';
import type { NextPage } from 'next';
import { Fields } from 'enums/pages/marketing/advertise';
import { FallbackTypes } from 'enums/pages/common';
import { getUUID, getAdvertiseByUUID } from 'graphql/queries/pages/marketing/advertise';
import {
	getPageStaticPaths,
	getPageStaticProps
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
		<div className={ wrapper }>
			<div className={ massage }>{ content }</div>
		</div>
	)
}

export const getStaticPaths = getPageStaticPaths<TUUID>(
	getUUID,
	CAROUSEL,
	SHOW_ERROR_PAGE
);
export const getStaticProps = getPageStaticProps<TPageData>(
	getAdvertiseByUUID,
	ADVERTISE
);

export default Advertise;
