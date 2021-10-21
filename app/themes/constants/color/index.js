const { color: sectionColor } = require('../../components/section');
const { color: footerColor } = require('../../components/footer');

module.exports = {
	color: {
		...sectionColor,
		...footerColor,
	}
}
