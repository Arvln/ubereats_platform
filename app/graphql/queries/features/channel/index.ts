export const getChannel: string = `
	channel {
		title
		subtitle
		imageSuffix
		uuid
		channelItems {
			... on ChannelShop {
				name
				deliveryCost
				shortestDeliveryTime
				score
				discountInfo
				imageSuffix
				uuid
			}
			... on ChannelCategory {
				title
				name
				uuid
			}
		}
	}
`
