import { query } from '../../db/query';

export async function getData(){
	const cannel = await query(
		`
			SELECT
				title,
				subtitle,
				HEX(uuid) AS uuid
			FROM
				Table_Shop_Cannel
		`
	);

	return cannel;
}
