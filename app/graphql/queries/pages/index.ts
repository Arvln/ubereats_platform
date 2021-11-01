import { gql } from '@apollo/client';
import {
	shortcutQuery,
	carouselQuery,
	cannelQuery
} from '../features';

export const query = gql`
	query {
		${shortcutQuery}
		${carouselQuery}
		${cannelQuery}
	}
`
