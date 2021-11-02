import {
	GraphQLObjectType,
	GraphQLList
} from 'graphql';
import {
	ShortcutType,
	CarouselType,
	ChannelType
} from '../../models/type_defs';
import {
	getShortcut,
	getCarousel,
	getChannel
} from '../resolvers';

export const query = new GraphQLObjectType({
  name: 'HomePageQuery',
  fields: {
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
  },
});
