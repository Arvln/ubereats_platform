import { ParsedUrlQuery } from 'querystring';

export type TPath<T> = {
	params: T & ParsedUrlQuery;
};

export type TDynamicRoutesPageResult<T> = {
	[key: string]: T[];
};

export type TQueryResult<T> = T | TDynamicRoutesPageResult<T>;
