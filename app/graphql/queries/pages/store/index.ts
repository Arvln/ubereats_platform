import { gql } from '@apollo/client';

export const getStoreSlugs = gql`
	query {
		storeSlugs {
			name
			uuid
		}
	}
`

export const getStoreBySlug = gql`
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
