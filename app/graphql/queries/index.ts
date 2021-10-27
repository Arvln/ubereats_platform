import { gql } from '@apollo/client';

export const getShortcutQuery = gql`
	query {
		shortcut{
			title
			shortcutImageSuffix
			isCuisines
			uuid
		}
	}
`
