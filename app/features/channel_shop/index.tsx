import { Prop, TShop } from './types';
import Shop from 'components/shop';

import classes from 'styles/features/ChannelShop.module.scss';

const {
	wrapper,
	pageWrapper,
	imageHeight_57
} = classes;

function ChannelShop({
	data: pages,
	size,
	offset
}: Prop) {
	function _renderPages() {
		return (
			pages.map((shops, index) => (
				<div
					className={ pageWrapper }
					style={{ transform: `translateX(${offset}%)` }}
					key={index}
				>
					<Shop
						data={shops as TShop[]}
						size={size}
						imageHeight={imageHeight_57}
					/>
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
