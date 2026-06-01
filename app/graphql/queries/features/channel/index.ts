export const getChannel: string = `
	channel {
		title
		subtitle
		imageSuffix
		uuid
		channelItems {
			... on ChannelShop {
				__typename
				name
				deliveryCost
				shortestDeliveryTime
				score
				discountLabel
				imageSuffix
				uuid
			}
			... on ChannelCategory {
				__typename
				title
				name
				uuid
			}
		}
	}
`
