import { TParent, TCategoryShop } from 'types/pages/title'
import { query } from '../../db/query';

export async function getData(title?: string) {
	const category = await query(
		`
			SELECT
				id,
				title,
				image_suffix AS imageSuffix,
				is_cuisines AS isCuisines
			FROM
				Table_Shop_Category
			WHERE
				title = ?
		`,
		[title]
	) as TParent;
	const categoryShop = await query(
		`
			SELECT
				Table_Shop.name AS name,
				Table_Shop.delivery_cost AS deliveryCost,
				Table_Shop.shortest_delivery_time AS shortestDeliveryTime,
				Table_Shop.score AS score,
				Table_Shop.discount_label AS discountLabel,
				Table_Shop.image_suffix AS imageSuffix,
				HEX(Table_Shop.uuid) AS uuid,
				Table_Mapping_Shop_And_Category.category_id AS categoryId
			FROM
				Table_Mapping_Shop_And_Category
			LEFT JOIN
				Table_Shop
			ON
				Table_Mapping_Shop_And_Category.shop_id = Table_Shop.id;
		`
	) as TCategoryShop[];

	return {
		category,
		categoryShop
	};
}
