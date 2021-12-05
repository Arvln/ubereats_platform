import { TConditionsState } from 'features/restrict_search/types';
import { getVar } from 'utils';

export const conditionsStateVar = getVar<TConditionsState>({});
