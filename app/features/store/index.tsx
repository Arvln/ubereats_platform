import { Prop } from './types';
import { TAppendClass } from 'components/button/types';
import { Button } from 'components';
import Title from './title';
import Image from 'next/image';

import classes from 'styles/features/store/Store.module.scss';

const {
	wrapper,
	banner,
	moreOptions,
	buttonWrapper
} = classes;
const STORE_IMAGE_SERVER_HOST = process.env.STORE_IMAGE_SERVER_HOST;
const button: TAppendClass = {
	appendWrapper: buttonWrapper,
	appendContent: ''
};

function Store({ data }: Prop) {
	const {
		name,
		deliveryCost,
		shortestDeliveryTime,
		score,
		bannerSuffix,
		address,
		goodChannels
	} = data;
	console.log(goodChannels);

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
		<main className={wrapper}>
			{_renderBanner()}
			<Title
				name={name}
				deliveryCost={deliveryCost}
				shortestDeliveryTime={shortestDeliveryTime}
				score={score}
			/>
		</main>
	);
};

export default Store;
