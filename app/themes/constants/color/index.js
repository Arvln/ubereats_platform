const { color: buttonColor } = require('../../components/button');

const { color: headerColor } = require('../../features/header');
const { color: footerColor } = require('../../features/footer');

module.exports = {
	...buttonColor,

	...headerColor,
	...footerColor,
}
