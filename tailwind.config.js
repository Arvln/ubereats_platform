const spacing = require('./app/themes/constants/spacing')
const color = require('./app/themes/constants/color');
const	borderRadius = require('./app/themes/constants/border_radius');

module.exports = {
	mode: 'jit',
	purge: ['./pages/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}'],
	darkMode: false, // or 'media' or 'class'
	theme: {
		extend: {
			spacing,
			color,
			backgroundColor: theme => ({
				...theme('color')
			}),
			textColor: theme => ({
				...theme('color')
			}),
		},
		borderRadius,
	},
	variants: {
			extend: {},
	},
	plugins: [],
};
