import { GraphQLSchema } from 'graphql';
import { query } from '../controllers/queries';

export const schema = new GraphQLSchema({
	query
});
