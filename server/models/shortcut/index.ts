import { query } from '../../db/query';

const shortcutLength = 14;

export async function getData(){
  const shortcut = await query(
    `SELECT
		title,
		shortcut_image_suffix as shortcutImageSuffix,
		is_cuisines as isCuisines,
		HEX(uuid) as uuid
    FROM
		Table_Shop_Category
		LIMIT ?`,
    [shortcutLength]
  );

	return shortcut;
}
