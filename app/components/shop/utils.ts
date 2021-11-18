import classes from 'styles/components/Shop.module.scss';

const {
	shopWidth_3,
	shopWidth_4
} = classes;
const minDistance: number = 0;
const maxDistance: number = 100;
const defaultShopsWidth: number = 4;

export function getScore(score: number): string {
	return (score / 10).toFixed(1);
}

export function isPickup(cost: number): boolean {
	return cost === minDistance || cost === maxDistance;
}

export function getPickupDistance(cost: number): string {
	if (cost === 0) return cost.toString();

	return (cost / 1000).toFixed(1);
}

export function getPageSizeWrapper(pageSize?: number): string | void {
	if (!pageSize) return;

	return pageSize === defaultShopsWidth ? shopWidth_4 : shopWidth_3;
}
