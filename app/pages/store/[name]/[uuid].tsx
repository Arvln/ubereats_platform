import { TStoreSlug, TPageData, Prop } from 'types/pages/store';
import { TAppendClass } from 'components/button/types';
import type { NextPage } from 'next';
import Button from 'components/button';
import Image from 'next/image';
import { Fields } from 'enums/pages/store';
import { FallbackTypes } from 'enums/pages/common';
import { getStoreSlugs, getStoreBySlug } from 'graphql/queries/pages/store';
import {
	getPageStaticPaths,
	getPageProps
} from "utils";
import { getScore } from 'components/shop/utils';

import classes from 'styles/pages/store/Store.module.scss';

const {
	wrapper,
	banner,
	moreOptions,
	buttonWrapper,
	info,
	title,
	detail,
	imageWrapper,
	detailInfo,
	moreDetail,
	time,
	cost,
	orders,
	space_8,
	optionWrapper,
	optionText
} = classes;
const {
	STORESLUGS,
	STORE
} = Fields;
const { SHOW_FALLBACK_PAGE } = FallbackTypes;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;
const STAR_ICON_SERVER_HOST = process.env.STAR_ICON_SERVER_HOST;
const UTILS_ICONS_SERVER_HOST = process.env.UTILS_ICONS_SERVER_HOST;
const iconButton: TAppendClass = {
	appendWrapper: buttonWrapper,
	appendContent: ''
}
const button: TAppendClass = {
	appendWrapper: optionWrapper,
	appendContent: optionText
}

const Store: NextPage<Prop> = ({ pageData }) => {
	if (!pageData) return <div>loading...</div>;

	const {
		name,
		deliveryCost,
		shortestDeliveryTime,
		score,
		bannerSuffix,
		address
	} = pageData;
	console.log(pageData);

	function _renderBanner() {
		return (
			<div className={ banner }>
				<Image
					src={`https://${STORE_IMAGE_SERVER_HOST}/${bannerSuffix}`}
					layout="fill"
					objectFit="cover"
					alt="Banner"
				/>
				<div className={ moreOptions }>
					<Button
						appendClass={ iconButton }
						icon={
							<Image
								src="/images/favor_black.svg"
								width={16}
								height={16}
								alt="Favor"
							/>
						}
					/>
					<Button
						appendClass={ iconButton }
						icon={
							<Image
								src="/images/options.svg"
								width={16}
								height={16}
								alt="Options"
							/>
						}
					/>
				</div>
			</div>
		)
	}

	function _renderTitle() {
		return (
			<>
				<div className={ info }>
					<h1 className={ title }>{ name }</h1>
					<div className={ detail }>
					<div className={ imageWrapper }>
						<Image
							src={`https://${STAR_ICON_SERVER_HOST}/static/images/Star_Black_Eats_3.png`}
							width="14"
							height="14"
							alt="Star"
						/>
					</div>
					<span className={ detailInfo }>{getScore(score)} •</span>
					<div className={ imageWrapper }>
						<Image
							src={`https://${UTILS_ICONS_SERVER_HOST}/ticket@3x.png`}
							width="14"
							height="14"
							alt="Ticket"
						/>
					</div>
					<span className={ detailInfo }>•</span>
					<div className={ moreDetail }>詳細資訊</div>
					</div>
					<div>
					<span className={ time }>{shortestDeliveryTime}–{shortestDeliveryTime + 10}分鐘</span>
					<span className={ cost }> • { deliveryCost }TWD 費用</span>
					</div>
				</div>
				<div className={ orders }>
					<Button
						appendClass={ button }
						icon={
							<Image
								src="/images/group_order.svg"
								width={16}
								height={16}
								alt="Favor"
							/>
						}
						text="團購訂單"
					/>
					<div className={ space_8 } />
					<Button
						appendClass={ button }
						icon={
							<Image
								src="/images/schedule.svg"
								width={16}
								height={16}
								alt="Favor"
							/>
						}
						text="安排時間"
					/>
				</div>
			</>
		)
	}

	return (
		<main className={ wrapper }>
			{ _renderBanner() }
			{ _renderTitle() }
		</main>
	)
}

export const getStaticPaths = getPageStaticPaths<TStoreSlug>(
	getStoreSlugs,
	STORESLUGS,
	SHOW_FALLBACK_PAGE
);
export const getStaticProps = getPageProps<TPageData>(
	getStoreBySlug,
	STORE
);

export default Store;
