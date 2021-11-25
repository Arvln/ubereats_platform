import {
	GraphQLList,
	GraphQLString,
	GraphQLNonNull
} from 'graphql';
import {
	StroeSlugType,
	StroeType
} from 'models/type_defs';
import {
	getStoreSlugs,
	getStore
} from 'controllers/resolvers';

export const storeFields = {
	storeSlugs: {
		type: new GraphQLList(StroeSlugType),
		resolve: getStoreSlugs
	},
	store: {
		type: new GraphQLList(StroeType),
		args: {
			name: {
				type: new GraphQLNonNull(GraphQLString)
			},
			uuid: {
				type: new GraphQLNonNull(GraphQLString)
			}
		},
		resolve: getStore
	}
};
