import { TStoreSlug ,TStore } from 'types/pages/store';
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
				name,
				delivery_cost AS deliveryCost,
				shortest_delivery_time AS shortestDeliveryTime,
				score,
				discount_info AS discountInfo,
				banner_suffix AS bannerSuffix ,
				address,
				HEX(uuid) AS uuid
			FROM
				Table_Shop
			WHERE
				name = ? AND uuid = UNHEX(?);
		`,
		[name, uuid]
	) as TStore;

	return {
		storeSlugs,
		store
	};
}
