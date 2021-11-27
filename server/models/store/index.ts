import {
	TStoreSlug,
	TParent,
	TGoodWithShopId,
	TChannel,
	TGoodWithChannelId
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
				name = ? AND uuid = UNHEX(?);
		`,
		[name, uuid]
	) as TParent[];
	const discountGoods = await query(
		`
			SELECT
				name,
				price,
				discription,
				image_suffix AS imageSuffix,
				spicy_level AS spicyLevel,
				is_emphasis AS isEmphasis ,
				HEX(uuid) AS uuid,
				shop_id AS shopId
			FROM
				Table_Good
			WHERE
				is_show = TRUE AND is_discount = TRUE;
		`
	) as TGoodWithShopId[];
	const exclusiveGoods = await query(
		`
			SELECT
				name,
				price,
				discription,
				image_suffix AS imageSuffix,
				spicy_level AS spicyLevel,
				is_emphasis AS isEmphasis,
				HEX(uuid) AS uuid,
				shop_id AS shopId
			FROM
				Table_Good
			WHERE
				is_show = TRUE AND is_exclusive = TRUE;
		`
	) as TGoodWithShopId[];
	const channels = await query(
		`
			SELECT
				id,
				title,
				shop_id AS shopId
			FROM
				Table_Good_Channel;
		`
	) as TChannel[];
	const goods = await query(
		`
			SELECT
				Table_Good.name AS name,
				Table_Good.price AS price,
				Table_Good.discription AS discription,
				Table_Good.image_suffix AS imageSuffix,
				Table_Good.spicy_level AS spicyLevel,
				Table_Good.is_emphasis AS isEmphasis,
				HEX(Table_Good.uuid) AS uuid,
				Table_Mapping_Good_And_Channel.channel_id AS channelId
			FROM
				Table_Mapping_Good_And_Channel
			LEFT JOIN
				Table_Good
			ON
				Table_Mapping_Good_And_Channel.good_id = Table_Good.id
			WHERE
				Table_Good.is_show = TRUE;
		`
	) as TGoodWithChannelId[];

	return {
		storeSlugs,
		store,
		discountGoods,
		exclusiveGoods,
		channels,
		goods
	};
}
