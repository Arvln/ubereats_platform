import {
	GraphQLObjectType,
	GraphQLList
} from 'graphql';
import {
	ShortcutType,
	CarouselType
} from '../../models/type_defs';
import {
	getShortcut,
	getCarousel
} from '../resolvers';

export const query = new GraphQLObjectType({
  name: 'RootQuery',
  fields: {
    shortcut: {
      type: new GraphQLList(ShortcutType),
			resolve: getShortcut
		},
		carousel: {
			type: new GraphQLList(CarouselType),
			resolve: getCarousel
		},
  },
});
