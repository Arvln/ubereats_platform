import { gql } from '@apollo/client';

export const getUUID = gql`
	query {
		carousel {
			uuid
		}
	}
`

export const getAdvertiseByUUID = gql`
	query($uuid: String!) {
		advertise(uuid: $uuid) {
			content
		}
	}
`
