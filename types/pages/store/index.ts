export type TStoreSlug = {
	name: string;
	uuid: string;
}

export type TStore = {
	__typename: string;
	name: string;
	deliveryCost: number;
	shortestDeliveryTime: number;
	score: number;
	discountLabel: string;
	bannerSuffix: string;
	address: string;
}

export type TGood = {
	name: string;
	price: number;
	discription: string;
	imageSuffix: string;
	spicyLevel: string;
	isEmphasis: boolean;
	uuid: string;
};

export type TChannel = {
	id: number;
	label: string;
};

export type TGoodWithChannelId = TGood & { channelId: number; };

export type TGoodChannel = {
	label: string;
	items: TGood[];
};

export type TParent = TStore & { id: number };

export type TPageData = TStore & {
	goodChannels: TGoodChannel[];
};

export type Prop = {
	pageData: TPageData;
};
