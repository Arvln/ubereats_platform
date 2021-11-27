import { TCarousel } from 'types/features';
import { query } from '../../db/query';

export async function getData(){
	const carousel = await query(
		`
			SELECT
				image_suffix AS imageSuffix,
				HEX(uuid) AS uuid
			FROM
				Table_Advertise
			WHERE
				is_show = TRUE;
		`
	) as TCarousel[];

	return carousel;
}
