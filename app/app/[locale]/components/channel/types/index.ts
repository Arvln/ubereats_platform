import type { HomeChannelItem } from "../../../queries";

export type TPagesState = {
	[id: string]: {
		currentPage: number;
		previousButtonStyle: string;
		nextButtonStyle: string;
	};
};

export type { HomeChannelItem };
