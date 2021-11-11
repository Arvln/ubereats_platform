const { color: headerColor } = require('../../features/header');
const { color: shortcutColor } = require('../../features/shortcut');
const { color: channelColor } = require('../../features/channel');

module.exports = {
	...headerColor,
	...shortcutColor,
	...channelColor
}
