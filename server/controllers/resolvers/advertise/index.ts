import { TAdvertise } from 'types/pages/marketing';
import { getData } from 'models/advertise';

export async function getAdvertise(
	parent: unknown,
	args: Record<string, string>
): Promise<TAdvertise[]> {
	const { uuid } = args;
	const advertise = await getData(uuid);

	return advertise;
}
