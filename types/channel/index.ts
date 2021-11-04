export type TChannel = {
	title: string;
	subtitle: string;
	imageSuffix: string;
	uuid: string;
}

export type TParent = TChannel & { id: number; }

export type TChannelShop = {
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
	title: string;
	categoryName: string;
	uuid: string;
}

export type TChannelItem = TChannelShop | TChannelCategory;
