import {
	TParent,
	TChannelShops
} from '../../../../types/channel';
import _ from 'lodash';
import { getData } from '../../../models/channel';

export async function getChannel(): Promise<TParent[]> {
	const {
		channel
	} = await getData();

	return channel;
}

export async function getChannelShops(parent: TParent): Promise<TChannelShops[]> {
	const {
		channelShop
	} = await getData();

	return _.filter(channelShop, {
		channelId: parent.id
	});
}
