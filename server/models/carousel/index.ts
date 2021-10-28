import { query } from '../../db/query';

const isShow: boolean = true;

export async function getData(){
	const carousel = await query(
		`
			SELECT
				image_suffix AS imageSuffix,
				HEX(uuid) AS uuid
			FROM
				Table_Advertise
			WHERE
				is_show = ?
		`,
		[isShow]
	);

	return carousel;
}
