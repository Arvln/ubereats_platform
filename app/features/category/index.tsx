import { Prop } from './types';
import { RecommandCategories } from 'enums/features/category';
import Title from './title';
import { Shop } from 'components';
import RestrictSearch from 'features/restrict_search';

import classes from 'styles/features/category/Category.module.scss';

const {
	wrapper,
	shopWrapper,
	recommandShop,
	imageHeight_30,
	imageHeight_38
} = classes;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;
const {
	DEALS,
	TOP_EATS
} = RecommandCategories;

function Category({ data }: Prop) {
	const {
		title,
		isCuisines,
		imageSuffix,
		categoryShopItems: shops
	} = data;
	const iconUrl = `https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${imageSuffix}`;

	function _renderShops(imageHeight: string, style?: string) {
		const wrapper: string = style ? `${shopWrapper} ${style}` : shopWrapper;

		return (
			<div className={wrapper}>
				<Shop
					data={shops}
					imageHeight={imageHeight}
				/>
			</div>
		);
	};

	if (title === DEALS || title === TOP_EATS) {
		return (
			<main className={wrapper}>
				{_renderShops(imageHeight_30, recommandShop)}
			</main>
		);
	};

	return (
		<>
			<Title
				title={title}
				iconUrl={iconUrl}
			/>
			<main className={wrapper}>
				<RestrictSearch isCuisines={isCuisines} />
				{_renderShops(imageHeight_38)}
			</main>
		</>
	);
};

export default Category;
