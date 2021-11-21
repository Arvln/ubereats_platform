import {
	TTitles,
	TPageData,
	Prop
} from 'types/pages/title';
import type { NextPage } from 'next';
import {
	RecommandCategories,
	Fields
} from 'enums/pages/category';
import { FallbackTypes } from 'enums/pages/common';
import Image from 'next/image';
import {
	getTitles,
	getCategoryByTitle
} from 'graphql/queries/pages/category';
import Shop from 'components/shop';
import RestrictSearch from 'features/restrict_search';
import {
	getPageStaticPaths,
	getPageStaticProps
} from 'utils';

import classes from 'styles/pages/Category.module.scss';

const {
	wrapper,
	shopWrapper,
	recommandShop,
	imageHeight_30,
	imageHeight_38,
	titleWrapper,
	background,
	topBackground,
	bottomBackground,
	left,
	right,
	content,
	text,
	imageWrapper
} = classes;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;
const {
	DEALS,
	TOP_EATS,
	PET,
	FLOWERS,
	RETAIL
} = RecommandCategories;
const {
	SHORTCUT,
	CATEGORY
} = Fields;
const { SHOW_ERROR_PAGE } = FallbackTypes;

const Category: NextPage<Prop> = ({ pageData }) => {
	const {
		title,
		isCuisines,
		imageSuffix,
		categoryShopItems: shops
	} = pageData;

	function _renderImage(): JSX.Element | void {
		if (title === PET || title === FLOWERS || title === RETAIL) return;

		return (
			<div className={ imageWrapper }>
				<Image
					src={`https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${imageSuffix}`}
					layout="fill"
					alt={imageSuffix}
				/>
			</div>
		)
	}

	function _renderTitle() {
		const wrapper = titleWrapper;

		return (
			<div className={wrapper}>
				<div className={ background }>
					<div className={ topBackground } />
					<div className={ bottomBackground }>
						<div className={ left } />
						<div className={ right } />
					</div>
				</div>
				<div className={ content }>
					<div className={ text }>{title}</div>
					{ _renderImage() }
				</div>
			</div>
		)
	}

	function _renderShops(imageHeight: string, style?: string) {
		const wrapper: string = style ? `${shopWrapper} ${style}` : shopWrapper;

		return (
			<div className={ wrapper }>
				<Shop
					shops={shops}
					imageHeight={imageHeight}
				/>
			</div>
		);
	}

	if (title === DEALS || title === TOP_EATS) {
		return (
			<main className={ wrapper }>
				{ _renderShops(imageHeight_30, recommandShop) }
			</main>
		)
	}

	return (
		<div>
			{ _renderTitle() }
			<main className={ wrapper }>
				<RestrictSearch isCuisines={isCuisines} />
				{ _renderShops(imageHeight_38) }
			</main>
		</div>
	);
}

export const getStaticPaths = getPageStaticPaths<TTitles>(
	getTitles,
	SHORTCUT,
	SHOW_ERROR_PAGE
);
export const getStaticProps = getPageStaticProps<TPageData>(
	getCategoryByTitle,
	CATEGORY
);

export default Category;