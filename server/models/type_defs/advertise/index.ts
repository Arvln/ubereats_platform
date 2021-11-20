import {
	GraphQLObjectType,
	GraphQLString
} from 'graphql';

export const AdvertiseType = new GraphQLObjectType({
  name: 'Advertise',
	fields: () => ({
		content: {
			type: GraphQLString
		}
	})
});
