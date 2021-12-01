import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import { useState } from 'react';
import { Button } from 'components';
import Title from './title';
import Sidebar from './sidebar';
import Menu from './menu';
import Head from 'next/head';
import Image from 'next/image';

import classes from 'styles/features/store/Store.module.scss';

const {
	wrapper,
	banner,
	moreOptions,
	buttonWrapper,
	content,
	space_40
} = classes;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;
const button: TAppendClass = {
	appendWrapper: buttonWrapper,
	appendContent: ''
};
const originPosition: number = 0;

function Store({ data }: Prop) {
	const [position, setPosition] = useState<number>(originPosition);
	const {
		name,
		deliveryCost,
		shortestDeliveryTime,
		score,
		bannerSuffix,
		address,
		goodChannels
	} = data;

	function _renderBanner() {
		return (
			<div className={banner}>
				<Image
					src={`https://${STORE_IMAGE_SERVER_HOST}/${bannerSuffix}`}
					layout="fill"
					objectFit="cover"
					alt="Banner"
				/>
				<div className={moreOptions}>
					<Button
						appendClass={button}
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
						appendClass={button}
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
		);
	};

	return (
		<>
			<Head>
				<title>{`${name} 台北 外送 | 菜單 | Uber Eats`}</title>
				<meta name="description" content="使用 Uber 帳戶即可向台北的兔寶寶漢堡店訂購外送美食。瀏覽菜單、查看熱門餐點，並可追蹤訂單進度。" />
			</Head>
			<main className={wrapper}>
				{_renderBanner()}
				<Title
					name={name}
					deliveryCost={deliveryCost}
					shortestDeliveryTime={shortestDeliveryTime}
					score={score}
				/>
				<div className={content}>
					<Sidebar
						data={goodChannels}
						position={position}
					/>
					<div className={space_40} />
					<Menu data={goodChannels} />
				</div>
			</main>
		</>
	);
};

export default Store;
