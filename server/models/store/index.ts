import {
	TStoreSlug,
	TParent
} from 'types/pages/store';
import { query } from '../../db/query';

export async function getData(name?: string, uuid?: string) {
	const storeSlugs = await query(
		`
			SELECT
				name,
				HEX(uuid) AS uuid
			FROM
				Table_Shop;
		`
	) as TStoreSlug[];
	const store = await query(
		`
			SELECT
				id,
				name,
				delivery_cost AS deliveryCost,
				shortest_delivery_time AS shortestDeliveryTime,
				score,
				discount_label AS discountLabel,
				banner_suffix AS bannerSuffix ,
				address
			FROM
				Table_Shop
			WHERE
				name = ?
			AND
				uuid = UNHEX(?);
		`,
		[name, uuid]
	) as TParent[];

	return {
		storeSlugs,
		store
	};
}
