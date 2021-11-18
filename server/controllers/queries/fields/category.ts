import {
	GraphQLList,
	GraphQLString,
	GraphQLNonNull
} from 'graphql';
import { CategoryType } from 'models/type_defs';
import { getCategory } from 'controllers/resolvers';

export const categoryFields = {
	category: {
		type: new GraphQLList(CategoryType),
		args: {
			title: {
				type: new GraphQLNonNull(GraphQLString)
			}
		},
		resolve: getCategory
	}
};

