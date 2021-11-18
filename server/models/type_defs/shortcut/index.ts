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
		imageSuffix: {
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
