import { getData } from '../../../models/cannel';

export async function getCannel() {
	const channel = await getData();

	return channel;
}
