import type { HomeChannelItem } from "../../../queries";
import { TShop } from 'types/shop';

export type Prop = {
	data: HomeChannelItem[][];
	size: number;
	offset: number;
};

export type {
	HomeChannelItem,
	TShop
};
