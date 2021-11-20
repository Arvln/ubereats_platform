import {
	GraphQLList,
	GraphQLString,
	GraphQLNonNull
} from 'graphql';
import { AdvertiseType } from 'models/type_defs';
import { getAdvertise } from 'controllers/resolvers';

export const advertiseFields = {
	advertise: {
		type: new GraphQLList(AdvertiseType),
		args: {
			uuid: {
				type: new GraphQLNonNull(GraphQLString)
			}
		},
		resolve: getAdvertise
	}
};
