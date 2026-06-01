export const getUUID = `
	query {
		carousel {
			uuid
		}
	}
`

export const getAdvertiseByUUID = `
	query($uuid: String!) {
		advertise(uuid: $uuid) {
			content
		}
	}
`
