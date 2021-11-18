import { GraphQLObjectType } from 'graphql';
import { homeFields } from './fields';
import { categoryFields } from './fields/category';

export const query = new GraphQLObjectType({
  name: 'RootQuery',
  fields: {
		...homeFields,
		...categoryFields
  },
});
