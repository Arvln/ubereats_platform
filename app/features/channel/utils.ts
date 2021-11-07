import { TChannelItem } from "../../../types/channel";
import { ContentType } from './types';

const EMPHASIS_SHOP_PAGE_SIZE: number = 3;
const REGULAR_DEFAULT_PAGE_SIZE: number = 4;
const SHOP_PAGE_SIZE: number = 4;
const CATEGORY_PAGE_SIZE: number = 8;

const {
	CHANNELSHOP,
	CHANNELCATEGORY
} = ContentType;

export function getOffset(
	currentPage: number,
	size: number
) {
  return (currentPage - 1) * size;
}

export function getPageDataList(
	data: TChannelItem[],
	size: number
) {
	let currentPage: number = 1;
	let offset: number = 0;
	let hasData: boolean = data.length > 0;
	let pageDataList: TChannelItem[][] = [];

	while (hasData) {
		pageDataList = [
			...pageDataList,
			data.slice(offset, offset + size)
		]
		currentPage++;
		offset = getOffset(currentPage, size);
		hasData = data.length > offset + size;
	}
	pageDataList = [
		...pageDataList,
		data.slice(offset, data.length)
	];

	return pageDataList;
}

export function getEmphsisPageSize() {
	return EMPHASIS_SHOP_PAGE_SIZE;
}

export function isShopsChannel(data: TChannelItem[]) {
	return data[0]['__typename'] === CHANNELSHOP;
}

export function getRegularPageSize(data: TChannelItem[]) {
	const type: string = data[0]['__typename'];

	if (type === CHANNELSHOP) return SHOP_PAGE_SIZE;
	if (type === CHANNELCATEGORY) return CATEGORY_PAGE_SIZE;

	return REGULAR_DEFAULT_PAGE_SIZE;
}

export function getTotalPage(
	data: TChannelItem[],
	pageSize: number
) {
	return Math.ceil(data.length / pageSize);
}
