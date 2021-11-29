import { Prop } from './types';
import { useState } from 'react';
import Image from 'next/image';
import { CategoryItem } from 'components';

import classes from 'styles/features/Shortcut.module.scss';

const {
	wrapper,
	shortcutItemWrapper,
	itemHoverStyle,
} = classes;
const SHORTCUT_ICONS_SERVER_HOST = process.env.SHORTCUT_ICONS_SERVER_HOST;

function Shortcut({ data }: Prop) {
	const [selectedId, setSelectedId] = useState<string>('');

	function _handleMouseEnter(selectedId: string): void {
		setSelectedId(selectedId);
	};

	function _handleMouseLeave(): void {
		setSelectedId('');
	};

	function _renderItems(): JSX.Element[] {
		return (
			data.map(({
				title,
				imageSuffix,
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
							pageUrl={`/${title}`}
							icon={
								<Image
									className={hoverStyle}
									src={`https://${SHORTCUT_ICONS_SERVER_HOST}/shortcuts${isCuisines ? `/cuisines/` : '/'}${imageSuffix}`}
									width={60}
									height={60}
									alt={title}
								/>
							}
							text={title}
						/>
					</li>
				)
			})
		);
	};
	
	return (
		<div className={wrapper}>
			<nav>
				<ul>
					{_renderItems()}
				</ul>
			</nav>
		</div>
	);
};

export default Shortcut;
