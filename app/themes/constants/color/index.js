const { color: shortcutColor } = require('../../features/shortcut');
const { color: channelColor } = require('../../features/channel');

module.exports = {
	...shortcutColor,
	...channelColor
}
