import { TShortcut } from 'types/shortcut';
import { getData } from 'models/shortcut';

export async function getShortcut(): Promise<TShortcut[]> {
	const shortcut = await getData();

	return shortcut;
}
