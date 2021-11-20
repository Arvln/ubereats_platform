/** @type {import('next').NextConfig} */
const ENV = process.env;
const SHORTCUT_ICONS_SERVER_HOST = ENV.SHORTCUT_ICONS_SERVER_HOST;
const ADVERTISE_IMAGE_SERVER_HOST = ENV.ADVERTISE_IMAGE_SERVER_HOST;
const CATEGORY_ICONS_SERVER_HOST = ENV.CATEGORY_ICONS_SERVER_HOST;
const STORE_IMAGE_SERVER_HOST = ENV.STORE_IMAGE_SERVER_HOST;
const UTILS_ICONS_SERVER_HOST = ENV.UTILS_ICONS_SERVER_HOST;

module.exports = {
	reactStrictMode: true,
	env: {
		SHORTCUT_ICONS_SERVER_HOST,
		ADVERTISE_IMAGE_SERVER_HOST,
		CATEGORY_ICONS_SERVER_HOST,
		STORE_IMAGE_SERVER_HOST,
		UTILS_ICONS_SERVER_HOST
	},
	images: {
		domains: [
			SHORTCUT_ICONS_SERVER_HOST,
			ADVERTISE_IMAGE_SERVER_HOST,
			CATEGORY_ICONS_SERVER_HOST,
			STORE_IMAGE_SERVER_HOST,
			UTILS_ICONS_SERVER_HOST
		],
		deviceSizes: [240, 550, 640, 750, 1080, 2880],
	},
	webpack(config) {
		const rules = config.module.rules
			.find(rule => typeof rule.oneOf === 'object')
			.oneOf
			.filter(rule => Array.isArray(rule.use));

		rules.forEach((rule) => {
			rule.use.forEach((moduleLoader) => {
				if (moduleLoader.loader.includes('resolve-url-loader'))
					moduleLoader.options.sourceMap = false;
			});
		});

		return config;
	},
}
