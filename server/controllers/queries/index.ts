import {
	GraphQLObjectType,
	GraphQLList
} from 'graphql';
import { ShortcutType } from '../../models/shortcut/type_defs';
import { getShortcut } from '../resolvers/shortcut';

export const query = new GraphQLObjectType({
  name: 'RootQuery',
  fields: {
    shortcut: {
      type: new GraphQLList(ShortcutType),
			resolve: getShortcut,
    },
  },
});
