import { TCarousel } from 'types/features';
import { getData } from 'models/carousel';

export async function getCarousel(): Promise<TCarousel[]> {
	const carousel = await getData();

	return carousel;
}
