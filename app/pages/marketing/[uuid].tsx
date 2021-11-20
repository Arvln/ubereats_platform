import { TUUID, TAdvertise, Prop } from 'types/pages/marketing';
import { NextPage } from 'next';
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
enum Fields {
	CAROUSEL = 'carousel',
	ADVERTISE = 'advertise'
};
const {
	CAROUSEL,
	ADVERTISE
} = Fields;

const Advertise: NextPage<Prop> = ({ pageData }) => {
	const { content } = pageData;

	return (
		<div className={ wrapper }>
			<div className={ massage }>{ content }</div>
		</div>
	)
}

export const getStaticPaths = getPageStaticPaths<TUUID>(getUUID, CAROUSEL);
export const getStaticProps = getPageStaticProps<TAdvertise>(
	getAdvertiseByUUID,
	ADVERTISE
);

export default Advertise;
