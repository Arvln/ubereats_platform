import { Prop } from './types';
import { useState } from 'react';
import Image from 'next/image';
import CategoryItem from 'components/category_item';

import {
	wrapper,
	shortcutItemWrapper,
	itemHoverStyle,
} from 'styles/features/Shortcut.module.scss';

const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;

function Shortcut({ data }: Prop) {
	const [selectedId, setSelectedId] = useState<string>('');

	function _handleMouseEnter(selectedId: string): void {
		setSelectedId(selectedId);
	}

	function _handleMouseLeave(): void {
		setSelectedId('');
	}

	function _renderItems(): JSX.Element[] {
		return (
			data.map(({
				title,
				shortcutImageSuffix,
				isCuisines,
				uuid
			}) => {
				const isSelected: boolean = uuid === selectedId;
				const hoverStyle: string = isSelected ? itemHoverStyle : '';

				return (
					<li
						key={uuid}
						onMouseEnter={() => _handleMouseEnter(uuid)}
						onMouseLeave={() => _handleMouseLeave()}
					>
						<CategoryItem
							appendClass={shortcutItemWrapper}
							pageUrl={`/shortcut/${uuid}`}
							icon={
								<Image
									className={ hoverStyle }
									src={`https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${shortcutImageSuffix}`}
									width={60}
									height={60}
									alt={shortcutImageSuffix}
								/>
							}
							text={title}
						/>
					</li>
				)
			})
		)
	}
	
	return (
		<nav className={ wrapper }>
			<ul>
				{ _renderItems() }
			</ul>
		</nav>
	)
}

export default Shortcut;
