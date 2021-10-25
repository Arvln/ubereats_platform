const { borderRadius: buttonBorderRadius } = require('../../components/button');

const { borderRadius: headerBorderRadius } = require('../../features/header');

module.exports = {
	...buttonBorderRadius,

	...headerBorderRadius,
}
