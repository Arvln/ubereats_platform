import {
	GraphQLObjectType,
	GraphQLInt,
	GraphQLString
} from 'graphql';

export const StroeSlugType = new GraphQLObjectType({
	name: 'StoreSlug',
	fields: () => ({
		name: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
});

export const StroeType = new GraphQLObjectType({
	name: 'Store',
	fields: () => ({
		name: {
			type: GraphQLString
		},
		deliveryCost: {
			type: GraphQLInt
		},
		shortestDeliveryTime: {
			type: GraphQLInt
		},
		score: {
			type: GraphQLInt
		},
		discountInfo: {
			type: GraphQLString
		},
		bannerSuffix: {
			type: GraphQLString
		},
		address: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
});
