import { ParsedUrlQuery } from 'querystring';

export type TQueryResult<T> = {
	[key: string]: T[];
}

export type TPath<T> = {
	params: T & ParsedUrlQuery;
};
