import {
	TChannelData,
	TChannelItem
} from "types/channel";

export type Prop = {
	data: TChannelData[]
};

export type TPagesState = {
	[id: string]: {
		currentPage: number;
		previousButtonStyle: string;
		nextButtonStyle: string;
	}
}

export enum ContentType {
	CHANNELSHOP = 'ChannelShop',
	CHANNELCATEGORY = 'ChannelCategory'
};

export type { TChannelItem };
