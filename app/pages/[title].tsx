import {
	TTitles,
	IParams,
	TPageData,
	Prop
} from 'types/pages/title';
import type {
	NextPage,
	GetStaticPaths,
	GetStaticProps
} from 'next';
import Image from 'next/image';
import { ApolloQueryResult } from '@apollo/client';
import { getApolloClient } from 'graphql/apollo_client';
import {
	getTitles,
	getCategory
} from 'graphql/queries/pages/title';
import Shop from 'components/shop';
import RestrictSearch from 'features/restrict_search';

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
	imageWrapper,
	grey
} = classes;
const client = getApolloClient();
enum RecommandCategoryType {
	DEALS = '優惠',
	TOP_EATS = '嚴選餐廳',
	PET = '寵物用品',
	FLOWERS = '鮮花',
	RETAIL = '百貨商場'
};
const {
	DEALS,
	TOP_EATS,
	PET,
	FLOWERS,
	RETAIL
} = RecommandCategoryType;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;

export const getStaticPaths: GetStaticPaths = async () => {
	const {
		data: {
			shortcut: titles
		}
	}: ApolloQueryResult<{shortcut: TTitles[]}> = await client.query({
		query: getTitles
	});
	const paths = titles.map(({ title }) => ({
		params: { title }
	}));

	return {
		paths,
		fallback: true
	};
}

export const getStaticProps: GetStaticProps = async ({
	params
}) => {
	const { title } = params as IParams;
	const {
		data: {
			category
		}
	}: ApolloQueryResult<{category: TPageData[]}> = await client.query({
		query: getCategory,
		variables: {
			title
		},
	});
	const pageData = category[0];

	if (!pageData) {
		return {
			redirect: {
				destination: '/',
				permanent: false,
			},
		}
	}
	
	return {
		props: {
			pageData
		}
	}
}

const Category: NextPage<Prop> = ({ pageData }) => {
	if (!pageData) return <div>loading...</div>;

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

export default Category;
