import { TChannelItem } from "types/features";

export type TPagesState = {
	[id: string]: {
		currentPage: number;
		previousButtonStyle: string;
		nextButtonStyle: string;
	};
};

export type { TChannelItem };
