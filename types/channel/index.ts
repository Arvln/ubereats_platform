export type TChannel = {
	title: string;
	subtitle: string;
	imageSuffix: string;
	uuid: string;
}

export type TParent = TChannel & { id: number; }

export type TChannelShops = {
	name: string;
	deliveryCost: number;
	shortestDeliveryTime: number;
	score: number;
	discountInfo: string;
	imageSuffix: string;
	uuid: string;
	channelId: number;
}
