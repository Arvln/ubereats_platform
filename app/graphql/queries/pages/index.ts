import {
	getShortcut,
	getCarousel,
	getChannel
} from '../features';

export const query = `
	query {
		${getShortcut}
		${getCarousel}
		${getChannel}
	}
`
