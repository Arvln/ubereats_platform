import { gql } from '@apollo/client';

export const getTitles = gql`
	query {
		shortcut {
			title
		}
	}
`

export const getCategory = gql`
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
				discountInfo
				imageSuffix
				uuid
			}
		}
	}
`
