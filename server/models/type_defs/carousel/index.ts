import {
	GraphQLObjectType,
	GraphQLString
} from 'graphql';

export const CarouselType = new GraphQLObjectType({
  name: 'Carousel',
	fields: () => ({
		content: {
			type: GraphQLString
		},
		imageSuffix: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
});
