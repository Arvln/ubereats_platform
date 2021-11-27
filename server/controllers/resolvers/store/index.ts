import { TStoreSlug, TParent, TGoodChannel } from 'types/pages/store';
import _ from 'lodash';
import { getData } from 'models/store';
import { getLabel } from './utils';

export async function getStoreSlugs(): Promise<TStoreSlug[]> {
	const { storeSlugs } = await getData();

	return storeSlugs;
};

export async function getGoodChannels(
	parent: TParent
): Promise<TGoodChannel[]> {
	const {
		discountLabel
	} = parent;
	const {
		discountGoods,
		exclusiveGoods,
		channels,
		goods
	} = await getData();
	const discountItems = _.filter(discountGoods, {
		shopId: parent.id
	});
	const exclusiveItems = _.filter(exclusiveGoods, {
		shopId: parent.id
	});
	const goodChannels = _
		.filter(channels, {
			shopId: parent.id
		})
		.map(({ id, title: label }) => ({
			label,
			items: _.filter(goods, {
				channelId: id
			})
		}));

	return [
		{
			label: getLabel(discountLabel),
			items: discountItems
		},
		{
			label: '您專屬的推薦商品',
			items: exclusiveItems
		},
		...goodChannels
	];
};

export async function getStore(
	parent: unknown,
	args: Record<string, string>
): Promise<TParent[]> {
	const {
		name,
		uuid
	} = args;
	const { store } = await getData(name, uuid);

	return store;
};
