import { TShortcut } from '../shortcut';
import { TCarousel } from '../carousel';
import {
	TChannel,
	TChannelItem
} from '../channel';

export type Prop = {
	shortcut: TShortcut[],
	carousel: TCarousel[],
	channel: (
		TChannel & {
			channelItems: TChannelItem[];
		}
	)[]
}
