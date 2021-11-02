import {
	GraphQLObjectType,
	GraphQLString
} from 'graphql';

export const CarouselType = new GraphQLObjectType({
  name: 'Carousel',
	fields: () => ({
		imageSuffix: {
			type: GraphQLString
		},
		uuid: {
			type: GraphQLString
		}
	})
});
