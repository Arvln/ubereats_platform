import { Prop } from './types';
import Image from 'next/image';
import { RecommandCategories } from 'enums/features/category';

import classes from 'styles/features/category/Title.module.scss';

const {
	wrapper,
	background,
	topBackground,
	bottomBackground,
	left,
	right,
	content,
	text,
	imageWrapper
} = classes;
const {
	PET,
	FLOWERS,
	RETAIL
} = RecommandCategories;

function Title({ title, iconUrl }: Prop) {
	function _renderImage(): JSX.Element | void {
		if (title === PET || title === FLOWERS || title === RETAIL) return;

		return (
			<div className={imageWrapper}>
				<Image
					src={iconUrl}
					layout="fill"
					alt={title}
				/>
			</div>
		);
	};

	return (
		<div className={wrapper}>
			<div className={background}>
				<div className={topBackground} />
				<div className={bottomBackground}>
					<div className={left} />
					<div className={right} />
				</div>
			</div>
			<div className={content}>
				<div className={text}>{title}</div>
				{_renderImage()}
			</div>
		</div>
	);
};

export default Title;
