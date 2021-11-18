import { TShortcut } from 'types/features';
import { getData } from 'models/shortcut';

export async function getShortcut(): Promise<TShortcut[]> {
	const shortcut = await getData();

	return shortcut;
}
