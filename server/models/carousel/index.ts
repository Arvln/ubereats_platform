import { TCarousel } from 'types/carousel';
import { query } from '../../db/query';

const IS_SHOW: boolean = true;

export async function getData(){
	const carousel = await query(
		`
			SELECT
				image_suffix AS imageSuffix,
				HEX(uuid) AS uuid
			FROM
				Table_Advertise
			WHERE
				is_show = ?;
		`,
		[IS_SHOW]
	) as TCarousel[];

	return carousel;
}
