import {
	TGood,
	TChannel,
	TGoodWithChannelId
} from 'types/pages/store';
import { query } from '../../../db/query';

export async function getData(shopId: number) {
	const discountGoods = await query(
		`
			SELECT
				name,
				price,
				discription,
				image_suffix AS imageSuffix,
				spicy_level AS spicyLevel,
				is_emphasis AS isEmphasis ,
				HEX(uuid) AS uuid
			FROM
				Table_Good
			WHERE
				is_show = TRUE
			AND
				is_discount = TRUE
			AND
				shop_id = ?;
		`,
		[shopId]
	) as TGood[];
	const exclusiveGoods = await query(
		`
			SELECT
				name,
				price,
				discription,
				image_suffix AS imageSuffix,
				spicy_level AS spicyLevel,
				is_emphasis AS isEmphasis,
				HEX(uuid) AS uuid
			FROM
				Table_Good
			WHERE
				is_show = TRUE
			AND
				is_exclusive = TRUE
			AND
				shop_id = ?;
		`,
		[shopId]
	) as TGood[];
	const channels = await query(
		`
			SELECT
				id,
				title AS label
			FROM
				Table_Good_Channel
			WHERE
				shop_id = ?;
		`,
		[shopId]
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
				Table_Good.is_show = TRUE
			AND
				Table_Good.shop_id = ?;
		`,
		[shopId]
	) as TGoodWithChannelId[];

	return {
		discountGoods,
		exclusiveGoods,
		channels,
		goods
	};
}
