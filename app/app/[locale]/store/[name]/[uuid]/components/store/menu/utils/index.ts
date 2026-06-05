const DISCOUNT_LABEL: string = '訂購指定餐點即享折扣優惠';
const DISCOUNT_RATE: number = 0.8;

export function getDiscountPrice(
	origin: string | number,
	label?: string
): string | void {
	if (typeof (origin) === 'string') return;
	if (label === DISCOUNT_LABEL) return `$${Math.round(origin * DISCOUNT_RATE)}`;

	return;
};

const FREE_GIFT_LABEL_START: string = '消費滿$';

export function isFreeGift(label: string) {
	return label.startsWith(FREE_GIFT_LABEL_START);
};
