const { color: headerColor } = require('../../features/header');
const { color: shortcutColor } = require('../../features/shortcut');
const { color: channelColor } = require('../../features/channel');
const { color: storeColor } = require('../../features/store');

module.exports = {
	...headerColor,
	...shortcutColor,
	...channelColor,
	...storeColor
}
