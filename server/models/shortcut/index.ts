import { TShortcut } from '../../../types/shortcut';
import { query } from '../../db/query';

const shortcutLength: number = 14;

export async function getData(){
	const shortcut = await query(
		`
			SELECT
				title,
				shortcut_image_suffix AS shortcutImageSuffix,
				is_cuisines AS isCuisines,
				HEX(uuid) AS uuid
			FROM
				Table_Shop_Category
			LIMIT ?;
		`,
		[shortcutLength]
	) as TShortcut[];

	return shortcut;
}
