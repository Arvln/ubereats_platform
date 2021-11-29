import { Prop } from './types';

import classes from 'styles/features/Popups.module.scss';

const {
	wrapper,
	showMask,
	hideMask,
	showMaskContent,
	hideMaskContent
} = classes;

function Popups({
	isShow,
	hide,
	children
}: Prop) {
	const maskWrapper = isShow ? showMask : hideMask;
	const maskContent = isShow ? showMaskContent : hideMaskContent;

	return (
		<div
			className={wrapper}
			onClick={() => hide()}
		>
			<div className={maskWrapper}>
				<div className={maskContent}>
					{children}
				</div>
			</div>
		</div>
	);
};

export default Popups;
