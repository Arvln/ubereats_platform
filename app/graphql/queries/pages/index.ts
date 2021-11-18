import { gql } from '@apollo/client';
import {
	getShortcut,
	getCarousel,
	getChannel
} from '../features';

export const query = gql`
	query {
		${getShortcut}
		${getCarousel}
		${getChannel}
	}
`
