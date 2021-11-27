export function getLabel(label: string): string{
	if (label.startsWith('免費餐點'))
		return `消費滿$${label.split('$')[1].slice(0, -1)}即可免費獲得(新增至購物車)`;

	return label;
}
