import { TParent, TCategoryShop } from 'types/pages/title';
import _ from 'lodash';
import { getData } from 'models/category';

export async function getCategory(
	parent: unknown,
	args: Record<string, string>
): Promise<TParent> {
	const { title } = args;
	const {
		category
	} = await getData(title);

	return category;
}

export async function getCategoryShopItems(parent: TParent): Promise<TCategoryShop[]> {
	const {
		categoryShop
	} = await getData();

	return _.filter(categoryShop, {
		categoryId: parent.id
	});
}
