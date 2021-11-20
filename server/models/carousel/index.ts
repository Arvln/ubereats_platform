import { TCarousel } from 'types/features';
import { query } from '../../db/query';

const IS_SHOW: boolean = true;

export async function getData(){
	const carousel = await query(
		`
			SELECT
				content,
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
