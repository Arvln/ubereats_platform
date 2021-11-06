export type TChannel = {
	title: string;
	subtitle: string;
	imageSuffix: string;
	uuid: string;
}

export type TParent = TChannel & { id: number; }

export type TChannelShop = {
	__typename: string;
	name: string;
	deliveryCost: number;
	shortestDeliveryTime: number;
	score: number;
	discountInfo: string;
	imageSuffix: string;
	uuid: string;
	channelId: number;
}

export type TChannelCategory = {
	__typename: string;
	title: string;
	categoryName: string;
	uuid: string;
}

export type TChannelItem = TChannelShop | TChannelCategory;

export type TChannelData = TChannel & {
	channelItems: TChannelItem[];
};
