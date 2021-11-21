import {
	TChannelData,
	TChannelItem
} from "types/features";

export type Prop = {
	data: TChannelData[]
};

export type TPagesState = {
	[id: string]: {
		currentPage: number;
		previousButtonStyle: string;
		nextButtonStyle: string;
	}
}

export type { TChannelItem };
