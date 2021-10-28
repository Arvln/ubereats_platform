import { gql } from '@apollo/client';
import {
	shortcutQuery,
	carouselQuery
} from '../features';

export const query = gql`
	query {
		${shortcutQuery}
		${carouselQuery}
	}
`
