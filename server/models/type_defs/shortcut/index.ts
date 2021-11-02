import {
	GraphQLObjectType,
	GraphQLString,
	GraphQLInt
} from 'graphql';

export const ShortcutType = new GraphQLObjectType({
  name: 'Shortcut',
	fields: () => ({
		title: {
			type: GraphQLString
		},
		shortcutImageSuffix: {
			type: GraphQLString
		},
		isCuisines: {
			type: GraphQLInt
		},
		uuid: {
			type: GraphQLString
		}
	})
});
