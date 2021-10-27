import { getData } from '../../../models/shortcut';

export async function getShortcut() {
	const shortcut = await getData();

	return shortcut;
}
