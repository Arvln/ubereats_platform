const spacing = require('./themes/constants/spacing')
const color = require('./themes/constants/color');
const borderRadius = require('./themes/constants/border_radius');
const padding = require('./themes/constants/padding');
const flex = require('./themes/constants/flex');

module.exports = {
	mode: 'jit',
	purge: ['./pages/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}', './features/**/*.{js,ts,jsx,tsx}'],
	darkMode: false, // or 'media' or 'class'
	theme: {
		extend: {
			spacing,
			padding,
			flex,
			borderRadius,
			color,
			backgroundColor: theme => ({
				...theme('color')
			}),
			textColor: theme => ({
				...theme('color')
			}),
			borderColor: theme => ({
				...theme('color')
			})
		},
	},
	variants: {
			extend: {},
	},
	plugins: [],
};
