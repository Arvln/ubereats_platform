import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import { Button } from 'components';
import Image from 'next/image';
import { getScore } from 'components/shop/utils';

import classes from 'styles/features/store/Title.module.scss';

const {
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
const STAR_ICON_SERVER_HOST = process.env.STAR_ICON_SERVER_HOST;
const UTILS_ICONS_SERVER_HOST = process.env.UTILS_ICONS_SERVER_HOST;
const button: TAppendClass = {
	appendWrapper: optionWrapper,
	appendContent: optionText
};

function Title({
	name,
	deliveryCost,
	shortestDeliveryTime,
	score
}: Prop) {
	return (
		<>
			<div className={info}>
				<h1 className={title}>{name}</h1>
				<div className={detail}>
					<div className={imageWrapper}>
						<Image
							src={`https://${STAR_ICON_SERVER_HOST}/static/images/Star_Black_Eats_3.png`}
							width="14"
							height="14"
							alt="Star"
						/>
					</div>
					<span className={detailInfo}>{getScore(score)} •</span>
					<div className={imageWrapper}>
						<Image
							src={`https://${UTILS_ICONS_SERVER_HOST}/ticket@3x.png`}
							width="14"
							height="14"
							alt="Ticket"
						/>
					</div>
					<span className={detailInfo}>•</span>
					<div className={moreDetail}>詳細資訊</div>
				</div>
				<div>
					<span className={time}>{shortestDeliveryTime}–{shortestDeliveryTime + 10}分鐘</span>
					<span className={cost}> • {deliveryCost}TWD 費用</span>
				</div>
			</div>
			<div className={orders}>
				<Button
					appendClass={button}
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
				<div className={space_8} />
				<Button
					appendClass={button}
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
	);
};

export default Title;
