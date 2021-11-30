const DISCOUNT_LABEL: string = '訂購指定餐點即享折扣優惠';

export function getDiscountPrice(
	origin: string | number,
	label?: string
): string | void {
	if (typeof (origin) === 'string') return;
	if (label === DISCOUNT_LABEL) return `$${Math.round(origin * 0.8)}`;

	return;
};
