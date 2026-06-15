import { TCarousel } from "types/features";

export function getRenderData(data: TCarousel[]) {
	return [
		...data.slice(0, 3),
		...data,
		...data.slice(data.length - 5, data.length)
	];
};

export function getRightStartPoint(offset: number) {
	const isReachLeftBoundary: boolean = offset === 0 || offset === -33.333;

	if (isReachLeftBoundary) offset -= 0.001;

	return Math.round((offset - 333.333) * 1000) / 1000;
};
