export enum ConditionsTypes {
	CLASSIFICATION = '分類',
	PRICE_RANGE = '價格範圍',
	DELIVERY_COST_LIMITATION = '外送費上限',
	DIETARY_RESTRICTION = '飲食限制'
};

export enum ClassificationTypes {
	RECOMMEND = 0,
	POPULAR = 1,
	SCORE = 2,
	DELIVERY_TIME = 3
};

export enum ClassificationsTypes {
	RECOMMEND = '  您專屬的推薦餐點 (預設)',
	POPULAR = '  熱門餐點',
	SCORE = '  評分',
	DELIVERY_TIME = '  配送時間'
};

export enum PriceLevelTypes {
	EXTREMELY_LOW = '$',
	LOW = '$$',
	MIDDLE = '$$$',
	HIGH = '$$$$'
};

export enum DeliveryCostLimitTypes {
	'NT$25' = 0,
	'NT$40' = 1,
	'NT$60' = 2,
	'NT$60_PLUS' = 3,
};

export enum DeliveryRestrictionTypes {
	VEGETABLE = 0,
	VEGAN = 1,
	GLUTEN_FREE = 2,
	NO_ALLERGY = 3
};

export enum DeliveryRestrictionsTypes {
	VEGETABLE = '  蔬食料理',
	VEGAN = '  純素食料理',
	GLUTEN_FREE = '  無麩質料理',
	NO_ALLERGY = '  過敏者可食用'
};
