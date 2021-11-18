import { TShop } from '../../shop';

export type TChannel = {
	title: string;
	subtitle: string;
	imageSuffix: string;
	uuid: string;
}

export type TParent = TChannel & { id: number; }

export type TChannelShop = TShop & { channelId: number; }

export type TChannelCategory = {
	__typename: string;
	title: string;
	name: string;
	uuid: string;
}

export type TChannelItem = TChannelShop | TChannelCategory;

export type TChannelData = TChannel & {
	channelItems: TChannelItem[];
};
