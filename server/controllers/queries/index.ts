import {
	GraphQLObjectType,
	GraphQLList
} from 'graphql';
import {
	ShortcutType,
	CarouselType,
	CannelType
} from '../../models/type_defs';
import {
	getShortcut,
	getCarousel,
	getCannel
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
		cannel: {
			type: new GraphQLList(CannelType),
			resolve: getCannel
		}
  },
});
