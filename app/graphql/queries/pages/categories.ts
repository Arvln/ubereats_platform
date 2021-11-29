import { gql } from '@apollo/client';

export const getTitles = gql`
	query {
		shortcut {
			title
		}
	}
`

export const getCategoryByTitle = gql`
	query($title: String!) {
		category(title: $title) {
			title
			imageSuffix
			isCuisines
			categoryShopItems {
				name
				deliveryCost
				shortestDeliveryTime
				score
				discountLabel
				imageSuffix
				uuid
			}
		}
	}
`
