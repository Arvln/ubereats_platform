export const channelQuery: string = `
	channel {
		title
		subtitle
		imageSuffix
		uuid
		channelShops {
			name
			deliveryCost
			shortestDeliveryTime
			score
			discountInfo
			imageSuffix
			uuid
		}
	}
`
