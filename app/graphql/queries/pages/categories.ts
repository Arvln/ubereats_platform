export const getTitles = `
	query {
		shortcut {
			title
		}
	}
`

export const getCategoryByTitle = `
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
