import { TShortcut } from '../shortcut';
import { TCarousel } from '../carousel';
import {
	TChannel,
	TChannelShops
} from '../channel';

export type Prop = {
	shortcut: TShortcut[],
	carousel: TCarousel[],
	channel: (
		TChannel & {
			channelShops: TChannelShops[];
		}
	)[]
}
