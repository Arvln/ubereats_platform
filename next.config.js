/** @type {import('next').NextConfig} */
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;
const CATEGORY_ICONS_SERVER_HOST = process.env.CATEGORY_ICONS_SERVER_HOST;

module.exports = {
	reactStrictMode: true,
	env: {
		SHORTCUT_ICONS_SERVER_HOST,
		CATEGORY_ICONS_SERVER_HOST
	},
	images: {
		domains: [
			SHORTCUT_ICONS_SERVER_HOST,
			CATEGORY_ICONS_SERVER_HOST
		],
	},
}
