export enum ConditionsTypes {
  CLASSIFICATION = 'restrict_search.categories',
  PRICE_RANGE = 'restrict_search.price_range',
  DELIVERY_COST_LIMITATION = 'restrict_search.maximum_delivery_fee',
  DIETARY_RESTRICTION = 'restrict_search.dietary_restrictions'
};

export enum ClassificationTypes {
  RECOMMEND = 0,
  POPULAR = 1,
  SCORE = 2,
  DELIVERY_TIME = 3
};

export enum ClassificationsTypes {
  RECOMMEND = 'restrict_search.personalized_recommended_dishes',
  POPULAR = 'restrict_search.popular_dishes',
  SCORE = 'restrict_search.rating',
  DELIVERY_TIME = 'restrict_search.delivery_time'
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
  VEGETABLE = 'restrict_search.vegetarian_dishes',
  VEGAN = 'restrict_search.vegan_dishes',
  GLUTEN_FREE = 'restrict_search.gluten_free_dishes',
  NO_ALLERGY = 'restrict_search.allergy_friendly'
};
