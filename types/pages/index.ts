import { TShortcut } from '../features';
import { TCarousel } from '../features';
import {
	TChannelData
} from '../features';

export type TPageData = {
	shortcut: TShortcut[],
	carousel: TCarousel[],
	channel: TChannelData[]
}

export type Prop = {
	pageData: TPageData;
}
