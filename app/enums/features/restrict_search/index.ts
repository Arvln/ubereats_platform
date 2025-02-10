export enum ConditionsTypes {
  CLASSIFICATION = 'restrict-search.categories',
  PRICE_RANGE = 'restrict-search.price-range',
  DELIVERY_COST_LIMITATION = 'restrict-search.maximum-delivery-fee',
  DIETARY_RESTRICTION = 'restrict-search.dietary-restrictions'
};

export enum ClassificationTypes {
  RECOMMEND = 0,
  POPULAR = 1,
  SCORE = 2,
  DELIVERY_TIME = 3
};

export enum ClassificationsTypes {
  RECOMMEND = 'restrict-search.personalized-recommended-dishes',
  POPULAR = 'restrict-search.popular-dishes',
  SCORE = 'restrict-search.rating',
  DELIVERY_TIME = 'restrict-search.delivery-time'
};

export enum PriceLevelTypes {
  EXTREMELY_LOW = '$',
  LOW = '$$',
  MIDDLE = '$$$',
  HIGH = '$$$$'
};

export enum DeliveryCostLimitTypes {
  LOWEST_FEE = 0,
  LOW_FEE = 1,
  MODERATE_FEE = 2,
  HIGHER_FEE = 3,
};

export enum DeliveryRestrictionTypes {
  VEGETABLE = 0,
  VEGAN = 1,
  GLUTEN_FREE = 2,
  NO_ALLERGY = 3
};

export enum DeliveryRestrictionsTypes {
  VEGETABLE = 'restrict-search.vegetarian-dishes',
  VEGAN = 'restrict-search.vegan-dishes',
  GLUTEN_FREE = 'restrict-search.gluten-free-dishes',
  NO_ALLERGY = 'restrict-search.allergy-friendly'
};
