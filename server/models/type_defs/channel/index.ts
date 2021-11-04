import {
	GraphQLObjectType,
	GraphQLUnionType,
	GraphQLID,
	GraphQLInt,
	GraphQLString,
	GraphQLList
} from 'graphql';
import { getChannelItems } from '../../../controllers/resolvers';

export const ChannelType = new GraphQLObjectType({
  name: 'Channel',
	fields: () => ({
		id: {
			type: GraphQLID
		},
		title: {
			type: GraphQLString
		},
		subtitle: {
			type: GraphQLString
		},
		imageSuffix: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		},
		channelItems: {
			type: new GraphQLList(ChannelItemType),
			resolve: getChannelItems
		}
	})
});

const ChannelItemType = new GraphQLUnionType({
	name: 'ChannelItem',
	types: () => [ChannelShopType, channelCategoryType],
	resolveType: value => value.name ? ChannelShopType : channelCategoryType
})

const ChannelShopType = new GraphQLObjectType({
	name: 'ChannelShop',
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
		imageSuffix: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		},
		channelId: {
			type: GraphQLID
		}
	})
})

const channelCategoryType = new GraphQLObjectType({
	name: 'ChannelCategory',
	fields: () => ({
		title: {
			type: GraphQLString
		},
		categoryName: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
})
