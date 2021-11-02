import {
	GraphQLObjectType,
	GraphQLID,
	GraphQLInt,
	GraphQLString,
	GraphQLList
} from 'graphql';
import { getChannelShops } from '../../../controllers/resolvers';

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
		channelShops: {
			type: new GraphQLList(ChannelShopsType),
			resolve: getChannelShops
		}
	})
});

export const ChannelShopsType = new GraphQLObjectType({
	name: 'ChannelShops',
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
