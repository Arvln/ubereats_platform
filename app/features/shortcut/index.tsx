import { TShortcut } from 'graphql/types';
import Image from 'next/image';
import CategoryItem from 'components/category_item';

import {
	wrapper,
	shortcutItemWrapper,
} from 'styles/features/Shortcut.module.scss';

const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;

type Prop = {
	shortcut: TShortcut[];
}

function Shortcut({ shortcut }: Prop) {
	function _renderShortcut() {
		return shortcut.map(({
			title,
			shortcutImageSuffix,
			isCuisines,
			uuid
		}) => (
			<CategoryItem
				key={uuid}
				appendClass={shortcutItemWrapper}
				pageUrl={`/shortcut/${uuid}`}
				icon={
					<Image
						src={`https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${shortcutImageSuffix}`}
						width={60}
						height={60}
						alt={shortcutImageSuffix}
					/>
				}
				text={title}
			/>
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
