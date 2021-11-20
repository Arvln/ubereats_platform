import { TShop } from '../shop';

export type TCategory = {
	title: string;
	imageSuffix: string;
	isCuisines: boolean;
};

export type TParent = TCategory & { id: number; };

export type TCategoryShop = TShop & { categoryId: number };

export type TTitles = {
	title: string;
};

export type TPageData = TCategory & {
	categoryShopItems: TShop[];
};

export type Prop = {
	pageData: TPageData
};
