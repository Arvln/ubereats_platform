import { getData } from '../../../models/carousel';

export async function getCarousel() {
	const carousel = await getData();

	return carousel;
}
