import {
	TParent,
	TChannelShop,
	TChannelCategory
} from 'types/features'
import { query } from '../../db/query';

const CATEGORY_LIMIT: number = 12;

export async function getData(){
	const channel = await query(
		`
			SELECT
				id,
				title,
				subtitle,
				image_suffix AS imageSuffix,
				HEX(uuid) AS uuid
			FROM
				Table_Shop_Channel;
		`
	) as TParent[];
	const channelShop = await query(
		`
			SELECT
				Table_Shop.name AS name,
				Table_Shop.delivery_cost AS deliveryCost,
				Table_Shop.shortest_delivery_time AS shortestDeliveryTime,
				Table_Shop.score AS score,
				Table_Shop.discount_label AS discountLabel,
				Table_Shop.image_suffix AS imageSuffix,
				HEX(Table_Shop.uuid) AS uuid,
				Table_Mapping_Shop_And_Channel.channel_id AS channelId
			FROM
				Table_Mapping_Shop_And_Channel
			LEFT JOIN
				Table_Shop
			ON
				Table_Mapping_Shop_And_Channel.shop_id = Table_Shop.id;
		`
	) as TChannelShop[]
	const channelCategory = await query(
		`
			SELECT
				title,
				name,
				HEX(uuid) AS uuid
			FROM
				Table_Shop_Category
			ORDER BY
				rank
			LIMIT
				?;
		`,
		[CATEGORY_LIMIT]
	) as TChannelCategory[];

	return {
		channel,
		channelShop,
		channelCategory
	};
}
