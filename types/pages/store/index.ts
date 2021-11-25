export type TStoreSlug = {
	name: string;
	uuid: string;
}

export type TStore = TStoreSlug & {
	__typename: string;
	deliveryCost: number;
	shortestDeliveryTime: number;
	score: number;
	discountInfo: string;
	bannerSuffix: string;
}

export type TPageData = TStore;

export type Prop = {
	pageData: TPageData;
};
