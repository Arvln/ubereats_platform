import { productConfig } from '../../config/default.config';

const {
	api: {
		version
	}
} = productConfig;
const API_PREFIX: string = `/api/${version}`;

export const HOME_URL: string = `${API_PREFIX}/`;
