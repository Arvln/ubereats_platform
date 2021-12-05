import { makeVar, ReactiveVar, useReactiveVar } from '@apollo/client';

export function getVar<T>(cache: T) {
	return makeVar<T>(cache);
};

export function useVar<T>(cacheVar: ReactiveVar<T>) {
	return [useReactiveVar(cacheVar), cacheVar()];
};
