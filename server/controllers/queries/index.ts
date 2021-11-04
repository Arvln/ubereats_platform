import { GraphQLObjectType } from 'graphql';
import { homeFields } from './fields';

export const query = new GraphQLObjectType({
  name: 'RootQuery',
  fields: {
		...homeFields
  },
});
