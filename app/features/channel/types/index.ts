import {
	TChannelData,
	TChannelItem
} from "../../../../types/channel";

export type Prop = {
	data: TChannelData[]
};

export enum ContentType {
	CHANNELSHOP = 'ChannelShop',
	CHANNELCATEGORY = 'ChannelCategory'
};

export type { TChannelItem };
