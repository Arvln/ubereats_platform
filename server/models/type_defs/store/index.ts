import {
	GraphQLObjectType,
	GraphQLID,
	GraphQLInt,
	GraphQLString,
	GraphQLBoolean,
	GraphQLList
} from 'graphql';
import { getGoodChannels } from 'controllers/resolvers';

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

const GoodType = new GraphQLObjectType({
	name: 'Good',
	fields: () => ({
		name: {
			type: GraphQLString
		},
		price: {
			type: GraphQLInt
		},
		discription: {
			type: GraphQLString
		},
		imageSuffix: {
			type: GraphQLString
		},
		spicyLevel: {
			type: GraphQLString
		},
		isEmphasis: {
			type: GraphQLBoolean
		},
		uuid: {
			type: GraphQLString
		}
	})
});

const GoodChannelType = new GraphQLObjectType({
	name: 'GoodChannel',
	fields: () => ({
		label: {
			type: GraphQLString,
		},
		items: {
			type: new GraphQLList(GoodType)
		}
	})
});

export const StroeType = new GraphQLObjectType({
	name: 'Store',
	fields: () => ({
		id: {
			type: GraphQLID
		},
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
		bannerSuffix: {
			type: GraphQLString
		},
		address: {
			type: GraphQLString
		},
		goodChannels: {
			type: new GraphQLList(GoodChannelType),
			resolve: getGoodChannels
		}
	})
});
