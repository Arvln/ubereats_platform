import { TGoodChannel, TGood } from "types/pages/store";

function getLabel(label?: string): string {
	if (!label) return '您專屬的推薦商品';

	if (label.startsWith('免費餐點'))
		return `消費滿$${label.split('$')[1].slice(0, -1)}即可免費獲得(新增至購物車)`;

	return label;
};

function getChannel(
	items: TGood[],
	label?: string
): TGoodChannel | void {
	if (items.length === 0) return;

	return {
		label: getLabel(label),
		items: items
	};
};

export function getChannels(
	origin: TGoodChannel[],
	items: TGood[],
	label?: string
): TGoodChannel[] {
	const channel = getChannel(items, label);

	if (!channel) return origin;

	return [
		channel,
		...origin
	];
};
