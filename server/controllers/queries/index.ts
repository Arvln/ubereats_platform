import { GraphQLObjectType } from 'graphql';
import { homeFields } from './fields';
import { categoryFields } from './fields/category';
import { advertiseFields } from './fields/marketing/advertise';
import { storeFields } from './fields/store';

export const query = new GraphQLObjectType({
  name: 'RootQuery',
  fields: {
		...homeFields,
		...categoryFields,
		...advertiseFields,
		...storeFields
  },
});
