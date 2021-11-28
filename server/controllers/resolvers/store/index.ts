import { TStoreSlug, TParent } from 'types/pages/store';
import _ from 'lodash';
import { getData } from 'models/store';

export async function getStoreSlugs(): Promise<TStoreSlug[]> {
	const { storeSlugs } = await getData();

	return storeSlugs;
};

export async function getStore(
	parent: unknown,
	args: Record<string, string>
): Promise<TParent[]> {
	const {
		name,
		uuid
	} = args;
	const { store } = await getData(name, uuid);

	return store;
};
