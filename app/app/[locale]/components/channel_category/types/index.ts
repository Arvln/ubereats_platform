import type {
  HomeChannelCategory,
  HomeChannelItem,
} from "../../../queries";

export type Prop = {
	data: HomeChannelItem[][];
	pageOffset: number;
};

export type { HomeChannelCategory, HomeChannelItem };
