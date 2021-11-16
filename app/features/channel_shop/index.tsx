import { Prop, TChannelShop } from './types';
import { TAppendClass } from 'components/button/types';
import Image from 'next/image';
import Link from 'next/link';
import Button from 'components/button';
import {
	getScore,
	isPickup,
	getPickupDistance,
	getPageSizeWrapper
} from './utils';

import classes from 'styles/features/ChannelShop.module.scss';

const {
	wrapper,
	pageWrapper,
	shopWrapper,
	storeTitle,
	imageWrapper,
	discountMessage,
	buttonWrapper,
	favorButtonWrapper,
	discountText,
	hideEmpty,
	baseMessage,
	title,
	scoreButtonWrapper,
	scoreText,
	hidden,
	detailMessage,
	detailMessageImage,
	fare,
	costTime,
	distance,
	detailImageWrapper,
	space_12,
	space_16
} = classes;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;
const UTILS_ICONS_SERVER_HOST = process.env.UTILS_ICONS_SERVER_HOST;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;
const withoutCommentScore: string = '0.0';

function ChannelShop({
	data: pages,
	pageSize,
	pageOffset
}: Prop) {
	function _renderDetailContent(
		cost: number,
		time: number
	) {
		const isPickupByCustomer: boolean = isPickup(cost);

		if (isPickupByCustomer)
			return (
				<>
					<div className={ costTime }>
						<span>
							{time}–{time + 10}分鐘
						</span>
					</div>
					<span> • </span>
					<div className={ distance }>
						<span>{getPickupDistance(cost)}公里</span>
					</div>
				</>
			);
		else
			return (
				<>
					<span> • </span>
					<div className={ fare }>
						<span>{cost}TWD 費用</span>
					</div>
					<span> • </span>
					<div className={ costTime }>
						<span>
							{time}–{time + 10}分鐘
						</span>
					</div>
				</>
			)
	}

	function _renderScoreButton(score: number) {
		const isCarefullySelected: boolean = score === 100;
		const isComment: boolean = getScore(score) !== withoutCommentScore;
		const scoreButton: TAppendClass = {
			appendWrapper: isComment ? scoreButtonWrapper : hidden,
			appendContent: scoreText
		}

		if (isCarefullySelected)
			return (
				<div className={ scoreButtonWrapper }>
					<Image
						src={`https://${SHORTCUT_ICONS_SERVER_HOST}/eatsfeed/other_icons/top_eats.png`}
						layout="fill"
						alt="Carefully Selected"
					/>
				</div>
			)
		else
			return (
				<Button
					appendClass={ scoreButton }
					text={getScore(score)}
				/>
			)
	}

	function _renderShop(shops: TChannelShop[]) {
		return (
			shops.map(({
				name,
				deliveryCost,
				shortestDeliveryTime,
				score,
				discountInfo,
				imageSuffix,
				uuid
			}) => {
				const pageSizeWrapper = getPageSizeWrapper(pageSize);
				const hideEmptyElement: string = discountInfo === '' ? hideEmpty : '';
				const favorButton: TAppendClass = {
					appendWrapper: favorButtonWrapper,
					appendContent: ''
				};

				return (
					<li
						className={ `${shopWrapper} ${pageSizeWrapper}` }
						key={uuid}
					>
						<Link href={`/store/${name}`}>
							<a>
								<h3 className={ storeTitle }>{name}</h3>
								<div className={ imageWrapper }>
									<Image
										src={`https://${STORE_IMAGE_SERVER_HOST}/${imageSuffix}`}
										layout="fill"
										alt="Shop"
									/>
									<div className={ discountMessage }>
										<span
											className={ `${hideEmptyElement} ${discountText}` }>
											{discountInfo}
										</span>
										<div className={ buttonWrapper }>
											<div className={ space_16 } />
											<Button
												appendClass={ favorButton }
												icon={
													<Image
														src="/images/favor.svg"
														width="20"
														height="20"
														alt="Favor"
													/>
												}
											/>
											<div className={ space_12 } />
										</div>
									</div>
								</div>
								<div className={ baseMessage }>
									<div className={ title }>{name}</div>
									{ _renderScoreButton(score) }
								</div>
								<div className={ detailMessage }>
									<div className={ detailImageWrapper }>
										<div className={ detailMessageImage }>
											<Image
												src={`https://${UTILS_ICONS_SERVER_HOST}/ticket@3x.png`}
												layout="fill"
												alt="Ticket"
											/>
										</div>
									</div>
									{ _renderDetailContent(deliveryCost, shortestDeliveryTime) }
								</div>
							</a>
						</Link>
					</li>
				)
			})
		)
	}

	function _renderPages() {
		return (
			pages.map((shops, index) => (
				<div
					className={pageWrapper}
					style={{ transform: `translateX(${pageOffset}%)` }}
					key={index}
				>
					{ _renderShop(shops as TChannelShop[]) }
				</div>
			))
		);
	}

	return (
		<div className={ wrapper }>
			{ _renderPages() }
		</div>
	)
}

export default ChannelShop;
