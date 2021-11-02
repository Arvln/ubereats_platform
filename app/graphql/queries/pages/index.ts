import { gql } from '@apollo/client';
import {
	shortcutQuery,
	carouselQuery,
	channelQuery
} from '../features';

export const query = gql`
	query {
		${shortcutQuery}
		${carouselQuery}
		${channelQuery}
	}
`
