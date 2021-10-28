import { Prop } from './types';
import Image from 'next/image';
import CategoryItem from 'components/category_item';

import {
	wrapper,
	shortcutItemWrapper,
	itemHoverStyle,
} from 'styles/features/Shortcut.module.scss';

const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;

function Shortcut({ shortcut }: Prop) {
	function _handleMouseEnter(key: string) {
		const element = document.getElementsByClassName(`shortcut-item-${key}`)[0];
		element.classList.add(itemHoverStyle);
	}

	function _handleMouseLeave(key: string) {
		const element = document.getElementsByClassName(`shortcut-item-${key}`)[0];
		element.classList.remove(itemHoverStyle);
	}

	function _renderShortcut() {
		return shortcut.map(({
			title,
			shortcutImageSuffix,
			isCuisines,
			uuid
		}) => (
			<li
				key={uuid}
				onMouseEnter={() => _handleMouseEnter(uuid)}
				onMouseLeave={() => _handleMouseLeave(uuid)}
			>
				<CategoryItem
					appendClass={shortcutItemWrapper}
					pageUrl={`/shortcut/${uuid}`}
					icon={
						<Image
							className={`shortcut-item-${uuid}`}
							src={`https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${shortcutImageSuffix}`}
							width={60}
							height={60}
							alt={shortcutImageSuffix}
						/>
					}
					text={title}
				/>
			</li>
		))
	}
	
	return (
		<nav className={ wrapper }>
			<ul>
				{ _renderShortcut() }
			</ul>
		</nav>
	)
}

export default Shortcut;
