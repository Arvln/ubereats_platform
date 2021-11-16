import { Prop, TChannelCategory } from './types';
import Image from 'next/image';
import CategoryItem from 'components/category_item';

import classes from 'styles/features/ChannelCategory.module.scss';

const {
	wrapper,
	pageWrapper,
	categoryWrapper,
	category
} = classes;
const CATEGORY_ICONS_SERVER_HOST = process.env.CATEGORY_ICONS_SERVER_HOST;

function ChannelCategory({
	data: pages,
	pageOffset
}: Prop) {
	function _renderCategory(categoies: TChannelCategory[]) {
		return (
			categoies.map(({
				title,
				categoryName,
				uuid
			}) => (
				<div
					className={categoryWrapper}
					key={uuid}
				>
					<CategoryItem
						appendClass={ category }
						pageUrl={`/category/${categoryName}`}
						icon={
							<Image
								src={`https://${CATEGORY_ICONS_SERVER_HOST}/new_search_home_eats_icon/${categoryName}_BrowseHome@3x.png`}
								width={68}
								height={80}
								alt={categoryName}
							/>
						}
						text={title}
					/>
				</div>
			))
		)
	}

	function _renderPages() {
		return (
			pages.map((categoies, index) => (
				<div
					className={pageWrapper}
					style={{ transform: `translateX(${pageOffset}%)` }}
					key={index}
				>
					{ _renderCategory(categoies as TChannelCategory[]) }
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

export default ChannelCategory;
