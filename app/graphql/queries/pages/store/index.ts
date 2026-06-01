export const getStoreSlugs = `
	query {
		storeSlugs {
			name
			uuid
		}
	}
`

export const getStoreBySlug = `
	query($name: String!, $uuid: String!) {
		store(name: $name, uuid: $uuid) {
			name
			deliveryCost
			shortestDeliveryTime
			score
			bannerSuffix
			address
			goodChannels {
				label,
				items {
					name
					price
					discription
					spicyLevel
					imageSuffix
					isEmphasis
					uuid
				}
			}
		}
	}
`
