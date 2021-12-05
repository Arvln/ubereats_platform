import { TPagesState } from 'features/channel/types';
import { getVar } from 'utils';

export const pagesStateVar = getVar<TPagesState>({});
