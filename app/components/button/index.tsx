import { Prop } from './types';

import {
	wrapper,
	content,
} from 'styles/components/Button.module.scss';

function Button({
	appendClass,
	icon,
	text
}: Prop
) {
	const {
		appendWrapper,
		appendContent,
	} = appendClass;
	const wrapperStyle = `${wrapper} ${appendWrapper}`;
	const contentStyle = `${content} ${appendContent}`;

	return (
		<div className={ wrapperStyle }>
			{ icon }
			<div className={ contentStyle }>{ text }</div>
		</div>
	)
}

export default Button;
