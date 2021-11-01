const {
	GraphQLObjectType,
	GraphQLString
} = require('graphql');

export const CannelType = new GraphQLObjectType({
  name: 'Cannel',
	fields: () => ({
		title: {
			type: GraphQLString
		},
		subtitle: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
});
