import {
	GraphQLObjectType,
	GraphQLID,
	GraphQLString,
	GraphQLInt,
	GraphQLList
} from 'graphql';
import { getCategoryShopItems } from 'controllers/resolvers';

export const CategoryType = new GraphQLObjectType({
	name: 'Category',
	fields: () => ({
		id: {
			type: GraphQLID
		},
		title: {
			type: GraphQLString
		},
		imageSuffix: {
			type: GraphQLString
		},
		isCuisines: {
			type: GraphQLInt
		},
		categoryShopItems: {
			type: new GraphQLList(CategoryShopType),
			resolve: getCategoryShopItems
		}
	})
});

const CategoryShopType = new GraphQLObjectType({
	name: 'CategoryShop',
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
		discountLabel: {
			type: GraphQLString
		},
		imageSuffix: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
});
