const { color: buttonColor } = require('../../components/button');
const { color: footerColor } = require('../../features/footer');

module.exports = {
	color: {
		...buttonColor,
		...footerColor,
	}
}
