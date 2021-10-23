import { Prop } from './types';
import {
	defaultStyle,
	textWrapper
} from 'styles/components/Button.module.scss';

function Button({ appendClass, icon, text }: Prop) {
	const buttonClass = appendClass ? `${defaultStyle} ${appendClass}` : defaultStyle;

	return (
		<div className={ buttonClass }>
			{ icon }
			<div className={ textWrapper }>{ text }</div>
		</div>
	)
}

export default Button;
