import {
	TParent,
	TChannelItem
} from 'types/channel';
import _ from 'lodash';
import { getData } from 'models/channel';

const SEARCH_BY_CATEGORY_CANNEL_ID: number = 5;

export async function getChannel(): Promise<TParent[]> {
	const {
		channel
	} = await getData();

	return channel;
}

export async function getChannelItems(parent: TParent): Promise<TChannelItem[]> {
	const {
		channelShop,
		channelCategory
	} = await getData();

	if (parent.id === SEARCH_BY_CATEGORY_CANNEL_ID) return channelCategory;

	return _.filter(channelShop, {
		channelId: parent.id
	});
}
