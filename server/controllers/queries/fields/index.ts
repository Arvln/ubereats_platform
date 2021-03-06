import { GraphQLList } from 'graphql';
import {
	ShortcutType,
	CarouselType,
	ChannelType
} from 'models/type_defs';
import {
	getShortcut,
	getCarousel,
	getChannel
} from 'controllers/resolvers';

export const homeFields = {
	shortcut: {
		type: new GraphQLList(ShortcutType),
		resolve: getShortcut
	},
	carousel: {
		type: new GraphQLList(CarouselType),
		resolve: getCarousel
	},
	channel: {
		type: new GraphQLList(ChannelType),
		resolve: getChannel
	}
};
