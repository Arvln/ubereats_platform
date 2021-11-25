import { TShortcut } from 'types/features';
import { query } from '../../db/query';

const SHORTCUT_LENGTH: number = 14;

export async function getData() {
	const shortcut = await query(
		`
			SELECT
				title,
				image_suffix AS imageSuffix ,
				is_cuisines AS isCuisines,
				HEX(uuid) AS uuid
			FROM
				Table_Shop_Category
			LIMIT
				?;
		`,
		[SHORTCUT_LENGTH]
	) as TShortcut[];

	return shortcut;
}
