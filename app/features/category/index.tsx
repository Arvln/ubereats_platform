'use client';

import { useQuery } from '@tanstack/react-query';
import { useParams } from 'next/navigation';
import { RecommandCategories } from 'app/[locale]/[title]/components/category/recommand-categories';
import Title from './title';
import { Shop } from 'components';
import RestrictSearch from 'app/[locale]/components/restrict_search';
import {
  categoryByTitleQueryOptions,
} from '../../app/[locale]/[title]/queries';

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

function Category() {
	const params = useParams<{ title: string }>();
	const title = params.title;
	const { data } = useQuery(categoryByTitleQueryOptions(title));

	if (!data) {
		return null;
	}

	const {
		title: categoryTitle,
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

	if (categoryTitle === DEALS || categoryTitle === TOP_EATS) {
		return (
			<main className={wrapper}>
				{_renderShops(imageHeight_30, recommandShop)}
			</main>
		);
	};

	return (
		<>
			<Title
				title={categoryTitle}
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
