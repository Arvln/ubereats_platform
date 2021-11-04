import {
	TChannel,
	TChannelItem
} from "../../../../types/channel";

export type Prop = {
	channel: (
		TChannel & {
			channelItems: TChannelItem[];
		}
	)[]
}
