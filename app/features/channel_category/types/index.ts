import type {
  HomeChannelCategory,
  HomeChannelItem,
} from "../../../app/[locale]/queries";

export type Prop = {
	data: HomeChannelItem[][];
	pageOffset: number;
};

export type { HomeChannelCategory, HomeChannelItem };
