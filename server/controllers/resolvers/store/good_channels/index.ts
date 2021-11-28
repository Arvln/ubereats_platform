import { TGoodChannel, TParent } from 'types/pages/store';
import _ from 'lodash';
import { getData } from 'models/store/good_channels';
import { getChannels } from './utils';

export async function getGoodChannels(
	parent: TParent
): Promise<TGoodChannel[]> {
	const {
		id,
		discountLabel
	} = parent;
	const {
		discountGoods,
		exclusiveGoods,
		channels,
		goods
	} = await getData(id);
	let goodChannels: TGoodChannel[] = channels.map(({
		id,
		label
	}) => ({
		label,
		items: _.filter(goods, {
			channelId: id
		})
	}));

	goodChannels = getChannels(goodChannels, exclusiveGoods);
	goodChannels = getChannels(goodChannels, discountGoods, discountLabel);

	return goodChannels;
};
